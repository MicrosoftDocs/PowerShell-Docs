---
description:  Runs a statement list one or more times, subject to a While or Until condition. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Do
---

# About Do

## SHORT DESCRIPTION

Runs a statement list one or more times, subject to a While or Until
condition.

## LONG DESCRIPTION

The Do keyword works with the While keyword or the Until keyword to run the
statements in a script block, subject to a condition. Unlike the related
While loop, the script block in a Do loop always runs at least once.

A **Do-While** loop is a variety of the While loop. In a **Do-While** loop,
the condition is evaluated after the script block has run. As in a While
loop, the script block is repeated as long as the condition evaluates to
true.

Like a **Do-While** loop, a **Do-Until** loop always runs at least once
before the condition is evaluated. However, the script block runs only
while the condition is false.

The *Continue* and *Break* flow control keywords can be used in a
**Do-While** loop or in a **Do-Until** loop.

### Syntax

The following shows the syntax of the **Do-While** statement:

```powershell
do {<statement list>} while (<condition>)
```

The following shows the syntax of the **Do-Until** statement:

```powershell
do {<statement list>} until (<condition>)
```

The statement list contains one or more statements that run each time the
loop is entered or repeated.

The condition portion of the statement resolves to true or false.

### Example

The following example of a Do statement counts the items in an array until
it reaches an item with a value of 0.

```powershell
C:\PS> $x = 1,2,78,0
C:\PS> do { $count++; $a++; } while ($x[$a] -ne 0)
C:\PS> $count
3
```

The following example uses the Until keyword. Notice that the not equal to
operator (`-ne`) is replaced by the equal to operator (`-eq`).

```powershell
C:\PS> $x = 1,2,78,0
C:\PS> do { $count++; $a++; } until ($x[$a] -eq 0)
C:\PS> $count
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

## SEE ALSO

[about_While](about_While.md)

[about_Operators](about_Operators.md)

[about_Assignment_Operators](about_Assignment_Operators.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Break](about_Break.md)

[about_Continue](about_Continue.md)
