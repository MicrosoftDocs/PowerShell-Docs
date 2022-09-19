---
description: Describes the full and relative path formats in  PowerShell.
Locale: en-US
ms.date: 08/29/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_path_syntax?view=powershell-7.3&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Path Syntax
---
# about_Path_Syntax

## Short description
Describes the full and relative path formats in  PowerShell.

## Long description

All items in a data store accessible through a PowerShell provider can be
uniquely identified by their path names. A path is a combination of the
item name, the container and subcontainers in which the item is located, and
the PowerShell drive through which the containers are accessed.

In PowerShell, path names are divided into one of two types: fully qualified
and relative. A fully qualified path consists of all elements that make
up a path. The following syntax shows the elements in a fully qualified path
name:

```Syntax
[<provider>::]<drive>:[\<container>[\<subcontainer>...]]\<item>
```

The `<provider>` placeholder refers to the PowerShell provider through which
you access the data store. For example, the FileSystem provider allows you to
access the files and directories on your computer. This element of the syntax
is optional and is never needed because the drive names are unique across all
providers.

The `<drive>` placeholder refers to the PowerShell drive that's supported by
a particular PowerShell provider. In the case of the FileSystem provider, the
PowerShell drives map to the Windows drives that are configured on your
system. For example, if your system includes an A: drive and a `C:` drive, the
FileSystem provider creates the same drives in PowerShell.

After you have specified the drive, you must specify any containers and
subcontainers that contain the item. The containers must be specified in the
hierarchical order in which they exist in the data store. In other words, you
must start with the parent container, then the child container in that parent
container, and so on. In addition, each container must be preceded by a
backslash. (Note that PowerShell allows you to use forward slashes for
compatibility with other PowerShells.)

After the container and subcontainers have been specified, you must provide
the item name, preceded by a backslash. For example, the fully qualified path
name for the Shell.dll file in the `C:\Windows\System32` directory is as
follows:

```powershell
C:\Windows\System32\Shell.dll
```

In this case, the drive through which the containers are accessed is the C:
drive, the top-level container is Windows, the subcontainer is System32
(located within the Windows container), and the item is Shell.dll.

In some situations, you don't need to specify a fully qualified path and can
instead use a relative path. PowerShell allows you to identify an item based on
its location relative to the current working location.

PowerShell uses the following character sequences to specify relative paths.

- (`.`) - Current location
- (`..`) - Parent of current location
- (`\`) - Root of current location

The following examples are based on the current working directory being set to
`C:\Windows`.

- The relative path `.\System` resolves as `C:\Windows\System`
- The relative path `..\Program Files` resolves as `C:\Program Files`
- The relative path `\Program Files` resolves as `C:\Program Files`
- The relative path `System` resolves as `C:\Windows\System`

When using a path in a command, you can use a fully qualified path or a
relative one. For example, suppose that your current working directory is
`C:\Windows`. The following `Get-ChildItem` command retrieves all items in the
`C:\TechDocs `directory:

```powershell
Get-ChildItem \TechDocs
```

The backslash indicates that the drive root of the current working location
should be used. Because the working directory is `C:\Windows`, the drive root
is the `C:` drive. Because the `TechDocs` directory is located off the root,
you need to specify only the backslash.

You get the same results using the fully qualified path:

```powershell
Get-ChildItem C:\TechDocs
```

Regardless of whether you use a fully qualified path or a relative path
name, a path is important not only because it locates an item but also
because it uniquely identifies the item even if that item shares the same name
as another item in a different container.

For instance, suppose that you have two files that are each named
`Results.txt`. The first file is in a directory named `C:\TechDocs\Jan`, and
the second file is in a directory named `C:\TechDocs\Feb`. The path for the
first file (`C:\TechDocs\Jan\Results.txt`) and the path for the second file
(`C:\TechDocs\Feb\Results.txt`) allow you to clearly distinguish between the
two files.

## See also

- [about_Locations](about_Locations.md)
