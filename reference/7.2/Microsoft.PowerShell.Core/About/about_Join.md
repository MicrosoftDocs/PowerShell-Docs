---
description: Describes how the join operator (-join) combines multiple strings into a single string.
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_join?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Join
---
# About join

## SHORT DESCRIPTION
Describes how the join operator (-join) combines multiple strings into a
single string.

## LONG DESCRIPTION

The join operator concatenates a set of strings into a single string. The
strings are appended to the resulting string in the order that they appear
in the command.

### Syntax

The following diagram shows the syntax for the join operator.

```powershell
-Join <String[]>
<String[]> -Join <Delimiter>
```

#### Parameters

String[] - Specifies one or more strings to be joined.

Delimiter - Specifies one or more characters placed between the
concatenated strings. The default is no delimiter ("").

Remarks

The unary join operator (-join <string[]>) has higher precedence than a
comma. As a result, if you submit a comma-separated list of strings to the
unary join operator, only the first string (before the first comma) is
submitted to the join operator.

To use the unary join operator, enclose the strings in parentheses, or
store the strings in a variable, and then submit the variable to join.

For example:

```powershell
-join "a", "b", "c"
a
b
c

-join ("a", "b", "c")
abc

$z = "a", "b", "c"
-join $z
abc
```

### Examples

The following statement joins three strings:

```powershell
-join ("Windows", "PowerShell", "2.0")
WindowsPowerShell2.0
```

The following statement joins three strings delimited by a space:

```powershell
"Windows", "PowerShell", "2.0" -join " "
Windows PowerShell 2.0
```

The following statements use a multiple-character delimiter to join three
strings:

```powershell
$a = "WIND", "S P", "ERSHELL"
$a -join "OW"
WINDOWS POWERSHELL
```

The following statement joins the lines in a here-string into a single
string. Because a here-string is one string, the lines in the here-string
must be split before they can be joined. You can use this method to rejoin
the strings in an XML file that has been saved in a here-string:

```powershell
$a = @'
a
b
c
'@

(-split $a) -join " "
a b c
```

## SEE ALSO

[about_Operators](about_Operators.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Split](about_Split.md)

