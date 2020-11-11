---
ms.date: 09/13/2016
ms.topic: reference
title: Extending Output Objects
description: Extending Output Objects
---
# Extending Output Objects

You can extend the .NET Framework objects that are returned by cmdlets, functions, and scripts by using types files (.ps1xml). Types files are XML-based files that let you add properties and methods to existing objects. For example, Windows PowerShell provides the Types.ps1xml file, which adds elements to several existing .NET Framework objects. The Types.ps1xml file is located in the Windows PowerShell installation directory (`$pshome`). You can create your own types file to further extend those objects or to extend other objects. When you extend an object by using a types file, any instance of the object is extended with the new elements.

## Extending the System.Array Object

The following example shows how Windows PowerShell extends the [System.Array](/dotnet/api/System.Array) object in the Types.ps1xml file. By default, [System.Array](/dotnet/api/System.Array) objects have a `Length` property that lists the number of objects in the array. However, because the name "length" does not clearly describe the property, Windows PowerShell adds the `Count` alias property, which displays the same value as the `Length` property. The following XML adds the `Count` property to the [System.Array](/dotnet/api/System.Array) type.

```xml
<Type>
  <Name>System.Array</Name>
  <Members>
    <AliasProperty>
      <Name>Count</Name>
      <ReferencedMemberName>Length</ReferencedMemberName>
    </AliasProperty>
  </Members>
</Type>

```

To see this new alias property, use a [Get-Member](/powershell/module/Microsoft.PowerShell.Utility/Get-Member) command on any array, as shown in the following example.

```powershell
Get-Member -InputObject (1,2,3,4)
```

The command returns the following results.

```output
Name           MemberType    Definition
----           ----------    ----------
Count          AliasProperty Count = Length
Address        Method        System.Object& Address(Int32 )
Clone          Method        System.Object Clone()
CopyTo         Method        System.Void CopyTo(Array array, Int32 index):
Equals         Method        System.Boolean Equals(Object obj)
Get            Method        System.Object Get(Int32 )
...
Length         Property      System.Int32 Length {get;}
```

You can use either the `Count` property or the `Length` property to determine how many objects are in an array. For example:

```powershell
PS> (1, 2, 3, 4).Count
```

```output
4
```

```powershell
PS> (1, 2, 3, 4).Length
```

```output
4
```

## Custom Types Files

To create a custom types file, start by copying an existing types file. The new file can have any name, but it must have a .ps1xml file name extension. When you copy the file, you can place the new file in any directory that is accessible to Windows PowerShell, but it is useful to place the files in the Windows PowerShell installation directory (`$pshome`) or in a subdirectory of the installation directory.

To add your own extended types to the file, add a types element for each object that you want to extend. The following topics provide examples.

- For more information about adding properties and property sets, see [Extended Properties](./extending-properties-for-objects.md)

- For more information about adding methods, see [Extended Methods](./defining-default-methods-for-objects.md).

- For more information about adding member sets, see [Extended Member Sets](./defining-default-member-sets-for-objects.md).

After you define your own extended types, use one of the following methods to make your extended objects available:

- To make your extended types file available to the current session, use the [Update-TypeData](/powershell/module/Microsoft.PowerShell.Utility/Update-TypeData) cmdlet to add the new file. If you want your types to take precedence over the types that are defined in other types files (including the Types.ps1xml file), use the `PrependData` parameter of the [Update-TypeData](/powershell/module/Microsoft.PowerShell.Utility/Update-TypeData) cmdlet.
- To make your extended types file available to all future sessions, add the types file to a module, export the current session, or add the [Update-TypeData](/powershell/module/Microsoft.PowerShell.Utility/Update-TypeData) command to your Windows PowerShell profile.

## Signing Types Files

Types files should be digitally signed to prevent tampering because the XML can include script blocks. For more information about adding digital signatures, see [about_Signing](/powershell/module/microsoft.powershell.core/about/about_signing)

## See Also

[Defining Default Properties for Objects](./extending-properties-for-objects.md)

[Defining Default Methods for Objects](./defining-default-methods-for-objects.md)

[Defining Default Member Sets for Objects](./defining-default-member-sets-for-objects.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
