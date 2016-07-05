---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/?LinkId=526219
schema: 2.0.0
---

# Get-Clipboard
## SYNOPSIS
Gets the current Windows clipboard entry.

## SYNTAX

```
Get-Clipboard [-Format] [-Raw] [-TextFormatType]
```

## DESCRIPTION
The Get-Clipboard cmdlet gets the current Windows clipboard entry.

## EXAMPLES

### Example 1: Get the content of the clipboard and display it to the command-line
```
PS C:\>Get-Clipboard
This is a test string.
```

This command displays the contents of the clipboard to the command-line.

### Example 2: Get the content of the clipboard and display it to the command-line
```
PS C:\>Get-Clipboard
http://upload.wikimedia.org/wikipedia/en/7/7f/Windows_PowerShell_icon.png
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
Type: SwitchParameter
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Accepted values: Text, UnicodeText, Rtf, Html, CommaSeparatedValue

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.String, System.IO.FileInfo, System.IO.Stream, System.Drawing.Image

## NOTES

## RELATED LINKS

[Set-Clipboard](4d8308cd-fbdd-4f94-b34b-ab8ff6fffaa3)

