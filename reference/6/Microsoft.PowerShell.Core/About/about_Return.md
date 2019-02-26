---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Return
---
# About Return

## Short description
Exits the current scope, which can be a function, script, or script block.

## Long description

The `return` keyword exits a function, script, or script block. It can be used
to exit a scope at a specific point, to return a value, or to indicate that the
end of the scope has been reached.

Users who are familiar with languages like C or C\# might want to use the
`return` keyword to make the logic of leaving a scope explicit.

In PowerShell, the results of each statement are returned as output, even
without a statement that contains the Return keyword. Languages like C or C\#
return only the value or values that are specified by the `return` keyword.

> [!NOTE]
> Beginning in PowerShell 5.0, PowerShell added language for defining
> classes, by using formal syntax.  In the context of a PowerShell class,
> nothing is output from a method except what you specify using a
> `return` statement. You can read more about PowerShell classes in
> [about_Classes](about_Classes.md).

### Syntax

The syntax for the `return` keyword is as follows:

```
return [<expression>]
```

The `return` keyword can appear alone, or it can be followed by a value or
expression, as follows:

```powershell
return
return $a
return (2 + $a)
```

### Examples

The following example uses the `return` keyword to exit a function at a
specific point if a conditional is met. Odd numbers are not multiplied
because the return statement exits before that statement can execute.

```powershell
function MultiplyEven
{
    param($number)

    if ($number % 2) { return "$number is not even" }
    $number * 2
}

1..10 | ForEach-Object {MultiplyEven -Number $_}
```

```output
1 is not even
4
3 is not even
8
5 is not even
12
7 is not even
16
9 is not even
20
```

In PowerShell, values can be returned even if the `return` keyword is not used.
The results of each statement are returned. For example, the following
statements return the value of the `$a` variable:

```powershell
$a
return
```

The following statement also returns the value of `$a`:

```powershell
return $a
```

The following example includes a statement intended to let the user know that
the function is performing a calculation:

```powershell
function calculation {
    param ($value)

    "Please wait. Working on calculation..."
    $value += 73
    return $value
}

$a = calculation 14
```

The "Please wait. Working on calculation..." string is not displayed. Instead,
it is assigned to the `$a` variable.

```output
C:\PS> $a
Please wait. Working on calculation...
87
```

If you would like to display a message within your function, beginning in
PowerShell 5.0, you can use the `Information` stream. The code below corrects
the above example using the `Write-Information` cmdlet with a
`InformationAction` of **Continue**.

```powershell
function calculation {
    param ($value)

    Write-Information "Please wait. Working on calculation..." -InformationAction Continue
    $value += 73
    return $value
}

$a = calculation 14
```

```output
Please wait. Working on calculation...
C:\PS> $a
87
```

## See also

[about_Language_Keywords](about_Language_Keywords.md)

[about_Functions](about_Functions.md)

[about_Scopes](about_Scopes.md)

[about_Classes](about_Classes.md)

[Write-Information](../../Microsoft.PowerShell.Utility/Write-Information.md)

[about_Script_Blocks](about_Script_Blocks.md)