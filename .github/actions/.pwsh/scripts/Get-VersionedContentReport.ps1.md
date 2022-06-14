---
external help file: -help.xml
Module Name:
online version:
schema: 2.0.0
---

# Get-VersionedContentReport.ps1

## Synopsis

Analyzes changes for versioned content.

## SYNTAX

```
.\Get-VersionedContentReport.ps1
    [-Owner] <String>
    [-Repo] <String>
    [-Number] <Int32>
    [[-ExcludePathPattern] <String[]>]
    [[-IncludePathPattern] <String[]>]
    [<CommonParameters>]
```

## Description

This script analyzes a changeset to discover versioned content and writes a report in the console
and as a GitHub Action summary, enumerating the versioned content changes and whether those changes
were made across all versions of the content.

It does not analyze whether such changes are needed or correct, only how each version of the content
was changed (or that it was not changed). This report still requires human analysis and
investigation but is intended to provide an easier way to see the aggregated changes across
versioned content to understand if all affected versions have been updated or not.

## Examples

### Example 1

```powershell
./Add-Expectations.ps1 -Owner Foo -Repo Bar -Number 123
```

The script finds the changes made in `https://github.com/foo/bar/pulls/123` and analyzes those
changes to find changes to versioned content. It then writes a report for each changed folder and
file enumerating the high-level changes across all versions that file belongs in.

## PARAMETERS

### `ExcludePathPattern`

Specify one or more regex patterns as a string. The list of changed files for the Pull Request is
filtered, comparing the path of the changed file to each pattern in this list. If the path of the
changed file matches any of the patterns specified, that change is discarded from the change report.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### `IncludePathPattern`

Specify one or more regex patterns as a string. The list of changed files for the Pull Request is
filtered, comparing the path of the changed file to each pattern in this list. If the path of the
changed file does not match any of the patterns specified, that change is discarded from the change
report.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### `Number`

Specify the number of the PR to inspect for changes.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### `Owner`

Specify the owner of the repository with the PR to inspect for changes. For
`https://github.com/foo/bar`, the owner is `foo`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### `Repo`

Specify the name of the repository with the PR to inspect for changes. For
`https://github.com/foo/bar\`, the repo is `bar`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
