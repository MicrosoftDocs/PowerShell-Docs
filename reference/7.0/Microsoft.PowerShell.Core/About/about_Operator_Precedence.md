---
description: Lists the PowerShell operators in precedence order.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 11/09/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_operator_precedence?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Operator_Precedence
---
# About Operator Precedence

## SHORT DESCRIPTION
Lists the PowerShell operators in precedence order.

## LONG DESCRIPTION

PowerShell operators let you construct simple, but powerful expressions. This
topic lists the operators in precedence order. Precedence order is the order in
which PowerShell evaluates the operators when multiple operators appear in the
same expression.

When operators have equal precedence, PowerShell evaluates them from left to
right as they appear within the expression. The exceptions are the assignment
operators, the cast operators, and the negation operators (`!`, `-not`,
`-bnot`), which are evaluated from right to left.

You can use enclosures, such as parentheses, to override the standard
precedence order and force PowerShell to evaluate the enclosed part of an
expression before an unenclosed part.

In the following list, operators are listed in the order that they are
evaluated. Operators on the same line, or in the same group, have equal
precedence.

The Operator column lists the operators. The Reference column lists the
PowerShell Help topic in which the operator is described. To display the topic,
type `get-help <topic-name>`.

|         OPERATOR         |           REFERENCE            |
| ------------------------ | ------------------------------ |
| `$() @() () @{}`         | [about_Operators][]            |
| `. ?.` (member access)   | [about_Operators][]            |
| `::` (static)            | [about_Operators][]            |
| `[0] ?[0]` (index operator) | [about_Operators][]         |
| `[int]` (cast operators) | [about_Operators][]            |
| `-split` (unary)         | [about_Split][]                |
| `-join` (unary)          | [about_Join][]                 |
| `,` (comma operator)     | [about_Operators][]            |
| `++ --`                  | [about_Assignment_Operators][] |
| `! -not`                 | [about_Logical_Operators][]    |
| `..` (range operator)    | [about_Operators][]            |
| `-f` (format operator)   | [about_Operators][]            |
| `-` (unary/negative)     | [about_Arithmetic_Operators][] |
| `* / %`                  | [about_Arithmetic_Operators][] |
| `+ -`                    | [about_Arithmetic_Operators][] |

The following group of operators have equal precedence. Their case-sensitive
and explicitly case-insensitive variants have the same precedence.

|         OPERATOR          |           REFERENCE            |
| ------------------------- | ------------------------------ |
| `-split` (binary)         | [about_Split][]                |
| `-join` (binary)          | [about_Join][]                 |
| `-is -isnot -as`          | [about_Type_Operators][]       |
| `-eq -ne -gt -gt -lt -le` | [about_Comparison_Operators][] |
| `-like -notlike`          | [about_Comparison_Operators][] |
| `-match -notmatch`        | [about_Comparison_Operators][] |
| `-in -notIn`              | [about_Comparison_Operators][] |
| `-contains -notContains`  | [about_Comparison_Operators][] |
| `-replace`                | [about_Comparison_Operators][] |

The list resumes here with the following operators in precedence
order:

|                OPERATOR                 |           REFERENCE            |
| --------------------------------------- | ------------------------------ |
| `-band -bnot -bor -bxor -shr -shl`      | [about_Arithmetic_Operators][] |
| `-and -or -xor`                         | [about_Logical_Operators][]    |

The following items are not true operators. They are part of PowerShell's
command syntax, not expression syntax. Assignment is always the last action
that happens.

|                SYNTAX                   |           REFERENCE            |
| --------------------------------------- | ------------------------------ |
| `.` (dot-source)                        | [about_Operators][]            |
| `&` (call)                              | [about_Operators][]            |
| `? <if-true> : <if-false>` (Ternary operator) | [about_Operators][]      |
| `??` (null-coalese operator)            | [about_Operators][]            |
| <code>&#124;</code> (pipeline operator) | [about_Operators][]            |
| `> >> 2> 2>> 2>&1`                      | [about_Redirection][]          |
| <code>&& &#124;&#124;</code> (pipeline chain operators) | [about_Operators][] |
| `= += -= *= /= %= ??=`                  | [about_Assignment_Operators][] |

## EXAMPLES

The following two commands show the arithmetic operators and the effect of
using parentheses to force PowerShell to evaluate the enclosed part of the
expression first.

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

Because the pipeline operator (`|`) has a higher precedence than the assignment
operator (`=`), the files that the `Get-ChildItem` cmdlet gets are sent to the
`Where-Object` cmdlet for filtering before they are assigned to the `$read_only`
variable.

The following example demonstrates that the index operator takes precedence
over the cast operator.

This expression creates an array of three strings. Then, it uses the index
operator with a value of 0 to select the first object in the array, which is
the first string. Finally, it casts the selected object as a string. In this
case, the cast has no effect.

```powershell
PS> [string]@('Windows','PowerShell','2.0')[0]
Windows
```

This expression uses parentheses to force the cast operation to occur before
the index selection. As a result, the entire array is cast as a (single)
string. Then, the index operator selects the first item in the string array,
which is the first character.

```powershell
PS> ([string]@('Windows','PowerShell','2.0'))[0]
W
```

In the following example, because the `-gt` (greater-than) operator has a
higher precedence than the `-and` (logical AND) operator, the result of the
expression is FALSE.

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

[about_Operators][]

[about_Assignment_Operators][]

[about_Comparison_Operators][]

[about_Arithmetic_Operators][]

[about_Join][]

[about_Redirection][]

[about_Scopes][]

[about_Split][]

[about_Type_Operators][]

<!-- reference links -->
[about_Arithmetic_Operators]: about_Arithmetic_Operators.md
[about_Assignment_Operators]: about_Assignment_Operators.md
[about_Comparison_Operators]: about_Comparison_Operators.md
[about_Join]: about_Join.md
[about_Logical_Operators]: about_logical_operators.md
[about_Operators]: about_Operators.md
[about_Redirection]: about_Redirection.md
[about_Scopes]: about_Scopes.md
[about_Split]: about_Split.md
[about_Type_Operators]: about_Type_Operators.md
