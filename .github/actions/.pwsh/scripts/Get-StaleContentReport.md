# Get-StaleContentReport.ps1

## Synopsis

Inspect a folder for stale content

## Syntax

### ByDate (Default)

```
Get-StaleContentReport.ps1 -RelativeFolderPath <String[]> [-ExcludeFolderSegment <String[]>]
 [-StaleSinceDate <DateTime>] [-PassThru] [-UploadArtifact] [-ExportAsCsv] [-ExportPath <String>]
 [<CommonParameters>]
```

### ByDays

```
Get-StaleContentReport.ps1 -RelativeFolderPath <String[]> [-ExcludeFolderSegment <String[]>]
 [-DaysTilStale <Int32>] [-PassThru] [-UploadArtifact] [-ExportAsCsv] [-ExportPath <String>]
 [<CommonParameters>]
```

## Description

This script inspects one or more folders, looking for Markdown documents that are stale as indicated
by the **ms.date** key in their frontmatter. It writes a console log and a GitHub Action job summary
by default.

It can be used to export a CSV report of the stale content and to upload that report as a GitHub
Action artifact as part of an action execution.

## Examples

### Example 1

```powershell
./Get-StaleContentReport.ps1 -RelativeFolderPath ./reference/conceptual
```

In this example, the script recursively searches the `reference/conceptual` folder in the current
working directory for any articles whose `ms.date` key is at least 330 days older than the current
date. It writes console logs for the results and, if run in GitHub Actions, appends a report to the
job's Markdown summary.

### Example 2

```powershell
./Get-StaleContentReport.ps1 -RelativeFolderPath ./reference/conceptual -DaysUntilStale 600
```

In this example, the script recursively searches the `reference/conceptual` folder in the current
working directory for any articles whose `ms.date` key is at least 600 days older than the current
date. It writes console logs for the results and, if run in GitHub Actions, appends a report to the
job's Markdown summary.

### Example 3

```powershell
$StaleDate = Get-Date 2021
./Get-StaleContentReport.ps1 -RelativeFolderPath ./reference/conceptual -StaleSinceDate $StaleDate
```

In this example, the script recursively searches the `reference/conceptual` folder in the current
working directory for any articles whose `ms.date` key older than midnight on January 1, 2021. It
writes console logs for the results and, if run in GitHub Actions, appends a report to the job's
Markdown summary.

### Example 4

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

### Example 5

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
date. It writes console logs for the results and, if run in GitHub Actions, appends a report to the
job's Markdown summary and exports the report data as comma-separated values to the
`StaleDocs.Conceptual.2022-07-07.csv` file (if run on July 7, 2022), marking it for upload as an
action artifact.

## PARAMETERS

### -RelativeFolderPath

Specify the path to one or more folders to search for stale documents relative to the current
working directory. Do not use any wildcard characters. The value for this parameter is interpreted
literally. Additionally, this value is used to determine the root path of any stale documents.

If you specify any values including a wildcard character, this cmdlet warns you about the
consequences. You can suppress this warning by specifying `SilentlyContinue` for the
**WarningAction** parameter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeFolderSegment

Specify one or more complete folder segments as strings to exclude from the list of files to report
on. Any file whose path matches an excluded segment will be discarded from the list prior to
inspection.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DaysUntilStale

Specify an integer representing how many days can pass before a document is considered stale. If any
document's `ms.date` key is older than this value, it is returned as a stale document.

```yaml
Type: Int32
Parameter Sets: ByDays
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StaleSinceDate

Specify a datetime object representing the point at which any older documents are considered stale.
If any document's `ms.date` key is older than this value, it is returned as a stale document. This
value defaults to `330` days before this cmdlet is called.

```yaml
Type: DateTime
Parameter Sets: ByDate
Aliases:

Required: False
Position: Named
Default value: (Get-Date).AddDays(-330).Date
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Specify to return the report data as an array of objects. By default, no objects are emitted to the
output stream, only console logs to the host.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UploadArtifact

Specify to upload the CSV of the report as an artifact during a GitHub Action execution. This
parameter implies the use of **ExportAsCsv**, you do not need to specify them together.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExportAsCsv

Specify to write the report as a CSV file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExportPath

Specify the path to where the CSV file should be written. This parameter is only valid with the
**UploadArtifact** or **ExportAsCsv** parameters. By default, the report is written in the current
directory as `StaleContentReport.\<%Y-%m-%d\>.csv`, like `StaleContentReport-2022-07-15.csv`

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "StaleContentReport.$(Get-Date -UFormat "%Y-%m-%d").csv"
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).
