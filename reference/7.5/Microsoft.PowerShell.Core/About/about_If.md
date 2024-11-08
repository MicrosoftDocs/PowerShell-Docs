---
description: Describes a language command you can use to run statement lists based on the results of one or more conditional tests.
Locale: en-US
ms.date: 06/07/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.5&WT.mc_id=ps-gethelp
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

### Using the ternary operator syntax

PowerShell 7.0 introduced a new syntax using the ternary operator. It follows
the C# ternary operator syntax:

```Syntax
<condition> ? <if-true> : <if-false>
```

The ternary operator behaves like the simplified `if-else` statement. The
`<condition>` expression is evaluated and the result is converted to a boolean
to determine which branch should be evaluated next:

- The `<if-true>` expression is executed if the `<condition>` expression is
  true
- The `<if-false>` expression is executed if the `<condition>` expression is
  false

For example:

```powershell
$message = (Test-Path $path) ? "Path exists" : "Path not found"
```

In this example, the value of `$message` is `Path exists` when `Test-Path`
returns `$true`. When `Test-Path` returns `$false`, the value of `$message` is
`Path not found`.

```powershell
$service = Get-Service BITS
$service.Status -eq 'Running' ? (Stop-Service $service) : (Start-Service $service)
```

In this example, if the service is running, it's stopped, and if its status is
not **Running**, it's started.

If a `<condition>`, `<if-true>`, or `<if-false>` expression calls a command,
you must wrap it in parentheses. If you don't, PowerShell raises an argument
exception for the command in the `<condition>` expression and parsing
exceptions for the `<if-true>` and `<if-false>` expressions.

For example, PowerShell raises exceptions for these ternaries:

```powershell
Test-Path .vscode   ? Write-Host 'exists'   : Write-Host 'not found'
(Test-Path .vscode) ? Write-Host 'exists'   : Write-Host 'not found'
(Test-Path .vscode) ? (Write-Host 'exists') : Write-Host 'not found'
```

```Output
Test-Path: A positional parameter cannot be found that accepts argument '?'.
ParserError:
Line |
   1 |  (Test-Path .vscode) ? Write-Host 'exists'   : Write-Host 'not found'
     |                       ~
     | You must provide a value expression following the '?' operator.
ParserError:
Line |
   1 |  (Test-Path .vscode) ? (Write-Host 'exists') : Write-Host 'not found'
     |                                               ~
     | You must provide a value expression following the ':' operator.
```

And this example parses:

```powershell
(Test-Path .vscode) ? (Write-Host 'exists') : (Write-Host 'not found')
```

```Output
exists
```

## See also

- [about_Booleans](about_Booleans.md)
- [about_Comparison_Operators](about_Comparison_Operators.md)
- [about_Switch](about_Switch.md)
