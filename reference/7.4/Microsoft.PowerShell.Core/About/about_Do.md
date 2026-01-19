---
description: Runs a statement list one or more times, subject to a `while` or `until` condition.
Locale: en-US
ms.date: 01/18/2026
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Do
---
# about_Do

## Short description

Runs a statement list one or more times, subject to a `while` or `until`
condition.

## Long description

The `do` keyword works with the `while` keyword or the `until` keyword to run
the commands in a statement block, subject to a condition. Unlike the related
`while` loop, the statement block in a `do` loop always runs at least once.

A `do/while` loop is a variety of the `while` loop. In a `do/while` loop, the
condition is evaluated after the statement block has run. As in a `while` loop,
the statement block is repeated as long as the condition evaluates to true.

Like a `do/while` loop, a `do/until` loop always runs at least once before the
condition is evaluated. However, the statement block runs only while the
condition is false.

The `continue` and `break` flow control keywords can be used in a `do/while`
loop or in a `do/until` loop.

### Syntax

The following shows the syntax of the `do/while` statement:

```powershell
do {<statement list>} while (<condition>)
```

The following shows the syntax of the `do/until` statement:

```powershell
do {<statement list>} until (<condition>)
```

The statement list contains one or more statements that run each time the loop
is entered or repeated.

The condition portion of the statement resolves to true or false. For more
information about how booleans are evaluated, see
[about_Booleans][02].

### Example

The following example of a `do` statement counts the items in an array until it
reaches an item with a value of 0.

```powershell
PS> $x = 1,2,78,0
PS> do { $count++; $a++; } while ($x[$a] -ne 0)
PS> $count
3
```

The following example uses the `until` keyword. Notice that the not equal to
operator (`-ne`) is replaced by the equal to operator (`-eq`).

```powershell
PS> $x = 1,2,78,0
PS> do { $count++; $a++; } until ($x[$a] -eq 0)
PS> $count
3
```

The following example writes all the values of an array, skipping any value
that is less than zero.

```powershell
do {
  if ($x[$a] -lt 0) { continue }
  Write-Host $x[$a]
}
while (++$a -lt 10)
```

## See also

- [about_Booleans][02]
- [about_Break][03]
- [about_Continue][05]
- [about_Operators][06]
- [about_Assignment_Operators][01]
- [about_Comparison_Operators][04]
- [about_While][07]

<!-- link references -->
[01]: about_Assignment_Operators.md
[02]: about_Booleans.md
[03]: about_Break.md
[04]: about_Comparison_Operators.md
[05]: about_Continue.md
[06]: about_Operators.md
[07]: about_While.md



