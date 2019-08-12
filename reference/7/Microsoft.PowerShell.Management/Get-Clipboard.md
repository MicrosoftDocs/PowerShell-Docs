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

## SYNTAX

```
Get-Clipboard [-Format <ClipboardFormat>] [-TextFormatType <TextDataFormat>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Clipboard` cmdlet gets the contents of the clipboard.

## EXAMPLES

### Example 1: Get the content of the clipboard and display it to the command-line

In this example we have copied the text "hello" into the clipboard.

```powershell
Get-Clipboard
```

```Output
hello
```

### Example 2: Get the content of the clipboard in a specific format

In this example we copied files to the clipboard in Windows Explorer by selecting them and pressing
<kbd>Ctrl-C</kbd>. Using the following command, you can access the contents of the clipboard as a
list of files:

```powershell
Get-Clipboard -Format FileDropList
```

```Output
    Directory: C:\Git\PS-Docs\PowerShell-Docs\wmf

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/7/2019   1:11 PM          10010 TOC.yml
-a----       11/18/2016  10:10 AM             53 md.style
-a----         5/6/2019   9:32 AM           4177 overview.md
-a----        6/28/2018   2:28 PM            345 README.md
```

> [!NOTE]
> This example is only supported on Windows.

## PARAMETERS

### -Format

Specifies the type, or format, of the clipboard. The acceptable values for this parameter
on Windows are:

- Text
- FileDropList
- Image
- Audio

> [!NOTE]
> On Linux and macOS, only the 'Text' format is supported.

```yaml
Type: ClipboardFormat
Parameter Sets: (All)
Aliases:
Accepted values: Text, FileDropList, Image, Audio

Required: False
Position: Named
Default value: Text
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -TextFormatType

Specifies the text data format type of the clipboard. The acceptable values for this parameter
on Windows are:

- Text
- UnicodeText
- Rtf
- Html
- CommaSeparatedValue

> [!NOTE]
> On Linux and macOS, only the 'UnicodeText' format type is supported.

```yaml
Type: TextDataFormat
Parameter Sets: (All)
Aliases:
Accepted values: Text, UnicodeText, Rtf, Html, CommaSeparatedValue

Required: False
Position: Named
Default value: UnicodeText
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String, System.IO.FileInfo, System.IO.Stream, System.Drawing.Image

## NOTES

## RELATED LINKS

[Set-Clipboard](Set-Clipboard.md)
