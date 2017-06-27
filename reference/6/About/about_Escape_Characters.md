---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Escape_Characters
description:  Introduces the escape character in PowerShell and explains its effect.
---

# About Escape Characters
## about\_Escape\_Characters

# SHORT DESCRIPTION

Introduces the escape character in PowerShell and explains
its effect.

# LONG DESCRIPTION

Escape characters are used to assign a special interpretation to
the characters that follow it.

In PowerShell, the escape character is the backtick (`), also
called the grave accent (ASCII 96). The escape character can be used
to indicate a literal, to indicate line continuation, and to indicate
special characters.

In a call to another program, instead of using escape characters
to prevent PowerShell from misinterpreting program arguments,
you can use the stop-parsing symbol (--%). The stop-parsing symbol
is introduced in PowerShell 3.0.

# ESCAPING A VARIABLE

When an escape character precedes a variable, it prevents a value from
being substituted for the variable. This is mostly used inside a double
quotes string.

For example:

```powershell
$a = 5

# normal use of variable to be substituted
"The value is stored in $a."

# escaping the variable prevents substitution
"The value is stored in `$a."
```

```output
The value is stored in 5.
The value is stored in $a.
```

# ESCAPING QUOTATION MARKS

When an escape character precedes a double quotation mark,
PowerShell interprets the double quotation mark as a character,
not as a string delimiter.

This next example generates an error because the double quote in parenthesis
is not escaped, signaling the end of a string; this leaves the closing
parenthesis exposed as the next token for the parser.

```powershell
"Use quotation marks (") to indicate a string."
```

```output

At C:\tmp\Untitled-14.ps1:4 char:23
+ $a = "Use quotation (") marks to enclose a string""
+                       ~
Unexpected token ')' in expression or statement.
```

This next example properly escapes the double quote,
allowing the author to include a double quote in a string.

```powershell
"Use quotation marks (`") to indicate a string."
```

```output

Use quotation (") marks to enclose a string
```

# USING LINE CONTINUATION

When the escape character is the last character of a line,
the escape character tells PowerShell that the command continues
on the next line. To use line continuation there must be a space
or a properly closed token before the escape character.

For example:

```powershell
Get-Process `
PowerShell
```

```output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
340       8    34556      31864   149     0.98   2036 PowerShell
```

# USING SPECIAL CHARACTERS

When used within quotation marks, the escape character indicates a
special character that provides instructions to the command parser.

The following special characters are recognized by PowerShell:

Escape Sequence | Special Character
-- | --
`0 | Null
`a | Alert
`b | Backspace
`e | Escape
`f | Form feed
`n | New line
`r | Carriage return
`t | Horizontal tab
`u{x} | Unicode escape sequence for characters with hex value x (up to xxxxxx)
`v | Vertical tab

This next example uses new line and tab characters to format the string:

```powershell
"12345678123456781`nCol1`tColumn2`tCol3`u{2195}"
```

```output
12345678123456781

Col1 Column2 Col3↕
```

This next example uses the escape character to specify a virtual
terminal sequence to output text with the foreground color of Orange.
This example requires Windows 10 Anniversary Update or a Linux or
macOS terminal that supports 24-bit color.

```powershell
$r,$g,$b = 0xff,0x66,0x00
"`e[38;2;$r;$g;${b}mOrange text`e[0m"
```

```output
Orange text
```

This next example uses a Unicode escape sequence to display the
character '↕'.

```powershell
"`u{2195}"
```

```output
↕
```

For more information, type:
Get-Help about\_Special\_Characters

# STOP-PARSING SYMBOL

When calling other programs, you can use the stop-parsing
symbol (--%) to prevent PowerShell from generating
errors or misinterpreting program arguments. The stop-parsing
symbol is an alternative to using escape characters in program
calls. It is introduced in PowerShell 3.0.

For example, the following command uses the stop-parsing
symbol in an Icacls command:

icacls X:\VMS --% /grant Dom\HVAdmin:(CI)(OI)F

For more information about the stop-parsing symbol,
see about\_Parsing.

# SEE ALSO

- [about_Quoting_Rules](about_Quoting_Rules.md)
- [about_Special_Characters](about_Special_Characters.md)
- [about_Parsing](about_Parsing.md)

