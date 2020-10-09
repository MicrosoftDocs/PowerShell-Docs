---
description: Function 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 10/18/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_function_provider?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Function Provider
---
# Function provider

## Provider name
Function

## Drives

`Function:`

## Capabilities

**ShouldProcess**

## Short description

Provides access to the functions defined in PowerShell.

## Detailed description

The PowerShell **Function** provider lets you get, add, change, clear, and
delete the functions and filters in PowerShell.

A function is a named block of code that performs an action. When you type the
function name, the code in the function runs. A filter is a named block of code
that establishes conditions for an action. You can type the name of the filter
in place of the condition, such as in a `Where-Object` command.

The **Function** drive is a flat namespace that contains only the function
and filter objects. Neither functions nor filters have child items.

The **Function** provider supports the following cmdlets, which are covered
in this article.

- [Get-Location](xref:Microsoft.PowerShell.Management.Get-Location)
- [Set-Location](xref:Microsoft.PowerShell.Management.Set-Location)
- [Get-Item](xref:Microsoft.PowerShell.Management.Get-Item)
- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)
- [Remove-Item](xref:Microsoft.PowerShell.Management.Remove-Item)
- [Clear-Item](xref:Microsoft.PowerShell.Management.Clear-Item)

## Types exposed by this provider

Each function is an instance of the
[System.Management.Automation.FunctionInfo](/dotnet/api/system.management.automation.functioninfo)
class. Each filter is an instance of the
[System.Management.Automation.FilterInfo](/dotnet/api/system.management.automation.filterinfo)
class.

## Navigating the Function drive

The **Function** provider exposes its data store in the `Function:` drive. To
work with functions, you can change your location to the `Function:` drive
(`Set-Location Function:`). Or, you can work from another PowerShell drive. To
reference a function from another location, use the drive name (`Function:`) in
the path.

```powershell
Set-Location Function:
```

To return to a file system drive, type the drive name. For example, type:

```powershell
Set-Location C:
```

You can also work with the **Function** provider from any other PowerShell
drive. To reference an function from another location, use the drive name
`Function:` in the path.

> [!NOTE]
> PowerShell uses aliases to allow you a familiar way to work with provider
> paths. Commands such as `dir` and `ls` are now aliases for
> [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem),
> `cd` is an alias for [Set-Location](xref:Microsoft.PowerShell.Management.Set-Location). and `pwd` is
> an alias for [Get-Location](xref:Microsoft.PowerShell.Management.Get-Location).

## Getting functions

This command gets the list of all the functions in the current session. You can
use this command from any PowerShell drive.

```powershell
Get-ChildItem -Path Function:
```

The Function provider has no containers, so the above command has the
same effect when used with `Get-ChildItem`.

```powershell
Get-ChildItem -Path Function:
```

You can retrieve a function's definition by accessing the **Definition**
property, as shown below.

```powershell
(Get-Item -Path function:more).Definition
```

You can also retrieve a function's definition using its provider path prefixed
by the dollar sign (`$`).

```powershell
$function:more
```

### Getting selected functions

This command gets the `man` function from the `Function:` drive. It uses the
`Get-Item` cmdlet to get the function. The pipeline operator (`|`) sends the
result to `Format-Table`. The `-Wrap` parameter directs text that does not fit
on the line onto the next line. The `-Autosize` parameter resizes the table
columns to accommodate the text.

```powershell
Get-Item -Path man | Format-Table -Wrap -Autosize
```

### Working with Function provider paths

These commands both get the function named `c:`. The first command can be used
in any drive. The second command is used in the `Function:` drive. Because the
name ends in a colon, which is the syntax for a drive, you must qualify the
path with the drive name. Within the `Function:` drive, you can use either
format. In the second command, the dot (`.`) represents the current location.

```
PS C:\> Get-Item -Path Function:c:
PS Function:\> Get-Item -Path .\c:
```

## Creating a function

This command uses the `New-Item` cmdlet to create a function called `Win32:`.
The expression in braces is the script block that is represented by the
function name.

```powershell
New-Item -Path Function:Win32: -Value {Set-Location C:\Windows\System32}
```

You can also create a function by typing it at the PowerShell command line. For
example, tpe `Function:Win32: {Set-Location C:\Windows\System32}`. If you are
in the `Function:` drive, you can omit the drive name.

## Deleting a function

This command deletes the `more:` function from the current session.

```powershell
Remove-Item Function:more:
```

## Changing a function

This command uses the `Set-Item` cmdlet to change the `prompt` function so that
it displays the time before the path.

```powershell
Set-Item -Path Function:prompt -Value {
  'PS '+ (Get-Date -Format t) + " " + (Get-Location) + '> '
  }
```

### Rename a function

This command uses the `Rename-Item` cmdlet to change the name of the `help`
function to `gh`.

```powershell
Rename-Item -Path Function:help -NewName gh
```

## Copying a function

This command copies the `prompt` function to `oldPrompt`, effectively creating
a new name for the script block that is associated with the prompt function.
You can use this to save the original prompt function if you plan to change it.
The **Options** property of the new function has a value of `None`. To change
the value of the **Options** property, use `Set-Item`.

```powershell
Copy-Item -Path Function:prompt -Destination Function:oldPrompt
```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell
provider and are available only when the cmdlet is being used in the
provider-enabled drive.

### Options <[System.Management.Automation.ScopedItemOptions]>

Determines the value of the **Options** property of a function.

- `None`: No options. `None` is the default.
- `Constant`: The function cannot be deleted, and its properties cannot be
  changed. `Constant` is available only when you are creating a function.
  You cannot change the option of an existing function to `Constant`.
- `Private`: The function is visible only in the current scope
- (not in child scopes).
- `ReadOnly`: The properties of the function cannot be changed except by
   using the `-Force` parameter. You can use `Remove-Item` to delete the
   function.
- `AllScope`: The function is copied to any new scopes that are created.

### Cmdlets supported

- [New-Item](xref:Microsoft.PowerShell.Management.New-Item)

- [Set-Item](xref:Microsoft.PowerShell.Management.Set-Item)

## Using the pipeline

Provider cmdlets accept pipeline input. You can use the pipeline to simplify
task by sending provider data from one cmdlet to another provider cmdlet.
To read more about how to use the pipeline with provider cmdlets, see the
cmdlet references provided throughout this article.

## Getting help

Beginning in Windows PowerShell 3.0, you can get customized help topics for
provider cmdlets that explain how those cmdlets behave in a file system drive.

To get the help topics that are customized for the file system drive, run a
[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) command in a file system drive or use the `-Path`
parameter of [Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) to specify a file system drive.

```powershell
Get-Help Get-ChildItem
```

```powershell
Get-Help Get-ChildItem -Path function:
```

## See also

[about_Functions](../About/about_Functions.md)

[about_Providers](../About/about_Providers.md)

