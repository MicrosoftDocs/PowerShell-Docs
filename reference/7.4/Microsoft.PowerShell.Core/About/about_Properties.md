---
description: Describes how to use object properties in PowerShell.
Locale: en-US
ms.date: 08/21/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_properties?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Properties
---
# about_Properties

## Short description
Describes how to use object properties in PowerShell.

## Long description

PowerShell uses structured collections of information called objects to
represent the items in data stores or the state of the computer. Typically, you
work with objects that are part of the Microsoft .NET Framework, but you can
also create custom objects in PowerShell.

The association between an item and its object is very close. When you change
an object, you usually change the item that it represents. For example, when
you get a file in PowerShell, you don't get the actual file. Instead, you get a
**FileInfo** object that represents the file. When you change the FileInfo
object, the file changes too.

Most objects have properties. Properties are the data that are associated with
an object. Different types of object have different properties. For example, a
**FileInfo** object, which represents a file, has an **IsReadOnly** property
that contains `$True` if the file has the read-only attribute and `$False` if
it doesn't. A **DirectoryInfo** object, which represents a file system
directory, has a **Parent** property that contains the path to the parent
directory.

### Object properties

To get the properties of an object, use the `Get-Member` cmdlet. For example,
to get the properties of a **FileInfo** object, use the `Get-ChildItem` cmdlet
to get the FileInfo object that represents a file. Then, use a pipeline
operator (`|`) to send the **FileInfo** object to `Get-Member`. The following
command gets the `pwsh.exe` file and sends it to `Get-Member`. The `$PSHOME`
automatic variable contains the path of the PowerShell installation directory.

```powershell
Get-ChildItem $PSHOME\pwsh.exe | Get-Member
```

The output of the command lists the members of the **FileInfo** object. Members
include both properties and methods. When you work in PowerShell, you have
access to all the members of the objects.

To get only the properties of an object and not the methods, use the
**MemberType** parameter of the `Get-Member` cmdlet with a value of `Property`,
as shown in the following example.

```powershell
Get-ChildItem $PSHOME\pwsh.exe | Get-Member -MemberType Property
```

```Output
TypeName: System.IO.FileInfo

Name              MemberType Definition
----              ---------- ----------
Attributes        Property   System.IO.FileAttributes Attributes {get;set;}
CreationTime      Property   System.DateTime CreationTime {get;set;}
CreationTimeUtc   Property   System.DateTime CreationTimeUtc {get;set;}
Directory         Property   System.IO.DirectoryInfo Directory {get;}
DirectoryName     Property   System.String DirectoryName {get;}
Exists            Property   System.Boolean Exists {get;}
Extension         Property   System.String Extension {get;}
FullName          Property   System.String FullName {get;}
IsReadOnly        Property   System.Boolean IsReadOnly {get;set;}
LastAccessTime    Property   System.DateTime LastAccessTime {get;set;}
LastAccessTimeUtc Property   System.DateTime LastAccessTimeUtc {get;set;}
LastWriteTime     Property   System.DateTime LastWriteTime {get;set;}
LastWriteTimeUtc  Property   System.DateTime LastWriteTimeUtc {get;set;}
Length            Property   System.Int64 Length {get;}
Name              Property   System.String Name {get;}
```

After you find the properties, you can use them in your PowerShell commands.

## Property values

Although every object of a specific type has the same properties, the values of
those properties describe the particular object. For example, every
**FileInfo** object has a **CreationTime** property, but the value of that
property differs for each file.

The most common way to get the values of the properties of an object is to use
the member access operator (`.`). Type a reference to the object, such as a
variable that contains the object, or a command that gets the object. Then,
type the operator (`.`) followed by the property name.

For example, the following command displays the value of the **CreationTime**
property of the `pwsh.exe` file. The `Get-ChildItem` command returns a
**FileInfo** object that represents the `pwsh.exe file`. The command is
enclosed in parentheses to make sure that it's executed before any properties
are accessed.

```powershell
(Get-ChildItem $PSHOME\pwsh.exe).CreationTime
```

```Output
Tuesday, June 14, 2022 5:17:14 PM
```

You can also save an object in a variable and then get its properties using the
member access (`.`) method, as shown in the following example:

```powershell
$a = Get-ChildItem $PSHOME\pwsh.exe
$a.CreationTime
```

```Output
Tuesday, June 14, 2022 5:17:14 PM
```

You can also use the `Select-Object` and `Format-List` cmdlets to display the
property values of an object. `Select-Object` and `Format-List` each have a
**Property** parameter. You can use the **Property** parameter to specify one
or more properties and their values. Or, you can use the wildcard character
(`*`) to represent all the properties.

For example, the following command displays the values of all the properties
of the pwsh.exe file.

```powershell
Get-ChildItem $PSHOME\pwsh.exe | Format-List -Property *
```

```Output
PSPath              : Microsoft.PowerShell.Core\FileSystem::C:\Program Files\PowerShell\7-preview\pwsh.exe
PSParentPath        : Microsoft.PowerShell.Core\FileSystem::C:\Program Files\PowerShell\7-preview
PSChildName         : pwsh.exe
PSDrive             : C
PSProvider          : Microsoft.PowerShell.Core\FileSystem
PSIsContainer       : False
Mode                : -a---
ModeWithoutHardLink : -a---
VersionInfo         : File:             C:\Program Files\PowerShell\7-preview\pwsh.exe
                      InternalName:     pwsh.dll
                      OriginalFilename: pwsh.dll
                      FileVersion:      7.3.0.5
                      FileDescription:  pwsh
                      Product:          PowerShell
                      ProductVersion:   7.3.0-preview.5 SHA: cfc237ac85cf24fa760923ace568201c8f3256aa
                      Debug:            False
                      Patched:          False
                      PreRelease:       False
                      PrivateBuild:     False
                      SpecialBuild:     False
                      Language:         Language Neutral

BaseName            : pwsh
ResolvedTarget      : C:\Program Files\PowerShell\7-preview\pwsh.exe
Target              :
LinkType            :
Length              : 285088
DirectoryName       : C:\Program Files\PowerShell\7-preview
Directory           : C:\Program Files\PowerShell\7-preview
IsReadOnly          : False
FullName            : C:\Program Files\PowerShell\7-preview\pwsh.exe
Extension           : .exe
Name                : pwsh.exe
Exists              : True
CreationTime        : 6/14/2022 5:17:14 PM
CreationTimeUtc     : 6/14/2022 10:17:14 PM
LastAccessTime      : 7/18/2022 11:32:06 AM
LastAccessTimeUtc   : 7/18/2022 4:32:06 PM
LastWriteTime       : 6/14/2022 5:17:14 PM
LastWriteTimeUtc    : 6/14/2022 10:17:14 PM
LinkTarget          :
Attributes          : Archive
```

### Static properties

You can use the static properties of .NET classes in PowerShell. Static
properties are properties of class, unlike standard properties, which are
properties of an object.

To get the static properties of a class, use the **Static** parameter of the
`Get-Member` cmdlet. For example, the following command gets the static
properties of the `System.DateTime` class.

```powershell
Get-Date | Get-Member -MemberType Property -Static
```

```Output
TypeName: System.DateTime

Name     MemberType Definition
----     ---------- ----------
MaxValue Property   static datetime MaxValue {get;}
MinValue Property   static datetime MinValue {get;}
Now      Property   datetime Now {get;}
Today    Property   datetime Today {get;}
UtcNow   Property   datetime UtcNow {get;}
```

To get the value of a static property, use the following syntax.

```Syntax
[<ClassName>]::<Property>
```

For example, the following command gets the value of the **UtcNow** static
property of the `System.DateTime` class.

```powershell
[System.DateTime]::UtcNow
```

## Member-access enumeration

Starting in PowerShell 3.0, when you use the member-access operator (`.`) to
access a property that doesn't exist on a list collection, PowerShell
automatically enumerates the items in the collection and returns the value of
the property on each item. For more information, see
[about_Member-Access_Enumeration](about_Member-Access_Enumeration.md).

### Examples

This command returns the value of the **DisplayName** property of every service
that `Get-Service` returns.

```powershell
(Get-Service).DisplayName
```

```Output
Application Experience
Application Layer Gateway Service
Windows All-User Install Agent
Application Identity
Application Information
...
```

All collections have a **Count** property that returns the number of objects in
the collection.

```powershell
(Get-Service).Count
```

```Output
176
```

Starting in PowerShell 3.0, you can get the **Count** or **Length** property of
singleton objects that aren't collections.

```powershell
(Get-Service Audiosrv).Count
```

```Output
1
```

However, some objects have a **Length** property. For example, the **Length**
of a string is the number of characters in the string. The **Count** property
is the number of instances of the object.

```powershell
PS> $str = 'string'
PS> $str.Length
6
PS> $str.Count
1
```

If a property exists on the individual objects and on the collection, only the
collection's property is returned.

 ```powershell
 $collection = @(
     [pscustomobject]@{length = "foo"}
     [pscustomobject]@{length = "bar"}
)
 # PowerShell returns the collection's Length.
 $collection.length
 ```

 ```Output
 2
 ```

## See also

- [about_Objects](about_Objects.md)
- [about_Member-Access_Enumeration](about_Member-Access_Enumeration.md)
- [about_Methods](about_Methods.md)
- [Format-List](xref:Microsoft.PowerShell.Utility.Format-List)
- [Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)
- [Select-Object](xref:Microsoft.PowerShell.Utility.Select-Object)
