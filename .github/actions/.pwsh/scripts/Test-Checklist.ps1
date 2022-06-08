<#
.SYNOPSIS
  Inspects Markdown to find checklist items and their status
.DESCRIPTION
  This script inspects the Markdown body of a Pull Request or GitHub comment to find mandatory
  checklist items and determine if they are checked or not. It writes console messages and a GitHub
  summary annotating the findings. If any mandatory checklist items are discovered and not checked,
  the script throws an exception, failing both the script and associated GitHub Action.

  To discover mandatory checklist items, it looks for checklist entries that are bolded with
  double-asterisks and a colon suffix. For example:

  ```markdown
  - Not a checklist item
  - [ ] Not a _mandatory_ checklist item
  - [ ] **Foo:** a mandatory checklist item that _is not_ checked
  - [x] **Bar:** a mandatory checklist item that _is_ checked.
  ```
.PARAMETER Body
  A block of Markdown text to inspect. This can come from a pull request or comment or you can pass
  an arbitrary block of Markdown to verify what mandatory checklist items exist and what their
  status is while developing a checklist.
.PARAMETER ReferenceUrl
  The URL to the pull request, comment, or other source of the Markdown passed in the **Body**. This
  is only used for the error generation/reporting if the checklist is not fully filled out.
.EXAMPLE
  ```pwsh
  $PullRequest = gh pr view --repo 'foo/bar' 123 --json body --json url | ConvertFrom-Json
  ./Test-Checklist.ps1 -Body $PullRequest.Body -ReferenceUrl $PullRequest.Url
  ```

  This example gets pull request 123 from the `bar` repository owned by `foo`, retrieving the body
  and URL of that pull request. It then passes those values to the script, which then inspects the
  body for mandatory checklist items and report their status.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)]
  [string]$Body,
  [string]$ReferenceUrl = 'Arbitrary'
)

begin {
  $GitHubFolder = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
  $ModuleFile = Resolve-Path -Path "$GitHubFolder/.pwsh/module/gha.psd1"
  | Select-Object -ExpandProperty Path
  Import-Module $ModuleFile -Force
  # Style Setup
  $NameStyle = $PSStyle.Foreground.BrightYellow
  $StatusStyle = @{
    Symbol = @{
      Checked = '✔ '
      Missing = '✖ '
    }
    Font = @{
      Checked = $PSStyle.Bold + $PSStyle.Foreground.BrightBlue
      Missing = $PSStyle.Bold + $PSStyle.Foreground.BrightMagenta
    }
  }
  $Summary = New-Object -TypeName System.Text.StringBuilder
  # Initialize variables
  $MissingItemCount = 0
}

process {
  # Get Checklist Items
  $null = $Summary.AppendLine('# Pull Request Checklist').AppendLine()
  $null = $Summary.AppendLine('| Item | State |')
  $null = $Summary.AppendLine('|:-----|:-----:|')
  $CheckListItems = $Body -split "`n" | ForEach-Object {
    if ($_ -match '- \[(?<Checked>.)\] \*\*(?<Name>.+):') {
      $Status = $Matches.Checked -eq 'x' ? 'Checked' : 'Missing'
      $Font = $StatusStyle.Font.$Status
      $Name = $Matches.Name
      [PSCustomObject]@{
        Name = $NameStyle + $Name + $PSStyle.Reset
        Prefix = $Font + $StatusStyle.Symbol.$Status + $PSStyle.Reset
        Status = $Font + $Status + $PSStyle.Reset
      }
      $null = $Summary.AppendLine("| **$Name** | $($StatusStyle.Symbol.$Status) |")
    }
  }

  # Add final newline and write summary; at this point we know everything we need for
  # the summary itself, the rest is for console logging and failure reporting
  $null = $Summary.AppendLine()
  $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
  
  # Get an appropriate padding width so the status values line up
  $PaddingWidth = 0
  $CheckListItems | ForEach-Object -Process {
    $Width = ($_.Prefix + "`t" + $_.Name).Length + 3 # pad right for the colon and space
    if ($PaddingWidth -lt $Width) {
      $PaddingWidth = $Width
    }
  }
  
  
  # Display Results
  foreach ($Item in $CheckListItems) {
    if ($Item.Prefix -notmatch '✔') {
      $MissingItemCount++
    }
    
    "$($Item.Prefix)$($Item.Name): ".PadRight($PaddingWidth) + $Item.Status
  }
  
  # Write summary message + exit if any checks are missing
  if ($MissingItemCount) {
    "" # Add a blank line before message
    $Message = @(
      "Missing $MissingItemCount of the checklist items."
      'Please review the PR checklist.'
    ) -join ' '
    $Message = Format-GHAConsoleText -Text $Message
    $Exception = [System.ApplicationException]::new($Message)
    $Record = [System.Management.Automation.ErrorRecord]::new(
      $Exception,
      'GHA.Checklist.NotComplete',
      [System.Management.Automation.ErrorCategory]::InvalidResult,
      $ReferenceUrl
    )
    $PSCmdlet.ThrowTerminatingError($Record)
  }
}

end {}