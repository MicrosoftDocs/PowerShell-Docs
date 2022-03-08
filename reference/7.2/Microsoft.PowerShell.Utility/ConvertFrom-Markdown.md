---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 11/02/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-markdown?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-Markdown
---

# ConvertFrom-Markdown

## SYNOPSIS
Convert the contents of a string or a file to a **MarkdownInfo**
object.

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

This cmdlet converts the specified content into a **MarkdownInfo**. When a file path is specified
for the **Path** parameter, the contents on the file are converted. The output object has three
properties:

- The **Token** property has the abstract syntax tree (AST) of the the converted object
- The **Html** property has the HTML conversion of the specified input
- The **VT100EncodedString** property has the converted string with ANSI (VT100) escape sequences if
  the **AsVT100EncodedString** parameter was specified

This cmdlet was introduced in PowerShell 6.1.

## EXAMPLES

### Example 1: Convert a file containing Markdown content to HTML

```powershell
ConvertFrom-Markdown -Path .\README.md
```

The **MarkdownInfo** object is returned. The **Tokens** property has the AST of the converted
content of the `README.md` file. The **Html** property has the HTML converted content of the
`README.md` file.

### Example 2: Convert a file containing Markdown content to a VT100-encoded string

```powershell
ConvertFrom-Markdown -Path .\README.md -AsVT100EncodedString
```

The **MarkdownInfo** object is returned. The **Tokens** property has the AST of the converted
content of the `README.md` file. The **VT100EncodedString** property has the VT100-encoded string
converted content of the `README.md` file.

### Example 3: Convert input object containing Markdown content to a VT100-encoded string

```powershell
Get-Item .\README.md | ConvertFrom-Markdown -AsVT100EncodedString
```

The **MarkdownInfo** object is returned. The **FileInfo** object from `Get-Item` is converted to a
VT100-encoded string. The **Tokens** property has the AST of the converted content of the
`README.md` file. The **VT100EncodedString** property has the VT100-encoded string converted content
of the `README.md` file.

### Example 4: Convert a string containing Markdown content to a VT100-encoded string

```powershell
"**Bold text**" | ConvertFrom-Markdown -AsVT100EncodedString
```

The **MarkdownInfo** object is returned. The specified string `**Bold text**` is converted to a
VT100-encoded string and available in **VT100EncodedString** property.

## PARAMETERS

### -AsVT100EncodedString

Specifies if the output should be encoded as a string with VT100 escape codes.

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

### -InputObject

Specifies the object to be converted. When an object of type **System.String** is specified, the
string is converted. When an object of type **System.IO.FileInfo** is specified, the contents of the
file specified by the object are converted. Objects of any other type result in an error.

```yaml
Type: System.Management.Automation.PSObject
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
Type: System.String[]
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
Type: System.String[]
Parameter Sets: PathParamSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

## OUTPUTS

### Microsoft.PowerShell.MarkdownRender.MarkdownInfo

## NOTES

## RELATED LINKS

[Markdown Parser](https://github.com/lunet-io/markdig)

[ANSI escape code](https://wikipedia.org/wiki/ANSI_escape_code)

