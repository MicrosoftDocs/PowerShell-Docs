---
description: Describes how to create and use a reference type variable. You can use reference type variables to permit a function to change the value of a variable that is passed to it. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 08/24/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ref?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Ref
---
# About Ref

## Short description
Describes how to create and use a reference type variable. You can use
reference type variables to permit a function to change the value
of a variable that is passed to it.

## Long description

You can pass variables to functions *by reference* or *by value*.

When you pass a variable *by value*, you are passing a copy of the data.

In the following example, the function changes the value of the variable passed
to it. In PowerShell, integers are value types so they are passed by value.
Therefore, the value of `$var` is unchanged outside the scope of the function.

```powershell
Function Test($data)
{
    $data = 3
}

$var = 10
Test -data $var
$var
```

```output
10
```

In the following example, a variable containing a `Hashtable` is passed to a
function. `Hashtable` is an object type so by default it is passed to the
function *by reference*.

When passing a variable *by reference*, the function can change the data and
that change persists after the function executes.

```powershell
Function Test($data)
{
    $data.Test = "New Text"
}

$var = @{}
Test -data $var
$var
```

```output
Name                           Value
----                           -----
Test                           New Text
```

The function adds a new key-value pair that persists outside of the function's
scope.

### Writing functions to accept reference parameters

You can code your functions to take a parameter as a reference, regardless of
the type of data passed. This requires that you specify the parameters type
as `System.Management.Automation.PSReference`, or `[ref]`.

When using references, you must use the `Value` property of the
`System.Management.Automation.PSReference` type to access your data.

```powershell
Function Test([ref]$data)
{
    $data.Value = 3
}
```

To pass a variable to a parameter that expects a reference, you must type
cast your variable as a reference.

> [!NOTE]
> The brackets and parenthesis are BOTH required.

```powershell
$var = 10
Test -data ([ref]$var)
$var
```

```output
3
```

### Passing references to .NET methods

Some .NET methods may require you to pass a variable as a reference. When
the method's definition uses the keywords `in`, `out`, or `ref` on a
parameter, it expects a reference.

```powershell
[int] | Get-Member -Static -Name TryParse
```

```output
Name     MemberType Definition
----     ---------- ----------
TryParse Method     static bool TryParse(string s, [ref] int result)
```

The `TryParse` method attempts to parse a string as an integer. If the method
succeeds, it returns `$true`, and the result is stored in the variable you
passed **by reference**.

```
PS> $number = 0
PS> [int]::TryParse("15", ([ref]$number))
True
PS> $number
15
```

### References and scopes

References allow the value of a variable in the parent scope to be changed
within a child scope.

```powershell
# Create a value type variable.
$i = 0
# Create a reference type variable.
$iRef = [ref]0
# Invoke a scriptblock to attempt to change both values.
&{$i++;$iRef.Value++}
# Output the results.
"`$i = $i;`$iRef = $($iRef.Value)"
```

```output
$i = 0;$iRef = 1
```

Only the reference type's variable was changed.

## See also

[about_Variables](about_Variables.md)

[about_Environment_Variables](about_Environment_Variables.md)

[about_Functions](about_Functions.md)

[about_Script_Blocks](about_Script_Blocks.md)

[about_Scopes](about_scopes.md)

