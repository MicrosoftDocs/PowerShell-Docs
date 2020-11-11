---
description: Describes the operators that connect statements in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_logical_operators?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Logical_Operators
---
# about_Logical_Operators

## SHORT DESCRIPTION
Describes the operators that connect statements in PowerShell.

## LONG DESCRIPTION

The PowerShell logical operators connect expressions and statements, allowing
you to use a single expression to test for multiple conditions.

For example, the following statement uses the and operator and the or operator
to connect three conditional statements. The statement is true only when the
value of $a is greater than the value of $b, and either $a or $b is less than
20.

```powershell
($a -gt $b) -and (($a -lt 20) -or ($b -lt 20))
```

PowerShell supports the following logical operators.

|Operator|Description                        |Example                   |
|--------|-----------------------------------|--------------------------|
|`-and`  |Logical AND. TRUE when both        |`(1 -eq 1) -and (1 -eq 2)`|
|        |statements are TRUE.               |`False`                   |
|`-or`   |Logical OR. TRUE when either       |`(1 -eq 1) -or (1 -eq 2)` |
|        |statement is TRUE.                 |`True`                    |
|`-xor`  |Logical EXCLUSIVE OR. TRUE when    |`(1 -eq 1) -xor (2 -eq 2)`|
|        |only one statement is TRUE         |`False`                   |
|`-not`  |Logical not. Negates the statement |`-not (1 -eq 1)`          |
|        |that follows.                      |`False`                   |
|`!`     |Same as `-not`                     |`!(1 -eq 1)`              |
|        |                                   |`False`                   |

 Note:

The previous examples also use the equal to comparison operator `-eq`. For
more information, see
[about_Comparison_Operators](about_Comparison_Operators.md). The examples also
use the Boolean values of integers. The integer 0 has a value of FALSE. All
other integers have a value of TRUE.

The syntax of the logical operators is as follows:

```
<statement> {-AND | -OR | -XOR} <statement>
{! | -NOT} <statement>
```

Statements that use the logical operators return Boolean (TRUE or FALSE)
values.

The PowerShell logical operators evaluate only the statements required to
determine the truth value of the statement. If the left operand in a statement
that contains the and operator is FALSE, the right operand is not evaluated.
If the left operand in a statement that contains the or statement is TRUE, the
right operand is not evaluated. As a result, you can use these statements in
the same way that you would use the `If` statement.

## SEE ALSO

[about_Operators](about_Operators.md)

[Compare-Object](xref:Microsoft.PowerShell.Utility.Compare-Object)

[about_Comparison_operators](about_Comparison_Operators.md)

[about_If](about_If.md)

