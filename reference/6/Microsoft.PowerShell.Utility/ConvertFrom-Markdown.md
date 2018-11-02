---
ms.date:  11/02/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet,markdown
online version:  https://go.microsoft.com/fwlink/?linkid=2006503
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  ConvertFrom-Markdown
---

# ConvertFrom-Markdown

## SYNOPSIS

Convert the contents of a specified file or an **InputObject** to a `Microsoft.PowerShell.MarkdownRender.MarkdownInfo` object.
**InputObject** can be of type **System.String** or **System.IO.FileInfo**.

## SYNTAX

### PathParamSet (Default)

```
ConvertFrom-Markdown [-Path] <String[]> [-AsVT100EncodedString] [<CommonParameters>]
```

### LiteralParamSet

```
ConvertFrom-Markdown -LiteralPath <String[]> [-AsVT100EncodedString] [<CommonParameters>]
```

### InputObjParamSet

```
ConvertFrom-Markdown -InputObject <PSObject> [-AsVT100EncodedString] [<CommonParameters>]
```

## DESCRIPTION

The **ConvertFrom-Markdown** cmdlet converts the specified content into a `Microsoft.PowerShell.MarkdownRender.MarkdownInfo`.
When a file path is specified for the `-Path` parameter, the contents on the file are converted.
When an object of type **System.String** is specified for `-InputObject` parameter, the string is converted.
When an object of type **System.IO.FileInfo** is specified for `-InputObject`
parameter, the contents of the file specified by the object are converted.
The output object has three properties **Html**,**Tokens**,**VT100EncodedString**.
The **Token** property has the abstract syntax tree (AST) of the the converted object.
The **Html** property has the HTML conversion of the specified input.
When the `-AsVT100EncodedString` parameter is specified, the **VT100EncodedString** has the converted string with `VT100` escape sequences.

## EXAMPLES

### Example 1: Convert contents of a file to `Html`

```powershell
ConvertFrom-Markdown -Path .\README.md
```

The `Microsoft.PowerShell.MarkdownRender.MarkdownInfo` object is returned.
The **Tokens** property has the AST of the converted content of the `README.md` file.
The **Html** property has the HTML converted content of the `README.md` file.

### Example 2: Convert content of a file to `VT100` encoded string

```powershell
ConvertFrom-Markdown -Path .\README.md -AsVT100EncodedString
```

The `Microsoft.PowerShell.MarkdownRender.MarkdownInfo` object is returned.
The **Tokens** property has the AST of the converted content of the `README.md` file.
The **VT100EncodedString** property has the `VT100` encoded string converted content of the `README.md` file.

### Example 3: Convert content of the input object to a `V100` encoded string

```powershell
Get-Item .\README.md | ConvertFrom-Markdown -AsVT100EncodedString
```

The `Microsoft.PowerShell.MarkdownRender.MarkdownInfo` object is returned.
The `System.IO.FileInfo` object from `Get-Item` is converted to a `VT100` encoded string.
The **Tokens** property has the AST of the converted content of the `README.md` file.
The **VT100EncodedString** property has the `VT100` encoded string converted content of the `README.md` file.

### Example 4: Convert content of the input string to a `VT100` encoded string

```powershell
"**Bold text**" | ConvertFrom-Markdown -AsVT100EncodedString
```

The `Microsoft.PowerShell.MarkdownRender.MarkdownInfo` object is returned.
The specified string `**Bold text**` is converted to a `VT100` encoded string and available in **VT100EncodedString** property.

## PARAMETERS

### -AsVT100EncodedString

Specifies if the output should be encoded as a string with `VT100` escape codes.

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

### -InputObject

Specifies the object to be converted.

```yaml
Type: PSObject
Parameter Sets: InputObjParamSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies a path to the file to be converted.

```yaml
Type: String[]
Parameter Sets: LiteralParamSet
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies a path to the file to be converted.

```yaml
Type: String[]
Parameter Sets: PathParamSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

## OUTPUTS

### Microsoft.PowerShell.MarkdownRender.MarkdownInfo

## NOTES

## RELATED LINKS

[https://go.microsoft.com/fwlink/?linkid=2006503](https://go.microsoft.com/fwlink/?linkid=2006503)
[Markdown Parser](https://github.com/lunet-io/markdig)