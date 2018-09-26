---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Environment Provider
online version:  https://go.microsoft.com/fwlink/?linkid=834944
---
# Environment provider

## Provider name

Environment

## Drives

*Env:*

## Capabilities

**ShouldProcess**

## Short description

Provides access to the Windows environment variables.

## Detailed description

The PowerShell **Environment** provider lets you get, add, change, clear, and delete environment
variables and values in PowerShell.

**Environment** variables are dynamically named variables that describe the environment in which your programs run. Windows and PowerShell use environment variables to store persistent information that affect system
and process execution. Unlike PowerShell variables, environment variables are not subject to scope constraints.

The **Environment** drive is a flat namespace containing the environment variables specific to the current user's session. The environment variables
have no child items.

The **Envrionment** provider supports the following cmdlets, which are covered
in this article.

- [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md)
- [Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md)
- [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)
- [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)
- [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)
- [Clear-Item](Clear-Item.md)

{{Make sure list is correct}}

## Types exposed by this provider

Each environment variable is an instance of the
[System.Collections.DictionaryEntry](https://msdn.microsoft.com/library/system.collections.dictionaryentry)
class. The name of the variable is the dictionary key. The value of the
environment variable is the dictionary value.

## Working with provider paths

A provider path can either be *Absolute* or *Relative*.  An *Absolute* path
should be usable from any location and start with a drive name followed by a
colon `:`.  Separate containers in your paths using a backslash `\` or a
forward slash `/`.  If you are referencing a specific item, it should be the
last item in the path. An *Absolute* path is absolute, it should not
change based on your current location.

This is an example of an *Absolute* path.

```
C:\Windows\System32\shell.dll
```

A *Relative* path begins with a dot `.` or double dot `..`.  The dot `.`
indicates the current location, the double dot `..` represents the location
directly above your current location. You can use multiple combinations
of dot `.` and double dot `..`. A *Relative* path can change based on your
current location.

This is an example of a *Relative* path.

```
PS C:\Windows\System32\> .\shell.dll
```

Notice that this path is only valid if you are in the System32 directory.

If any element in the fully qualified name includes spaces, you must enclose
the name in quotation marks `" "`. The following example shows a fully
qualified path that includes spaces.

```
"C:\Program Files\Internet Explorer\iexplore.exe"
```

## Navigating the Environment drive

The **Environment** provider exposes its data store in the `Env:` drive. To
work with environment variables, change your location to the `Env:` drive
(`Set-Location Env:`), or work from another PowerShell drive. To reference an
environment variable from another location, use the `Env:` drive name in the
path.

### Example 1: Getting to the Env: drive

This command changes the current location to the `Env:` drive.

```powershell
Set-Location Env:
```

You can use this command from any drive in PowerShell. To return to a file
system drive, type the drive name. For example, type:

```powershell
Set-Location c:
```

## Getting environment variables

### Example 1: Get all environment variables

This command lists all the environment variables in the current session:

```powershell
Get-Item -Path Env:
```

You can use this command from any PowerShell drive.

The Environment provider has no containers, so the above command has the
same effect when used with `Get-ChildItem`.

```powershell
Get-ChildItem -Path Env:
```

### Example 2: Get a selected environment variable

This command gets the `WINDIR` environment Variable.

```powershell
Get-ChildItem -Path Env:windir
```

### Example 3: List environment variables by name

This command gets a list of all the environment variables in the current
session and then sorts them by name. By default, the environment variables
appear in the order that PowerShell discovers them.

```powershell
PS Env:\> Get-ChildItem | Sort-Object -Property name
```

## Creating a new environment variable

### Example 1: Create an environment variable

This command creates the `USERMODE` environment variable with a value of
"Non-Admin". Because the current location is in the `C:` drive, the value of
the `-Path` parameter is the `Env:` drive.

```powershell
PS C:\> New-Item -Path Env: -Name USERMODE -Value Non-Admin
```

## Changing the properties of an environment variable

### Example 1: Rename an environment variable

This command uses the `Rename-Item` cmdlet to change the name of the `USERMODE`
environment variable that you created to `USERROLE`. Do not change the name of
an environment variable that the system uses. Although these changes affect
only the current session, they might cause the system or a program to operate
incorrectly.

```powershell
Rename-Item -Path Env:USERMODE -NewName USERROLE
```

### Example 2: Change an environment variable

This command uses the `Set-Item` cmdlet to change the value of the `USERROLE`
environment variable to "Administrator".

```powershell
Set-Item -Path Env:USERROLE -Value Administrator
```

## Copying an environment variable

### Example 1: Copy an environment variable

This command copies the value of the `USERROLE` environment variable to the
`USERROLE2` environment Variable.

```powershell
Copy-Item -Path Env:USERROLE -Destination Env:USERROLE2
```

## Deleting an environment variable

### Example 1: Remove an environment variable

This command deletes the `USERROLE2` environment variable from the current
session.

```powershell
Remove-Item -Path Env:USERROLE2
```

### Example 2: Delete an environment variable with Clear-Item

This command deletes the `USERROLE` environment variable.

```powershell
Clear-Item -Path Env:USERROLE
```

## Getting help

Beginning in Windows PowerShell 3.0, you can get customized help topics for
provider cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help](../Get-Help.md) command in a file system drive or use the `-Path`
parameter of [Get-Help](../Get-Help.md) to specify a file system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path c:
```

{{Make provider specific>}}

## See also

[about_Providers](../About/about_Providers.md)