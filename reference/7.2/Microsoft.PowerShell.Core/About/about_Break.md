---
description: Describes a statement you can use to immediately exit `foreach`, `for`, `while`, `do`, `switch`, or `trap` statements.
Locale: en-US
ms.date: 06/04/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_break?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Break
---
# About Break

## Short description

Describes a statement you can use to immediately exit `foreach`, `for`,
`while`, `do`, `switch`, or `trap` statements.

## Long description

The `break` statement provides a way to exit the current control block.
Execution continues at the next statement after the control block. The
statement supports labels. A label is a name you assign to a statement in a
script.

## Using break in loops

When a `break` statement appears in a loop, such as a `foreach`, `for`, `do`,
or `while` loop, PowerShell immediately exits the loop.

A `break` statement can include a label that lets you exit embedded loops. A
label can specify any loop keyword, such as `foreach`, `for`, or `while`, in a
script.

The following example shows how to use a `break` statement to exit a `for`
statement:

```powershell
for($i=1; $i -le 10; $i++) {
   Write-Host $i
   break
}
```

In this example, the `break` statement exits the `for` loop when the `$i`
variable equals 1. Even though the `for` statement evaluates to **True** until
`$i` is greater than 10, PowerShell reaches the break statement the first time
the `for` loop is run.

It is more common to use the `break` statement in a loop where an inner
condition must be met. Consider the following `foreach` statement example:

```powershell
$i=0
$varB = 10,20,30,40
foreach ($val in $varB) {
  if ($val -eq 30) {
    break
  }
  $i++
}
Write-Host "30 was found in array index $i"
```

In this example, the `foreach` statement iterates the `$varB` array. The `if`
statement evaluates to False the first two times the loop is run and the
variable `$i` is incremented by 1. The third time the loop is run, `$i` equals
2, and the `$val` variable equals 30. At this point, the `break` statement
runs, and the `foreach` loop exits.

### Using a labeled break in a loop

A `break` statement can include a label. If you use the `break` keyword with a
label, PowerShell exits the labeled loop instead of exiting the current loop.
The label is a colon followed by a name that you assign. The label must be the
first token in a statement, and it must be followed by the looping keyword,
such as `while`.

`break` moves execution out of the labeled loop. In embedded loops, this has a
different result than the `break` keyword has when it is used by itself. This
example has a `while` statement with a `for` statement:

```powershell
:myLabel while (<condition 1>) {
  for ($item in $items) {
    if (<condition 2>) {
      break myLabel
    }
    $item = $x   # A statement inside the For-loop
  }
}
$a = $c  # A statement after the labeled While-loop
```

If condition 2 evaluates to **True**, the execution of the script skips down to
the statement after the labeled loop. In the example, execution starts again
with the statement `$a = $c`.

You can nest many labeled loops, as shown in the following example.

```powershell
:red while (<condition1>) {
  :yellow while (<condition2>) {
    while (<condition3>) {
      if ($a) {break}
      if ($b) {break red}
      if ($c) {break yellow}
    }
    Write-Host "After innermost loop"
  }
  Write-Host "After yellow loop"
}
Write-Host "After red loop"
```

If the `$b` variable evaluates to True, execution of the script resumes after
the loop that is labeled "red". If the `$c` variable evaluates to True,
execution of the script control resumes after the loop that is labeled
"yellow".

If the `$a` variable evaluates to True, execution resumes after the innermost
loop. No label is needed.

PowerShell does not limit how far labels can resume execution. The label can
even pass control across script and function call boundaries.

## Using break in a switch statement

In a `switch`construct, `break` causes PowerShell to exit the `switch` code block.

The `break` keyword is used to leave the `switch` construct. For example, the
following `switch` statement uses `break` statements to test for the most
specific condition:

```powershell
$var = "word2"
switch -regex ($var) {
    "word2" {
      Write-Host "Exact" $_
      break
    }

    "word.*" {
      Write-Host "Match on the prefix" $_
      break
    }

    "w.*" {
      Write-Host "Match on at least the first letter" $_
      break
    }

    default {
      Write-Host "No match" $_
      break
    }
}
```

In this example, the `$var` variable is created and initialized to a string
value of `word2`. The `switch` statement uses the **Regex** class to match the
variable value first with the term `word2`. Because the variable value and the
first test in the `switch` statement match, the first code block in the
`switch` statement runs.

When PowerShell reaches the first `break` statement, the `switch` statement
exits. If the four `break` statements are removed from the example, all four
conditions are met. This example uses the `break` statement to display results
when the most specific condition is met.

## Using break in a trap statement

If the final statement executed in the body of a `trap` statement is `break`,
the error object is suppressed and the exception is re-thrown.

The following example create a **DivideByZeroException** exception that is
trapped using the `trap` statement.

```powershell
function test {
  trap [DivideByZeroException] {
    Write-Host 'divide by zero trapped'
    break
  }

  $i = 3
  'Before loop'
  while ($true) {
     "1 / $i = " + (1 / $i--)
  }
  'After loop'
}
test
```

Notice that execution stops at the exception. The `After loop` is never reached.
The exception is re-thrown after the `trap` executes.

```Output
Before loop
1 / 3 = 0.333333333333333
1 / 2 = 0.5
1 / 1 = 1
divide by zero trapped
ParentContainsErrorRecordException:
Line |
  10 |       "1 / $i = " + (1 / $i--)
     |       ~~~~~~~~~~~~~~~~~~~~~~~~
     | Attempted to divide by zero.
```

## Do not use break outside of a loop, switch, or trap

When `break` is used outside of a construct that directly supports it
(loops, `switch`, `trap`), PowerShell looks _up the call stack_ for an
enclosing construct. If it can't find an enclosing construct, the current
runspace is quietly terminated.

This means that functions and scripts that inadvertently use a `break` outside
of an enclosing construct that supports it can inadvertently terminate their
_callers_.

Using `break` inside a pipeline `break`, such as a `ForEach-Object` script
block, not only exits the pipeline, it potentially terminates the entire
runspace.

## See also

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Continue](about_Continue.md)

[about_For](about_For.md)

[about_Foreach](about_Foreach.md)

[about_Switch](about_Switch.md)

[about_Throw](about_Throw.md)

[about_Trap](about_Trap.md)

[about_Try_Catch_Finally](about_Try_Catch_Finally.md)

[about_While](about_While.md)
