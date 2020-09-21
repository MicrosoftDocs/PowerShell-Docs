---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/21/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-clipboard?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Clipboard
---
# Get-Clipboard

## SYNOPSIS
Gets the current Windows clipboard entry.

## SYNTAX

```
Get-Clipboard [-Format <ClipboardFormat>] [-TextFormatType <TextDataFormat>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Clipboard` cmdlet gets the current Windows clipboard entry. Multiple lines of text are
returned as an array of strings similar to `Get-Content`.

## EXAMPLES

### Example 1: Get the content of the clipboard and display it to the command-line

In this example we have right-clicked on an image in a browser and chose the **Copy** action. The
following command displays the link, as a URL, of the image that is stored in the clipboard.

```powershell
Get-Clipboard
```

```Output
https://en.wikipedia.org/wiki/PowerShell
```

### Example 2: Get the content of the clipboard in a specific format

In this example we copied files to the clipboard in Windows Explorerby selecting them and pressing
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

## PARAMETERS

### -Format

Specifies the type, or format, of the clipboard. The acceptable values for this parameter are:

- Text
- FileDropList
- Image
- Audio

```yaml
Type: Microsoft.PowerShell.Commands.ClipboardFormat
Parameter Sets: (All)
Aliases:
Accepted values: Text, FileDropList, Image, Audio

Required: False
Position: Named
Default value: None
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

### -TextFormatType

Specifies the text data format type of the clipboard. The acceptable values for this parameter are:

- Text
- UnicodeText
- Rtf
- Html
- CommaSeparatedValue

```yaml
Type: System.Windows.Forms.TextDataFormat
Parameter Sets: (All)
Aliases:
Accepted values: Text, UnicodeText, Rtf, Html, CommaSeparatedValue

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

### System.String, System.IO.FileInfo, System.IO.Stream, System.Drawing.Image

## NOTES

## RELATED LINKS

[Set-Clipboard](Set-Clipboard.md)
