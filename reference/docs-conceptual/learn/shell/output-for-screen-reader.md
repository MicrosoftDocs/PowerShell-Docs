---
description: This article aims to guide you through methods to output from PowerShell in formats that are friendly for screen readers, enhancing the accessibility of your scripts.
ms.custom: experience
ms.date: 09/15/2024
title: Output from PowerShell to Formats Friendly for Screen Readers
---
# Output from PowerShell to Formats Friendly for Screen Readers

Most shell environments output in raw text format. User environments that
rely on screen readers to narrate what is on the screen can be tedious
when consuming large amounts of raw text because there is limited metadata
to characterize the format of the content.

The examples on this page demonstrate how to improve the structure and labelling
of output from scripts, to improve usability with screen reader technologies.

## Out-GridView command

For a small amount of interactive data, use the `Out-GridView` command. Text is rendered
using Windows Presentation Foundation (WPF) in graphical format. The built-in Narrator
tool in Windows is able to read the format details including column names and row count.
The `Out-GridView` command is only available in Windows.

```Pwsh
Get-Service | Out-GridView
```

## Choose an output format

For an increased amount of data, rather than output to the shell, consider output to a tool that
is designed to work well with screen reading technologies.

### Comma Separated Value (CSV)

If the script returns a large amount of data, convert to comma separated value format,
write the content to a file and open the file in another tool. Spreadsheet applications such as
Microsoft Excel support CSV files.

```Pwsh
Get-Service | ConvertTo-CSV | Out-File .\myFile.csv
```

### HyperText Markup Language (HTML)

If the script returns data that will be read as a report without modification, convert the data
to HTML. HTML format is used by web browsers such as Microsoft Edge.

```Pwsh
Get-Service | ConvertTo-HTML | Out-File .\myFile.html
```

## Customize the structure or your data

Regardless of the chosen format, consider best practices to enhance the accessibility of your
output.

### Select and filter data

Rather than returning a large mount of data, use commands such as `Select-Object`, `Sort-Object`,
and `Where-Object` to reduce the amount of output.

```Pwsh
Get-Service | Where-Object Status -eq Running | Where-Object Description -Match 'event'
```

### Descriptive property names

The default property names of .NET objects output by PowerShell can be verbose and confusing.
Change the property names to something easily understood when read by a narrator technology.

```Pwsh
Get-Process | Sort-Object WorkingSet -Descending | Select -First 5 -Property ProcessName, @{Name = "MemoryMB"; Expression = {$_.WorkingSet/1Mb}}
```
