---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Special_Characters
---

# About Special Characters

## SHORT DESCRIPTION

Describes the special characters that you can use to control how Windows
PowerShell interprets the next character in a command or parameter.

## LONG DESCRIPTION

PowerShell supports a set of special character sequences that are used
to represent characters that are not part of the standard character set.

The special characters in PowerShell begin with the backtick
character, also known as the grave accent (ASCII 96).

The following special characters are recognized by PowerShell:

```
| Character | Description             |
| --------- | ----------------------- |
| `0        | Null                    |
| `a        | Alert                   |
| `b        | Backspace               |
| `f        | Form feed               |
| `n        | New line                |
| `r        | Carriage return         |
| `t        | Horizontal tab          |
| `v        | Vertical tab            |
| --%       | Stop parsing            |
```

These characters are case-sensitive. The escape character is only interpreted
when used within double quoted (") strings.

## NULL (`0)

PowerShell recognizes a null special character (`0) and represents it
with a character code of 0. It appears as an empty space in the Windows
PowerShell output. This allows you to use PowerShell to read and
process text files that use null characters, such as string termination or
record termination indicators. The null special character is not equivalent to
the $null variable, which stores a value of NULL.

## ALERT (`a)

The alert (`a) character sends a beep signal to the computer's speaker. You
can use this to warn a user about an impending action. The following command
sends two beep signals to the local computer's speaker:

for ($i = 0; $i -le 1; $i++){"`a"}

## BACKSPACE (`b)

The backspace character (`b) moves the cursor back one character, but it does
not delete any characters. The following command writes the word "backup",
moves the cursor back twice, and then writes the word "out" (preceded by a
space and starting at the new position):

```powershell
"backup`b`b out"
```

The output from this command is as follows:

```output
back out
```

## FORM FEED (`f)

The form feed character (`f) is a print instruction that ejects the current
page and continues printing on the next page. This character affects printed
documents only; it does not affect screen output.

## NEW LINE (`n)

The new line character (`n) inserts a line break immediately after the
character.

The following example shows how to use the new line character in a Write-Host
command:

```powershell
"There are two line breaks`n`nhere."
```

The output from this command is as follows:

```output
There are two line breaks

here.
```

## CARRIAGE RETURN (`r)

The carriage return character ``(`r)`` eliminates the entire line prior to the
`r character, as though the prior text were on a different line.

For example:

```powershell
Write-Host "Let's not move`rDelete everything before this point."
```

The output from this command is:

```output
Delete everything before this point.
```

## HORIZONTAL TAB (`t)

The horizontal tab character (`t) advances to the next tab stop and continues
writing at that point. By default, the PowerShell console has a tab
stop at every eighth space.

For example, the following command inserts two tabs between each column.

```powershell
"Column1`t`tColumn2`t`tColumn3"
```

The output from this command is:

```output
Column1         Column2         Column3
```

## VERTICAL TAB (`v)

The horizontal tab character (`t) advances to the next vertical tab stop and
writes all subsequent output beginning at that point. This character affects
printed documents only. It does not affect screen output.

## STOP PARSING  (--%)

The stop-parsing symbol (--%) prevents PowerShell from interpreting
arguments in program calls as PowerShell commands and expressions.

Place the stop-parsing symbol after the program name and before program
arguments that might cause errors.

For example, the following Icacls command uses the stop-parsing symbol.

```powershell
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F
```

PowerShell sends the following command to Icacls.

```output
X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

For more information about the stop-parsing symbol, see [about_Parsing](about_Parsing.md).

## SEE ALSO

- [about_Quoting_Rules](about_Quoting_Rules.md)