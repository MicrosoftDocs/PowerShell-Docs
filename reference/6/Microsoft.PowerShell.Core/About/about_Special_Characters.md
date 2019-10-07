---
keywords: powershell,cmdlet
locale: en-us
ms.date: 08/05/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-6
schema: 2.0.0
title: about_Special_Characters
---

# About Special Characters

## Short description

Describes the special characters that you can use to control how PowerShell
interprets the next character in a command or parameter.

## Long description

PowerShell supports a set of special character sequences that are used to
represent characters that aren't part of the standard character set.

PowerShell's special characters are only interpreted when they're enclosed in
double-quoted (`"`) strings. Special characters begin with the backtick
character, known as the grave accent (ASCII 96), and are case-sensitive.

PowerShell recognizes these special characters:

| Character | Description             |
| --------- | ----------------------- |
| `` `0 ``  | Null                    |
| `` `a ``  | Alert                   |
| `` `b ``  | Backspace               |
| `` `e ``  | Escape                  |
| `` `f ``  | Form feed               |
| `` `n ``  | New line                |
| `` `r ``  | Carriage return         |
| `` `t ``  | Horizontal tab          |
| `` `u{x} ``  | Unicode escape sequence |
| `` `v ``  | Vertical tab            |
| `--%`     | Stop parsing            |

## Null (`0)

The null (`` `0 ``) character appears as an empty space in PowerShell output.
This functionality allows you to use PowerShell to read and process text files
that use null characters, such as string termination or record termination
indicators. The null special character isn't equivalent to the `$null`
variable, which stores a **null** value.

## Alert (`a)

The alert (`` `a ``) character sends a beep signal to the computer's speaker.
You can use this character to warn a user about an impending action. The
following example sends two beep signals to the local computer's speaker.

```powershell
for ($i = 0; $i -le 1; $i++){"`a"}
```

## Backspace (`b)

The backspace (`` `b ``) character moves the cursor back one character, but it
doesn't delete any characters.

The example writes the word **backup** and then moves the cursor back twice.
Then, at the new position, writes a space followed by the word **out**.

```powershell
"backup`b`b out"
```

```Output
back out
```

## Escape (`e)

The escape (`` `e ``) character is most commonly used to specify a virtual
terminal sequence (ANSI escape sequence) that modifies the color of text and
other text attributes such as bolding and underlining. These sequences can also
be used for cursor positioning and scrolling. The PowerShell host must support
virtual terminal sequences. This can be checked on PowerShell v5 and higher
with the boolean property `$Host.UI.SupportsVirtualTerminal`.

For more information about ANSI escape sequences, see [ANSI_escape_code](https://en.wikipedia.org/wiki/ANSI_escape_code).

The following example outputs text with a green foreground color.

```powershell
$fgColor = 32 # green
"`e[${fgColor}mGreen text`e[0m"
```

```Output
Green text
```

## Form feed (`f)

The form feed (`` `f ``) character is a print instruction that ejects the
current page and continues printing on the next page. The form feed character
only affects printed documents. It doesn't affect screen output.

## New line (`n)

The new line (`` `n ``) character inserts a line break immediately after the
character.

This example shows how to use the new line character to create line breaks in a
`Write-Host` command.

```powershell
"There are two line breaks to create a blank line`n`nbetween the words."
```

```Output
There are two line breaks to create a blank line

between the words.
```

## Carriage return (`r)

The carriage return (`` `r ``) character eliminates the entire line before the
character's insertion point. The carriage returns functions as though the prior
text were on a different line.

In this example, the text before the carriage return is removed from the
output.

```powershell
Write-Host "Let's not move`rDelete everything before this point."
```

```Output
Delete everything before this point.
```

## Horizontal tab (`t)

The horizontal tab (`` `t ``) character advances to the next tab stop and
continues writing at that point. By default, the PowerShell console has a tab
stop at every eighth space.

This example inserts two tabs between each column.

```powershell
"Column1`t`tColumn2`t`tColumn3"
```

```Output
Column1         Column2         Column3
```

## Unicode character (`u{x})

The Unicode escape sequence (`` `u{x} ``) allows you to specify any Unicode
character by the hexadecimal representation of its code point. This includes
Unicode characters above the Basic Multilingual Plane (> `0xFFFF`) which
includes emoji characters such as the **thumbs up** (`` `u{1F44D} ``)
character. The Unicode escape sequence requires at least one hexidecimal digit
and supports up to six hexidecimal digits. The maximum hexidecimal value for
the sequence is `10FFFF`.

This example outputs the **up down arrow** (&#x2195;) symbol.

```powershell
"`u{2195}"
```

## Vertical tab (`v)

The horizontal tab (`` `v ``) character advances to the next vertical tab stop
and writes all subsequent output beginning at that point. The vertical tab
character only affects printed documents. It doesn't affect screen output.

## Stop parsing  (--%)

The stop-parsing (`--%`) symbol prevents PowerShell from interpreting arguments
in program calls as PowerShell commands and expressions.

Place the stop-parsing symbol after the program name and before program
arguments that might cause errors.

In this example, the `Icacls` command uses the stop-parsing symbol.

```powershell
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F
```

PowerShell sends the following command to `Icacls`.

```Output
X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

For more information about the stop-parsing symbol, see [about_Parsing](about_Parsing.md).

## See also

[about_Quoting_Rules](about_Quoting_Rules.md)
