---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/30/2020
online version: https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Utility/Get-MarkdownOption?view=powershell-7.x.0&WT.mc_id=ps-gethelp
schema: 2.0.0
---

# Get-MarkdownOption

## SYNOPSIS
Returns the current colors and styles used for rendering Markdown content in the console.

## SYNTAX

```
Get-MarkdownOption [<CommonParameters>]
```

## DESCRIPTION

Returns the current colors and styles used for rendering Markdown content in the console. The
strings displayed in the output of this cmdlet contain the ANSI escape codes used to change the
color and style of the Markdown text being rendered.

For more information about Markdown, see the [CommonMark](https://commonmark.org/) website.

## EXAMPLES

### Example 1 - Get the current colors and style

```powershell
Get-MarkdownOption
```

```Output
Header1         : [7m
Header2         : [4;93m
Header3         : [4;94m
Header4         : [4;95m
Header5         : [4;96m
Header6         : [4;97m
Code            : [48;2;155;155;155;38;2;30;30;30m
Link            : [4;38;5;117m
Image           : [33m
EmphasisBold    : [1m
EmphasisItalics : [36m
```

> [!NOTE]
> The string values shown in the output are the characters that follow the **Escape** character
> (`[char]0x1B`) for the ANSI escape sequence. For more information about ANSI escape codes work,
> see [ANSI_escape_code](https://en.wikipedia.org/wiki/ANSI_escape_code).

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Microsoft.PowerShell.MarkdownRender.PSMarkdownOptionInfo

## NOTES

## RELATED LINKS

[Set-MarkdownOption](Set-MarkdownOption.md)

[ConvertFrom-Markdown](ConvertFrom-Markdown.md)

[Show-Markdown](Show-Markdown.md)

[ANSI_escape_code](https://en.wikipedia.org/wiki/ANSI_escape_code)

[CommonMark](https://commonmark.org/)

