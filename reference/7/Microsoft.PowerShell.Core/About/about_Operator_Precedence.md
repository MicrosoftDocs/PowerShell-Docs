---
ms.date:  11/30/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Operator_Precedence
---
# About Operator Precedence

## SHORT DESCRIPTION
Lists the PowerShell operators in precedence order.

[This topic was contributed by Kirk Munro, a PowerShell MVP
from Ottawa, Ontario]

## LONG DESCRIPTION

PowerShell operators let you construct simple, but powerful
expressions. This topic lists the operators in precedence order. Precedence
order is the order in which PowerShell evaluates the operators when
multiple operators appear in the same expression.

When operators have equal precedence, PowerShell evaluates them from
left to right as they appear within the expression.
The exceptions are the assignment operators, the cast
operators, and the negation operators (!, -not, -bnot), which are evaluated
from right to left.

You can use enclosures, such as parentheses, to override the standard
precedence order and force PowerShell to evaluate the enclosed part of
an expression before an unenclosed part.

In the following list, operators are listed in the order that they are
evaluated. Operators on the same line, or in the same group, have equal
precedence.

The Operator column lists the operators. The Reference column lists the
PowerShell Help topic in which the operator is described. To display
the topic, type `get-help <topic-name>`.

|OPERATOR                |REFERENCE|
|------------------------|---------|
|`$() @() ()`            |[about_Operators](about_Operators.md)|
|`.` (dereference)       |[about_Operators](about_Operators.md)|
|`::` (static)           |[about_Operators](about_Operators.md)|
|`[0]` (index operator)  |[about_Operators](about_Operators.md)|
|`[int]` (cast operators)|[about_Operators](about_Operators.md)|
|`-split` (unary)        |[about_Split](about_Split.md)|
|`-join` (unary)         |[about_Join](about_Join.md)|
|`,` (comma operator)    |[about_Operators](about_Operators.md)|
|`++ --`                 |[about_Assignment_Operators](about_Assignment_Operators.md)|
|`-not`                  |[about_Logical_Operators](about_logical_operators.md)|
|`! -bNot`               |[about_Comparison_Operators](about_Comparison_Operators.md)|
|`..` (range operator)   |[about_Operators](about_Operators.md)|
|`-f` (format operator)  |[about_Operators](about_Operators.md)|
|`-` (unary/negative)    |[about_Arithmetic_Operators](about_Arithmetic_Operators.md)|
|`* / %`                 |[about_Arithmetic_Operators](about_Arithmetic_Operators.md)|
|`+ -`                   |[about_Arithmetic_Operators](about_Arithmetic_Operators.md)|

The following group of operators have equal precedence. Their case-sensitive
and explicitly case-insensitive variants have the same precedence.

|OPERATOR                 |REFERENCE|
|-------------------------|---------|
|`-split` (unary)         |[about_Split](about_Split.md)|
|`-join` (unary)          |[about_Join](about_Join.md)|
|`-is -isnot -as`         |[about_Type_Operators](about_Type_Operators.md)|
|`-eq -ne -gt -gt -lt -le`|[about_Comparison_Operators](about_Comparison_Operators.md)|
|`-like -notlike`         |[about_comparison_operators](about_comparison_operators.md)|
|`-match -notmatch`       |[about_comparison_operators](about_comparison_operators.md)|
|`-in -notIn`             |[about_comparison_operators](about_comparison_operators.md)|
|`-contains -notContains` |[about_comparison_operators](about_comparison_operators.md)|
|`-replace`               |[about_comparison_operators](about_comparison_operators.md)|

The list resumes here with the following operators in precedence
order:

|OPERATOR                  |REFERENCE|
|--------------------------|---------|
|`-band -bor -bxor`        |[about_Arithmetic_Operators](about_Arithmetic_Operators.md)|
|`-and -or -xor`           |[about_Logical_Operators](about_logical_operators.md)|
|`.` (dot-source)          |[about_Scopes](about_Scopes.md)|
|`&` (call)                |[about_Operators](about_Operators.md)|
|<code>&#124;</code> (pipeline operator)|[about_Operators](about_Operators.md)|
|`> >> 2> 2>> 2>&1`        |[about_Redirection](about_Redirection.md)|
|`= += -= *= /= %=`        |[about_Assignment_Operators](about_Assignment_Operators.md)|

## EXAMPLES

The following two commands show the arithmetic operators and the effect of
using parentheses to force PowerShell to evaluate the enclosed part of
the expression first.

```powershell
PS> 2 + 3 * 4
14

PS> (2 + 3) * 4
20
```

The following example gets the read-only text files from the local directory
and saves them in the `$read_only` variable.

```powershell
$read_only = Get-ChildItem *.txt | Where-Object {$_.isReadOnly}
```

It is equivalent to the following example.

```powershell
$read_only = ( Get-ChildItem *.txt | Where-Object {$_.isReadOnly} )
```

Because the pipeline operator (|) has a higher precedence than the assignment
operator (=), the files that the Get-ChildItem cmdlet gets are sent to the
Where-Object cmdlet for filtering before they are assigned to the $read_only
variable.

The following example demonstrates that the index operator takes precedence
over the cast operator.

The first expression creates an array of three strings. Then, it uses the
index operator with a value of 0 to select the first object in the array,
which is the first string. Finally, it casts the selected object as a string.
In this case, the cast has no effect.

```powershell
PS> [string]@('Windows','PowerShell','2.0')[0]
Windows
```

The second expression uses parentheses to force the cast operation to occur
before the index selection. As a result, the entire array is cast as a
(single) string. Then, the index operator selects the first item in the string
array, which is the first character.

```powershell
PS> ([string]@('Windows','PowerShell','2.0'))[0]
W
```

In the following example, because the -gt (greater-than) operator has a higher
precedence than the -and (logical AND) operator, the result of the expression
is FALSE.

```powershell
PS> 2 -gt 4 -and 1
False
```

It is equivalent to the following expression.

```powershell
PS> (2 -gt 4) -and 1
False
```

If the -and operator had higher precedence, the answer would be TRUE.

```powershell
PS> 2 -gt (4 -and 1)
True
```

However, this example demonstrates an important principle of managing operator
precedence. When an expression is difficult for people to interpret, use
parentheses to force the evaluation order, even when it forces the default
operator precedence. The parentheses make your intentions clear to people who
are reading and maintaining your scripts.

## SEE ALSO

[about_Operators](about_Operators.md)

[about_Assignment_Operators](about_Assignment_Operators.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Arithmetic_Operators](about_Arithmetic_Operators.md)

[about_Join](about_Join.md)

[about_Redirection](about_Redirection.md)

[about_Scopes](about_Scopes.md)

[about_Split](about_Split.md)

[about_Type_Operators](about_Type_Operators.md)