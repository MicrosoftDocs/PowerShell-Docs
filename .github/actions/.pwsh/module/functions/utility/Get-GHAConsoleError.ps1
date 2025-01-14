<#
.SYNOPSIS
    Returns an alternate view of an error record for the GH CLI
.DESCRIPTION
    This cmdlet returns an alternate view of an error record for the GH CLI. It limits the object
    properties to the fully qualified ID, the type of the error, the error message, and the target
    object (which for GH CLI errors is always the command-line arguments for the failing command).

    It can retrieve errors from the `$error` variable or act on an input object.
.PARAMETER Newest
    Specifies the number of error records to return, from newest to oldest.
.PARAMETER InputObject
    Specifies an error record to get the alternate view for.
.EXAMPLE
    ```powershell
    Get-GHAConsoleError -Newest 1
    ```

    The cmdlet gets the alternate view for the last error in the session.
.EXAMPLE
    ```powershell
    Get-GHAConsoleError -InputObject $error[0]
    ```

    The cmdlet gets the alternate view for the last error in the session.
#>
function Get-GHAConsoleError {
    [CmdletBinding()]
    param(
        [int]$Newest,
        [parameter(ValueFromPipeline)]
        [psobject]$InputObject
    )

    begin {
        $Properties = @(
            'FullyQualifiedErrorId'
            @{
                Name       = 'Type'
                Expression = { $_.CategoryInfo.Reason }
            }
            @{
                Name       = 'Message'
                Expression = { $_.Exception.Message }
            }
            @{
                Name       = 'Command Parameters'
                Expression = { $_.TargetObject }
            }
            'ScriptStackTrace'
        )
    }

    process {
        Get-Error @PSBoundParameters | Select-Object -Property $Properties
    }

    end {}
}
