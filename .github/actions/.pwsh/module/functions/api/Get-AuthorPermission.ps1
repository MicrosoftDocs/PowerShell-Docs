<#
.SYNOPSIS
    Retrieves repository permissions for a user.
.DESCRIPTION
    This cmdlet retrieves repository permissions for a user, returning a hashtable that enumerates
    whether the user can admin, maintain, push, triage, and/or pull.
.PARAMETER Owner
    The owner of the repository to check the user's permissions in. For `https://github.com/foo/bar`
    the owner is `foo`.
.PARAMETER Repo
    The name of the repository to check the user's permissions in. For `https://github.com/foo/bar`
    the repo is `bar`.
.PARAMETER Author
    The username to retrieve permissions for.
.EXAMPLE
    Get-AuthorPermission -Owner foo -Repo bar -Author baz

    The cmdlet checks the `baz` user's permissions in the `https://github.com/foo/bar` repository.
#>

function Get-AuthorPermission {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$Owner,
        [parameter(Mandatory)]
        [string]$Repo,
        [parameter(Mandatory)]
        [string]$Author
    )

    begin {
        $ApiQueryParams = @(
            'api', "repos/$Owner/$Repo/collaborators/$Author/permission"
        )

        $ReturnProperties = @(
            @{
                Name = 'Admin'
                Expression = { $_.user.permissions.admin }
            }
            @{
                Name = 'Maintain'
                Expression = { $_.user.permissions.maintain }
            }
            @{
                Name = 'Push'
                Expression = { $_.user.permissions.push }
            }
            @{
                Name = 'Triage'
                Expression = { $_.user.permissions.triage }
            }
            @{
                Name = 'Pull'
                Expression = { $_.user.permissions.pull }
            }
        )
    }

    process {
        [string]$ResultString = gh @ApiQueryParams 2>&1
        $ExitCode = $LASTEXITCODE

        if ($ExitCode -ne 0) {
            $ErrorParameters = @{
                ResultString = $ResultString
                ExitCode     = $ExitCode
                CliParams    = $ApiQueryParams
                Intent       = "retrieve permissions for author '$Author' in $Owner/$Repo"
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

        $ResultString | ConvertFrom-Json | Select-Object -Property $ReturnProperties
    }

    end {}
}
