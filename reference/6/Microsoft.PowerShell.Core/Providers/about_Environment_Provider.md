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

`Env:`

## Short description

Provides access to the Windows environment variables.

## Detailed description

The PowerShell **Environment** provider lets you get, add, change, clear, and
delete Windows environment variables in PowerShell.

The **Environment** provider is a flat namespace that contains only objects
that represent the environment variables. The variables have no child items.

Each environment variable is an instance of the
[System.Collections.DictionaryEntry](https://msdn.microsoft.com/library/system.collections.dictionaryentry)
class. The name of the variable is the dictionary key. The value of the
environment variable is the dictionary value.

The **Environment** provider exposes its data store in the `Env:` drive. To
work with environment variables, change your location to the `Env:` drive
(`Set-Location Env:`), or work from another PowerShell drive. To reference an
environment variable from another location, use the `Env:` drive name in the
path.

The **Environment** provider supports all the cmdlets that contain the *Item*
noun except for `Invoke-Item`. And, it supports the `Get-Content` and
`Set-Content` cmdlets. However, it does not support the cmdlets that contain
the *ItemProperty* noun, and it does not support the `-Filter` parameter in any
cmdlet.

Environment variables must conform to the usual naming standards. Additionally,
the name cannot include the equal sign (`=`).

## Capabilities

ShouldProcess

## Navigating the `Env:` drive

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

## See also

[about_Providers](../About/about_Providers.md)