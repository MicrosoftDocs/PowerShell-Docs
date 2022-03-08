---
description: Explains the differences between PSObject and PSCustomObject.
Locale: en-US
ms.date: 03/08/2022
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pscustomobject?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about PSCustomObject
---
# about_PSCustomObject

## Short description
Explains the differences between **PSObject** and **PSCustomObject**.

## Long description

The `[pscustomobject]` type accelerator was added in PowerShell 4.0.

Prior to adding this type accelerator, creating an object with member
properties and values was more complicated. Originally, you had to use
`New-Object` to create the object and `Add-Member` to add properties. For
example:

```powershell
PS> $object1 = New-Object -TypeName psobject
PS> Add-Member -InputObject $object1 -MemberType NoteProperty -Name one -Value 1
PS> Add-Member -InputObject $object1 -MemberType NoteProperty -Name two -Value 2
PS> $object1 | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
one         NoteProperty int one=1
two         NoteProperty int two=2

PS> $object1

one two
--- ---
  1   2
```

Later, you could use the **Property** parameter of `New-Object` to pass a
**Hashtable** containing the members and values. For example:

```powershell
PS> $object2 = New-Object -TypeName psobject -Property @{one=1; two=2}
PS> $object2 | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
one         NoteProperty int one=1
two         NoteProperty int two=2

PS> $object2

one two
--- ---
  1   2
```

Since PowerShell 3.0, casting a **Hashtable** to `[pscustomobject]` achieves
the same result.

```powershell
PS> $object3 = [pscustomobject]@{one=1; two=2}
PS> $object3 | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
one         NoteProperty int one=1
two         NoteProperty int two=2

PS> $object3

one two
--- ---
  1   2
```

## Understanding the type accelerators

`[psobject]` and `[pscustomobject]` are type accelerators.

For more information, see [about_Type_Accelerators](about_type_accelerators.md).

Even though you might think that `[pscustomobject]` should map to
**System.Management.Automation.PSCustomObject**, the types are different.

```powershell
PS> [pscustomobject] -eq [System.Management.Automation.PSCustomObject]
False
```

Both type accelerators are mapped to the same class, **PSObject**:

```powershell
PS> [pscustomobject]

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     PSObject                                 System.Object

PS> [psobject]

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     PSObject                                 System.Object
```

When the `[pscustomobject]` type accelerator was added, it included extra code
to handle conversion of **Hashtable** objects. This extra code is only invoked
when a new object is being created. Therefore, you can't use
`[pscustomobject]` for type coercion or type comparison, because all objects
are treated as a **PSObject** types.

For example, using the `-is` operator to check that an object returned by a
cmdlet is a `[pscustomobject]` is the same as comparing it to `[psobject]`.

```powershell
PS> (Get-Item /) -is [pscustomobject]
True

PS> (Get-Item /) -is [psobject]
True
```

When you cast any object to `[psobject]` you get the type of the original
object. Therefore, casting anything other than a **Hashtable** to
`[pscustomobject]` results in the same type.

```powershell
PS> ([PSObject]@{Property = 'Value'}).GetType().FullName
System.Collections.Hashtable

PS> ([pscustomobject]123).GetType().Name
Int32

PS> ([PSCustomObject]@{Property = 'Value'}).GetType().FullName
System.Management.Automation.PSCustomObject
```

## Notes

Calling `.Length` or its alias `.Count` on an object created by casting a
**Hashtable** to `[pscustomobject]` returns `$null` in Windows PowerShell.

## See also

- [about_Object_Creation](about_Object_Creation.md)
- [about_Objects](about_Objects.md)
- [System.Management.Automation.PSObject](xref:System.Management.Automation.PSObject)
- [System.Management.Automation.PSCustomObject](xref:System.Management.Automation.PSCustomObject)
