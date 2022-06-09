<#
.SYNOPSIS
  Ensures all open community PRs have an expectations comment.
.DESCRIPTION
  This script ensures all open community PRs have an expectations comment. It searches the
  repository for open pull requests without the comment (identified by an HTML comment with a
  special ID in it) and then checks each open pull request to see if the author is a maintainer or
  a community member. If the author is a maintainer, the script skips that PR. If the author is a
  community member, writes the contents of the message rendered as HTML from Markdown as a comment
  on the PR.
.PARAMETER Owner
  The owner of the repository to search for uncommented PRs. For `https://github.com/foo/bar`, the
  owner is `foo`.
.PARAMETER Repo
  The name of the repository to search for uncommented PRs. For `https://github.com/foo/bar`, the
  repo is `bar`.
.PARAMETER Message
  The message to write on uncommented PRs. Must be a single string and should be written as markdown
  for best results. The message should include somewhere in it the following HTML comment:

  `<!-- GHA.Comment.Id.Community.Expectations -->`

  Failure to include that comment in the message causes the script to add the comment to PRs it
  already commented on, as it uses the presence of that annotation to find the expectations comment.
.EXAMPLE
  ```powershell
  $Message = Get-Content -Raw ./messages/expectations.md
  ./Add-Expectations.ps1 -Owner Foo -Repo Bar -Message $Message
  ```

  The script searches `https://github.com/foo/bar` for open pull requests targeting the `main`
  branch which do not already have an expectations comment. If the PR author is not a maintainer, it
  adds the text from the `expectations.md` file rendered as HTML as a comment on the PR.
#>
[cmdletbinding()]
param(
  [Parameter(Mandatory)]
  [string]$Owner,
  [Parameter(Mandatory)]
  [string]$Repo,
  [Parameter(Mandatory)]
  [Alias('Markdown', 'Text')]
  [string]$Message
)

begin {
  <#
    Setup steps:

    - Need to import the GHA module, which contains all of the functions that interact with the API
      and includes helper utilities for console formatting.
    - Need a string builder to generate the markdown summary for this step.
    - Need to grab the values for ANSI and PlainText output rendering so the markdown in the summary
      doesn't include ANSI decorations.
    - Need to create empty arrays to grab the data on comments and failures.
    - Need to grab the path to the body file for the PR comment.
  #>
  $GitHubFolder = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
  $ModuleFile = Resolve-Path -Path "$GitHubFolder/.pwsh/module/gha.psd1"
  | Select-Object -ExpandProperty Path
  Import-Module $ModuleFile -Force
  $Summary = New-Object -TypeName System.Text.StringBuilder
  $Ansi = [System.Management.Automation.OutputRendering]::Ansi
  $Plain = [System.Management.Automation.OutputRendering]::PlainText
  $Failures = @()
  $Comments = @()
  $CachedAuthors = @{}
  # We convert to HTML to deal with GitHub's bad markdown parsing for comments, which treats soft
  # line breaks like hard line breaks. Because this comment isn't edited by a human, that's fine.
  $BodyText = $Message
  | ConvertFrom-Markdown
  | Select-Object -ExpandProperty Html
}

process {
  # Retrieve open PRs to this repo without an expectation comment; if this fails, end the script.
  # Nothing else will work anyway.
  try {
    $OpenPRsWithoutExpectations = Get-OpenPRWithoutExpectation -Owner $Owner -Repo $Repo
  } catch {
    $Record = $_ | Get-GHAConsoleError
    Write-ActionFailureSummary -Record $Record -Synopsis 'Unable to find open PRs.'
    $PSCmdlet.ThrowTerminatingError($_)
  }
  
  $null = $Summary.AppendLine("## Open Pull Requests").AppendLine()
  if ($OpenPRsWithoutExpectations.Count -eq 0) {
    $OpenPRsMessage = 'Found no open PRs without an expectations comment.'
    Format-ConsoleStyle -Text "$OpenPRsMessage" -StyleComponent $PSStyle.Foreground.BrightYellow
    $null = $Summary.AppendLine($OpenPRsMessage).AppendLine()
  } else {
    $OpenPRsMessage = 'Found open PRs without an expectations comment:'
    $null = $Summary.AppendLine($OpenPRsMessage).AppendLine()
    Format-ConsoleStyle -Text "$OpenPRsMessage" -StyleComponent $PSStyle.Foreground.BrightYellow
    $OpenPRsWithoutExpectations
    | Sort-Object -Property Number -OutVariable OpenPRsWithoutExpectations
    | Format-Table | Out-String | ForEach-Object -Process { $_.Trim() }
    $OpenPRsWithoutExpectations | ForEach-Object -Process {
      $PullRequestLink = "[#$($_.Number)](https://github.com/$Owner/$Repo/pull/$($_.Number))"
      $OpenPullRequestMarkdown = "- $PullRequestLink by ``$($_.Author)``"
      $null = $Summary.AppendLine($OpenPullRequestMarkdown)
    }
    $null = $Summary.AppendLine()
  }

  foreach ($OpenPR in $OpenPRsWithoutExpectations) {
    $Author = $OpenPR.Author
    $Number = $OpenPR.Number
    $ConsoleNumber = Format-ConsoleStyle -Text $Number -StyleComponent @(
      $PSStyle.Bold
      $PSStyle.Foreground.BrightBlue
    )
    $ConsoleAuthor = Format-ConsoleStyle -Text $Author -StyleComponent @(
      $PSStyle.Bold
      $PSStyle.Foreground.BrightYellow
    )
    try {
      # Check if the PR author is an admin or a maintainer; if they are, skip them. If this fails,
      # we immediately go to the catch block and skip this PR for commenting. If the author is not
      # an admin or maintainer, comment on the PR with expectations for the process.
      $AuthorStatus = $CachedAuthors.$Author
      if ($AuthorStatus -eq 'Community') {
        "`nAttempting to comment on PR $ConsoleNumber by $ConsoleAuthor..."
      } elseif ($AuthorStatus -eq 'Maintainer') {
        "`nSkipping PR $ConsoleNumber; $ConsoleAuthor is admin or maintainer."
        continue
      } else {
        # These log messages only shows up in the console logs; would clutter the markdown summary
        # if included there.
        "`nChecking to see if author ($ConsoleAuthor) of PR $ConsoleNumber is a community member..."
        $Permissions = Get-AuthorPermission -Owner $Owner -Repo $Repo -Author $Author
        if ($Permissions.Admin -or $Permissions.Maintain) {
          "Skipping PR $ConsoleNumber; $ConsoleAuthor is admin or maintainer."
          $CachedAuthors.$Author = 'Maintainer'
          continue
        } else {
          "Attempting to comment on PR $ConsoleNumber..."
          $CachedAuthors.$Author = 'Community'
        }
      }

      $CommentParameters = @{
        Owner    = $Owner
        Repo     = $Repo
        Number   = $OpenPR.Number
        BodyText = $BodyText
      }
      $Uri = Add-PullRequestComment @CommentParameters
      "Commented on PR $ConsoleNumber by $ConsoleAuthor at: $Uri"

      $Comments += @{
        Author     = $Author
        Number     = $Number
        TimeStamp  = [datetime]::Now
        CommentUri = $Uri
      }
    }
    catch {
      $Failures += $_ | Get-GHAConsoleError
      continue
    }
  }
}

end {
  # Add a section to the summary markdown to list all of the commented-on PRs. Includes the link to
  # the comment, the author's handle (without @-mentioning them), and the timestamp for the comment.
  if ($Comments.Count -gt 0) {
    $null = $Summary.AppendLine('## Added Expectation Comments').AppendLine()
    $Comments | Sort-Object -Property Number | ForEach-Object -Process {
      $CommentMarkdown = @(
        "- [$Owner/$Repo/pull/$($_.Number)]($($_.CommentUri))"
        "by ``$($_.Author)``"
        "at ``$($_.TimeStamp.ToUniversalTime().ToString('u'))``."
      ) -join ' '
      $null = $Summary.AppendLine($CommentMarkdown)
    }
    $null = $Summary.AppendLine()
  }
  # Add a section to the summary markdown to list all of the failures in readable code blocks. The
  # errors are also written into the run log.
  if ($Failures.Count -gt 0) {
    $null = $Summary.AppendLine('## Action Failures').AppendLine()
    $FailureMessage = 'Error(s) occurred during action. Error details:'
    $null = $Summary.AppendLine($FailureMessage).AppendLine()
    Format-ConsoleStyle -Text $FailureMessage -StyleComponent @(
      $PSStyle.Bold
      $PSStyle.Foreground.Magenta
    )
    $Failures | ForEach-Object -Process {
      $PSStyle.OutputRendering = $Plain
      $null = $Summary.AppendLine('```text')
      $RecordBlock = $Record | Format-List -Property * | Out-String
      $null = $Summary.AppendLine($RecordBlock.Trim())
      $null = $Summary.AppendLine('```').AppendLine()
      $PSStyle.OutputRendering = $Ansi
      $Record | Format-List -Property *
    }
  }
  # Write the summary file and exit; if any failures happened, exit code is number of failures. Any
  # exit code other than 0 is interpreted as job failure.
  $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
  exit $Failures.Count
}
