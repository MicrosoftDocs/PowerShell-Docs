---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=526219
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-Clipboard
---

# Get-Clipboard

## SYNOPSIS
Gets the current Windows clipboard entry.

## SYNTAX

```
Get-Clipboard [-Format <ClipboardFormat>] [-TextFormatType <TextDataFormat>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
The **Get-Clipboard** cmdlet gets the current Windows clipboard entry.

## EXAMPLES

### Example 1: Get the content of the clipboard and display it to the command-line
```
PS C:\> Get-Clipboard
This is a test string.
```

This command displays the contents of the clipboard to the command-line.

### Example 2: Get the content of the clipboard and display it to the command-line
```
PS C:\> Get-Clipboard
https://en.wikipedia.org/wiki/PowerShell
```

This command displays the link, as a URL, of the image that is stored in the clipboard.

## PARAMETERS

### -Format
Specifies the type, or format, of the clipboard.
The acceptable values for this parameter are:

- Text
- FileDropList
- Image
- Audio

```yaml
Type: ClipboardFormat
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
Specifies the text data format type of the clipboard.
The acceptable values for this parameter are:

- Text
- UnicodeText
- Rtf
- Html
- CommaSeparatedValue

```yaml
Type: TextDataFormat
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String, System.IO.FileInfo, System.IO.Stream, System.Drawing.Image

## NOTES

## RELATED LINKS

[Set-Clipboard](Set-Clipboard.md)