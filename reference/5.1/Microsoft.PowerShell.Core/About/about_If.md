---
description: Describes a language command you can use to run statement lists based on the results of one or more conditional tests.
Locale: en-US
ms.date: 06/07/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_If
---
# about_If

## Short description
Describes a language command you can use to run statement lists based on the
results of one or more conditional tests.

## Long description

You can use the `if` statement to run code blocks if a specified conditional
test evaluates to true. You can also specify one or more additional conditional
tests to run if all the prior tests evaluate to false. Finally, you can specify
an additional code block that's run if no other prior conditional test
evaluates to true.

### Syntax

The following example shows the `if` statement syntax:

```powershell
if (<test1>)
    {<statement list 1>}
[elseif (<test2>)
    {<statement list 2>}]
[else
    {<statement list 3>}]
```

When you run an `if` statement, PowerShell evaluates the `<test1>` conditional
expression as true or false. If `<test1>` is true, `<statement list 1>` runs,
and PowerShell exits the `if` statement. If `<test1>` is false, PowerShell
evaluates the condition specified by the `<test2>` conditional statement.

For more information about boolean evaluation, see
[about_Booleans](about_Booleans.md).

If `<test2>` is true, `<statement list 2>` runs, and PowerShell exits the `if`
statement. If both `<test1>` and `<test2>` evaluate to false, the
`<statement list 3`> code block runs, and PowerShell exits the `if` statement.

You can use multiple `elseif` statements to chain a series of conditional
tests. Each test is run only if all the previous tests are false. If you need
to create an `if` statement that contains many `elseif` statements, consider
using a Switch statement instead.

Examples:

The simplest `if` statement contains a single command and doesn't contain
any `elseif` statements or any `else` statements. The following example shows
the simplest form of the `if` statement:

```powershell
if ($a -gt 2) {
    Write-Host "The value $a is greater than 2."
}
```

In this example, if the `$a` variable is greater than `2`, the condition
evaluates to true, and the statement list runs. However, if `$a` is less than
or equal to `2` or isn't an existing variable, the `if` statement doesn't
display a message.

By adding an Else statement, a message is displayed when $a is less than or
equal to 2. As the next example shows:

```powershell
if ($a -gt 2) {
    Write-Host "The value $a is greater than 2."
}
else {
    Write-Host ("The value $a is less than or equal to 2," +
        " is not created or is not initialized.")
}
```

To further refine this example, you can use the `elseif` statement to display a
message when the value of `$a` is equal to `2`. As the next example shows:

```powershell
if ($a -gt 2) {
    Write-Host "The value $a is greater than 2."
}
elseif ($a -eq 2) {
    Write-Host "The value $a is equal to 2."
}
else {
    Write-Host ("The value $a is less than 2 or" +
        " was not created or initialized.")
}
```

## See also

- [about_Booleans](about_Booleans.md)
- [about_Comparison_Operators](about_Comparison_Operators.md)
- [about_Switch](about_Switch.md)
