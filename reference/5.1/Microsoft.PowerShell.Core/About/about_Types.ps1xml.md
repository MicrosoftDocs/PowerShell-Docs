---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Types.ps1xml
---

# About Types.ps1xml

## SHORT DESCRIPTION

Explains how to use Types.ps1xml files to extend the types of objects
that are used in PowerShell.

## LONG DESCRIPTION

Extended type data defines additional properties and methods ("members")
of object types in PowerShell. There are two techniques for adding
extended type data to a PowerShell session.

- Types.ps1xml file: An XML file that defines extended type data.
- `Update-TypeData`: A cmdlet that reloads Types.ps1xml files and defines
  extended data for types in the current session.

This topic describes Types.ps1xml files. For more information about using the
`Update-TypeData` cmdlet to add dynamic extended type data to the current
session see
[Update-TypeData](../../Microsoft.PowerShell.Utility/Update-TypeData.md).

## About Extended Type Data

Extended type data defines additional properties and methods ("members") of
object types in PowerShell. You can extend any type that is supported
by PowerShell and use the added properties and methods in the same way
that you use the properties that are defined on the object types.

For example, PowerShell adds a `DateTime` property to all
`System.DateTime` objects, such as the ones that the `Get-Date` cmdlet
returns.

```powershell
PS C:> (Get-Date).DateTime
Sunday, January 29, 2012 9:43:57 AM
```

You won't find the `DateTime` property in the description of the
[`System.DateTime` structure](http://msdn.microsoft.com/library/system.datetime.aspx),
because PowerShell adds the property and it is visible only in Windows
PowerShell.

To add the `DateTime` property to all PowerShell sessions, Windows
PowerShell defines the `DateTime` property in the Types.ps1xml file in the
PowerShell installation directory (`$PSHOME`).

## Adding Extended Type Data to PowerShell.

There are three sources of extended type data in PowerShell sessions.

- The Types.ps1xml files in the PowerShell installation directory
  are loaded automatically into every PowerShell session.

- The Types.ps1xml files that modules export are loaded when the module
  is imported into the current session.

- Extended type data that is defined by using the `Update-TypeData` cmdlet
  is added only to the current session. It is not saved in a file.

In the session, the extended type data from the three sources is applied
to objects in the same way and is available on all objects of the specified
types.

## The TypeData Cmdlets

The following TypeData cmdlets are included in the Microsoft.PowerShell.Utility
module in Windows PowerShell 3.0 and later versions of Windows PowerShell
and PowerShell Core.

- `Get-TypeData`: Gets extended type data in the current session.
- `Update-TypeData`: Reloads Types.ps1xml files. Adds extended type data to the
  current session.
- `Remove-TypeData`: Removes extended type data from the current session.

For more information about these cmdlets, see the help topic for each cmdlet.

## Built-in Types.ps1xml Files

The Types.ps1xml files in the `$PSHOME` directory are added automatically to
every session.

The Types.ps1xml file in the PowerShell installation directory
(`$PSHOME`) is an XML-based text file that lets you add properties and
methods to the objects that are used in PowerShell. Windows
PowerShell has built-in Types.ps1xml files that add several elements
to the .NET Framework types, but you can create additional Types.ps1xml
files to further extend the types.

For example, by default, array objects (`System.Array`) have a `Length`
property that lists the number of objects in the array. However, because
the name "Length" does not clearly describe the property, Windows
PowerShell adds an alias property named "Count" that displays the same
value. The following XML adds the Count property to the `System.Array` type.

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

To get the new `AliasProperty`, use a `Get-Member` command on any array, as
shown in the following example.

```powershell
Get-Member -InputObject (1,2,3,4)
```

The command returns the following results.

```output
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

As a result, you can use either the Count property or the Length property
of arrays in PowerShell. For example:

```powershell
C:\PS> (1, 2, 3, 4).count
# 4
```

```powershell
C:\PS> (1, 2, 3, 4).length
# 4
```

## Creating New Types.ps1xml Files

The .ps1xml files that are installed with PowerShell are
digitally signed to prevent tampering because the formatting can include
script blocks. Therefore, to add a property or method to a .NET Framework
type, create your own Types.ps1xml files, and then add them to your
PowerShell session.

To create a new file, start by copying an existing Types.ps1xml file. The
new file can have any name, but it must have a .ps1xml file name
extension. You can place the new file in any directory that is accessible
to PowerShell, but it is useful to place the files in the Windows
PowerShell installation directory (`$PSHOME`) or in a subdirectory of the
installation directory.

When you have saved the new file, use the `Update-TypeData` cmdlet to add
the new file to your PowerShell session. If you want your types
to take precedence over the types that are defined in the built-in file,
use the PrependData parameter of the `Update-TypeData` cmdlet.
`Update-TypeData` affects only the current session. To make the change to
all future sessions, export the console, or add the `Update-TypeData`
command to your PowerShell profile.

## Types.ps1xml and Add-Member

The Types.ps1xml files add properties and methods to all the instances
of the objects of the specified .NET Framework type in the affected
PowerShell session. However, if you need to add properties or
methods only to one instance of an object, use the `Add-Member` cmdlet.

For more information, see [Add-Member](../../Microsoft.PowerShell.Utility/Add-Member.md).

## Example: Adding an `Age` Member to `FileInfo` Objects

This example shows how to add an `Age` property to file objects
(`System.IO.FileInfo`). The age of a file is the difference between
its creation time and the current time in days.

It is easiest to use the original Types.ps1xml file as a template
for the new file. The following command copies the original file to
a file called MyTypes.ps1xml in the `$PSHOME` directory.

```powershell
Copy-Item Types.ps1xml MyTypes.ps1xml
```

Next, open the Types.ps1xml file in any XML or text editor, such
as Notepad. Because the `Age` property is calculated by using a script
block, find a `<ScriptProperty>` tag to use as a model for the new `Age`
property.

Copy the XML between the `<Type>` and `</Type>` tags of the code to create
the script property. Then, delete the remainder of the file, except for
the opening `<?xml>` and `<Types>` tags and the closing `</Types>` tag. You
must also delete the digital signature to prevent errors.

Begin with the model script property, such as the following script
property, which was copied from the original Types.ps1xml file.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Types>
  <Type>
    <Name>System.Guid</Name>
    <Members>
      <ScriptProperty>
        <Name>Guid</Name>
        <GetScriptBlock>$this.ToString()</GetScriptBlock>
      </ScriptProperty>
    </Members>
  </Type>
</Types>
```

Then, change the name of the .NET Framework type, the name of the
property, and the value of the script block to create an `Age` property
for file objects.

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

After you save the file and close it, run an `Update-TypeData` command,
such as the following command, to add the new Types.ps1xml file to the
current session. The command uses the `PrependData` parameter to place the
new file in a higher precedence order than the original file. (For more
information about `Update-TypeData`, see
[Update-TypeData](../../Microsoft.PowerShell.Utility/Update-TypeData.md).)

```powershell
Update-Typedata -PrependPath $PSHOME\MyTypes.ps1xml
```

To test the change, run a `Get-ChildItem` command to get the
PowerShell.exe file in the `$PSHOME` directory, and then pipe the file to
the `Format-List` cmdlet to list all of the properties of the file. As a
result of the change, the `Age` property appears in the list.

```powershell
Get-ChildItem $PSHOME\PowerShell.exe | Format-List -Property *

PSPath            : Microsoft.PowerShell.Core\FileSystem::C:\WINDOWS...
PSParentPath      : Microsoft.PowerShell.Core\FileSystem::C:\WINDOWS...
PSChildName       : PowerShell.exe
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : False
Age               : 16
VersionInfo       : File:             C:\WINDOWS\system32\WindowsPow...
InternalName:     POWERSHELL
OriginalFilename: PowerShell.EXE
# ...
```

You can also display the `Age` property of the file by using the following
command.

```powershell
(Get-ChildItem $PSHOME\PowerShell.exe).Age
# 16
```

## The XML in Types.ps1xml Files

The `<Types>` tag encloses all of the types that are defined in the file.
There should be only one pair of `<Types>` tags.

Each .NET Framework type mentioned in the file should be represented by
a pair of `<Type>` tags.

The type tags must contain the following tags:

`<Name>`: A pair of `<Name>` tags that enclose the name of the affected
.NET Framework type.

`<Members>`: A pair of `<Members>` tags that enclose the tags for the
new properties and methods that are defined for the
.NET Framework type.

Any of the following member tags can be inside the `<Members>` tags.

`<AliasProperty>`: Defines a new name for an existing property.

The `<AliasProperty>` tag must have a pair of `<Name>` tags that specify
the name of the new property and a pair of `<ReferencedMemberName>` tags
that specify the existing property.

For example, the `Count` alias property is an alias for the `Length`
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

`<CodeMethod>`:  References a static method of a .NET Framework class.

The `<CodeMethod>` tag must have a pair of `<Name>` tags that specify
the name of the new method and a pair of `<GetCodeReference>` tags
that specify the code in which the method is defined.

For example, the Mode property of directories (`System.IO.DirectoryInfo`
objects) is a code property defined in the PowerShell
FileSystem provider.

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

`<CodeProperty>`: References a static method of a .NET Framework class.

The `<CodeProperty>` tag must have a pair of `<Name>` tags that specify
the name of the new property and a pair of `<GetCodeReference>` tags
that specify the code in which the property is defined.

For example, the `Mode` property of directories (`System.IO.DirectoryInfo`
objects) is a code property defined in the PowerShell
FileSystem provider.

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

The `<MemberSet>` tags appear within the primary `<Members>` tags. The
tags must enclose a pair of `<Name>` tags surrounding the name of the
member set and a pair of secondary `<Members>` tags that surround the
members (properties and methods) in the set. Any of the tags that
create a property (such as `<NoteProperty>` or `<ScriptProperty>`) or a
method (such as `<Method>` or `<ScriptMethod>`) can be members of the set.

In Types.ps1xml files, the `<MemberSet>` tag is used to define the
default views of the .NET Framework objects in PowerShell. In
this case, the name of the member set (the value within the `<Name>`
tags) is always "PsStandardMembers", and the names of the properties
(the value of the `<Name>` tag) are one of the following:

- `DefaultDisplayProperty`: A single property of an object.

- `DefaultDisplayPropertySet`: One or more properties of an object.

- `DefaultKeyPropertySet`: One or more key properties of an object.
  A key property identifies instances of property values, such as
  the ID number of items in a session history.

For example, the following XML defines the default display of services
(`System.ServiceProcess.ServiceController` objects) that are returned by
the `Get-Service` cmdlet. It defines a member set named
"PsStandardMembers" that consists of a default property set with the
`Status`, `Name`, and `DisplayName` properties.

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

The `<NoteProperty>` tag must have a pair of `<Name>` tags that specify
the name of the new property and a pair of `<Value>` tags that specify
the value of the property.

For example, the following XML creates a Status property for
directories (`System.IO.DirectoryInfo` objects). The value of the
`Status` property is always "Success".

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

The `<PropertySet>` tag must have a pair of `<Name>` tags that specify
the name of the property set and a pair of `<ReferencedProperty>` tags
that specify the properties. The names of the properties are enclosed
in `<Name>` tag pairs.

In Types.ps1xml, `<PropertySet>` tags are used to define sets of
properties for the default display of an object. You can identify the
default displays by the value "PsStandardMembers" in the `<Name>` tag
of a `<MemberSet>` tag.

For example, the following XML creates a Status property for
directories (`System.IO.DirectoryInfo` objects). The value of the `Status`
property is always "Success".

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

The `<ScriptMethod>` tag must have a pair of `<Name>` tags that specify
the name of the new method and a pair of `<Script>` tags that enclose
the script block that returns the method result.

For example, the `ConvertToDateTime` and `ConvertFromDateTime` methods of
management objects (`System.System.Management.ManagementObject`) are
script methods that use the `ToDateTime` and `ToDmtfDateTime` static
methods of the `System.Management.ManagementDateTimeConverter` class.

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

`<ScriptProperty>`: Defines a property whose value is the output of a
script.

The `<ScriptProperty>` tag must have a pair of `<Name>` tags that specify
the name of the new property and a pair of `<GetScriptBlock>` tags
that enclose the script block that returns the property value.

For example, the `VersionInfo` property of files (`System.IO.FileInfo`
objects) is a script property that results from using the `FullName`
property of the `GetVersionInfo` static method of
`System.Diagnostics.FileVersionInfo` objects.

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

For more information, see the [Windows PowerShell Software Development
Kit (SDK) in the MSDN (Microsoft Developer Network)
library](http://go.microsoft.com/fwlink/?LinkId=144538).

## `Update-TypeData`

To load your Types.ps1xml files into a PowerShell session, run
the `Update-TypeData` cmdlet. If you want the types in your file to take
precedence over types in the built-in Types.ps1xml file, add the
PrependData parameter of `Update-TypeData`. `Update-TypeData` affects only
the current session. To make the change to all future sessions, export
the session, or add the `Update-TypeData` command to your Windows
PowerShell profile.

Exceptions that occur in properties, or from adding properties to an
`Update-TypeData` command, do not report errors to `StdErr`. This is to
suppress exceptions that would occur in many common types during formatting
and outputting. If you are getting .NET Framework properties, you can work
around the suppression of exceptions by using method syntax instead, as
shown in the following example:

```powershell
"hello".get_Length()
```

Note that method syntax can only be used with .NET Framework properties.
Properties that are added by running the `Update-TypeData` cmdlet cannot
use method syntax.

## Signing a Types.ps1xml File

To protect users of your Types.ps1xml file, you can sign the file using a
digital signature. For more information, see
[about_Signing](about_Signing.md).

## SEE ALSO

[about_Signing](about_Signing.md)

[Copy-Item](../../Microsoft.PowerShell.Management/Copy-Item.md)

[Copy-ItemProperty](../../Microsoft.PowerShell.Management/Copy-ItemProperty.md)

[Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md)

[Get-TypeData](../../Microsoft.PowerShell.Utility/Get-TypeData.md)

[Remove-TypeData](../../Microsoft.PowerShell.Utility/Remove-TypeData.md)

[Update-TypeData](../../Microsoft.PowerShell.Utility/Update-TypeData.md)