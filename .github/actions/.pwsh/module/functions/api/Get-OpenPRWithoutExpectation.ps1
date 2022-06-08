<#
.SYNOPSIS
    Retrieves open PRs without an expectations comment.
.DESCRIPTION
    This cmdlet searches a repository for open pull requests targeting the `main` branch which do
    not have an expectations comment on them already. It returns a hashtable with the author and
    number of every pull request in the repository matching these criteria.
.PARAMETER Owner
    The owner of the repository to search for uncommented PRs. For `https://github.com/foo/bar`, the
    owner is `foo`.
.PARAMETER Repo
    The name of the repository to search for uncommented PRs. For `https://github.com/foo/bar`, the
    repo is `bar`.
.EXAMPLE
    Get-OpenPRWithoutExpectations -Owner foo -Repo bar

    The cmdlet searches the `https://github.com/foo/bar` repository for open pull requests to the
    `main` branch which do not have an expectations comment on them already.
#>
function Get-OpenPRWithoutExpectation {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$Owner,
        [parameter(Mandatory)]
        [string]$Repo
    )
  
    begin {
        $ApiQueryParams = @(
            'search', 'prs'
            '--repo', "$Owner/$Repo"
            '--base', 'main'
            '--state', 'open'
            '--json', 'author'
            '--json', 'number'
            'NOT', 'in:comments', 'GHA.Comment.Id.Community.Expectations'
        )

        $ReturnProperties = @(
            @{
                Name = 'Author'
                Expression = { $_.author.login }
            }
            @{
                Name = 'Number'
                Expression = { $_.number }
            }
        )
    }
  
    process {
        [string[]]$ResultString = gh @ApiQueryParams 2>&1
        Write-Verbose -Message "Command:`n`tgh $($ApiQueryParams -join ' ')"
        Write-Verbose -Message "Result String:`n`t$($ResultString -join "`n`t")"
        $ExitCode = $LASTEXITCODE
      
        if ($ExitCode -ne 0) {
            $ErrorParameters = @{
                ResultString = ($ResultString -join "`n")
                ExitCode     = $ExitCode
                CliParams    = $ApiQueryParams
                Intent       = 'retrieve open PRs without an expectations comment'
                ErrorID      = 'GitHub.ApiQueryFailure'
            }
            $Record = New-CliErrorRecord @ErrorParameters
            $PSCmdlet.ThrowTerminatingError($Record)
        }
  
        $ResultString | ConvertFrom-Json | Select-Object -Property $ReturnProperties
    }
  
    end {}
}