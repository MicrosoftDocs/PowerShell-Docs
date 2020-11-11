---
description: Describes how to use object properties in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 12/01/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_properties?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Properties
---
# About Properties

## Short description
Describes how to use object properties in PowerShell.

## Long description

PowerShell uses structured collections of information called objects to
represent the items in data stores or the state of the computer. Typically,
you work with object that are part of the Microsoft .NET Framework, but you
can also create custom objects in PowerShell.

The association between an item and its object is very close. When you change
an object, you usually change the item that it represents. For example, when
you get a file in PowerShell, you do not get the actual file. Instead, you get
a FileInfo object that represents the file. When you change the FileInfo
object, the file changes too.

Most objects have properties. Properties are the data that is associated with
an object. Different types of object have different properties. For example, a
FileInfo object, which represents a file, has an **IsReadOnly** property that
contains $True if the file the read-only attribute and $False if it does not.
A DirectoryInfo object, which represents a file system directory, has a Parent
property that contains the path to the parent directory.

### Object properties

To get the properties of an object, use the `Get-Member` cmdlet. For example,
to get the properties of a **FileInfo** object, use the `Get-ChildItem` cmdlet
to get the FileInfo object that represents a file. Then, use a pipeline
operator (&#124;) to send the **FileInfo** object to `Get-Member`. The
following command gets the PowerShell.exe file and sends it to `Get-Member`.
The \$Pshome automatic variable contains the path of the PowerShell
installation directory.

```powershell
Get-ChildItem $pshome\PowerShell.exe | Get-Member
```

The output of the command lists the members of the **FileInfo** object.
Members include both properties and methods. When you work in PowerShell, you
have access to all the members of the objects.

To get only the properties of an object and not the methods, use the
MemberType parameter of the `Get-Member` cmdlet with a value of "property", as
shown in the following example.

```powershell
Get-ChildItem $pshome\PowerShell.exe | Get-Member -MemberType property
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

Although every object of a specific type has the same properties, the values
of those properties describe the particular object. For example, every
FileInfo object has a CreationTime property, but the value of that property
differs for each file.

The most common way to get the values of the properties of an object is to use
the dot method. Type a reference to the object, such as a variable that
contains the object, or a command that gets the object. Then, type a dot (.)
followed by the property name.

For example, the following command displays the value of the CreationTime
property of the PowerShell.exe file. The `Get-ChildItem` command returns a
FileInfo object that represents the PowerShell.exe file. The command is
enclosed in parentheses to make sure that it is executed before any properties
are accessed. The `Get-ChildItem` command is followed by a dot and the name of
the CreationTime property, as follows:

```powershell
(Get-ChildItem $pshome\PowerShell.exe).creationtime
```

```output
Tuesday, March 18, 2008 12:07:52 AM
```

You can also save an object in a variable and then get its properties by using
the dot method, as shown in the following example:

```powershell
$a = Get-ChildItem $pshome\PowerShell.exe
$a.CreationTime
```

```output
Tuesday, March 18, 2008 12:07:52 AM
```

You can also use the `Select-Object` and `Format-List` cmdlets to display the
property values of an object. `Select-Object` and `Format-List` each have a
**Property** parameter. You can use the **Property** parameter to specify one
or more properties and their values. Or, you can use the wildcard character
(\*) to represent all the properties.

For example, the following command displays the values of all the properties
of the PowerShell.exe file.

```powershell
Get-ChildItem $pshome\PowerShell.exe | Format-List -Property *
```

```output
PSPath            : Microsoft.PowerShell.Core\FileSystem::C:\Windows\System3
                    2\WindowsPowerShell\v1.0\PowerShell.exe
PSParentPath      : Microsoft.PowerShell.Core\FileSystem::C:\Windows\System3
                    2\WindowsPowerShell\v1.0
PSChildName       : PowerShell.exe
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : False
Mode              : -a----
VersionInfo       : File:             C:\Windows\System32\WindowsPowerShell\
                    v1.0\PowerShell.exe
                    InternalName:     POWERSHELL
                    OriginalFilename: PowerShell.EXE.MUI
                    FileVersion:      10.0.16299.15 (WinBuild.160101.0800)
                    FileDescription:  Windows PowerShell
                    Product:          Microsoft Windows Operating System
                    ProductVersion:   10.0.16299.15
                    Debug:            False
                    Patched:          False
                    PreRelease:       False
                    PrivateBuild:     False
                    SpecialBuild:     False
                    Language:         English (United States)

BaseName          : PowerShell
Target            : {C:\Windows\WinSxS\amd64_microsoft-windows-powershell-ex
                    e_31bf3856ad364e35_10.0.16299.15_none_8c022aa6735716ae\p
                    owershell.exe}
LinkType          : HardLink
Name              : PowerShell.exe
Length            : 449024
DirectoryName     : C:\Windows\System32\WindowsPowerShell\v1.0
Directory         : C:\Windows\System32\WindowsPowerShell\v1.0
IsReadOnly        : False
Exists            : True
FullName          : C:\Windows\System32\WindowsPowerShell\v1.0\PowerShell.ex
Extension         : .exe
CreationTime      : 9/29/2017 6:43:19 AM
CreationTimeUtc   : 9/29/2017 1:43:19 PM
LastAccessTime    : 9/29/2017 6:43:19 AM
LastAccessTimeUtc : 9/29/2017 1:43:19 PM
LastWriteTime     : 9/29/2017 6:43:19 AM
LastWriteTimeUtc  : 9/29/2017 1:43:19 PM
Attributes        : Archive
```

### Static properties

You can use the static properties of .NET classes in PowerShell. Static
properties are properties of class, unlike standard properties, which are
properties of an object.

To get the static properties of an class, use the Static parameter of the
Get-Member cmdlet.

For example, the following command gets the static properties of the
`System.DateTime` class.

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

```
[<ClassName>]::<Property>
```

For example, the following command gets the value of the UtcNow static
property of the `System.DateTime` class.

```powershell
[System.DateTime]::UtcNow
```

### Properties of scalar objects and collections

The properties of one ("scalar") object of a particular type are often
different from the properties of a collection of objects of the same type.
For example, every service has as **DisplayName** property, but a collection
of services does not have a **DisplayName** property.

The following command gets the value of the **DisplayName** property of the
'Audiosrv' service.

```powershell
(Get-Service Audiosrv).DisplayName
```

```output
Windows Audio
```

Beginning in PowerShell 3.0, PowerShell tries to prevent scripting errors that
result from the differing properties of scalar objects and collections. The
same command returns the value of the **DisplayName** property of every service
that `Get-Service` returns.

```powershell
(Get-Service).DisplayName
```

```output
Application Experience
Application Layer Gateway Service
Windows All-User Install Agent
Application Identity
Application Information
...
```

When you submit a collection, but request a property that exists only on
single ("scalar") objects, PowerShell returns the value of that property
for every object in the collection.

All collections have a **Count** property that returns how many objects are in
the collection.

```powershell
(Get-Service).Count
```

```output
176
```

Beginning in PowerShell 3.0, if you request the Count or Length property of
zero objects or one object, PowerShell returns the correct value.

```powershell
(Get-Service Audiosrv).Count
```

```output
1
```

If a property exists on the individual objects and on the collection,
only the collection's property is returned.

 ```powershell
 $collection = @(
 [pscustomobject]@{length = "foo"}
 [pscustomobject]@{length = "bar"}
 )
 # PowerShell returns the collection's Length.
 $collection.length
 ```

 ```output
 2
 ```

This feature also works on methods of scalar objects and collections. For more
information, see [about_Methods](about_methods.md).

## See also

[about_Methods](about_Methods.md)

[about_Objects](about_Objects.md)

[Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)

[Select-Object](xref:Microsoft.PowerShell.Utility.Select-Object)

[Format-List](xref:Microsoft.PowerShell.Utility.Format-List)

