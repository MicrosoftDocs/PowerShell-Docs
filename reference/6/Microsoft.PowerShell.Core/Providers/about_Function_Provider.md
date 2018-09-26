---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Function Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=834961
---
# Function provider

## Provider name

Function

## Drives

*Function:*

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

- [Get-Location](../../Microsoft.PowerShell.Management/Get-Location.md)
- [Set-Location](../../Microsoft.PowerShell.Management/Set-Location.md)
- [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)
- [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)
- [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)
- [Clear-Item](Clear-Item.md)

{{Make sure list is correct}}

## Types exposed by this provider

Each function is an instance of the
[System.Management.Automation.FunctionInfo](https://msdn.microsoft.com/library/system.management.automation.functioninfo)
class. Each filter is an instance of the
[System.Management.Automation.FilterInfo](https://msdn.microsoft.com/library/system.management.automation.filterinfo)
class.

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

## Navigating the Function drive

The **Function** provider exposes its data store in the `Function:` drive. To
work with functions, you can change your location to the `Function:` drive
(`Set-Location Function:`). Or, you can work from another PowerShell drive. To
reference a function from another location, use the drive name (`Function:`) in
the path.

In the `Function:` drive, functions are preceded by the label "Function" and
filters are preceded by the label "Filter", but they operate properly when used
in the correct context regardless of the label. The examples in this section show how to manage functions, but the same methods can be used with filters.

### Example 1: Getting to the Function: drive

 Changes the current location to the `Function:` drive. You can use this command from any drive in PowerShell. To return to a file system drive, type the drive name. For example, type `set-location c:`.

```powershell
Set-Location Function:
```

## Getting functions

### Example 1: Getting all functions in the current session

 This command gets the list of all the functions in the current session. You can use this command from any PowerShell drive.

```powershell
Get-ChildItem -Path Function:
```

The Function provider has no containers, so the above command has the
same effect when used with `Get-ChildItem`.

```powershell
Get-ChildItem -Path Function:
```

### Example 2: Getting selected functions

This command gets the `man` function from the `Function:` drive. It uses the
`Get-Item` cmdlet to get the function. The pipeline operator (`|`) sends the
result to `Format-Table`. The `-Wrap` parameter directs text that does not fit
on the line onto the next line. The `-Autosize` parameter resizes the table
columns to accommodate the text.

```powershell
Get-Item -Path man | Format-Table -Wrap -Autosize
```

### Example 3: Working with Function provider paths

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

### Example 1: Create a Function

This command uses the `New-Item` cmdlet to create a function called `Win32:`.
The expression in braces is the script block that is represented by the
function name.

```powershell
New-Item -Path Function:Win32: -Value {Set-Location C:\Windows\System32}
```

You can also create a function by typing it at the PowerShell command line. For example, tpe `Function:Win32: {Set-Location C:\Windows\System32}`. If you are in the `Function:` drive, you can omit the drive name.

## Deleting a function

### Example 1: Delete a function

 This command deletes the `HKLM:` function from the current session.

```powershell
Remove-Item Function:HKLM:
```

### Example 2: Delete a function with Clear-Item

This command deletes all the functions from the current session except for the
functions whose **Options** property has a value of `Constant`. Without the
`-Force` parameter, the command does not delete functions whose **Options**
property has a value of `ReadOnly`.

```powershell
Remove-Item Function:* -Force
```

When you delete all the functions, the command prompt changes because the
prompt function, which defines the content of the command prompt, is deleted.

## Changing the properties of a function

### Example 1: Set a function as ReadOnly

You can use the `Set-Item` cmdlet with the `-Options` dynamic parameter to
change the value of the **Options** property of a function.

This command sets the `AllScope` and `ReadOnly` options for the `prompt`
function. This command uses the `-Options` dynamic parameter of the `Set-Item`
cmdlet. The `-Options` parameter is available in `Set-Item` only when you use
it with the **Alias** or **Function** provider.

```powershell
Set-Item -Path Function:prompt -Options "ReadOnly"
```

### Example 2: Change the value of a function

This command uses the `Set-Item` cmdlet to change the `prompt` function so that
it displays the time before the path.

```powershell
Set-Item -Path Function:prompt -Value {
  'PS '+ $(Get-Date -Format t) + " " + $(Get-Location) + '> '
  }
```

### Example 3: Rename a function

This command uses the `Rename-Item` cmdlet to change the name of the `help`
function to `gh`.

```powershell
Rename-Item -Path Function:help -NewName gh
```

## Copying a function

### Example 1: Copy a function

This command copies the `prompt` function to `oldPrompt`, effectively creating
a new name for the script block that is associated with the prompt function.
You can use this to save the original prompt function if you plan to change it.
The **Options** property of the new function has a value of `None`. To change
the value of the **Options** property, use `Set-Item`.

```powershell
Copy-Item -Path Function:prompt -Destination Function:oldPrompt
```

## Dynamic parameters

Dynamic parameters are cmdlet parameters that are added by a PowerShell provider and are available only when the cmdlet is being used in the provider-enabled drive.

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

- [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)

- [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)

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

[about_Functions](../About/about_Functions.md)

[about_Providers](../About/about_Providers.md)