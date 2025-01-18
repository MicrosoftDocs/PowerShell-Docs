---
description: Describes how to call generic methods of .NET types in PowerShell
Locale: en-US
ms.date: 02/02/2022
schema: 2.0.0
title: about_Calling_Generic_Methods
---
# about_Calling_Generic_Methods

Generics let you tailor a method, class, structure, or interface to the precise
data type it acts upon. For example, instead of using the
[System.Collections.Hashtable][01] class, which allows keys and values to be
of any type, you can use the [System.Collections.Generic.Dictionary%602][02]
generic class and specify the types allowed for the **key** and **value**
properties. Generics provide increased code reusability and type safety.

For some generic methods, PowerShell is able to figure out generic arguments
for a method by inferring from the provided arguments. However, method
resolution can be complicated when a method has both generic and non-generic
overloads, or when the generic method takes no formal parameter. PowerShell can
fail to resolve the correct method without the explicit generic method
arguments.

For example, `[Array]::Empty<T>()`. The .NET **Array** class has a static,
generic method `Empty<T>()` that takes no formal parameters.

Prior to PowerShell 7.3, to ensure proper method resolution you had to use
complicated workarounds using .NET reflection. For an example, see Lee Holmes'
blog post [Invoking generic methods on non-generic classes in PowerShell][03].

Beginning with PowerShell 7.3, you can specify the types for a generic method.

## Syntax

A generic method is a method with two parameter lists: a list of generic types
and a list of method arguments.

The following examples show the new PowerShell syntax for accessing a generic
method:

```Syntax
# static generic methods
[type_name]::MethodName[generic_type_arguments](method_arguments)

# instance generic methods
$object.MethodName[generic_type_arguments](method_arguments)
```

The `generic_type_arguments` can be a single type or comma-separated list of
types, like `[string, int]`, including other generic types like
`$obj.MethodName[string, System.Collections.Generic.Dictionary[string, int]]()`

The `method_arguments` can be zero or more items.

For more information, see [Generics in .NET][04].

## Example

In this example, we create a list of integers then use the
`System.Linq.Enumerable` class to enumerate the values and transform them to a
new value.

The variable `$list` is a generic `List<T>` object that can only contain
integers. `List<T>` is a generic class that allows you to specify the type of
its members when you create it.
`[System.Linq.Enumerable]::Select<T1,T2>(T1,T2)` is a generic method that
require two generic type parameters and two formal value parameters.

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

<!-- link references -->
[01]: xref:System.Collections.Hashtable
[02]: xref:System.Collections.Generic.Dictionary%602
[03]: https://www.leeholmes.com/invoking-generic-methods-on-non-generic-classes-in-powershell/
[04]: /dotnet/standard/generics/
