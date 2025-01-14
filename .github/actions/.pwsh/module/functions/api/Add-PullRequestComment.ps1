<#
.SYNOPSIS
    Adds a comment to a pull request via GitHub CLI.
.DESCRIPTION
    This cmdlet adds a comment to a pull request via GitHub CLI by specifying a raw Markdown string
    or the path to a markdown file containing the comment to write.
.PARAMETER Owner
    The owner of the repository the pull request is in. For `https://github.com/foo/bar/pull/10` the
    owner is `foo`.
.PARAMETER Repo
    The name of the repository the pull request is in. For `https://github.com/foo/bar/pull/10` the
    repo is `bar`.
.PARAMETER Number
    The number of the pull request to comment on. For `https://github.com/foo/bar/pull/10` the
    number is `10`.
.PARAMETER BodyText
    The raw markdown text to write as a comment on the PR.
.PARAMETER BodyFile
    The path to the markdown file to write as a comment on the PR. Due to the way GitHub mistreats
    soft line breaks as hard line breaks in comments (unlike files), the markdown in a body file is
    converted to HTML when writing the comment. From the user perspective, it's a normal comment.
.EXAMPLE
    Add-PullRequestComment -Owner foo -Repo bar -Number 10 -BodyText @'
    Hello, _world_! How are **you**?
    '@

    The cmdlet adds a comment to `https://github/foo/bar/pull/10`, rendering the body text' markdown
    in the comment.
.EXAMPLE
    Add-PullRequestComment -Owner foo -Repo bar -Number 10 -BodyFile ./messages/hello.md

    The cmdlet adds a comment to `https://github/foo/bar/pull/10`, rendering the contents of
    `hello.md` in the comment.
#>

function Add-PullRequestComment {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$Owner,
        [parameter(Mandatory)]
        [string]$Repo,
        [parameter(Mandatory)]
        [int]$Number,
        [Parameter(Mandatory, ParameterSetName = 'Text')]
        [string]$BodyText,
        [Parameter(Mandatory, ParameterSetName = 'File')]
        [string]$BodyFile
    )

    begin {
        $AddCommentParams = @(
            'pr', 'comment', $Number
            '--repo', "$Owner/$Repo"
        )
        if (![string]::IsNullOrEmpty($BodyText)) {
            $AddCommentParams += '--body'
            $AddCommentParams += $BodyText
        } else {
            $AddCommentParams += '--body-file'
            $AddCommentParams += $BodyFile
        }
    }

    process {
        [string]$ResultString = gh @AddCommentParams 2>&1
        $ExitCode = $LASTEXITCODE

        if ($ExitCode -ne 0) {
            $ErrorParameters = @{
                ResultString = $ResultString
                ExitCode     = $ExitCode
                CliParams    = $AddCommentParams
                Intent       = "write expectations comment on PR $Number in $Owner/$Repo"
                ErrorID      = 'GitHub.ApiPostFailure'
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

        $ResultString
    }

    end {}
}
