---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Ref
---

# About Ref

## Short description

Describes how to create and use a reference variable type. You can use
reference variables type to permit a method to change the value
of a variable that is passed to it.

## Long description

You can pass variables to methods *by reference* or *by value*.

In the following example, a method attempts to change the value of a
variable that is passed into it, and fails.

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

When you pass a variable *by value*, you are passing a copy of the data.

In the following example, a variable containing a `Hashtable` is passed to a
method. The method adds its own key, which you can still view after the
method executes.

```powershell
Function Test($data)
{
    $data.Value = "New Text"
}

$var = @{}
Test -data $var
$var.Value
```

```output
New Text
```

When passing a variable *by reference*, the method can change the data and
that change will persist after the method executes.

You can code your methods to take references, regardless of the type of data
passed. When doing so, you will need to access the data passed to your
method using the `Value` property of the
`System.Management.Automation.PSReference` type.

When calling your method, you must type cast you variable as a reference.
The brackets and parenthesis are BOTH required.

```powershell
Function Test([ref]$data)
{
    $data.Value = 3
}

$var = 10
Test -data ([ref]$var)
$var
```

```output
3
```

Certain .NET methods may require you to pass a variable as a reference. When
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

For the `TryParse` method, you can attempt to parse a string as an integer.
If the method succeeds, the method will return true, and the result will
be stored in the variable you passed **by reference**.

```powershell
$number = 0
[int]::TryParse("15", ([ref]$number))
$number
```

```output
True
15
```

References allow the value of a variable in the parent scope to be changed
within a child scope.

```powershell
$i = 0
$iRef = [ref]0
&{$i++;$iRef.Value++}
"`$i = $i;`$iRef = $($iRef.Value)"
```

```output
$i = 0;$iRef = 1
```

## See also

[about_Variables](about_Variables.md)

[about_Environment_Variables](about_Environment_Variables.md)

[about_Functions](about_Functions.md)

[about_Script_Blocks](about_Script_Blocks.md)

[about_Scopes](about_scopes.md)