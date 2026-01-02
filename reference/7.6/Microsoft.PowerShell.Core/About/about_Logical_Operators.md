---
description: Describes the operators that connect statements in PowerShell.
Locale: en-US
ms.date: 12/30/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_logical_operators?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Logical_Operators
---
# about_Logical_Operators

## Short description

Describes the operators that connect statements in PowerShell.

## Long description

The PowerShell logical operators connect expressions and statements, allowing
you to use a single expression to test for multiple conditions.

Statements that use the logical operators return boolean (TRUE or FALSE)
values.

The PowerShell logical operators evaluate only the statements required to
determine the truth value of the statement. If the left operand in a statement
that contains the `-and` operator is FALSE, the right operand isn't evaluated.
If the left operand in a statement that contains the `-or` statement is TRUE,
the right operand isn't evaluated. As a result, you can use these statements in
the same way that you would use the `if` statement.

> [!IMPORTANT]
> The `-and`, `-or` and `-xor` operators have equal precedence. They are
> evaluated from left to right as they appear within the expression. For more
> information, see [about_Operator_Precedence][01].

## Syntax

The syntax of the logical operators is as follows:

```Syntax
<statement> {-and | -or | -xor} <statement>
{! | -not} <statement>
```

## Examples

The following example uses the `-and` and `-or` operators to connect three
conditional statements. The result is TRUE only when the value of `$a` is
greater than the value of `$b`, and either `$a` or `$b` is less than `20`.

```powershell
($a -gt $b) -and (($a -lt 20) -or ($b -lt 20))
```

PowerShell supports the following logical operators.

- Logical AND (`-and`) - TRUE when both statements are TRUE.

  ```powershell
  (1 -eq 1) -and (1 -eq 2)   # Result is False
  ```

- Logical OR (`-or`) - TRUE when either statement is TRUE.

  ```powershell
  (1 -eq 1) -or (1 -eq 2)    # Result is True
  ```

- Logical EXCLUSIVE OR (`-xor`) - TRUE when only one statement is TRUE

  ```powershell
  (1 -eq 1) -xor (2 -eq 2)   # Result is False
  ```

- Logical NOT (`-not`) or (`!`) - Negates the statement that follows.

  ```powershell
  -not (1 -eq 1)             # Result is False
  !(1 -eq 1)                 # Result is False
  ```

The previous examples also use the equality comparison operator, `-eq`. For
more information, see [about_Comparison_Operators][03]. The examples also use
the boolean values of integers. The integer `0` has a boolean value of FALSE.
All other integers have a value of TRUE.

## See also

- [about_Operators][02]
- [about_Operator_Precedence][01]
- [about_Comparison_Operators][03]
- [about_If][04]
- [Compare-Object][05]

<!-- link references -->
[01]: about_Operator_Precedence.md
[02]: about_Operators.md
[03]: about_Comparison_Operators.md
[04]: about_If.md
[05]: xref:Microsoft.PowerShell.Utility.Compare-Object
