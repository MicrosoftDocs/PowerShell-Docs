---
ms.date: 07/29/2020
title:  New language features in PowerShell 5.0
description: PowerShell 5.0 added the ability to define classes and other user-defined types using formal syntax and semantics like other object-oriented programming languages.
---
# New language features in PowerShell 5.0

PowerShell 5.0 added the ability to define classes and other user-defined types using formal syntax
and semantics like other object-oriented programming languages. The goal is to enable developers and
IT professionals to embrace PowerShell for a wider range of use cases, simplify development of
PowerShell artifacts (such as DSC resources), and accelerate coverage of management surfaces.

PowerShell 5.0 introduces the following new language elements in PowerShell:

### Class keyword

The `class` keyword defines a new class. This is a true .NET Framework type. Class members are
public, but only public within the module scope. You can't refer to the type name as a string (for
example, `New-Object` doesn't work), and in this release, you can't use a type literal (for example,
`[MyClass]`) outside the script or module file in which the class is defined.

```powershell
class MyClass
{
    ...
}
```

### Enum keyword and enumerations

Support for the `enum` keyword has been added, which uses newline as the delimiter. Currently, you
cannot define an enumerator in terms of itself. However, you can initialize an enum in terms of
another enum, as shown in the following example. Also, the base type cannot be specified; it is
always `[int]`.

```powershell
enum Color2
{
    Yellow = [Color]::Blue
}
```

An enumerator value must be a parse time constant. You cannot set it to the result of an invoked
command.

```powershell
enum MyEnum
{
    Enum1
    Enum2
    Enum3 = 42
    Enum4 = [int]::MaxValue
}
```

Enums support arithmetic operations, as shown in the following example.

```powershell
enum SomeEnum { Max = 42 }
enum OtherEnum { Max = [SomeEnum]::Max + 1 }
```

### Import-DscResource

`Import-DscResource` is now a true dynamic keyword. PowerShell parses the specified module's root
module, searching for classes that contain the **DscResource** attribute.

### ImplementingAssembly

A new field, **ImplementingAssembly**, has been added to **ModuleInfo**. It is set to the dynamic
assembly created for a script module if the script defines classes, or the loaded assembly for
binary modules. It is not set when **ModuleType** is **Manifest**.

Reflection on the **ImplementingAssembly** field discovers resources in a module. This means you can
discover resources written in either PowerShell or other managed languages.

## Further reading

- [about_Classes](/powershell/module/microsoft.powershell.core/about/about_classes)
- [about_Enum](/powershell/module/microsoft.powershell.core/about/about_enum)
- [about_Classes_and_DSC](/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc)
