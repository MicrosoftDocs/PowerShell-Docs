---
description: Syntax of Comment-Based Help
ms.date: 09/05/2026
title: Syntax of Comment-Based Help
---
# Syntax of Comment-Based Help

This section describes the syntax of comment-based help.

## Syntax Diagram

 The syntax for comment-based Help is as follows:

```
# .< help keyword>
# <help content>
```

-or -

```
<#
.< help keyword>
< help content>
#>
```

## Syntax Description

 Comment-based Help is written as a series of comments. You can type a comment symbol (`#`) before
 each line of comments, or you can use the `<#` and `#>` symbols to create a comment block. All the
 lines within the comment block are interpreted as comments.

 Each section of comment-based Help is defined by a keyword and each keyword is preceded by a dot
 (`.`). The keywords can appear in any order. The keyword names aren't case-sensitive.

 A comment block must contain at least one help keyword. Some of the keywords, such as `.EXAMPLE`,
 can appear many times in the same comment block. The body of each section begins on the line
 after the keyword and can span multiple lines. Some keywords also accept text on the keyword
 line, such as the parameter name in `.PARAMETER <Parameter-Name>`.

 Beginning in PowerShell 7.7, `.EXAMPLE` also accepts an optional title on the keyword line.
 For example, the following single-line comments define a titled example:

```powershell
# .EXAMPLE Greet a user
# Get-Greeting -Name 'Ada'
#
# Returns a greeting for Ada.
```

 The same syntax works in block comments. For details and compatibility guidance for earlier
 PowerShell versions, see the [`.EXAMPLE` keyword][01].

 All the lines in a comment-based Help topic must be contiguous. If a comment-based Help topic
 follows a comment that isn't part of the Help topic, there must be at least one blank line between
 the last non-Help comment line and the beginning of the comment-based Help.

 For example, the following comment-based help topic contains the `.DESCRIPTION` keyword and its
 value, which is a description of a function or script.

```powershell
<#
    .DESCRIPTION
    The Get-Function function displays the name and syntax of all functions in the session.
#>
```

<!-- link references -->
[01]: ./comment-based-help-keywords.md#example
