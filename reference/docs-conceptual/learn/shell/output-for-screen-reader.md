---
description: This article aims to guide you through methods to output from PowerShell in formats that are friendly for screen readers, enhancing the accessibility of your scripts.
ms.custom: experience
ms.date: 09/04/2024
title: Improve the accessibility of output in PowerShell
---
# Improve the accessibility of output in PowerShell

Most terminal environments only display raw text. Users that rely on screen readers are faced with
tedious narration when consuming large amounts of raw text because the raw output doesn't have the
accessibility metadata to characterize the format of the content.

The examples in this article show how to improve the structure and labelling of output from
PowerShell to improve usability with screen reader technologies.

## Out-GridView command on Windows

For small to moderate size output, use the `Out-GridView` command. The output is rendered using
Windows Presentation Foundation (WPF) in tabular form, much like a spreadsheet. The GridView control
allows you to sort, filter, and search the data, which reduces the amount of data that needs to be
read. The GridView control is also accessible to screen readers. The **Narrator** tool built into
Windows is able to read the GridView details, including column names and row count.

The following example shows how to display a list of services in a GridView control.

```powershell
Get-Service | Out-GridView
```

The `Out-GridView` command is only available in PowerShell on Windows.

## Reduce the amount of output

One way to improve the accessibility of the output is to reduce the amount of output displayed in
the terminal. PowerShell has several commands that can help you filter and select the data you want.

### Select and filter data

Rather than returning a large mount of data, use commands such as `Select-Object`, `Sort-Object`,
and `Where-Object` to reduce the amount of output. The following example gets the list of services
running on the computer, filters the list to only show the running services with `event` in the
description.

```powershell
Get-Service | Where-Object {$_.Status -eq 'Running' -and $_.Description -Match 'event'}
```

### Descriptive property names

The default property names of .NET objects output by PowerShell can be verbose and confusing. Using
`Select-Object` you can select only the properties you are interested in and use calculated
properties to change the property names and values to something easier to understood when read by a
narrator technology.

The following examples shows how to get the top 5 processes by memory usage and display the process
name and memory usage in megabytes.

```powershell
Get-Process | Sort-Object WorkingSet -Descending |
    Select -First 5 -Property ProcessName, @{Name = "MemoryMB"; Expression = {$_.WorkingSet/1Mb}}
```

## Choose an output format

For large amounts of data, rather than output to the host, consider writing output in a format that
can be viewed in another tool that supports screen reading technologies. Save that formatted output
to a file then open the file in an the appropriate application.

### Character Separated Value (CSV) format

Spreadsheet applications such as **Microsoft Excel** support CSV files. The following example shows
how to save the output of a command to a CSV file.

```powershell
Get-Service | Export-Csv -Path .\myFile.csv
```

Once the file is saved, you can open it in Excel to view the data in a tabular format.

### HyperText Markup Language (HTML) format

HTML files can be viewed by web browsers such as **Microsoft Edge**. The following example shows how
to save the output of a command to an HTML file.

```powershell
Get-Service | ConvertTo-HTML | Out-File .\myFile.html
```

Open the save file in your web browser to view the data in a tabular format.

## Additional reading

- [Out-GridView](xref:Microsoft.PowerShell.Utility.Out-GridView)
- [Export-Csv](xref:Microsoft.PowerShell.Utility.Export-Csv)
- [ConvertTo-Html](xref:Microsoft.PowerShell.Utility.ConvertTo-Html)
- [about_Calculated_Properties](/powershell/module/microsoft.powershell.core/about/about_calculated_properties)
