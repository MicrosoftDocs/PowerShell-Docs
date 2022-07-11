<#
.SYNOPSIS

  Inspect a folder for stale content

.DESCRIPTION

  This script inspects one or more folders, looking for Markdown documents that are stale as
  indicated by the **ms.date** key in their frontmatter. It writes a console log and a GitHub Action
  job summary by default.
  
  It can be used to export a CSV report of the stale content and to upload that report as a GitHub
  Action artifact as part of an action execution.

.PARAMETER RelativeFolderPath

  Specify the path to one or more folders to search for stale documents relative to the current
  working directory. Do not use any wildcard characters. The value for this parameter is interpreted
  literally. Additionally, this value is used to determine the root path of any stale documents.

  If you specify any values including a wildcard character, this cmdlet warns you about the
  consequences. You can suppress this warning by specifying `SilentlyContinue` for the
  **WarningAction** parameter.

.PARAMETER ExcludeFolderSegment
  Specify one or more complete folder segments as strings to exclude from the list of files to
  report on. Any file whose path matches an excluded segment will be discarded from the list prior
  to inspection.

.PARAMETER DaysUntilStale

  Specify an integer representing how many days can pass before a document is considered
  stale. If any document's `ms.date` key is older than this value, it is returned as a stale
  document.

.PARAMETER StaleSinceDate

  Specify a datetime object representing the point at which any older documents are considered
  stale. If any document's `ms.date` key is older than this value, it is returned as a stale
  document. This value defaults to `330` days before this cmdlet is called.

.PARAMETER PassThru

  Specify to return the report data as an array of objects. By default, no objects are emitted to
  the output stream, only console logs to the host.

.PARAMETER UploadArtifact

  Specify to upload the CSV of the report as an artifact during a GitHub Action execution. This
  parameter implies the use of **ExportAsCsv**, you do not need to specify them together.

.PARAMETER ExportAsCsv

  Specify to write the report as a CSV file.

.PARAMETER ExportPath

  Specify the path to where the CSV file should be written. This parameter is only valid with the
  **UploadArtifact** or **ExportAsCsv** parameters. By default, the report is written in the current
  directory as `StaleContentReport.<%Y-%m-%d>.csv`, like `StaleContentReport-2022-07-15.csv`

.EXAMPLE

  ```powershell
  ./Get-StaleContentReport.ps1 -RelativeFolderPath ./reference/conceptual
  ```

  In this example, the script recursively searches the `reference/conceptual` folder in the current
  working directory for any articles whose `ms.date` key is at least 330 days older than the current
  date. It writes console logs for the results and, if run in GitHub Actions, appends a report to
  the job's Markdown summary.

.EXAMPLE

  ```powershell
  ./Get-StaleContentReport.ps1 -RelativeFolderPath ./reference/conceptual -DaysUntilStale 600
  ```

  In this example, the script recursively searches the `reference/conceptual` folder in the current
  working directory for any articles whose `ms.date` key is at least 600 days older than the current
  date. It writes console logs for the results and, if run in GitHub Actions, appends a report to
  the job's Markdown summary.

.EXAMPLE

  ```powershell
  $StaleDate = Get-Date 2021
  ./Get-StaleContentReport.ps1 -RelativeFolderPath ./reference/conceptual -StaleSinceDate $StaleDate
  ```

  In this example, the script recursively searches the `reference/conceptual` folder in the current
  working directory for any articles whose `ms.date` key older than midnight on January 1, 2021. It
  writes console logs for the results and, if run in GitHub Actions, appends a report to the job's
  Markdown summary.

.EXAMPLE

  ```powershell
  $Parameters = @{
    RelativeFolderPath   = './reference/conceptual'
    ExcludeFolderSegment = @(
      'historical'
      'language-spec'
    )
  }
  ./Get-StaleContentReport.ps1 @Parameters
  ```

  In this example, the script recursively searches the `reference/conceptual` folder in the current
  working directory for any articles whose `ms.date` key is at least 330 days older than the current
  date. If any files have a folder segment in their path matching the listed excludes, they are
  ignored. It writes console logs for the results and, if run in GitHub Actions, appends a report to
  the job's Markdown summary.

.EXAMPLE

  ```powershell
  $Parameters = @{
    RelativeFolderPath = './reference/conceptual'
    UploadArtifact     = $true
    ExportPath         = "StaleDocs.Conceptual.$(Get-Date -UFormat "%Y-%m-%d").csv"
  }
  ./Get-StaleContentReport.ps1 @Parameters
  ```

  In this example, the script recursively searches the `reference/conceptual` folder in the current
  working directory for any articles whose `ms.date` key is at least 330 days older than the current
  date. It writes console logs for the results and, if run in GitHub Actions, appends a report to
  the job's Markdown summary and exports the report data as comma-separated values to the
  `StaleDocs.Conceptual.2022-07-07.csv` file (if run on July 7, 2022), marking it for upload as an
  action artifact.

#>
[CmdletBinding(DefaultParameterSetName='ByDate')]
param(
  [Parameter(Mandatory)]
  [string[]]$RelativeFolderPath,
  [string[]]$ExcludeFolderSegment,

  [Parameter(ParameterSetName='ByDays')]
  [int]$DaysUntilStale,
  
  [Parameter(ParameterSetName='ByDate')]
  [datetime]$StaleSinceDate = (Get-Date).AddDays(-330).Date,

  [switch]$PassThru,
  [switch]$UploadArtifact,
  [switch]$ExportAsCsv,
  [string]$ExportPath = "StaleContentReport.$(Get-Date -UFormat "%Y-%m-%d").csv"
)

begin {
  $GitHubFolder = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
  $ModuleFile = Resolve-Path -Path "$GitHubFolder/.pwsh/module/gha.psd1"
  | Select-Object -ExpandProperty Path
  Import-Module $ModuleFile -Force
  $Summary = New-Object -TypeName System.Text.StringBuilder
  if ($DaysUntilStale -gt 0) {
    $StaleSinceDate = (Get-Date).AddDays((0 - $DaysUntilStale)).Date
  }
  $UnpassableParameters = @(
    'PassThru'
    'UploadArtifact'
    'ExportAsCsv'
    'ExportPath'
  )
}

process {
  $AnalysisParameters = $PSBoundParameters
  $UnpassableParameters | ForEach-Object -Process {
    $null = $AnalysisParameters.Remove($_)
  }
  
  $StaleDocuments = Get-StaleDocument @AnalysisParameters -ErrorAction Stop
  | Sort-Object -Property RootPath, RelativePath

  Write-Host "Searching for documents stale since $StaleSinceDate" -ForegroundColor Magenta
  $StaleDocumentsByRootFolder = $StaleDocuments | Group-Object -Property RootPath
  #region    Overview
  Write-Host "Stale Documents:" -ForegroundColor DarkMagenta
  $HostMessage = $StaleDocumentsByRootFolder | Select-Object -Property @(
      @{ Name = 'Relative Root Folder Path' ; Expression = { $_.Name } }
      @{ Name = 'Stale Article Count' ; Expression = { $_.Count } }
  ) | Format-Table | Out-String
  Write-Host $HostMessage

  $null = $Summary.AppendLine('# Stale Content Report').AppendLine()
  $null = $Summary.AppendJoin(
    ' ',
    'Documents in this report are stale since',
    $StaleSinceDate.Date.ToString()
  ).AppendLine()
  $null = $Summary.AppendJoin(' | ', '| Relative Root Folder Path', 'Stale Articles |').AppendLine()
  $null = $Summary.AppendJoin(' | ', '| :------------------------', ':------------: |').AppendLine()
  ForEach ($FolderInfo in $StaleDocumentsByRootFolder) {
    $null = $Summary.AppendLine("| $($FolderInfo.Name) | $($FolderInfo.Count) |")
  }
  $null = $Summary.AppendLine()
  #endregion Overview
  #region    Per-Root
  foreach ($RootRelativeFolder in $StaleDocumentsByRootFolder) {
    $StaleDocsInFolder = $RootRelativeFolder.Group
    | Select-Object -Property RelativePath, MSDate

    if ($StaleDocsInFolder.Count -lt 1) {
      continue
    }

    $null = $Summary.AppendLine("## $($RootRelativeFolder.Name)").AppendLine()

    $StaleSubFolders = $StaleDocsInFolder | ForEach-Object {
      $StaleFolder = Split-Path -Parent $_.RelativePath
      while (![string]::IsNullOrEmpty($StaleFolder)) {
        $StaleFolder -replace '\\', '/'
        $StaleFolder = Split-Path -Parent $StaleFolder
      }
    } | Select-Object -Unique | Sort-Object

    $HostMessage = "Folders with Stale Content in '$($RootRelativeFolder.Name)':"
    Write-Host $HostMessage -ForegroundColor DarkYellow
    $HostMessage = $StaleSubFolders | ForEach-Object -Process {
      $PSStyle.Foreground.Magenta + $_ + $PSStyle.Reset
    } | Join-String -Separator ', ' -OutputPrefix "`t"
    Write-Host (Format-GHAConsoleText -Text $HostMessage)

    foreach ($StaleSubFolder in $StaleSubFolders) {
      $StaleDocsInSubFolder = $StaleDocsInFolder | ForEach-Object -Process {
        if ($_.RelativePath -match "$StaleSubFolder\/[^\/]+`$") {
          [PSCustomObject]@{
            FileName = Split-Path -Path $_.RelativePath -Leaf
            MSDate   = Get-Date $_.MSDate -UFormat '%m/%d/%Y'
          }
        }
      }

      if ($StaleDocsInSubFolder.Count -lt 1) {
        continue
      }

      Write-Host "Stale Content in '$StaleSubFolder'" -ForegroundColor DarkYellow
      Write-Host ($StaleDocsInSubFolder | Format-Table | Out-String)

      $null = $Summary.AppendLine("### $StaleSubFolder").AppendLine()
      $null = $Summary.AppendLine('| File Name | Last Updated On |')
      $null = $Summary.AppendLine('| :-------- | :-------------: |')
      foreach ($Document in $StaleDocsInSubFolder) {
        $null =  $Summary.AppendLine("| $($Document.FileName) | $($Document.MSDate) |")
      }
      $null = $Summary.AppendLine()
    }
  }
  #endregion Per-Root
  $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY

  if ($ExportAsCsv -or $UploadArtifact) {
    Write-Host "Exporting report as CSV to '$ExportPath'" -ForegroundColor Blue
    $StaleDocuments | Export-Csv -Path $ExportPath -Force -ErrorAction Stop
    if ($UploadArtifact) {
      Write-Host "Adding CSV path to GITHUB_ENV as 'artifactPath'" -ForegroundColor Blue
      "artifactPath=$ExportPath" >> $ENV:GITHUB_ENV
    }
  }

  if ($PassThru) {
    $StaleDocuments
  }
}