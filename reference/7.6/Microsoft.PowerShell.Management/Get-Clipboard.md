---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 12/10/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-clipboard?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
aliases:
  - gcb
title: Get-Clipboard
---

# Get-Clipboard

## SYNOPSIS
Gets the contents of the clipboard.

## SYNTAX

```
Get-Clipboard [-Raw] [-Delimiter <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Clipboard` cmdlet gets the contents of the clipboard as text. Multiple lines of text are
returned as an array of strings similar to `Get-Content`.

> [!NOTE]
> On Linux, this cmdlet requires the `xclip` utility to be in the path. On macOS, this cmdlet uses
> the `pbpaste` utility.

## EXAMPLES

### Example 1: Get the content of the clipboard

```powershell
Set-Clipboard -Value 'hello world'
Get-Clipboard
```

```Output
hello world
```

### Example 2: Get the content of the clipboard using a custom delimiter

This example gets the content of the clipboard. The content is a string containing the pipe
character. `Get-Clipboard` splits the content at each occurrence of the specified delimiter.

```powershell
Set-Clipboard -Value 'line1|line2|line3'
Get-Clipboard -Delimiter '|'
```

```Output
line1
line2
line3
```

### Example 3: Get the content of the clipboard using custom delimiters

This example gets the content of the clipboard delimited by the line ending for both Windows and
Linux.

```powershell
Get-Clipboard -Delimiter "`r`n", "`n"
```

## PARAMETERS

### -Delimiter

Specifies one or more delimiters to use when the clipboard content is returned as an array of
strings. The contents of the clipboard are split at each occurrence of any of the specified
delimiters. If not specified, the default delimiter is the platform-specific newline.

- On Windows, the default delimiter is ``"`r`n"``.
- On Linux and macOS, the default delimiter is ``"`n"``.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [Environment.NewLine]
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw

Gets the entire contents of the clipboard. Multiline text is returned as a single multiline string
rather than an array of strings.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.String

By default, this cmdlet returns the content as an array of strings, one per line. When you use the
**Raw** parameter, it returns a single string containing every line in the file.

## NOTES

PowerShell includes the following aliases for `Get-Clipboard`:

- All platforms:
  - `gcb`

Support for this cmdlet on macOS was added in the PowerShell 7.0.0 release.

## RELATED LINKS

[Set-Clipboard](Set-Clipboard.md)
