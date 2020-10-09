---
description: Explains how to use `Types.ps1xml` files to extend the types of objects that are used in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 04/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_`Types.ps1xml`?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Types.ps1xml
---
# About Types.ps1xml

## Short description
Explains how to use `Types.ps1xml` files to extend the types of objects that
are used in PowerShell.

## Long description

Extended type data defines additional properties and methods ("members") of
object types in PowerShell. There are two techniques for adding extended type
data to a PowerShell session.

- `Types.ps1xml` file: An XML file that defines extended type data.
- `Update-TypeData`: A cmdlet that reloads `Types.ps1xml` files and defines
  extended data for types in the current session.

This topic describes `Types.ps1xml` files. For more information about using the
`Update-TypeData` cmdlet to add dynamic extended type data to the current
session see
[Update-TypeData](xref:Microsoft.PowerShell.Utility.Update-TypeData).

## About extended type data

Extended type data defines additional properties and methods ("members") of
object types in PowerShell. You can extend any type that is supported by
PowerShell and use the added properties and methods in the same way that you
use the properties that are defined on the object types.

For example, PowerShell adds a **DateTime** property to all `System.DateTime`
objects, such as the ones that the `Get-Date` cmdlet returns.

```powershell
(Get-Date).DateTime
```

```Output
Sunday, January 29, 2012 9:43:57 AM
```

You won't find the **DateTime** property in the description of the
[System.DateTime](/dotnet/api/system.datetime) structure, because PowerShell
adds the property and it is visible only in PowerShell.

PowerShell internally defines a default set of extended types. This type
information is loaded in every PowerShell session at startup. The **DateTime**
property is part of this default set. Prior to PowerShell 6, the type
definitions were stored the `Types.ps1xml` file in the PowerShell installation
directory (`$PSHOME`).

## Adding extended type data to PowerShell

There are three sources of extended type data in PowerShell sessions.

- The defined by PowerShell and is loaded automatically into every PowerShell
  session. Beginning with PowerShell 6, this information is compiled into
  PowerShell and is no longer shipped in a `Types.ps1xml` file.

- The `Types.ps1xml` files that modules export are loaded when the module
  is imported into the current session.

- Extended type data that is defined by using the `Update-TypeData` cmdlet
  is added only to the current session. It is not saved in a file.

In the session, the extended type data from the three sources is applied
to objects in the same way and is available on all objects of the specified
types.

## The TypeData cmdlets

The following cmdlets are included in the **Microsoft.PowerShell.Utility**
module in PowerShell 3.0 and later.

- `Get-TypeData`: Gets extended type data in the current session.
- `Update-TypeData`: Reloads `Types.ps1xml` files. Adds extended type data to
  the current session.
- `Remove-TypeData`: Removes extended type data from the current session.

For more information about these cmdlets, see the help topic for each cmdlet.

## Built-in Types.ps1xml files

The `Types.ps1xml` files in the `$PSHOME` directory are added automatically to
every session.

The `Types.ps1xml` file in the PowerShell installation directory (`$PSHOME`) is
an XML-based text file that lets you add properties and methods to the objects
that are used in PowerShell. PowerShell has built-in `Types.ps1xml` files that
add several elements to the .NET types, but you can create additional
`Types.ps1xml` files to further extend the types.

For example, by default, array objects (`System.Array`) have a **Length**
property that lists the number of objects in the array. However, because the
name **Length** does not clearly describe the property, PowerShell adds an alias
property named **Count** that displays the same value. The following XML adds
the **Count** property to the `System.Array` type.

```xml
<Type>
  <Name>System.Array</Name>
  <Members>
    <AliasProperty>
      <Name>Count</Name>
      <ReferencedMemberName>
        Length
      </ReferencedMemberName>
    </AliasProperty>
  </Members>
</Type>
```

To get the new **AliasProperty**, use a `Get-Member` command on any array, as
shown in the following example.

```powershell
Get-Member -InputObject (1,2,3,4)
```

The command returns the following results.

```Output
Name       MemberType    Definition
----       ----------    ----------
Count      AliasProperty Count = Length
Address    Method        System.Object& Address(Int32)
Clone      Method        System.Object Clone()
CopyTo     Method        System.Void CopyTo(Array array, Int32 index):
Equals     Method        System.Boolean Equals(Object obj)
Get        Method        System.Object Get(Int32)
# ...
```

As a result, you can use either the **Count** property or the **Length**
property of arrays in PowerShell. For example:

```powershell
(1, 2, 3, 4).count
4
```

```powershell
(1, 2, 3, 4).length
4
```

## Creating new Types.ps1xml files

The `.ps1xml` files that are installed with PowerShell are
digitally signed to prevent tampering because the formatting can include
script blocks. Therefore, to add a property or method to a .NET
type, create your own `Types.ps1xml` files, and then add them to your
PowerShell session.

To create a new file, start by copying an existing `Types.ps1xml` file. The new
file can have any name, but it must have a `.ps1xml` file name extension. You
can place the new file in any directory that is accessible to PowerShell, but
it is useful to place the files in the PowerShell installation directory
(`$PSHOME`) or in a subdirectory of the installation directory.

When you have saved the new file, use the `Update-TypeData` cmdlet to add the
new file to your PowerShell session. If you want your types to take precedence
over the built-in types that are defined, use the **PrependData** parameter of
the `Update-TypeData` cmdlet. `Update-TypeData` affects only the current
session. To make the change to all future sessions, export the console, or add
the `Update-TypeData` command to your PowerShell profile.

## Types.ps1xml and Add-Member

The `Types.ps1xml` files add properties and methods to all the instances of the
objects of the specified .NET type in the affected PowerShell session. However,
if you need to add properties or methods only to one instance of an object, use
the `Add-Member` cmdlet.

For more information, see [Add-Member](xref:Microsoft.PowerShell.Utility.Add-Member).

## Example: Adding an Age member to FileInfo objects

This example shows how to add an **Age** property to **System.IO.FileInfo**
objects. The age of a file is the difference between its creation time and the
current time in days.

Because the **Age** property is calculated by using a script block, find a
`<ScriptProperty>` tag to use as a model for the new **Age** property.

Save the follow XML code to the file `$PSHOME\MyTypes.ps1xml`.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Types>
  <Type>
    <Name>System.IO.FileInfo</Name>
    <Members>
      <ScriptProperty>
        <Name>Age</Name>
        <GetScriptBlock>
          ((Get-Date) - ($this.CreationTime)).Days
        </GetScriptBlock>
      </ScriptProperty>
    </Members>
  </Type>
</Types>
```

Run `Update-TypeData` to add the new `Types.ps1xml` file to the current
session. The command uses the **PrependData** parameter to place the new file
in a precedence order higher than the original definitions.

For more information about `Update-TypeData`, see
[Update-TypeData](xref:Microsoft.PowerShell.Utility.Update-TypeData).

```powershell
Update-Typedata -PrependPath $PSHOME\MyTypes.ps1xml
```

To test the change, run a `Get-ChildItem` command to get the PowerShell.exe
file in the `$PSHOME` directory, and then pipe the file to the `Format-List`
cmdlet to list all of the properties of the file. As a result of the change,
the **Age** property appears in the list.

```powershell
Get-ChildItem $PSHOME\pwsh.exe | Select-Object Age
```

```Output
142
```

## The XML in Types.ps1xml files

The full schema definition can be found in
[Types.xsd](https://github.com/PowerShell/PowerShell/blob/master/src/Schemas/Types.xsd)
in the PowerShell source code repository on GitHub.

The `<Types>` tag encloses all of the types that are defined in the file. There
should be only one `<Types>` tag.

Each .NET type mentioned in the file should be represented by a `<Type>` tag.

The type tags must contain the following tags:

`<Name>`: Encloses the name of the affected .NET
type.

`<Members>`: Encloses the tags for the new properties and methods that are
defined for the .NET type.

Any of the following member tags can be inside the `<Members>` tag.

`<AliasProperty>`: Defines a new name for an existing property.

The `<AliasProperty>` tag must have a `<Name>` tag that specifies the name of
the new property and a `<ReferencedMemberName>` tag that specifies the existing
property.

For example, the **Count** alias property is an alias for the **Length**
property of array objects.

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

`<CodeMethod>`:  References a static method of a .NET class.

The `<CodeMethod>` tag must have a `<Name>` tag that specifies the name of the
new method and a `<GetCodeReference>` tag that specifies the code in which the
method is defined.

For example, the **Mode** property of `System.IO.DirectoryInfo` objects is a
code property defined in the PowerShell FileSystem provider.

```xml
<Type>
  <Name>System.IO.DirectoryInfo</Name>
  <Members>
    <CodeProperty>
      <Name>Mode</Name>
      <GetCodeReference>
        <TypeName>
          Microsoft.PowerShell.Commands.FileSystemProvider
        </TypeName>
        <MethodName>Mode</MethodName>
      </GetCodeReference>
    </CodeProperty>
  </Members>
</Type>
```

`<CodeProperty>`: References a static method of a .NET class.

The `<CodeProperty>` tag must have a `<Name>` tag that specifies the name of
the new property and a `<GetCodeReference>` tag that specifies the code in
which the property is defined.

For example, the **Mode** property of `System.IO.DirectoryInfo` objects is a
code property defined in the PowerShell FileSystem provider.

```xml
<Type>
  <Name>System.IO.DirectoryInfo</Name>
  <Members>
    <CodeProperty>
      <Name>Mode</Name>
      <GetCodeReference>
        <TypeName>
          Microsoft.PowerShell.Commands.FileSystemProvider
        </TypeName>
        <MethodName>Mode</MethodName>
      </GetCodeReference>
    </CodeProperty>
  </Members>
</Type>
```

`<MemberSet>`: Defines a collection of members (properties and methods).

The `<MemberSet>` tags appear within the primary `<Members>` tags. The tags
must enclose a `<Name>` tag surrounding the name of the member set and
a secondary `<Members>` tag that surround the members (properties and
methods) in the set. Any of the tags that create a property (such as
`<NoteProperty>` or `<ScriptProperty>`) or a method (such as `<Method>` or
`<ScriptMethod>`) can be members of the set.

In `Types.ps1xml` files, the `<MemberSet>` tag is used to define the default
views of the .NET objects in PowerShell. In this case, the name of the member
set (the value within the `<Name>` tags) is always **PsStandardMembers**, and
the names of the properties (the value of the `<Name>` tag) are one of the
following:

- `DefaultDisplayProperty`: A single property of an object.

- `DefaultDisplayPropertySet`: One or more properties of an object.

- `DefaultKeyPropertySet`: One or more key properties of an object. A key
  property identifies instances of property values, such as the ID number of
  items in a session history.

For example, the following XML defines the default display of services
(`System.ServiceProcess.ServiceController` objects) that are returned by the
`Get-Service` cmdlet. It defines a member set named **PsStandardMembers** that
consists of a default property set with the **Status**, **Name**, and
**DisplayName** properties.

```xml
<Type>
  <Name>System.ServiceProcess.ServiceController</Name>
  <Members>
    <MemberSet>
      <Name>PSStandardMembers</Name>
      <Members>
        <PropertySet>
          <Name>DefaultDisplayPropertySet</Name>
          <ReferencedProperties>
            <Name>Status</Name>
            <Name>Name</Name>
            <Name>DisplayName</Name>
          </ReferencedProperties>
        </PropertySet>
      </Members>
    </MemberSet>
  </Members>
</Type>
```

`<Method>`: References a native method of the underlying object.

`<Methods>`: A collection of the methods of the object.

`<NoteProperty>`: Defines a property with a static value.

The `<NoteProperty>` tag must have a `<Name>` tag that specifies the name of
the new property and a `<Value>` tag that specifies the value of the property.

For example, the following XML creates a **Status** property for
**System.IO.DirectoryInfo** objects. The value of the **Status** property is
always **Success**.

```xml
<Type>
  <Name>System.IO.DirectoryInfo</Name>
  <Members>
    <NoteProperty>
      <Name>Status</Name>
      <Value>Success</Value>
    </NoteProperty>
  </Members>
</Type>
```

`<ParameterizedProperty>`: Properties that take arguments and return a
value.

`<Properties>`: A collection of the properties of the object.

`<Property>`: A property of the base object.

`<PropertySet>`: Defines a collection of properties of the object.

The `<PropertySet>` tag must have a `<Name>` tag that specifies the name
of the property set and a `<ReferencedProperty>` tag that specifies the
properties. The names of the properties are enclosed in `<Name>` tag.

In `Types.ps1xml`, `<PropertySet>` tags are used to define sets of properties
for the default display of an object. You can identify the default displays by
the value **PsStandardMembers** in the `<Name>` tag of a `<MemberSet>` tag.

For example, the following XML creates a **Status** property for the
`System.IO.DirectoryInfo` object. The value of the **Status** property is
always **Success**.

```xml
<Type>
  <Name>System.ServiceProcess.ServiceController</Name>
  <Members>
    <MemberSet>
      <Name>PSStandardMembers</Name>
      <Members>
        <PropertySet>
          <Name>DefaultDisplayPropertySet</Name>
          <ReferencedProperties>
            <Name>Status</Name>
            <Name>Name</Name>
            <Name>DisplayName</Name>
          </ReferencedProperties>
        </PropertySet>
      </Members>
    </MemberSet>
  </Members>
</Type>
```

`<ScriptMethod>`: Defines a method whose value is the output of a script.

The `<ScriptMethod>` tag must have a `<Name>` tag that specifies the
name of the new method and a `<Script>` tag that encloses the script
block that returns the method result.

For example, the `ConvertToDateTime` and `ConvertFromDateTime` methods of
management objects (`System.System.Management.ManagementObject`) are script
methods that use the `ToDateTime` and `ToDmtfDateTime` static methods of the
`System.Management.ManagementDateTimeConverter` class.

```xml
<Type>
 <Name>System.Management.ManagementObject</Name>
 <Members>
 <ScriptMethod>
   <Name>ConvertToDateTime</Name>
   <Script>
   [System.Management.ManagementDateTimeConverter]::ToDateTime($args[0])
   </Script>
 </ScriptMethod>
 <ScriptMethod>
   <Name>ConvertFromDateTime</Name>
   <Script>
   [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime($args[0])
   </Script>
 </ScriptMethod>
 </Members>
</Type>
```

`<ScriptProperty>`: Defines a property whose value is the output of a script.

The `<ScriptProperty>` tag must have a `<Name>` tag that specifies the
name of the new property and a `<GetScriptBlock>` tag that encloses the
script block that returns the property value.

For example, the **VersionInfo** property of the **System.IO.FileInfo** object
is a script property that results from using the **FullName** property of the
**GetVersionInfo** static method of **System.Diagnostics.FileVersionInfo**
objects.

```xml
<Type>
  <Name>System.IO.FileInfo</Name>
  <Members>
    <ScriptProperty>
      <Name>VersionInfo</Name>
      <GetScriptBlock>
      [System.Diagnostics.FileVersionInfo]::GetVersionInfo($this.FullName)
      </GetScriptBlock>
    </ScriptProperty>
  </Members>
</Type>
```

For more information, see the
[Windows PowerShell Software Development Kit (SDK)](/powershell/scripting/developer/windows-powershell).

## Update-TypeData

To load your `Types.ps1xml` files into a PowerShell session, run the
`Update-TypeData` cmdlet. If you want the types in your file to take precedence
over types in the built-in `Types.ps1xml` file, add the **PrependData**
parameter of `Update-TypeData`. `Update-TypeData` affects only the current
session. To make the change to all future sessions, export the session, or add
the `Update-TypeData` command to your PowerShell profile.

Exceptions that occur in properties, or from adding properties to an
`Update-TypeData` command, do not report errors to `StdErr`. This is to
suppress exceptions that would occur in many common types during formatting and
outputting. If you are getting .NET properties, you can work around the
suppression of exceptions by using method syntax instead, as shown in the
following example:

```powershell
"hello".get_Length()
```

Note that method syntax can only be used with .NET properties. Properties that
are added by running the `Update-TypeData` cmdlet cannot use method syntax.

## Signing a Types.ps1xml file

To protect users of your `Types.ps1xml` file, you can sign the file using a
digital signature. For more information, see
[about_Signing](about_Signing.md).

## See also

[about_Signing](about_Signing.md)

[Copy-Item](xref:Microsoft.PowerShell.Management.Copy-Item)

[Copy-ItemProperty](xref:Microsoft.PowerShell.Management.Copy-ItemProperty)

[Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)

[Get-TypeData](xref:Microsoft.PowerShell.Utility.Get-TypeData)

[Remove-TypeData](xref:Microsoft.PowerShell.Utility.Remove-TypeData)

[Update-TypeData](xref:Microsoft.PowerShell.Utility.Update-TypeData)
