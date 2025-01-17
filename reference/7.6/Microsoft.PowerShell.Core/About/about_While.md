---
description: Describes a language statement that you can use to run a command block based on the results of a conditional test.
Locale: en-US
ms.date: 01/18/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_while?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_While
---
# about_While

## Short description

Describes a language statement that you can use to run a command block based on
the results of a conditional test.

## Long description

The `while` statement (also known as a `while` loop) is a language construct
for creating a loop that runs commands in a command block as long as a
conditional test evaluates to true. The `while` statement is easier to
construct than a For statement because its syntax is less complicated. In
addition, it is more flexible than the Foreach statement because you specify a
conditional test in the `while` statement to control how many times the loop
runs.

The following shows the While statement syntax:

```powershell
while (<condition>){<statement list>}
```

When you run a `while` statement, PowerShell evaluates the `<condition>` section
of the statement before entering the `<statement list>` section. The condition
portion of the statement resolves to either true or false. As long as the
condition remains true, PowerShell reruns the `<statement list>` section. For
more information about how booleans are evaluated, see
[about_Booleans](about_Booleans.md).

The `<statement list>` section of the statement contains one or more commands
that are run each time the loop is entered or repeated. The `<statement list>`
can contain any valid PowerShell statements, including the `break` and
`continue` keywords.

For example, the following `while` statement displays the numbers 1 through 3 if
the `$val` variable has not been created or if the `$val` variable has been
created and initialized to 0.

```powershell
while($val -ne 3)
{
    $val++
    Write-Host $val
}
```

In this example, the condition (`$val` is not equal to 3) is true while `$val`
is equal to 0, 1, and 2. Each time through the loop, `$val` is incremented by 1
using the `++` unary increment operator. The last time through the loop `$val`
is set to 3, the condition statement evaluates to false, and the loop exits.

To conveniently write this command at the PowerShell command prompt, you
can enter it in the following way:

```powershell
while($val -ne 3){$val++; Write-Host $val}
```

Notice that the semicolon separates the first command that adds 1 to `$val` from
the second command that writes the value of `$val` to the console.

## See also

- [about_Booleans](about_Booleans.md)
- [about_Break](about_Break.md)
- [about_Comparison_Operators](about_Comparison_Operators.md)
- [about_Continue](about_Continue.md)
- [about_Do](about_Do.md)
- [about_For](about_For.md)
- [about_Foreach](about_Foreach.md)
- [about_Language_Keywords](about_Language_Keywords.md)
