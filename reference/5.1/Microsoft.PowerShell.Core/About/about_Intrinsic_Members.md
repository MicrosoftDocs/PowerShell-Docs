---
description: Describes automatic members in all PowerShell objects
Locale: en-US
ms.date: 06/01/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_Inrinsic_Members?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Intrinsic_Members
---

# About intrinsic members

## Short description

Provides information about PowerShell's intrinsic members that are available to
all PowerShell objects.

## Detailed description

When PowerShell objects are created, some properties and methods are built into
the object called intrinsic members. Some of these members provide different
views of the object and some are hidden methods you can't see at all but are
accessible nonetheless.

## Object views

PowerShell objects are built incrementally and as it's built or even after, the
object can be adjusted. Each object provides a set of members to represent the
object. You can find the available member sets using the `Get-Member -Force`
cmdlet on any PowerShell object. Below are the available member sets.

### PSBase

The members of an object without extension or adaptation.

### PSAdapted

The PSAdapted view shows the base object but includes adapted members if present.
Adapted members are formatting changes made by the Extended Type System (ETS).

### PSExtended

The PSExtended view shows _only_ the members added by the [Types.ps1xml](about_Types.ps1xml.md)
files and the [Add-Member](../../Microsoft.PowerShell.Utility/Add-Member.md) cmdlet.

### PSObject

PSObject is the base type of all PowerShell objects. However, when an object
gets created, PowerShell also wraps the object with a PSObject instance. The
`.psobject` member allows access to the PSObject wrapper instance. It includes
methods, properties, and more about the object. Using the `.psobject` member is
comparable to using [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md)
but might have some differences as it is only accessing the wrapper instance.

### PSTypeNames

A list of object types that describe the object in order of specificity. For
example:

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

As you can see it starts with the most specific object type in
`System.IO.FileInfo` all the way down to the most generic, `System.Object`.

## Methods

There are several hidden methods available to all PowerShell objects.

### ForEach() and Where()

The `.ForEach()` and `.Where()` methods are available to all PowerShell
objects. However, they are most useful when working with collections. For more
information on how to use these methods, see [about_Arrays](about_Arrays.md).
