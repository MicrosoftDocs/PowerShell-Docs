---
description: Lists the PowerShell operators in precedence order.
Locale: en-US
ms.date: 06/29/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_operator_precedence?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Operator_Precedence
---
# about_Operator_Precedence

## Short description

Lists the PowerShell operators in precedence order.

## Long description

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

|          OPERATOR           |              REFERENCE               |
| --------------------------- | ------------------------------------ |
| `$() @() () @{}`            | [about_Operators][ops]               |
| `. ?.` (member access)      | [about_Operators][ops]               |
| `::` (static)               | [about_Operators][ops]               |
| `[0] ?[0]` (index operator) | [about_Operators][ops]               |
| `[int]` (cast operators)    | [about_Operators][ops]               |
| `-split` (unary)            | [about_Split][split]                 |
| `-join` (unary)             | [about_Join][join]                   |
| `,` (comma operator)        | [about_Operators][ops]               |
| `++ --`                     | [about_Assignment_Operators][assign] |
| `! -not`                    | [about_Logical_Operators][logic]     |
| `..` (range operator)       | [about_Operators][ops]               |
| `-f` (format operator)      | [about_Operators][ops]               |
| `-` (unary/negative)        | [about_Arithmetic_Operators][math]   |
| `* / %`                     | [about_Arithmetic_Operators][math]   |
| `+ -`                       | [about_Arithmetic_Operators][math]   |

The following group of operators have equal precedence. Their case-sensitive
and explicitly case-insensitive variants have the same precedence.

|         OPERATOR          |               REFERENCE               |
| ------------------------- | ------------------------------------- |
| `-split` (binary)         | [about_Split][split]                  |
| `-join` (binary)          | [about_Join][join]                    |
| `-is -isnot -as`          | [about_Type_Operators][type]          |
| `-eq -ne -gt -ge -lt -le` | [about_Comparison_Operators][compare] |
| `-like -notlike`          | [about_Comparison_Operators][compare] |
| `-match -notmatch`        | [about_Comparison_Operators][compare] |
| `-in -notIn`              | [about_Comparison_Operators][compare] |
| `-contains -notContains`  | [about_Comparison_Operators][compare] |
| `-replace`                | [about_Comparison_Operators][compare] |

The list resumes here with the following operators in precedence
order:

|              OPERATOR              |             REFERENCE              |
| ---------------------------------- | ---------------------------------- |
| `-band -bnot -bor -bxor -shr -shl` | [about_Arithmetic_Operators][math] |
| `-and -or -xor`                    | [about_Logical_Operators][logic]   |

The following items are not true operators. They are part of PowerShell's
command syntax, not expression syntax. Assignment is always the last action
that happens.

|                         SYNTAX                          |              REFERENCE               |
| ------------------------------------------------------- | ------------------------------------ |
| `.` (dot-source)                                        | [about_Operators][ops]               |
| `&` (call)                                              | [about_Operators][ops]               |
| `? <if-true> : <if-false>` (Ternary operator)           | [about_Operators][ops]               |
| `??` (null-coalese operator)                            | [about_Operators][ops]               |
| <code>&#124;</code> (pipeline operator)                 | [about_Operators][ops]               |
| `> >> 2> 2>> 2>&1`                                      | [about_Redirection][redir]           |
| <code>&& &#124;&#124;</code> (pipeline chain operators) | [about_Operators][ops]               |
| `= += -= *= /= %= ??=`                                  | [about_Assignment_Operators][assign] |

## Examples

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

## See also

- [about_Operators][ops]
- [about_Arithmetic_Operators][math]
- [about_Assignment_Operators][assign]
- [about_Comparison_Operators][compare]
- [about_Type_Operators][type]
- [about_Join][join]
- [about_Redirection][redir]
- [about_Scopes][scopes]
- [about_Split][split]
- [about_Type_Operators][type]

<!-- reference links -->
[math]: about_Arithmetic_Operators.md
[assign]: about_Assignment_Operators.md
[compare]: about_Comparison_Operators.md
[join]: about_Join.md
[logic]: about_logical_operators.md
[ops]: about_Operators.md
[redir]: about_Redirection.md
[scopes]: about_Scopes.md
[split]: about_Split.md
[type]: about_Type_Operators.md
