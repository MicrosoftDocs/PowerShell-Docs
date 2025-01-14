<#
.SYNOPSIS
    Generates an error record for a failed `gh` command.
.DESCRIPTION
    This cmdlet generates an error record for a failed `gh` command. It enables the API commands in
    this module to write useful error messages.

    The exception type is always **System.ApplicationException** and the error category is always
    `FromStdErr`.
.PARAMETER ResultString
    Specifies the output from the failed `gh` command. This becomes part of the exception message.
.PARAMETER ExitCode
    Specifies the exit code from the failed `gh` command. This is included in the exception message.
.PARAMETER CliParams
    Specifies the parameters passed to the failed `gh` command. This defines the target of the error
    record so a user can understand what was called when the command failed.
.PARAMETER Intent
    Specifies what the `gh` command was supposed to do at a high level. This becomes part of the
    exception message.
.PARAMETER ErrorID
    Specifies an identifier for the error record.
.EXAMPLE
    The cmdlet creates an error record for a failed GH command.
    ```powershell
    $ErrorInfo = @{
        ResultString = 'Unknown command'
        ExitCode = 1
        CliParams = @('repo', 'get', '--owner', 'foo')
        Intent = 'get the foo repo'
        ErrorID = 'gha.repo.get'
    }
    New-CliErrorRecord @ErrorInfo
    ```

    ```Output
    Exception             :
        Type       : System.ApplicationException
        TargetSite :
            Name          : ThrowTerminatingError
            DeclaringType : System.Management.Automation.MshCommandRuntime, System.Management.Automation, Version=7.2.4.500, Culture=neutral, PublicKeyToken=31bf3856ad364e35
            MemberType    : Method
            Module        : System.Management.Automation.dll
        Message    : Author (markekraus) may not target file paths:
                    .github/pwsh
                    .github/workflows

        Source     : System.Management.Automation
        HResult    : -2146232832
        StackTrace :
    at System.Management.Automation.MshCommandRuntime.ThrowTerminatingError(ErrorRecord errorRecord)
    CategoryInfo          : PermissionDenied: (:String) [Test-Authorization.ps1], ApplicationException
    FullyQualifiedErrorId : GHA.NotPermittedToTarget,Test-Authorization.ps1
    InvocationInfo        :
        MyCommand        : Test-Authorization.ps1
        ScriptLineNumber : 1
        OffsetInLine     : 1
        HistoryId        : 125
        Line             : .\.github\pwsh\scripts\Test-Authorization.ps1 -Owner michaeltlombardi -Repo ghe -Author markekraus -TargetPath '.github/pwsh', '.github/workflows'
        PositionMessage  : At line:1 char:1
                        + .\.github\pwsh\scripts\Test-Authorization.ps1 -Owner michaeltlombardi …
                        + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        InvocationName   : .\.github\pwsh\scripts\Test-Authorization.ps1
        CommandOrigin    : Internal
    ScriptStackTrace      : at <ScriptBlock><Process>, C:\code\personal\ghe\.github\pwsh\scripts\Test-Authorization.ps1: line 134
                            at <ScriptBlock>, <No file>: line 1
    ```
#>
function New-CliErrorRecord {
    [CmdletBinding()]
    param(
        [string]$ResultString,
        [int]$ExitCode,
        [string[]]$CliParams,
        [string]$Intent,
        [string]$ErrorID
    )

    begin {
        $AcceptableErrors = @(
            @{
                Pattern = 'HTTP 403: .+ rate limit'
                Message = 'Rate limited by GitHub API; unable to continue.'
            }
        )
    }

    process {
        foreach ($AcceptableError in $AcceptableErrors) {
            if ($ResultString -match $AcceptableError.Pattern) {
                Write-Host -ForegroundColor DarkMagenta $AcceptableError.Message
                exit
            }
        }
        $Message = New-Object -TypeName System.Text.StringBuilder
        $null = $Message.AppendLine("GitHub API call to $Intent failed with exit code ${ExitCode}:")
        $null = $Message.AppendLine("    $ResultString")
        $Message = Format-GHAConsoleText -Text $Message.ToString()
        $Exception = [System.ApplicationException]::new($Message)
        $TargetObject = Format-GHAConsoleText -Text "gh $($CliParams -join ' ')"
        [System.Management.Automation.ErrorRecord]::new(
            $Exception,
            $ErrorID,
            [System.Management.Automation.ErrorCategory]::FromStdErr,
            $TargetObject
        )
    }

    end {}
}
