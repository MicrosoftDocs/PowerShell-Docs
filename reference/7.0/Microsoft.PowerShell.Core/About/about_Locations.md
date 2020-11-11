---
description: Describes how to access items from the working location in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_locations?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Locations
---
# about_Locations

## SHORT DESCRIPTION
Describes how to access items from the working location in PowerShell.

## LONG DESCRIPTION

The current working location is the default location to which commands point.
In other words, this is the location that PowerShell uses if you do not supply
an explicit path to the item or location that is affected by the command. In
most cases, the current working location is a drive accessed through the
PowerShell FileSystem provider and, in some cases, a directory on that drive.
For example, you might set your current working location to the following
location:

```powershell
C:\Program Files\Windows PowerShell
```

As a result, all commands are processed from this location unless another path
is explicitly provided.

PowerShell maintains the current working location for each drive even when the
drive is not the current drive. This allows you to access items from the
current working location by referring only to the drive of another location.
For example, suppose that your current working location is C:\\Windows. Now,
suppose you use the following command to change your current working location
to the HKLM: drive:

```powershell
Set-Location HKLM:
```

Although your current location is now the registry drive, you can still access
items in the C:\\Windows directory simply by using the C: drive, as shown in
the following example:

```powershell
Get-ChildItem C:
```

PowerShell remembers that your current working location for that drive is the
Windows directory, so it retrieves items from that directory. The results
would be the same if you ran the following command:

```powershell
Get-ChildItem C:\Windows
```

In PowerShell, you can use the Get-Location command to determine the current
working location, and you can use the Set-Location command to set the current
working location. For example, the following command sets the current working
location to the Windows directory of the C: drive:

```powershell
Set-Location c:\windows
```

After you set the current working location, you can still access items from
other drives simply by including the drive name (followed by a colon) in the
command, as shown in the following example:

```powershell
Get-ChildItem HKLM:\software
```

The example command retrieves a list of items in the Software container of the
HKEY Local Machine hive in the registry.

PowerShell also allows you to use special characters to represent the current
working location and its parent location. To represent the current working
location, use a single period. To represent the parent of the current working
location, use two periods. For example, the following specifies the System
subdirectory in the current working location:

```powershell
Get-ChildItem .\system
```

If the current working location is C:\\Windows, this command returns a list of
all the items in C:\\Windows\\System. However, if you use two periods, the
parent directory of the current working directory is used, as shown in the
following example:

```powershell
Get-ChildItem ..\"program files"
```

In this case, PowerShell treats the two periods as the C: drive, so the
command retrieves all the items in the C:\\Program Files directory.

A path beginning with a slash identifies a path from the root of the current
drive. For example, if your current working location is C:\\Program
Files\\PowerShell, the root of your drive is C. Therefore, the following
command lists all items in the C:\\Windows directory:

```powershell
Get-ChildItem \windows
```

If you do not specify a path beginning with a drive name, slash, or period
when supplying the name of a container or item, the container or item is
assumed to be located in the current working location. For example, if your
current working location is C:\\Windows, the following command returns all the
items in the C:\\Windows\\System directory:

```powershell
Get-ChildItem system
```

If you specify a file name rather than a directory name, PowerShell returns
details about that file (assuming that file is located in the current working
location).

## SEE ALSO

[Set-Location](xref:Microsoft.PowerShell.Management.Set-Location)

[about_Providers](about_Providers.md)

[about_Path_Syntax](about_Path_Syntax.md)
