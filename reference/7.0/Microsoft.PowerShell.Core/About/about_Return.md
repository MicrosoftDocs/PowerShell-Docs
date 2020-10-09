---
description:  Exits the current scope, which can be a function, script, or script block. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_return?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Return
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
it is assigned to the `$a` variable, as in the following example:

```
PS> $a
Please wait. Working on calculation...
87
```

Both the informational string and the result of the calculation are returned
by the function and assigned to the `$a` variable.

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

### Return values and the Pipeline

When you return a collection from your script block or function, PowerShell
automatically unrolls the members and passes them one at a time through the
pipeline. This is due to PowerShell's one-at-a-time processing. For more
information, see [about_pipelines](about_pipelines.md).

This concept is illustrated by the following sample function that returns an
array of numbers. The output from the function is piped to the `Measure-Object`
cmdlet which counts the number of objects in the pipeline.

```powershell
function Test-Return
{
    $array = 1,2,3
    return $array
}
Test-Return | Measure-Object
```

```Output
Count    : 3
Average  :
Sum      :
Maximum  :
Minimum  :
Property :
```

To force a script block or function to return collection as a single
object to the pipeline, use one of the following two methods:

- Unary array expression

  Utilizing a unary expression you can send your return value down the pipeline
  as a single object as illustrated by the following example.

  ```powershell
  function Test-Return
  {
      $array = 1,2,3
      return (, $array)
  }
  Test-Return | Measure-Object
  ```

  ```Output
  Count    : 1
  Average  :
  Sum      :
  Maximum  :
  Minimum  :
  Property :
  ```

- `Write-Output` with **NoEnumerate** parameter.

  You can also use the `Write-Output` cmdlet with the **NoEnumerate**
  parameter. The example below uses the `Measure-Object` cmdlet to count the
  objects sent to the pipeline from the sample function by the `return`
  keyword.

  ```powershell
  function Test-Return
  {
      $array = 1, 2, 3
      return Write-Output -NoEnumerate $array
  }

  Test-Return | Measure-Object
  ```

  ```Output
  Count    : 1
  Average  :
  Sum      :
  Maximum  :
  Minimum  :
  Property :
  ```

## See also

[about_Language_Keywords](about_Language_Keywords.md)

[about_Functions](about_Functions.md)

[about_Scopes](about_Scopes.md)

[about_Classes](about_Classes.md)

[Write-Information](xref:Microsoft.PowerShell.Utility.Write-Information)

[about_Script_Blocks](about_Script_Blocks.md)
