---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 08/30/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-clipboard?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Clipboard
---

# Get-Clipboard

## SYNOPSIS
Gets the contents of the clipboard.

## SYNTAX

```
Get-Clipboard [-Raw] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Clipboard` cmdlet gets the contents of the clipboard as text. Multiple lines of text are
returned as an array of strings similar to `Get-Content`.

> [!NOTE]
> On Linux, this cmdlet requires the `xclip` utility to be in the path. On macOS, this cmdlet uses
> the `pbpaste` utility.

## EXAMPLES

### Example 1: Get the content of the clipboard and display it to the command-line

In this example we have copied the text "hello" into the clipboard.

```powershell
Get-Clipboard
```

```Output
hello
```

## PARAMETERS

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

This cmdlet returns a string containing the contents of the clipboard.

## NOTES

PowerShell includes the following aliases for `Get-Clipboard`:

- All platforms:
  - `gcb`

Support for this cmdlet on macOS was added in the PowerShell 7.0.0 release.

## RELATED LINKS

[Set-Clipboard](Set-Clipboard.md)
