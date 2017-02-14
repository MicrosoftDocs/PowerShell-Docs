---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Special_Characters
ms.technology:  powershell
---

# About Special Characters
## about_Special_Characters


# SHORT DESCRIPTION

Describes the special characters that you can use to control how
Windows PowerShell interprets the next character in a command or parameter.

# LONG DESCRIPTION

Windows PowerShell supports a set of special character sequences that
are used to represent characters that are not part of the standard
character set.

The special characters in Windows PowerShell begin with the backtick
character, also known as the grave accent (ASCII 96).

The following special characters are recognized by Windows PowerShell:

`0    Null
`a    Alert
`b    Backspace
`f    Form feed
`n    New line
`r    Carriage return
`t    Horizontal tab
`v    Vertical tab
--%   Stop parsing

These characters are case-sensitive.

# NULL (`0)

Windows PowerShell recognizes a null special character (`0) and represents
it with a character code of 0. It appears as an empty space in the
Windows PowerShell output. This allows you to use Windows PowerShell to
read and process text files that use null characters, such as string
termination or record termination indicators. The null special character
is not equivalent to the $null variable, which stores a value of NULL.

ALERT (`a)
The alert (`a) character sends a beep signal to the computer's speaker.
You can use this to warn a user about an impending action. The following
command sends two beep signals to the local computer's speaker:

for ($i = 0; $i -le 1; $i++){"`a"}

BACKSPACE (`b)
The backspace character (`b) moves the cursor back one character, but it
does not delete any characters. The following command writes the word
"backup", moves the cursor back twice, and then writes the word "out"
(preceded by a space and starting at the new position):

"backup`b`b out"

The output from this command is as follows:

back out

FORM FEED (`f)
The form feed character (`f) is a print instruction that ejects the
current page and continues printing on the next page. This character
affects printed documents only; it does not affect screen output.

NEW LINE (`n)
The new line character (`n) inserts a line break immediately after the
character.

The following example shows how to use the new line character in a
Write-Host command:

"There are two line breaks`n`nhere."

The output from this command is as follows:

There are two line breaks

here.

CARRIAGE RETURN (`r)
The carriage return character (`r) eliminates the entire line prior
to the `r character, as though the prior text were on a different line.

For example:

Write-Host "Let's not move`rDelete everything before this point."

The output from this command is:

Delete everything before this point.

HORIZONTAL TAB (`t)
The horizontal tab character (`t) advances to the next tab stop and
continues writing at that point. By default, the Windows PowerShell
console has a tab stop at every eighth space.

For example, the following command inserts two tabs between each
column.

"Column1`t`tColumn2`t`tColumn3"

The output from this command is:

Column1         Column2         Column3

VERTICAL TAB (`v)
The horizontal tab character (`t) advances to the next vertical tab stop
and writes all subsequent output beginning at that point. This character
affects printed documents only. It does not affect screen output.

STOP PARSING  (--%)
The stop-parsing symbol (--%) prevents Windows PowerShell from
interpreting arguments in program calls as Windows PowerShell
commands and expressions.

Place the stop-parsing symbol after the program name and before
program arguments that might cause errors.

For example, the following Icacls command uses the stop-parsing
symbol.
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F

Windows PowerShell sends the following command to Icacls.
X:\VMS /grant Dom\HVAdmin:(CI)(OI)F

For more information about the stop-parsing symbol, see
about_Parsing.

# KEYWORDS

about_Punctuation
about_Symbols

# SEE ALSO

[about_Quoting_Rules](about_Quoting_Rules.md)

[about_Escape_Characters](about_Escape_Characters.md)
