---
description: Describes rules for using single and double quotation marks in PowerShell.
Locale: en-US
ms.date: 12/09/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Quoting Rules
---
# about_Quoting_Rules

## Short description
Describes rules for using single and double quotation marks in PowerShell.

## Long description

Quotation marks are used to specify a literal string. You can enclose a string
in single quotation marks (`'`) or double quotation marks (`"`).

Quotation marks are also used to create a _here-string_. A here-string is a
single-quoted or double-quoted string in which quotation marks are interpreted
literally. A here-string can span multiple lines. All the lines in a
here-string are interpreted as strings, even though they are not enclosed in
quotation marks.

In commands to remote computers, quotation marks define the parts of the
command that are run on the remote computer. In a remote session, quotation
marks also determine whether the variables in a command are interpreted first
on the local computer or on the remote computer.

## Double-quoted strings

A string enclosed in double quotation marks is an _expandable_ string. Variable
names preceded by a dollar sign (`$`) are replaced with the variable's value
before the string is passed to the command for processing.

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

Only simple variable references can be directly embedded in an expandable
string. Variables references using array indexing or member access must be
enclosed in a subexpression. For example:

```powershell
"PS version: $($PSVersionTable.PSVersion)"
```

```Output
PS version: 7.1.4
```

To separate a variable name from subsequent characters in the string,
enclose it in braces (`{}`). This is especially important if the variable name
is followed by a colon (`:`). PowerShell considers everything between the `$`
and the `:` a scope specifier, typically causing the interpretation to fail.
For example, `"$HOME: where the heart is."` throws an error, but
`"${HOME}: where the heart is."` works as intended.

To prevent the substitution of a variable value in a double-quoted string, use
the backtick character (`` ` ``), which is the PowerShell escape character.

In the following example, the backtick character that precedes the first `$i`
variable prevents PowerShell from replacing the variable name with its value.
For example:

```powershell
$i = 5
"The value of `$i is $i."
```

The output of this command is:

```Output
The value of $i is 5.
```

## Single-quoted strings

A string enclosed in single-quotation marks is a _verbatim_ string. The string
is passed to the command exactly as you type it. No substitution is performed.
For example:

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

## Including quote characters in a string

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
"Use a quotation mark (`") to begin a string."
'Use a quotation mark (`") to begin a string.'
```

Because the contents of single-quoted strings are interpreted literally, the
backtick character is treated as a literal character and displayed in the
output.

```Output
Use a quotation mark (") to begin a string.
Use a quotation mark (`") to begin a string.
```

## Here-strings

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

> [!NOTE]
> PowerShell allows double- or single-quoted strings to span multiple lines
> without using the `@` syntax of here-strings. However, full here-string
> syntax is the preferred usage.

## Interpretation of expandable strings

Expanded strings don't necessarily look the same as the default output that you
see in the console.

Collections, including arrays, are converted to strings by placing a single
space between the string representations of the elements. A different separator
can be specified by setting preference variable `$OFS`. For more information,
see the [`$OFS` preference variable](about_preference_variables.md#ofs).

Instances of any other type are converted to strings by calling the
`ToString()` method which may not give a meaningful representation. For
example:

```powershell
"hashtable: $(@{ key = 'value' })"
```

```Output
hashtable: System.Collections.Hashtable
```

To get the same output as in the console, use a subexpression in which you pipe
to `Out-String`. Apply the `Trim()` method if you want to remove any leading
and trailing empty lines.

```powershell
"hashtable:`n$((@{ key = 'value' } | Out-String).Trim())"
```

```Output
hashtable:
Name                           Value
----                           -----
key                            value
```

## Passing quoted strings to external commands

Some native commands expect arguments that contain quote characters. PowerShell
interprets the quoted string before passing it to the external command. This
interpretation removes the outer quote characters.

For more information about this behavior, see the
[about_Parsing](about_Parsing.md#passing-arguments-that-contain-quote-characters)
article.

## See also

- [about_Parsing](about_Parsing.md)
- [about_Special_Characters](about_Special_Characters.md)
- [ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData)
