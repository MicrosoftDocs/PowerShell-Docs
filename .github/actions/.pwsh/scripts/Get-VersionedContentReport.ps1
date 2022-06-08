<#
.SYNOPSIS
  Analyzes changes for versioned content.
.DESCRIPTION
  This script analyzes a changeset to discover versioned content and writes a report in the console
  and as a GitHub Action summary, enumerating the versioned content changes and whether those
  changes were made across all versions of the content.

  It does not analyze whether such changes are needed or correct, only how each version of the
  content was changed (or that it was not changed). This report still requires human analysis and
  investigation but is intended to provide an easier way to see the aggregated changes across
  versioned content to understand if all affected versions have been updated or not.
.PARAMETER Owner
  The owner of the repository with the PR to inspect for changes. For `https://github.com/foo/bar`,
  the owner is `foo`.
.PARAMETER Repo
  The name of the repository with the PR to inspect for changes. For `https://github.com/foo/bar`,
  the repo is `bar`.
.PARAMETER Number
  The number of the PR to inspect for changes.
.EXAMPLE
  ./.github/pwsh/scripts/Add-Expectations.ps1 -Owner Foo -Repo Bar -Number 123

  The script finds the changes made in https://github.com/foo/bar/pulls/123` and analyzes those
  changes to find changes to versioned content. It then writes a report for each changed folder and
  file enumerating the high-level changes across all versions that file belongs in.
#>
[cmdletbinding()]
param(
  [Parameter(Mandatory)]
  [string]$Owner,
  [Parameter(Mandatory)]
  [string]$Repo,
  [Parameter(Mandatory)]
  [int]$Number
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
  $ModuleFile = Resolve-Path -Path "$GitHubFolder/pwsh/gha/gha.psm1"
  | Select-Object -ExpandProperty Path
  Import-Module $ModuleFile -Force
  $Summary = New-Object -TypeName System.Text.StringBuilder
  $Ansi = [System.Management.Automation.OutputRendering]::Ansi
  $Plain = [System.Management.Automation.OutputRendering]::PlainText
}

process {
  try {
    $ChangedContent = Get-PullRequestChangedFile -Owner $Owner -Repo $Repo -Number $Number -All
  } catch {
    $Record = $_ | Get-GHAConsoleError
    Write-ActionFailureSummary -Record $Record -Synopsis 'Unable to find open PRs.'
    $PSCmdlet.ThrowTerminatingError($_)
  }
  
  $ChangeSetsWithStatus = Get-VersionedContentChangeStatus -ChangedContent $ChangedContent
  | Sort-Object -Stable -Property BaseFolder, VersionRelativePath

  $null = $Summary.AppendLine('# Versioned Content Change Report').AppendLine()
  $null = $Summary.AppendJoin(
    ' ',
    'This report is organized by base folder (a folder containing multiple versions of content)',
    'with child folders beneath. Each child folder section enumerates all of the changes to files',
    'in that folder across the versions in tables.'
  ).AppendLine().AppendLine()
  $null = $Summary.AppendJoin(
    ' ',
    'Each table includes the version-relative path to the files and the change status of those',
    'files for each version. The version-relative path is the remainder of the path from the',
    'version folder. For example, the file `reference/5.1/Foo/Bar/Baz.md` is in the `reference`',
    'base folder and has a version-relative path of `Foo/Bar/Baz.md`. For change status, every',
    'versioned file will have one of the following statuses:'
  ).AppendLine().AppendLine()
  $null = $Summary.AppendLine('- `added`: The file was added. Git status `A`.')
  $null = $Summary.AppendLine("- ``changed``: The file's type was changed. Git status `T`.")
  $null = $Summary.AppendLine('- `copied`: The file was copied. Git status `C`.')
  $null = $Summary.AppendLine("- ``modified``: The file's contents were changed. Git status `M`.")
  $null = $Summary.AppendLine('- `removed`: The file was deleted. Git status `D`.')
  $null = $Summary.AppendLine('- `renamed`: The file was renamed. Git status `R`.')
  $null = $Summary.AppendLine('- `unchanged`: The file was not modified.')
  $null = $Summary.AppendLine('- `n/a`: The file does not exist for this version.')
  $null = $Summary.AppendLine().AppendJoin(
    ' ',
    'In cases where the change status of a file is not the same across versions, the Pull Request',
    'author and reviewer should both double check the file to understand if the discrepancy is',
    'intentional or accidental.'
  ).AppendLine().AppendLine()

  [string[]]$BaseFolders = $ChangeSetsWithStatus.BaseFolder | Select-Object -Unique

  foreach ($BaseFolder in $BaseFolders) {
    $null = $Summary.AppendLine("## Base Folder: ``$BaseFolder``").AppendLine()
    $ChangeSetsInBaseFolder = $ChangeSetsWithStatus | Where-Object -FilterScript {
      $_.BaseFolder -eq $BaseFolder
    }
    $null = $Summary.AppendJoin(
      ' ',
      "Changed **$($ChangeSetsInBaseFolder.Count)** versioned files in ``$BaseFolder``.",
      "See below for details per folder."
    ).AppendLine().AppendLine()

    [string[]]$ChangeSetFolders = $ChangeSetsInBaseFolder | ForEach-Object {
      $Folder = Split-Path -Parent $_.VersionRelativePath
      while (![string]::IsNullOrEmpty($Folder)) {
        $Folder -replace '\\', '/'
        $Folder = Split-Path -Parent $Folder
      }
    } | Select-Object -Unique | Sort-Object

    foreach($Folder in $ChangeSetFolders) {
      $ChangeSets = $ChangeSetsInBaseFolder | Where-Object -FilterScript {
        $_.VersionRelativePath -match "$Folder\/[^\/]+`$"
      }
      if ($null -eq $ChangeSets) {
        continue
      }
      $null = $Summary.AppendLine("### Change Sets for ``$Folder``").AppendLine()
      $RelativePathWidth = 30
      $ChangeSets.VersionRelativePath | ForEach-Object -Process {
        if (($_.Length + 4) -gt $RelativePathWidth) {
          $RelativePathWidth = $_.Length + 4
        }
      }
      $VersionList = $ChangeSets.Versions.Version | Select-Object -Unique
      $VersionWidth = 14
      $VersionList | ForEach-Object -Process {
        if (($_.Length + 4) -gt $VersionWidth) {
          $VersionWidth = $_.Length + 4
        }
      }
      # Setup table header
      $null = $Summary.Append("|$(' Version-Relative Path'.PadRight($RelativePathWidth))")
      foreach ($Version in $VersionList) {
        $null = $Summary.Append("|$(" $Version".PadRight($VersionWidth))")
      }
      $null = $Summary.AppendLine('|')
      $null = $Summary.Append("|:$('-' * ($RelativePathWidth - 1))")
      foreach($Version in $VersionList) {
        $null = $Summary.Append("|:$('-' * ($VersionWidth - 2)):")
      }
      $null = $Summary.AppendLine('|')
      # loop over change sets; version status or `N/A` if it doesn't exist.
      foreach ($ChangeSet in $ChangeSets) {
        $RelativePath = $ChangeSet.VersionRelativePath
        $null = $Summary.Append("|$(" ``$RelativePath`` ".PadRight($RelativePathWidth))")
        foreach ($Version in $VersionList) {
          $ChangeType = $ChangeSet.Versions.Where({$_.Version -eq $Version}).ChangeType
          if ([string]::IsNullOrEmpty($ChangeType)) {
            $ChangeType = 'n/a'
          }
          $null = $Summary.Append("|$(" ``$ChangeType`` ".PadRight($VersionWidth))")
        }
        $null = $summary.AppendLine('|')
      }
      $null = $Summary.AppendLine()
    }
  }
  $Summary.ToString()
}

end {}