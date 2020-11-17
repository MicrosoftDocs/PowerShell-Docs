---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/23/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/show-markdown?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Show-Markdown
---

# Show-Markdown

## SYNOPSIS
Shows a Markdown file or string in the console in a friendly way using VT100 escape sequences or in
a browser using HTML.

## SYNTAX

### Path (Default)

```
Show-Markdown [-Path] <String[]> [-UseBrowser] [<CommonParameters>]
```

### InputObject

```
Show-Markdown -InputObject <PSObject> [-UseBrowser] [<CommonParameters>]
```

### LiteralPath

```
Show-Markdown -LiteralPath <String[]> [-UseBrowser] [<CommonParameters>]
```

## DESCRIPTION

The `Show-Markdown` cmdlet is used to render Markdown in a human readable format either in a
terminal or in a browser.

`Show-Markdown` can return a string that includes the VT100 escape sequences which the terminal
renders (if it supports VT100 escape sequences). This is primarily used for viewing Markdown files
in a terminal. You can also get this string via the `ConvertFrom-Markdown` by specifying the
**AsVT100EncodedString** parameter.

`Show-Markdown` also has the ability to open a browser and show you a rendered version of the
Markdown. It renders the Markdown by turning it into HTML and opening the HTML file in your default
browser.

You can change how `Show-Markdown` renders Markdown in a terminal by using `Set-MarkdownOption`.

This cmdlet was introduced in PowerShell 6.1.

## EXAMPLES

### Example 1: Simple example specifying a path

```powershell
Show-Markdown -Path ./README.md
```

### Example 2: Simple example specifying a string

```powershell
@"
# Show-Markdown

## Markdown

You can now interact with Markdown via PowerShell!

*stars*
__underlines__
"@ | Show-Markdown
```

### Example 2: Opening Markdown in a browser

```powershell
Show-Markdown -Path ./README.md -UseBrowser
```

## PARAMETERS

### -InputObject

A Markdown string that will be shown in the terminal. If you do not pass in a supported format,
`Show-Markdown` will emit an error.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: InputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to a Markdown file. Unlike the Path parameter, the value of LiteralPath is used
exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape
characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to
interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the path to a Markdown file to be rendered.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -UseBrowser

Compiles the Markdown input as HTML and opens it in your default browser.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

### System.String[]

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[ConvertFrom-Markdown](ConvertFrom-Markdown.md)

