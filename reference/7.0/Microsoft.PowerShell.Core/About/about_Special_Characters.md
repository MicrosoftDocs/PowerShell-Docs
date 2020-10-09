---
description:  Describes the special character sequences that control how PowerShell interprets the next characters in the sequence. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 04/04/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Special_Characters
---

# About Special Characters

## Short description

Describes the special character sequences that control how PowerShell
interprets the next characters in the sequence.

## Long description

PowerShell supports a set of special character sequences that are used to
represent characters that aren't part of the standard character set. The
sequences are commonly known as _escape sequences_.

Escape sequences begin with the backtick character, known as the grave accent
(ASCII 96), and are case-sensitive. The backtick character can also be referred
to as the _escape character_.

Escape sequences are only interpreted when contained in double-quoted (`"`)
strings.

PowerShell recognizes these escape sequences:

|  Sequence   |       Description       |
| ----------- | ----------------------- |
| `` `0 ``    | Null                    |
| `` `a ``    | Alert                   |
| `` `b ``    | Backspace               |
| `` `e ``    | Escape                  |
| `` `f ``    | Form feed               |
| `` `n ``    | New line                |
| `` `r ``    | Carriage return         |
| `` `t ``    | Horizontal tab          |
| `` `u{x} `` | Unicode escape sequence |
| `` `v ``    | Vertical tab            |

PowerShell also has a special token to mark where you want parsing to stop. All
characters that follow this token are used as literal values that aren't
interpreted.

Special parsing token:

| Sequence |            Description             |
| -------- | ---------------------------------- |
| `--%`    | Stop parsing anything that follows |

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
virtual terminal sequences. You can check the boolean value of
`$Host.UI.SupportsVirtualTerminal` to determine if these ANSI sequences are
supported.

For more information about ANSI escape sequences, see
[ANSI_escape_code](https://en.wikipedia.org/wiki/ANSI_escape_code).

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

The carriage return (`` `r ``) character moves the output cursor to the
beginning of the current line and continues writing. Any characters on the
current line are overwritten.

In this example, the text before the carriage return is overwritten.

```powershell
Write-Host "These characters are overwritten.`rI want this text instead "
```

Notice that the text before the `` `r `` character is not deleted, it is
overwritten.

```Output
I want this text instead written.
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
character. The Unicode escape sequence requires at least one hexadecimal digit
and supports up to six hexadecimal digits. The maximum hexadecimal value for
the sequence is `10FFFF`.

This example outputs the **up down arrow** (&#x2195;) symbol.

```powershell
"`u{2195}"
```

## Vertical tab (`v)

The horizontal tab (`` `v ``) character advances to the next vertical tab stop
and writes the remaining output at that point. This has no effect in the
default Windows console.

```powershell
Write-Host "There is a vertical tab`vbetween the words."
```

The following example shows the output you would get on a printer or in a
different console host.

```Output
There is a vertical tab
                       between the words.
```

## Stop-parsing token (--%)

The stop-parsing (`--%`) token prevents PowerShell from interpreting strings as
PowerShell commands and expressions. This allows those strings to be passed to
other programs for interpretation.

Place the stop-parsing token after the program name and before program
arguments that might cause errors.

In this example, the `Icacls` command uses the stop-parsing token.

```powershell
icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F
```

PowerShell sends the following string to `Icacls`.

```
X:\VMS /grant Dom\HVAdmin:(CI)(OI)F
```

Here is another example. The **showArgs** function outputs the values passed to
it. In this example, we pass the variable named `$HOME` to the function twice.

```powershell
function showArgs {
  "`$args = " + ($args -join '|')
}

showArgs $HOME --% $HOME
```

You can see in the output that, for the first parameter, the variable `$HOME`
is interpreted by PowerShell so that the value of the variable is passed to the
function. The second use of `$HOME` comes after the stop-parsing token, so the
string "$HOME" is passed to the function without interpretation.

```Output
$args = C:\Users\username|--%|$HOME
```

For more information about the stop-parsing token, see
[about_Parsing](about_Parsing.md).

## See also

[about_Quoting_Rules](about_Quoting_Rules.md)
