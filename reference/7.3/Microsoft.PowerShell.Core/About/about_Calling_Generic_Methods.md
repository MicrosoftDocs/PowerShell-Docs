---
description: Describes how to call generic methods of .NET types in PowerShell
Locale: en-US
ms.date: 02/01/2022
schema: 2.0.0
title: about Calling Generic Methods
---
# about_Calling_Generic_Methods

Generics let you tailor a method, class, structure, or interface to the precise data type it acts
upon. For example, instead of using the <xref:System.Collections.Hashtable> class, which allows keys
and values to be of any type, you can use the <xref:System.Collections.Generic.Dictionary%602>
generic class and specify the types allowed for the **key** and **value** properties. Generics
provide increased code reusability and type safety.

Prior to PowerShell 7.3, you could not use generic methods of a .NET class without complicated
workarounds using .NET reflection. For an example, see Lee Holmes' blog post
[Invoking generic methods on non-generic classes in PowerShell](https://www.leeholmes.com/invoking-generic-methods-on-non-generic-classes-in-powershell/).

A generic method is a method with two parameter lists: a list of generic type parameters and a list
of formal parameters.

The following examples show the new PowerShell syntax for accessing a generic method:

```Syntax
# static generic methods
[type_name]::MethodName[generic_type_arguments](method_arguments)

# instance generic methods
$object.MethodName[generic_type_arguments](method_arguments)
```

The `generic_type_arguments` can be a a single type, or comma-separated list of types, like
`[string, int]`, including other generic types like
`$obj.MethodName[string, System.Collections.Generic.Dictionary[string, int]]()`

For more information, see [Generics in .NET](/dotnet/standard/generics/).

## Example

In this example, we create a list of integers then use the `System.Linq.Enumerable` class to
enumerate the values in the list and transform them to a new value.

The variable `$list` is a generic `List<T>` object that can only contain integers. `List<T>` is a
generic class that allows you to specify the type of its members when you create it.
`[System.Linq.Enumerable]::Select<T,T>()` is a generic method that require two generic type
parameters and two formal value parameters.

```powershell
[System.Collections.Generic.List[int]]$list = @( 1, 2, 3, 4, 5 )
$result = [System.Linq.Enumerable]::Select[int, float](
    $list,
    [Func[int, float]]{
        param($item)
        [math]::Pow($item, 3)
    }
)
$result
```

The output shows each value raised to the power of 3.

```Output
1
8
27
64
125
```
