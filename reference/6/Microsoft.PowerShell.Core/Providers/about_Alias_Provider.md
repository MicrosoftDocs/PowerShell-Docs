---
ms.date:  11/15/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Alias Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=834943
---
# Alias provider

## Provider name

Alias

## Drives

`Alias:`

## Short description

Provides access to the PowerShell aliases and the values that they represent.

## Detailed description

The PowerShell **Alias** provider lets you get, add, change, clear, and delete
aliases in PowerShell.

An alias is an alternate name for a cmdlet, function, executable file,
including scripts. PowerShell includes a set of built-in aliases. You can add
your own aliases to the current session and to your PowerShell profile.

The **Alias** provider is a flat namespace that contains only the alias objects.
The aliases have no child items.

Each alias is an instance of the
[System.Management.Automation.AliasInfo](https://msdn.microsoft.com/library/system.management.automation.aliasinfo) class.

The **Alias** provider exposes its data store in the `Alias:` drive. To work
with aliases, you can change your location to the `Alias:` drive by using the
following command:

```powershell
Set-Location Alias:
```

You can also work with the Alias provider from any other PowerShell drive. To
reference an alias from another location, use the `Alias:` drive name in the
path.

PowerShell includes a set of cmdlets that are designed to view and to change aliases:

- [Export-Alias](../../Microsoft.PowerShell.Utility/Export-Alias.md)
- [Get-Alias](../../Microsoft.PowerShell.Utility/Get-Alias.md)
- [Import-Alias](../../Microsoft.PowerShell.Utility/Import-Alias.md)
- [New-Alias](../../Microsoft.PowerShell.Utility/New-Alias.md)
- [Set-Alias](../../Microsoft.PowerShell.Utility/Set-Alias.md)

When you use these cmdlets, you do not need to specify the `Alias:` drive in
the name.

The **Alias** provider supports all the cmdlets that have the *Item* noun
except for the
[Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md) cmdlet.
It also supports the
[Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) and
[Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md) cmdlets.
The **Alias** provider does not support the cmdlets that have the
*ItemProperty* noun and does not support the `-Filter` parameter in any cmdlet.

All changes to the aliases affect the current session only. To save the
changes, add the changes to the PowerShell profile, or use the
[Export-Alias](../../Microsoft.PowerShell.Utility/Export-Alias.md) and
[Import-Alias](../../Microsoft.PowerShell.Utility/Import-Alias.md) cmdlets.

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell
provider and are available only when the cmdlet is being used in the
provider-enabled drive.

### Options [System.Management.Automation.ScopedItemOptions]

Determines the value of the **Options** property of an alias.

- `None`: No options. This value is the default.
- `Constant`:The alias cannot be deleted and its properties cannot be changed.
  `Constant` is available only when you create an alias. You cannot change the option of an existing alias to `Constant`.
- `Private`:The alias is visible only in the current scope, not in the child
   scopes.
- `ReadOnly`:The properties of the alias cannot be changed except by using the
  `-Force` parameter. You can use `Remove-Item` to delete the alias.
- `AllScope`:The alias is copied to any new scopes that are created.

#### Cmdlets supported

- [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)
- [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)

## Capabilities

ShouldProcess

## Navigating the Alias: drive

### Example 1: Navigate to the Alias: drive

This command changes the current location to the `Alias:` drive.
You can use this command from any drive in PowerShell.
To return to a file system drive, type the drive name.
For example, type `Set-Location C:`.

```powershell
Set-Location Alias:
```

## Displaying the Contents of the Alias: drive

### Example 1: Get all aliases in the current session

This command gets a list of all the aliases in the current session.
You can use this command in any PowerShell drive.

```powershell
Get-Item -Path Alias:
```

The Alias provider has no containers, so the above command has the
same effect when used with `Get-ChildItem`.

```powershell
Get-ChildItem -Path Alias:
```

### Example 2: Get a selected alias

This command gets the `ls` alias.
Because it includes the path, you can use it in any PowerShell drive.

```powershell
Get-Item -Path Alias:ls
```

If you are in the `Alias:` drive, you can omit the drive name from the path.

### Example 3: Get all aliases for a specific cmdlet

This command gets a list of the aliases that are associated with the
`Get-ChildItem` cmdlet. It uses the **Definition** property, which stores
the cmdlet name.

```powershell
Get-Item -Path Alias:* | Where-Object {$_.Definition -eq "Get-ChildItem"}
```

### Example 4: Get all aliases from the Alias: drive

This command gets the list of all the aliases when the current location is the
`Alias:` drive. It uses a wildcard character `*` to indicate all the contents
of the current location.

```powershell
PS Alias:\> Get-Item -Path *
```

In the `Alias:` drive, a dot `.`, which represents the current location, and a
wildcard character `*`, which represents all items in the current location,
have the same effect. For example, `Get-Item -Path .` or `Get-Item \*` produce
the same result.

## Creating aliases

### Example 1: Create an alias from the Alias: drive

This command creates the `serv` alias for the `Get-Service` cmdlet. Because the
current location is in the `Alias:` drive, the `-Path` parameter is not
needed.

This command also uses the `-Options` dynamic parameter to set the **AllScope**
option on the alias. The `-Options` parameter is available in
the `New-Item` cmdlet only when you are in the `Alias:` drive. The dot (`.`)
indicates the current directory, which is the alias drive.

```powershell
PS Alias:\> New-Item -Path . `
                     -Name serv `
                     -Value Get-Service `
                     -Options "AllScope"
```

### Example 2: Create an alias with an absolute path

You can create an alias for any item that invokes a command.
This command creates the `np` alias for `Notepad.exe`.

```powershell
New-Item -Path Alias:np -Value c:\windows\notepad.exe
```

### Example 3: Create an alias to a new function

You can create an alias for any function. You can use this feature to create an
alias that includes both a cmdlet and its parameters.

The first command creates the `CD32` function, which changes the current
directory to the `System32` directory. The second command creates the `go`
alias for the `CD32` function.

When the command is complete, you can use either `CD32` or `go` to invoke the
function.

```powershell
function CD32 {Set-Location -Path c:\windows\system32}
Set-Item -Path Alias:go -Value CD32
```

## Changing the properties of an alias

### Example 1: Change the options of an alias

You can use the `Set-Item` cmdlet with the `-Options` dynamic parameter to change the value of the `-Options` property of an alias.

This command sets the **AllScope** and **ReadOnly** options for the `dir`
alias. The command uses the `-Options` dynamic parameter of the `Set-Item`
cmdlet. The `-Options` parameter is available in `Set-Item` when you use it
with the **Alias** or **Function** provider.

```powershell
Set-Item -Path Alias:dir -Options "AllScope,ReadOnly"
```

### Example 2: Change an aliases referenced command

This command uses the `Set-Item` cmdlet to change the `gp` alias so that it
represents the `Get-Process` cmdlet instead of the `Get-ItemProperty` cmdlet.
The `-Force` parameter is required because the value of the **Options**
property of the `gp` alias is set to `ReadOnly`. Because the command is
submitted from within the `Alias:` drive, the drive is not specified in the
path.

```powershell
Set-Item -Path gp -Value Get-Process -Force
```

The change affects the four properties that define the association between the
alias and the command. To view the effect of the change, type the following
command:

```powershell
Get-Item -Path gp | Format-List -Property *
```

### Example 3: Rename an alias

This command uses the `Rename-Item` cmdlet to change the `popd` alias to `pop`.

```powershell
Rename-Item -Path Alias:popd -NewName pop
```

## Copying an alias

### Example 1: Copy an alias

This command copies the `pushd` alias so that a new `push` alias is created for
the `Push-Location` cmdlet.

When the new alias is created, its **Description** property has a null value.
And, its **Option** property has a value of `None`. If the command is issued
from within the `Alias:` drive, you can omit the drive name from the value of
the `-Path` parameter.

```powershell
Copy-Item -Path Alias:pushd -Destination Alias:push
```

## Deleting an alias

### Example 1: Delete an alias

This command deletes the `serv` alias from the current session.
You can use this command in any PowerShell drive.

```powershell
Remove-Item -Path Alias:serv
```

### Example 2: Delete aliases using wildcards

This command deletes aliases that begin with "s".
It does not delete read-only aliases.

```powershell
Clear-Item -Path Alias:s*
```

### Example 3: Delete read-only aliases

This command deletes all aliases from the current session, except those with a
value of `Constant` for their **Options** property. The `-Force`
parameter allows the command to delete aliases whose **Options** property has a
value of `ReadOnly`.

```powershell
Remove-Item Alias:* -Force
```

## See also

[about_Aliases](../About/about_Aliases.md)

[about_Providers](../About/about_Providers.md)