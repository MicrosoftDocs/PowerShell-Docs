---
description:  Provides essential information about objects in Windows PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 11/30/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_objects?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Objects
---

# About Objects

## Short Description

Provides essential information about objects in Windows PowerShell.

## Long Description

Every action you take in Windows PowerShell occurs within the context of
objects. As data moves from one command to the next, it moves as one or
more identifiable objects. An object, then, is a collection of data that
represents an item. An object is made up of three types of data: the
objects type, its methods, and its properties.

## Types, Methods, and Properties

The object type tells what kind of object it is. For example, an object
that represents a file is a FileInfo object.

The object methods are actions that you can perform on the object.
For example, FileInfo objects have a CopyTo method that you can use
to copy the file.

Object properties store information about the object. For example,
FileInfo objects have a LastWriteTime property that stores the date
and time that the file was most recently accessed.

When working with objects, you can use their methods and properties
in commands to take action and manage data.

## Objects in Pipelines

When commands are combined in a pipeline, they pass information to each
other as objects. When the first command runs, it sends one or more
objects down the pipeline to the second command. The second command
receives the objects from the first command, processes the objects, and
then passes new or revised objects to the next command in the pipeline.
This continues until all commands in the pipeline run.

The following example demonstrates how objects are passed from one
command to the next:

```powershell
Get-ChildItem C: | where { $_.PsIsContainer -eq $false } | Format-List
```

The first command `Get-ChildItem C:` returns a file or directory object
for each item in the root directory of the file system. The file and
directory objects are passed down the pipeline to the second command.

The second command `where { $_.PsIsContainer -eq $false }` uses the
PsIsContainer property of all file system objects to select only
files, which have a value of False (\$false) in their PsIsContainer
property. Folders, which are containers and, thus, have a value of
True (\$true) in their PsIsContainer property, are not selected.

The second command passes only the file objects to the third command
`Format-List`, which displays the file objects in a list.

## See Also

[about_Methods](about_Methods.md)

[about_Object_Creation](about_Object_Creation.md)

[about_Properties](about_Properties.md)

[about_Pipelines](about_Pipelines.md)

[Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)
