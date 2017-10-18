---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Path_Syntax
---

# About Path Syntax

## SHORT DESCRIPTION

Describes the full and relative path name formats in  PowerShell.

## LONG DESCRIPTION

All items in a data store accessible through a PowerShell provider can be
uniquely identified by their path names. A path name is a combination of the
item name, the container and subcontainers in which the item is located, and
the PowerShell drive through which the containers are accessed.

In PowerShell, path names are divided into one of two types: fully qualified
and relative. A fully qualified path name consists of all elements that make
up a path. The following syntax shows the elements in a fully qualified path
name:

```powershell
[<provider>::]<drive>:[\<container>[\<subcontainer>...]]\<item>
```

The \<provider\> placeholder refers to the PowerShell provider through which
you access the data store. For example, the FileSystem provider allows you to
access the files and directories on your computer. This element of the syntax
is optional and is never needed because the drive names are unique across all
providers.

The \<drive\> placeholder refers to the PowerShell drive that is supported by
a particular PowerShell provider. In the case of the FileSystem provider, the
PowerShell drives map to the Windows drives that are configured on your
system. For example, if your system includes an A: drive and a C: drive, the
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
name for the Shell.dll file in the C:\\Windows\\System32 directory is as
follows:

```powershell
C:\Windows\System32\Shell.dll
```

In this case, the drive through which the containers are accessed is the C:
drive, the top-level container is Windows, the subcontainer is System32
(located within the Windows container), and the item is Shell.dll.

In some situations, you do not need to specify a fully qualified path name and
can instead use a relative path name. A relative path name is based on the
current working location. PowerShell allows you to identify an item based on
its location relative to the current working location. You can specify
relative path names by using special characters. The following table describes
each of these characters and provides examples of relative path names and
fully qualified path names. The examples in the table are based on the current
working directory being set to C:\Windows.

|Symbol|Description               |Relative path    |Full path          |
|------|--------------------------|-----------------|-------------------|
|.     |Current location          |.\\System        |c:\\Windows\\System|
|..    |Parent of current location|..\\Program Files|c:\\Program Files  |
|\     |Drive root of current     |\\Program Files  |c:\\Program Files  |
|      |location                  |                 |                   |
|[none]|No special characters     |System           |c:\\Windows\\System|

When using a path name in a command, you enter that name in the same way
whether you use a fully qualified path name or a relative one. For example,
suppose that your current working directory is C:\Windows. The following
Get-ChildItem command retrieves all items in the C:\Techdocs directory:

```powershell
Get-ChildItem \techdocs
```

The backslash indicates that the drive root of the current working location
should be used. Because the working directory is C:\\Windows, the drive root
is the C: drive. Because the techdocs directory is located off the root, you
need to specify only the backslash.

You can achieve the same results by using the following command:

```powershell
Get-ChildItem c:\techdocs
```

Regardless of whether you use a fully qualified path name or a relative path
name, a path name is important not only because it locates an item but also
because it uniquely identifies the item even if that item shares the same name
as another item in a different container.

For instance, suppose that you have two files that are each named Results.txt.
The first file is in a directory named C:\\Techdocs\\Jan, and the second file
is in a directory named C:\\Techdocs\\Feb. The path name for the first file
(C:\\Techdocs\\Jan\\Results.txt) and the path name for the second file
(C:\\Techdocs\\Feb\\Results.txt) allow you to clearly distinguish between the
two files.

## SEE ALSO

[about_Locations](about_Locations.md)
