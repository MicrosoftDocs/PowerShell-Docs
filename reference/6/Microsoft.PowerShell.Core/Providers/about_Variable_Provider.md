---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Variable Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=834963
---
# Variable provider

## Provider name

Variable

## Drives

`Variable:`

## Short description

Provides access to the PowerShell variables and to their values.

## Detailed description

The PowerShell **Variable** provider lets you get, add, change, clear, and
delete PowerShell variables in the current console.

The PowerShell **Variable** provider supports the variables that PowerShell
creates, including the automatic variables, the preference variables, and the
variables that you create.

The **Variable** provider is a flat namespace that contains only the variable
objects. The variables have no child items.

Most of the variables are instances of the
[System.Management.Automation.PSVariable](https://msdn.microsoft.com/library/system.management.automation.psvariable)
class. However, there are some variations. For example, the `?` variable is a
member of the `QuestionMarkVariable` internal class, and the
`MaximumVariableCount` variable is a member of the
`SessionStateCapacityVariable` internal class.

The **Variable** provider exposes its data store in the `Variable:` drive. To
work with variables, you can change your location to the `Variable:` drive
(`Set-Location Variable:`), or you can work from any other PowerShell drive. To
reference a variable from another location, use the drive name (`Variable:`) in
the path.

PowerShell includes a set of cmdlets designed especially to view and to change
variables:

- [Get-Variable](../../Microsoft.PowerShell.Utility/Get-Variable.md)
- [New-Variable](../../Microsoft.PowerShell.Utility/New-Variable.md)
- [Set-Variable](../../Microsoft.PowerShell.Utility/Set-Variable.md)
- [Remove-Variable](../../Microsoft.PowerShell.Utility/Remove-Variable.md)
- [Clear-Variable](../../Microsoft.PowerShell.Utility/Clear-Variable.md)

When you use these cmdlets, you do not need to specify the `Variable:` drive in
the name.

The **Variable** provider supports all of the cmdlets whose names contain the
*Item* noun (the `*-Item` cmdlets), except for `Invoke-Item`. The **Variable**
provider supports the `Get-Content` and `Set-Content` cmdlets. However, it does
not support the cmdlets whose names contain the *ItemProperty* noun (the
`*-ItemProperty` cmdlets), and it does not support the `-Filter` parameter in
any cmdlet.

You can also use the PowerShell expression parser to create, view, and change
the values of variables without using the cmdlets. When working with variables
directly, use a dollar sign (`$`) to identify the name as a variable and the
assignment operator (`=`)to establish and change its value. For example,
`$p = Get-Process` creates the `p` variable and stores the results of a
`Get-Process` command in it.

## Capabilities

ShouldProcess

## Navigating the Variable: drive

### Example 1: Getting to the Variable: drive

This command changes the current location to the `Variable:` drive. You can use
this command from any drive in PowerShell. To return to a file system drive,
type the drive name. For example, type `Set-Location c:`.

```powershell
Set-Location Variable:
```

## Displaying the value of variables

### Example 1: Get all variables in the current session

This command gets the list of all the variables and their values in the current
session. You can use this command from any PowerShell drive.

```powershell
Get-ChildItem -Path Variable:
```

### Example 2: Get variables using wildcards

This command gets the variables with names that begin with "max". You can use
this command from any PowerShell drive.

```powershell
Get-ChildItem -Path Variable:max*
```

### Example 3: Get the value of the ? variable

This command uses the `-LiteralPath` parameter of
[Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) to get
the value of the `?` variable from within the `Variable:` drive.
`Get-ChildItem` does not attempt to resolve any wildcards in the values of the
`-LiteralPath` parameter.

```powershell
Get-ChildItem -Literalpath ?
```

### Example 4: Get ReadOnly and Constant variables

This command gets the variables that have the values of `ReadOnly` or
`Constant` for their **Options** property.

```powershell
Get-ChildItem -Path Variable: | Where-Object {
   $_.options -Match "Constant" `
   -or $_.options -Match "ReadOnly"
 } | Format-List -Property name, value, options
```

## Creating variables

### Example 1: Create a new variable

This command creates the `services` variable and stores the results of a
`Get-Service` command in it. Because the current location is in the `Variable:`
drive, the value of the `-Path` parameter is a dot (`.`), which represents the
current location.

The parentheses around the `Get-Service` command ensure that the command is
executed before the variable is created. Without the parentheses, the value of
the new variable is a "Get-Service" string.

```powershell
New-Item -Path . -Name services -Value (Get-Service)
```

### Example 2: Create a variable using an absolute path

This command creates a `services` variable and stores the result of a
`Get-Service` command in it.

```powershell
New-Item -Path Variable:services -Value Get-Service
```

 To create a variable without a value, omit the assignment operator.

## Changing the properties of variables

### Example 1: Rename a variable

This command uses the `Rename-Item` cmdlet to change the name of the `a`
variable to `processes`.

```powershell
Rename-Item -Path Variable:a -NewName processes
```

### Example 2: Change the value of a variable

This command uses the `Set-Item` cmdlet to change the value of the
`ErrorActionPreference` variable to "Stop".

```powershell
Set-Item -Path Variable:ErrorActionPreference -Value Stop
```

## Copying variables

### Example 1: Copy a variable

This command uses the `Copy-Item` cmdlet to copy the `processes` variable to
`old_processes`. This creates a new variable named `old_processes` that has the
same value as the `processes` variable.

```powershell
Copy-Item -Path Variable:processes -Destination Variable:old_processes
```

## Deleting a variable

### Example 1: Delete a variable

This command deletes the `serv` variable from the current session. You can use
this command in any PowerShell drive.

```powershell
Remove-Variable -Path Variable:serv
```

### Example 2: Delete variables using the -Force parameter

This command deletes all variables from the current session except for the
variables whose **Options** property has a value of `Constant`. Without the
`-Force` parameter, the command does not delete variables whose **Options**
property has a value of `ReadOnly`.

```powershell
Remove-Item Variable:* -Force
```

## Setting the value of a variable to NULL

### Example 1: Clear a variable

This command uses the `Clear-Item` cmdlet to change the value of the
`processes` variable to NULL.

```powershell
Clear-Item -Path Variable:processes
```

## See also

[about_Variables](../About/about_Variables.md)

[about_Automatic_Variables](../About/about_Automatic_Variables.md)

[about_Providers](../About/about_Providers.md)