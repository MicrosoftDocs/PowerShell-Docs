---
description:  Describes how the `continue` statement immediately returns the program flow to the top of a program loop, a `switch` statement, or a `trap` statement. 
keywords: powershell,cmdlet
ms.date: 06/04/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_continue?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Continue
---
# About Continue

## Short description

Describes how the `continue` statement immediately returns the program flow
to the top of a program loop, a `switch` statement, or a `trap` statement.

## Long description

The `continue` statement provides a way to exit the current control block but
continue execution, rather than exit completely. The statement supports labels.
A label is a name you assign to a statement in a script.

## Using continue in loops

An unlabeled `continue` statement immediately returns the program flow to
the top of the innermost loop that is controlled by a `for`, `foreach`, `do`,
or `while` statement. The current iteration of the loop is terminated and the
loop continues with the next iteration.

In the following example, program flow returns to the top of the `while` loop
if the `$ctr` variable is equal to 5. As a result, all the numbers between 1
and 10 are displayed except for 5:

```powershell
while ($ctr -lt 10)
{
    $ctr += 1
    if ($ctr -eq 5)
    {
        continue
    }

    Write-Host -Object $ctr
}
```

When using a `for` loop, execution continues at the `<Repeat>` statement,
followed by the `<Condition>` test. In the example below, an infinite loop
will not occur because the decrement of `$i` occurs after the `continue`
keyword.

```powershell
#   <Init>  <Condition> <Repeat>
for ($i = 0; $i -lt 10; $i++)
{
    Write-Host -Object $i
    if ($i -eq 5)
    {
        continue
        # Will not result in an infinite loop.
        $i--
    }
}
```

### Using a labeled continue in a loop

A labeled `continue` statement terminates execution of the iteration and
transfers control to the targeted enclosing iteration or `switch` statement
label.

In the following example, the innermost `for` is terminated when `$condition`
is **True** and iteration continues with the second `for` loop at `labelB`.

```powershell
:labelA for ($i = 1; $i -le 10; $i++) {
    :labelB for ($j = 1; $j -le 10; $j++) {
        :labelC for ($k = 1; $k -le 10; $k++) {
            if ($condition) {
                continue labelB
            } else {
                $condition = Update-Condition
            }
        }
    }
}
```

## Using continue in a switch statement

An unlabeled `continue` statement within a `switch` terminates execution of the
current `switch` iteration and transfers control to the top of the `switch` to get
the next input item.

When there is a single input item `continue` exits the entire `switch` statement.
When the `switch` input is a collection, the `switch` tests each element of the
collection. The `continue` exits the current iteration and the `switch` continues
with the next element.

```powershell
switch (1,2,3) {
  2 { continue }  # moves on to the next element, 3
  default { $_ }
}
```

```Output
1
3
```

## Using continue in a trap statement

If the final statement executed in the body a `trap` statement is `continue`,
the trapped error is silently ignored and execution continues with the
statement immediately following the one that caused `trap` to occur.

## Do not use continue outside of a loop, switch, or trap

When `continue` is used outside of a construct that directly supports it
(loops, `switch`, `trap`), PowerShell looks _up the call stack_ for an
enclosing construct. If it can't find an enclosing construct, the current
runspace is quietly terminated.

This means that functions and scripts that inadvertently use a `continue`
outside of an enclosing construct that supports it, can inadvertently terminate
their _callers_.

Using `continue` inside a pipeline, such as a `ForEach-Object` script block,
not only exits the pipeline, tt potentially terminates the entire runspace.

## See also

[about_Break](about_Break.md)

[about_For](about_For.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Throw](about_Throw.md)

[about_Trap](about_Trap.md)

[about_Try_Catch_Finally](about_Try_Catch_Finally.md)
