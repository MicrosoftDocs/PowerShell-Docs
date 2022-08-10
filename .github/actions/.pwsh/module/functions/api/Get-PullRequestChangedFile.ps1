<#
.SYNOPSIS
    Retrieves the list of file changes for a PR
.DESCRIPTION
    This cmdlet retrieves the list of file changes for a PR, returning an array of relative file
    paths and the change type: `added`, `removed`, `modified`, `renamed`, `copied`, `changed`, or
    `unchanged`.
.PARAMETER Owner
    The owner of the repository the pull request is in. For `https://github.com/foo/bar/pull/10` the
    owner is `foo`.
.PARAMETER Repo
    The name of the repository the pull request is in. For `https://github.com/foo/bar/pull/10` the
    repo is `bar`.
.PARAMETER Number
    The number of the pull request to get changed files from. For `https://github.com/foo/bar/pull/10` the
    number is `10`.
.PARAMETER All
    Indicates that the query should return all files; by default, returns only the first 30.
.EXAMPLE
    Get-AuthorPermission -Owner foo -Repo bar -Author baz

    The cmdlet checks the `baz` user's permissions in the `https://github.com/foo/bar` repository.
#>

function Get-PullRequestChangedFile {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$Owner,
        [parameter(Mandatory)]
        [string]$Repo,
        [parameter(Mandatory)]
        [int]$Number,
        [switch]$All
    )

    begin {
        $ApiQueryParams = @(
            'api', "repos/$Owner/$Repo/pulls/$Number/files"
            '--jq', '.[] | { Path: .filename, ChangeType: .status }'
        )
        if ($All) {
            $ApiQueryParams += '--paginate'
        }
    }

    process {
        [string[]]$ResultString = gh @ApiQueryParams 2>&1
        $ExitCode = $LASTEXITCODE

        if ($ExitCode -ne 0) {
            $ErrorParameters = @{
                ResultString = ($ResultString -join "`n")
                ExitCode     = $ExitCode
                CliParams    = $ApiQueryParams
                Intent       = "retrieve files for PR $Number in $Owner/$Repo"
                ErrorID      = 'GitHub.ApiQueryFailure'
            }
            $Record = New-CliErrorRecord @ErrorParameters

            # If an error record is returned, the error is unhandled and the action should fail.
            # If no error record is returned, the error is acceptable and the action should exit.
            if ($Record) {
                $PSCmdlet.ThrowTerminatingError($Record)
            } else {
                exit
            }
        }

        $ResultString | ConvertFrom-Json
    }

    end {}
}
