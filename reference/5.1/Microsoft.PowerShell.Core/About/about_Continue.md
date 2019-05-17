---
ms.date: 5/9/2019
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_Continue
---
# About Continue

## SHORT DESCRIPTION

Describes how the `Continue` statement immediately returns the program flow
to the top of a program loop.

## LONG DESCRIPTION

In a script, the `Continue` statement immediately returns the program flow
to the top of the innermost loop that is controlled by a `For`, `Foreach`,
or `While` statement.

The `Continue` keyword supports labels. A label is a name you assign to a
statement in a script. For information about labels, see
[about_Break](about_Break.md).

In the following example, program flow returns to the top of the While loop
if the `$ctr` variable is equal to 5. As a result, all the numbers between 1
and 10 are displayed except for 5:

```powershell
while ($ctr -lt 10)
{
    $ctr += 1
    if ($ctr -eq 5)
    {
        Continue
    }

    Write-Host -Object $ctr
}
```

When using a `For` loop, execution continues at the `<Repeat>` statement,
followed by the `<Condition>` test. In the example below, an infinite loop
will not occur because the decrement of `$i` occurs after the `Continue`
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
        $i--;
    }
}
```

## SEE ALSO

[about_Break](about_Break.md)

[about_For](about_For.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Throw](about_Throw.md)

[about_Trap](about_Trap.md)

[about_Try_Catch_Finally](about_Try_Catch_Finally.md)