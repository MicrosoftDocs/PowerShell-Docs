---
ms.date: 09/12/2016
ms.topic: reference
title: Syntax of Comment-Based Help
description: Syntax of Comment-Based Help
---
# Syntax of Comment-Based Help

This section describes the syntax of comment-based help.

## Syntax Diagram

 The syntax for comment-based Help is as follows:

```
# .< help keyword>
# <help content>

-or -

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
 (`.`). The keywords can appear in any order. The keyword names are not case-sensitive.

 A comment block must contain at least one help keyword. Some of the keywords, such as **EXAMPLE**,
 can appear many times in the same comment block. The Help content for each keyword begins on the
 line after the keyword and can span multiple lines.

 All of the lines in a comment-based Help topic must be contiguous. If a comment-based Help topic
 follows a comment that is not part of the Help topic, there must be at least one blank line between
 the last non-Help comment line and the beginning of the comment-based Help.

 For example, the following comment-based help topic contains the .Description keyword and its
 value, which is a description of a function or script.

```powershell
<#
    .Description
    The Get-Function function displays the name and syntax of all functions in the session.
#>
```
