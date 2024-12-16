---
description: Describes how to create and use a reference type variable. You can use reference type variables to permit a function to change the value of a variable that is passed to it.
Locale: en-US
ms.date: 12/12/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ref?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Ref
---
# about_Ref

## Short description

Describes how to create and use a reference type variable.

## Long description

You can pass variables to functions _by reference_ or _by value_. When you pass
a variable _by value_, you are passing a copy of the data. When you pass a
variable _by reference_, you are passing a reference to the original value.
This allows the function to change the value of the variable that's passed to
it. Reference types are created using `[ref]`, which is the type accelerator
for the `[System.Management.Automation.PSReference]` type.

The primary purpose of `[ref]` is to enable passing PowerShell variables by
reference to .NET method parameters marked as `ref`, `out`, or `in`. You can
also define your own PowerShell function that take `[ref]` type parameters. In
this usage, `[ref]` is applied to a _variable_, and the resulting `[ref]`
instance can be used to indirectly modify that variable's value.

In the following example, the function changes the value of the variable passed
to it. In PowerShell, integers are value types so they're passed by value.
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
function. `Hashtable` is an object type so by default it's passed to the
function _by reference_.

When passing a variable _by reference_, the function can change the data and
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

## Writing functions to accept reference parameters

You can code your functions to take a parameter as a reference, regardless of
the type of data passed. This requires that you specify the parameters type
as `[ref]`.

When using references, you must use the `Value` property of the `[ref]` type to
access your data.

```powershell
function Test {
    param([ref]$data)
    $data.Value = 3
}
```

To pass a variable to a parameter that expects a reference, you must type cast
your variable as a reference.

> [!IMPORTANT]
> The brackets and parenthesis are BOTH required.

```powershell
$var = 10
Test -data ([ref]$var)
$var
```

```output
3
```

## Passing references to .NET methods

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

## References and scopes

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

## Using `[ref]` as a general-purpose object holder

You can also use `[ref]` as a general-purpose object holder. In this usage,
`[ref]` is applied to a _value_ instead of a variable. Typically, the value is
an instance of a _value type_, like a number. In most scenarios you can use a
regular variable or parameter instead. However, this technique is useful in
scenarios where passing an explicit value holder is undesired (for brevity) or
not possible, such as in script-block parameter values.

For example, you can use script-block parameter values to calculate the value
of **NewName** parameter of the `Rename-Item` cmdlet. The `Rename-Item` cmdlet
allows you to pipe items to it. The command run the script block passed to the
**NewName** for each item in the pipeline. The script block run in a child
scope. Modifying a variable in the caller's scope directly won't help and you
can't pass arguments to the script block in this context.

In this example, the script block passed to the **NewName** parameter
increments the value of `$iRef` for each item in the pipeline. The script block
creates a new name by adding a number to the beginning of the filename.

```powershell
$iRef = [ref] 0
Get-ChildItem -File $setPath |
    Rename-Item -NewName { '{0} - {1}' -f $iRef.Value++,$_.Name }
```

## Difference between `[ref]` and `[System.Management.Automation.PSReference]`

A reference type variable is created using the `[ref]` type accelerator or by
specifying the `[System.Management.Automation.PSReference]` type directly. Even
though `[ref]` is a type accelerator for
`[System.Management.Automation.PSReference]`, they behave differently.

- When you use `[ref]` to cast a variable, PowerShell creates a reference object
  that contains a reference to the original instance of the variable.
- When you use `[System.Management.Automation.PSReference]` to cast a variable,
  PowerShell creates a reference object that contains a copy of the variable,
  rather than a reference to the original instance.

For example, the following script creates a variable `$x` and two reference
objects.

```powershell
PS> $int = 1
PS> $aRef = [ref] $int
PS> $bRef = [System.Management.Automation.PSReference] $int
PS> $int
1
PS> $aRef, $bRef

Value
-----
    1
    1
```

At this point, both reference objects have the same value as `$int`. By adding
different values to the reference objects, we can see that `$aRef`, which was
created using `[ref]`, is a reference to the original instance of `$int`.
`$bRef`, which was created using `[System.Management.Automation.PSReference]`,
is a copy of the variable.

```powershell
PS> $aRef.Value+=2
PS> $bRef.Value+=5
PS> $int
3
PS> $aRef, $bRef

Value
-----
    3
    6
```

## See also

- [about_Variables][06]
- [about_Environment_Variables][01]
- [about_Functions][02]
- [about_Script_Blocks][04]
- [about_Scopes][03]
- [about_Type_Accelerators][05]
- [System.Management.Automation.PSReference][07]

<!-- link references -->
[01]: about_Environment_Variables.md
[02]: about_Functions.md
[03]: about_scopes.md
[04]: about_Script_Blocks.md
[05]: about_Type_Accelerators.md
[06]: about_Variables.md
[07]: xref:System.Management.Automation.PSReference
