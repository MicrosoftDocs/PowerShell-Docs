---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Management
ms.date: 08/09/2019
online version: https://go.microsoft.com/fwlink/?linkid=526219
schema: 2.0.0
title: Get-Clipboard
---
# Get-Clipboard

## SYNOPSIS
Gets the contents of the clipboard.

[!NOTE]
> On Linux, this cmdlet requires the `xclip` utility to be in the path.

## SYNTAX

```
Get-Clipboard [-Raw] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Clipboard` cmdlet gets the contents of the clipboard as text.

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

Indicates that this cmdlet ignores newline characters and gets the entire contents of the clipboard.

```yaml
Type: SwitchParameter
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Set-Clipboard](Set-Clipboard.md)

