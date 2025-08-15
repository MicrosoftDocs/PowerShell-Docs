---
description: Describes the full and relative path formats in  PowerShell.
Locale: en-US
ms.date: 09/05/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_path_syntax?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Path_Syntax
---
# about_Path_Syntax

## Short description
Describes the full and relative path formats in  PowerShell.

## Long description

All items in a data store accessible through a PowerShell provider can be
uniquely identified by their path names. A path is a combination of the
item name, the container and subcontainers in which the item is located, and
the PowerShell drive through which the containers are accessed.

In PowerShell, path names can be one of two types: _fully qualified_ and
_relative_. A fully qualified path consists of all elements that make up a
path. The following syntax shows the elements in a fully qualified path:

```Syntax
[<provider>::]<drive>:[\<container>[\<subcontainer>...]]\<item>
```

The `<provider>` placeholder refers to the PowerShell provider through which
you access the data store. For example, the FileSystem provider allows you to
access the files and directories on your computer. This element of the syntax
is optional and is never needed because the drive names are unique across all
providers.

The `<drive>` placeholder refers to the PowerShell drive that's supported by a
particular PowerShell provider. In the case of the FileSystem provider, the
PowerShell drives map to the Windows drives that are configured on your system.
For example, if your system includes an `A:` drive and a `C:` drive, the
FileSystem provider creates the same drives in PowerShell.

After you have specified the drive, you must specify any containers and
subcontainers that contain the item. The containers must be specified in the
hierarchical order in which they exist in the data store. In other words, you
must start with the parent container, then the child container in that parent
container, repeating the pattern for each child container. In addition, each
container must be preceded by a backslash.

> [!NOTE]
> PowerShell allows you to use backslash or forward slash for compatibility
> with PowerShell on other platforms. This works for PowerShell commands, but
> may not work when used with native applications that only expect the native
> directory separator. Use `[System.IO.Path]::DirectorySeparatorChar` to find
> the character used for your platform.

After the container and subcontainers have been specified, you must provide
the item name, preceded by a backslash. For example, the fully qualified path
name for the `Shell.dll` file in the `C:\Windows\System32` directory is as
follows:

```powershell
C:\Windows\System32\Shell.dll
```

In this case, the drive through which the containers are accessed is the `C:`
drive, the top-level container is `Windows`, the subcontainer is `System32`,
and the item is `Shell.dll`.

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

Regardless of whether you use a fully qualified path or a relative path name, a
path is important not only because it locates an item but also because it
uniquely identifies the item even if that item shares the same name as another
item in a different container.

For instance, suppose that you have two files that are each named
`Results.txt`. The first file is in a directory named `C:\TechDocs\Jan`, and
the second file is in a directory named `C:\TechDocs\Feb`. The path for the
first file (`C:\TechDocs\Jan\Results.txt`) and the path for the second file
(`C:\TechDocs\Feb\Results.txt`) allow you to clearly distinguish between the
two files.

## Support for the Win32 File namespace

On Windows, the cmdlets that support the FileSystem provider also support the
paths that use the Win32 File namespace format. You can only use these paths
with the **LiteralPath** parameter of the cmdlets.

Paths in Win32 File namespace are prefixed with `\\?\`. The prefix tells the
Windows APIs to disable all string parsing and send the string that follows
directly to the file system. For example, if the file system supports large
paths and file names, you can exceed the **MAX_PATH** limits that are otherwise
enforced by the Windows APIs.

For more information, see _Win32 File Namespaces_ in
[Naming Files, Paths, and Namespaces][01].

## See also

- [about_Locations][02]
- [Convert-Path][03]
- [Join-Path][04]
- [Resolve-Path][05]
- [Split-Path][06]
- [Test-Path][07]

<!-- link references -->
[01]: /windows/win32/fileio/naming-a-file#win32-file-namespaces
[02]: about_Locations.md
[03]: xref:Microsoft.PowerShell.Management.Convert-Path
[04]: xref:Microsoft.PowerShell.Management.Join-Path
[05]: xref:Microsoft.PowerShell.Management.Resolve-Path
[06]: xref:Microsoft.PowerShell.Management.Split-Path
[07]: xref:Microsoft.PowerShell.Management.Test-Path
