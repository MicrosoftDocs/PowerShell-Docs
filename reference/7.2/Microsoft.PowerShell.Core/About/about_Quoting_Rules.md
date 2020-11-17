---
description: Describes rules for using single and double quotation marks in PowerShell.
Locale: en-US
ms.date: 10/05/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Quoting_Rules
---
# About Quoting Rules

## SHORT DESCRIPTION
Describes rules for using single and double quotation marks in PowerShell.

## LONG DESCRIPTION

Quotation marks are used to specify a literal string. You can enclose a string
in single quotation marks (`'`) or double quotation marks (`"`).

Quotation marks are also used to create a here-string. A here-string is a
single-quoted or double-quoted string in which quotation marks are interpreted
literally. A here-string can span multiple lines. All the lines in a
here-string are interpreted as strings, even though they are not enclosed in
quotation marks.

In commands to remote computers, quotation marks define the parts of the
command that are run on the remote computer. In a remote session, quotation
marks also determine whether the variables in a command are interpreted first
on the local computer or on the remote computer.

### SINGLE AND DOUBLE-QUOTED STRINGS

When you enclose a string in double quotation marks (a double-quoted string),
variable names that are preceded by a dollar sign (`$`) are replaced with the
variable's value before the string is passed to the command for processing.

For example:

```powershell
$i = 5
"The value of $i is $i."
```

The output of this command is:

```Output
The value of 5 is 5.
```

Also, in a double-quoted string, expressions are evaluated, and the result is
inserted in the string. For example:

```powershell
"The value of $(2+3) is 5."
```

The output of this command is:

```Output
The value of 5 is 5.
```

When you enclose a string in single-quotation marks (a single-quoted string),
the string is passed to the command exactly as you type it. No substitution is
performed. For example:

```powershell
$i = 5
'The value of $i is $i.'
```

The output of this command is:

```Output
The value $i is $i.
```

Similarly, expressions in single-quoted strings are not evaluated. They are
interpreted as literals. For example:

```powershell
'The value of $(2+3) is 5.'
```

The output of this command is:

```Output
The value of $(2+3) is 5.
```

To prevent the substitution of a variable value in a double-quoted string, use
the backtick character (`` ` ``)(ASCII 96), which is the PowerShell escape
character.

In the following example, the backtick character that precedes the first $i
variable prevents PowerShell from replacing the variable name with its value.
For example:

```powershell
$i = 5
"The value of `$i is $i."
```

The output of this command is:

```Output
The value $i is 5.
```

To make double-quotation marks appear in a string, enclose the entire string
in single quotation marks. For example:

```powershell
'As they say, "live and learn."'
```

The output of this command is:

```Output
As they say, "live and learn."
```

You can also enclose a single-quoted string in a double-quoted string. For
example:

```powershell
"As they say, 'live and learn.'"
```

The output of this command is:

```Output
As they say, 'live and learn.'
```

Or, double the quotation marks around a double-quoted phrase. For example:

```powershell
"As they say, ""live and learn."""
```

The output of this command is:

```Output
As they say, "live and learn."
```

To include a single quotation mark in a single-quoted string, use a second
consecutive single quote. For example:

```powershell
'don''t'
```

The output of this command is:

```Output
don't
```

To force PowerShell to interpret a double quotation mark literally, use a
backtick character. This prevents PowerShell from interpreting the quotation
mark as a string delimiter. For example:

```powershell
PS> "Use a quotation mark (`") to begin a string."
Use a quotation mark (") to begin a string.
PS> 'Use a quotation mark (`") to begin a string.'
Use a quotation mark (`") to begin a string.
```

Because the contents of single-quoted strings are interpreted literally, you
the backtick character is treated as a literal character and displayed in the
output.

### HERE-STRINGS

The quotation rules for here-strings are slightly different.

A here-string is a single-quoted or double-quoted string in which quotation
marks are interpreted literally. A here-string can span multiple lines. All the
lines in a here-string are interpreted as strings even though they are not
enclosed in quotation marks.

Like regular strings, variables are replaced by their values in double-quoted
here-strings. In single-quoted here-strings, variables are not replaced by
their values.

You can use here-strings for any text, but they are particularly useful for
the following kinds of text:

- Text that contains literal quotation marks
- Multiple lines of text, such as the text in an HTML or XML
- The Help text for a script or function document

A here-string can have either of the following formats, where `<Enter>`
represents the linefeed or newline hidden character that is added when you
press the <kbd>ENTER</kbd> key.

Double-quotes:

```
@"<Enter>
<string> [string] ...<Enter>
"@
```

Single-quotes:

```
@'<Enter>
<string> [string] ...<Enter>
'@
```

In either format, the closing quotation mark must be the first character in
the line.

A here-string contains all the text between the two hidden characters. In the
here-string, all quotation marks are interpreted literally. For example:

```powershell
@"
For help, type "get-help"
"@
```

The output of this command is:

```Output
For help, type "get-help"
```

Using a here-string can simplify using a string in a command. For example:

```powershell
@"
Use a quotation mark (') to begin a string.
"@
```

The output of this command is:

```Output
Use a quotation mark (') to begin a string.
```

In single-quoted here-strings, variables are interpreted literally and
reproduced exactly. For example:

```powershell
@'
The $profile variable contains the path
of your PowerShell profile.
'@
```

The output of this command is:

```Output
The $profile variable contains the path
of your PowerShell profile.
```

In double-quoted here-strings, variables are replaced by their values. For
example:

```powershell
@"
Even if you have not created a profile,
the path of the profile file is:
$profile.
"@
```

The output of this command is:

```Output
Even if you have not created a profile,
the path of the profile file is:
C:\Users\User1\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1.
```

Here-strings are typically used to assign multiple lines to a variable. For
example, the following here-string assigns a page of XML to the $page variable.

```powershell
$page = [XML] @"
<command:command xmlns:maml="http://schemas.microsoft.com/maml/2004/10"
xmlns:command="http://schemas.microsoft.com/maml/dev/command/2004/10"
xmlns:dev="http://schemas.microsoft.com/maml/dev/2004/10">
<command:details>
        <command:name>
               Format-Table
        </command:name>
        <maml:description>
            <maml:para>Formats the output as a table.</maml:para>
        </maml:description>
        <command:verb>format</command:verb>
        <command:noun>table</command:noun>
        <dev:version></dev:version>
</command:details>
...
</command:command>
"@
```

Here-strings are also a convenient format for input to the
`ConvertFrom-StringData` cmdlet, which converts here-strings to hash tables.
For more information, see `ConvertFrom-StringData`.

## SEE ALSO

[about_Special_Characters](about_Special_Characters.md)

[ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData)
