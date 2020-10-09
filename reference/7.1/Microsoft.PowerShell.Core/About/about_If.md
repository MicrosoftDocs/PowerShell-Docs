---
description: Describes a language command you can use to run statement lists based on the results of one or more conditional tests. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_If
---
# About If

## SHORT DESCRIPTION
Describes a language command you can use to run statement lists based on
the results of one or more conditional tests.

## LONG DESCRIPTION

You can use the `If` statement to run code blocks if a specified conditional
test evaluates to true. You can also specify one or more additional
conditional tests to run if all the prior tests evaluate to false. Finally,
you can specify an additional code block that is run if no other prior
conditional test evaluates to true.

### Syntax

The following example shows the `If` statement syntax:

```powershell
if (<test1>)
    {<statement list 1>}
[elseif (<test2>)
    {<statement list 2>}]
[else
    {<statement list 3>}]
```

When you run an `If` statement, PowerShell evaluates the `<test1>`
conditional expression as true or false. If `<test1>` is true,
`<statement list 1>` runs, and PowerShell exits the `If` statement. If
`<test1>` is false, PowerShell evaluates the condition specified by the
`<test2>` conditional statement.

If `<test2>` is true, `<statement list 2>` runs, and PowerShell exits the
`If` statement. If both `<test1>` and `<test2>` evaluate to false, the
`<statement list 3`> code block runs, and PowerShell exits the If
statement.

You can use multiple Elseif statements to chain a series of conditional
tests. So, that each test is run only if all the previous tests are false.
If you need to create an `If` statement that contains many Elseif statements,
consider using a Switch statement instead.

Examples:

The simplest `If` statement contains a single command and does not contain
any Elseif statements or any Else statements. The following example shows
the simplest form of the `If` statement:

```powershell
if ($a -gt 2) {
    Write-Host "The value $a is greater than 2."
}
```

In this example, if the $a variable is greater than 2, the condition
evaluates to true, and the statement list runs. However, if $a is less than
or equal to 2 or is not an existing variable, the `If` statement does not
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

To further refine this example, you can use the Elseif statement to display
a message when the value of $a is equal to 2. As the next example shows:

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

### Using the ternary operator syntax

PowerShell 7.0 introduced a new syntax using the ternary operator. It follows the C# ternary
operator syntax:

```Syntax
<condition> ? <if-true> : <if-false>
```

The ternary operator behaves like the simplified `if-else` statement. The `<condition>` expression
is evaluated and the result is converted to a boolean to determine which branch should be evaluated
next:

- The `<if-true>` expression is executed if the `<condition>` expression is true
- The `<if-false>` expression is executed if the `<condition>` expression is false

For example:

```powershell
$message = (Test-Path $path) ? "Path exists" : "Path not found"
```

In this example, the value of `$message` is "Path exists" when `Test-Path` returns `$true`. When
`Test-Path` returns `$false`, the value of `$message` is "Path not found".

```powershell
$service = Get-Service BITS
$service.Status -eq 'Running' ? (Stop-Service $service) : (Start-Service $service)
```

In this example, if the service is running, it is stopped, and if its status is not **Running**,
it is started.

## SEE ALSO

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Switch](about_Switch.md)

