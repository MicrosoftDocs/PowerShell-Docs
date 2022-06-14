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

  Specify the owner of the repository with the PR to inspect for changes. For
  `https://github.com/foo/bar`, the owner is `foo`.

.PARAMETER Repo

  Specify the name of the repository with the PR to inspect for changes. For
  `https://github.com/foo/bar`, the repo is `bar`.

.PARAMETER Number

  Specify the number of the PR to inspect for changes.

.PARAMETER ExcludePathPattern

  Specify one or more regex patterns as a string. The list of changed files for the Pull Request is
  filtered, comparing the path of the changed file to each pattern in this list. If the path of the
  changed file matches any of the patterns specified, that change is discarded from the change
  report.

.PARAMETER IncludePathPattern

  Specify one or more regex patterns as a string. The list of changed files for the Pull Request is
  filtered, comparing the path of the changed file to each pattern in this list. If the path of the
  changed file does not match any of the patterns specified, that change is discarded from the
  change report.

.EXAMPLE

  ```powershell
  ./Add-Expectations.ps1 -Owner Foo -Repo Bar -Number 123
  ```

  The script finds the changes made in `https://github.com/foo/bar/pulls/123` and analyzes those
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
  [int]$Number,
  [string[]]$ExcludePathPattern,
  [string[]]$IncludePathPattern
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
}

process {
  try {
    $ChangedContent = Get-PullRequestChangedFile -Owner $Owner -Repo $Repo -Number $Number -All
  } catch {
    $Record = $_ | Get-GHAConsoleError
    Write-ActionFailureSummary -Record $Record -Synopsis 'Unable to find open PRs.'
    $PSCmdlet.ThrowTerminatingError($_)
  }

  Write-Host "Discovered Changed Content:" -ForegroundColor Blue
  Write-Host ($ChangedContent | Format-Table | Out-String)

  if ($IncludePath.Count -gt 0) {
    $ChangedContent = $ChangedContent | Where-Object -FilterScript {
      foreach ($Pattern in $IncludePathPattern) {
        if ($_.Path -match $Pattern) {
          return $true
        }
      }
      return $false
    }
  }

  if ($ExcludePath.Count -gt 0) {
    $ChangedContent = $ChangedContent | Where-Object -FilterScript {
      foreach ($Pattern in $ExcludePathPattern) {
        if ($_.Path -notmatch $Pattern) {
          return $true
        }
      }
      return $false
    }
  }

  $null = $Summary.AppendLine('# Versioned Content Change Report').AppendLine()
  $null = $Summary.AppendLine('> Pull Request:').AppendLine('>')
  $null = $Summary.AppendLine('> ```yaml')
  $null = $Summary.AppendLine("> Owner:  $Owner")
  $null = $Summary.AppendLine("> Repo:   $Repo")
  $null = $Summary.AppendLine("> Number: $Number")
  $null = $Summary.AppendLine('> ```').AppendLine()


  if ($ChangedContent.Count -eq 0) {
    $null = $Summary.AppendLine('No changes to versioned content found.').AppendLine()
    $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
    exit 0
  } else {
    Write-Host "Changed Content after inclusion/exclusion:" -ForegroundColor Blue
    Write-Host ($ChangedContent | Format-Table | Out-String)
  }
  
  $ChangeSetsWithStatus = Get-VersionedContentChangeStatus -ChangedContent $ChangedContent
  | Sort-Object -Stable -Property BaseFolder, VersionRelativePath

  # Find the column widths for all tables in the future
  $RelativePathWidth, $VersionWidth = Get-VersionedContentTableColumnWidth -ChangeSet $ChangeSetsWithStatus

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
  $null = $Summary.AppendLine('- **Added:** The file was added. Git status `A`.')
  $null = $Summary.AppendLine("- **Changed:** The file's type was changed. Git status ``T``.")
  $null = $Summary.AppendLine('- **Copied:** The file was copied. Git status `C`.')
  $null = $Summary.AppendLine("- **Modified:** The file's contents were changed. Git status ``M``.")
  $null = $Summary.AppendLine('- **Removed:** The file was deleted. Git status `D`.')
  $null = $Summary.AppendLine('- **Renamed:** The file was renamed. Git status `R`.')
  $null = $Summary.AppendLine('- **Unchanged:** The file was not modified.')
  $null = $Summary.AppendLine('- **N/A:** The file does not exist for this version.')
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

    Write-Host "Changes in ${BaseFolder}:" -ForegroundColor Blue
    foreach ($ChangeSet in $ChangeSetsInBaseFolder) {
      Write-Host $ChangeSet.VersionRelativePath -ForegroundColor Cyan
      $VersionInfo = [PSCustomObject]@{}
      foreach ($Version in $ChangeSet.Versions) {
        $PropertyParameters = @{
          Name       = $Version.Version
          Value      = $Version.ChangeType
          MemberType = 'NoteProperty'
        }
        $VersionInfo | Add-Member @PropertyParameters
      }
      Write-Host ($VersionInfo | Format-List | Out-String)
    }

    <#
      Handle changes in the root of the version folder first, before all subfolders. For example:

      reference/1.2/foo.md     # in root
      reference/1.2/bar/baz.md # not in root
    #>
    $ChangesInVersionRootFolder = $ChangeSetsInBaseFolder | Where-Object {
      $_.VersionRelativePath -notmatch '(\\|\/)'
    }

    if ($ChangesInVersionRootFolder.Count -gt 0) {
      $ChangeSets = $ChangesInVersionRootFolder
      $null = $Summary.AppendLine("### Change Sets in the version root folder").AppendLine()
      $TableParameters = @{
        ChangeSet         = $ChangeSets
        Summary           = $Summary
        RelativePathWidth = $RelativePathWidth
        VersionWidth      = $VersionWidth
      }
      Add-VersionedContentTable @TableParameters
    }

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
      $TableParameters = @{
        ChangeSet         = $ChangeSets
        Summary           = $Summary
        RelativePathWidth = $RelativePathWidth
        VersionWidth      = $VersionWidth
      }
      Add-VersionedContentTable @TableParameters
    }
  }
  $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
  exit 0
}

end {}