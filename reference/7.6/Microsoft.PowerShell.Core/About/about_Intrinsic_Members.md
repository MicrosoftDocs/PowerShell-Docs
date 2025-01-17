---
description: Describes automatic members in all PowerShell objects
Locale: en-US
ms.date: 01/03/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_Intrinsic_Members?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Intrinsic_Members
---

# About intrinsic members

## Short description

Provides information about PowerShell's intrinsic members that are available to
all PowerShell objects.

## Detailed description

When objects are created, PowerShell adds some "hidden" properties and methods
to each object. These properties and methods are known as _intrinsic members_.
These intrinsic members are normally hidden from view. These hidden members can
be seen using the **Force** parameter of [Get-Member][07].

## Object views

The intrinsic members include a set of **MemberSet** properties that represent
a view of the object. For more information about **MemberSet** properties, see
[PSMemberSet][08].

Every PowerShell object includes the following properties.

- `psbase`

  The `psbase` **MemberSet** contains the members of the base object without
  extension or adaptation. Depending on the object type it's either a .NET
  instance wrapped by a `[psobject]` instance or, if there's no wrapper, it's
  the input object itself.

- `psadapted`

  The `psadapted` **MemberSet** shows the base object plus the adapted members,
  if present. Adapted members are added by the Extended Type System (ETS).

- `psextended`

  The `psextended` **MemberSet** _only_ shows the members added by the
  [Types.ps1xml][05] files and the [Add-Member][06] cmdlet. Any object can be
  extended at runtime using the `Add-Member` cmdlet.

- `psobject`

  The `psobject` **MemberSet** a rich source of reflection for any object that
  includes methods, properties, and other information about the object.

### Examples

For this example, `$hash` is a hashtable containing information about a user.
The **Force** parameter of `Get-Member` shows us the intrinsic members of the
object.

```powershell
$hash = @{
    Age  = 33
    Name = 'Bob'
}

$hash | Get-Member -Force -MemberType MemberSet, CodeProperty
```

```Output
   TypeName: System.Collections.Hashtable

Name        MemberType   Definition
----        ----------   ----------
pstypenames CodeProperty System.Collections.ObjectModel.Collection`1[[System.String, System.Private.CoreLib, Version=7…
psadapted   MemberSet    psadapted {Item, IsReadOnly, IsFixedSize, IsSynchronized, Keys, Values, SyncRoot, Count, Add,…
psbase      MemberSet    psbase {Item, IsReadOnly, IsFixedSize, IsSynchronized, Keys, Values, SyncRoot, Count, Add, Cl…
psextended  MemberSet    psextended {}
psobject    MemberSet    psobject {Members, Properties, Methods, ImmediateBaseObject, BaseObject, TypeNames, get_Membe…
```

Using `psobject` is similar to using `Get-Member`, but provides more
flexibility. For example, you can enumerate the properties of an object and
their values.

```powershell
$hash.psobject.Properties | Select-Object Name, MemberType, Value
```

```Output
Name           MemberType                    Value
----           ----------                    -----
IsReadOnly       Property                    False
IsFixedSize      Property                    False
IsSynchronized   Property                    False
Keys             Property              {Age, Name}
Values           Property                {33, Bob}
SyncRoot         Property {[Age, 33], [Name, Bob]}
Count            Property                        2
```

Compare that to the object created by converting the hashtable to a
**PSCustomObject**.

```powershell
$user = [pscustomobject]$hash
$user.psobject.Properties | Select-Object Name, MemberType, Value
```

```Output
Name   MemberType Value
----   ---------- -----
Age  NoteProperty    33
Name NoteProperty   Bob
```

Notice that the keys from the hashtable have been converted to properties in
the **PSCustomObject**. The new properties are now part of the `psextended`
**MemberSet**.

```powershell
$user | Get-Member -Force -MemberType MemberSet, CodeProperty
```

```Output
   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
pstypenames CodeProperty System.Collections.ObjectModel.Collection`1[[System.String, System.Private.CoreLib, Version=7…
psadapted   MemberSet    psadapted {ToString, GetType, Equals, GetHashCode}
psbase      MemberSet    psbase {ToString, GetType, Equals, GetHashCode}
psextended  MemberSet    psextended {Age, Name}
psobject    MemberSet    psobject {Members, Properties, Methods, ImmediateBaseObject, BaseObject, TypeNames, get_Membe…
```

## Type information

The `pstypenames` **CodeProperty** lists the object type hierarchy in order of
inheritance. For example:

```powershell
$file = Get-Item C:\temp\test.txt
$file.pstypenames
```

```Output
System.IO.FileInfo
System.IO.FileSystemInfo
System.MarshalByRefObject
System.Object
```

The Output starts with the most specific object type, `System.IO.FileInfo`, and
continues down to the most generic type, `System.Object`.

## Methods

PowerShell adds two hidden methods to all PowerShell objects. These methods are
not visible using the `Get-Member -Force` command or tab completion.

### ForEach() and Where()

The `ForEach()` and `Where()` methods are available to all PowerShell objects.
However, they're most useful when working with collections. For more
information on how to use these methods, see [about_Arrays][01].

## Properties

Not all scalar type have **Count** or **Length** properties in the base type.
PowerShell adds the missing property as an intrinsic member for all scalar
types.

> [!NOTE]
> Uninitialized variables are implicitly `$null`. `$null` is scalar and has an
> intrinsic **Count** and **Length** of 0.

While the **Count** and **Length** properties are similar, they may work
differently depending on the data type. For example, the **Length** of a string
is the number of characters in the string. The **Count** property is the number
of instances of the object.

```powershell
PS> $str = 'string'
PS> $str.Length
6
PS> $str.Count
1
```

For more information about these properties, see [about_Properties][04].

## Array indexing scalar types

When an object isn't an indexed collection, using the index operator to access
the first element returns the object itself. Index values beyond the first
element return `$null`.

```
PS> (2)[0]
2
PS> (2)[-1]
2
PS> (2)[1] -eq $null
True
PS> (2)[0,0] -eq $null
True
```

For more information, see [about_Operators][03].

## New() method for types

Beginning in PowerShell 5.0, PowerShell adds a static `New()` method for all
.NET types. The following examples produce the same result.

```powershell
$expression = New-Object -TypeName regex -ArgumentList 'pattern'
$expression = [regex]::new('pattern')
```

Using the `new()` method performs better than using `New-Object`.

For more information, see [about_Classes][02].

<!-- link references -->
[01]: about_Arrays.md
[02]: about_Classes.md
[03]: about_Operators.md#index-operator--
[04]: about_Properties.md
[05]: about_Types.ps1xml.md
[06]: xref:Microsoft.PowerShell.Utility.Add-Member
[07]: xref:Microsoft.PowerShell.Utility.Get-Member
[08]: xref:System.Management.Automation.PSMemberSet
