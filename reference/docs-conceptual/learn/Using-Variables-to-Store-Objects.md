---
ms.date:  08/27/2018
keywords:  powershell,cmdlet
title:  Using Variables to Store Objects
ms.assetid:  b1688d73-c173-491e-9ba6-6d0c1cc852de
---

# Using variables to store objects

PowerShell works with objects. PowerShell lets you create named objects known as variables.
Variable names can include the underscore character and any alphanumeric characters. When used in
PowerShell, a variable is always specified using the \$ character followed by variable name.

## Creating a variable

You can create a variable by typing a valid variable name:

```
PS> $loc
PS>
```

This example returns no result because `$loc` doesn't have a value. You can create a variable and
assign it a value in the same step. PowerShell only creates the variable if it doesn't exist.
Otherwise, it assigns the specified value to the existing variable. The following example stores
the current location in the variable `$loc`:

```powershell
$loc = Get-Location
```

PowerShell displays no output when you type this command. PowerShell sends the output of
'Get-Location' to `$loc`. In PowerShell, data that isn't assigned or redirected is sent to the
screen. Typing `$loc` shows your current location:

```
PS> $loc

Path
----
C:\temp
```

You can use `Get-Member` to display information about the contents of variables. `Get-Member` shows
you that `$loc` is a **PathInfo** object, just like the output from `Get-Location`:

```powershell
PS> $loc | Get-Member -MemberType Property

   TypeName: System.Management.Automation.PathInfo

Name         MemberType Definition
----         ---------- ----------
Drive        Property   System.Management.Automation.PSDriveInfo Drive {get;}
Path         Property   System.String Path {get;}
Provider     Property   System.Management.Automation.ProviderInfo Provider {...
ProviderPath Property   System.String ProviderPath {get;}
```

## Manipulating variables

PowerShell provides several commands to manipulate variables. You can see a complete listing in a
readable form by typing:

```powershell
Get-Command -Noun Variable | Format-Table -Property Name,Definition -AutoSize -Wrap
```

PowerShell also creates several system-defined variables. You can use the `Remove-Variable` cmdlet
to remove variables, which are not controlled by PowerShell, from the current session. Type the
following command to clear all variables:

```powershell
Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
```

After running the previous command, the `Get-Variable` cmdlet shows the PowerShell system variables.

PowerShell also creates a variable drive. Use the following example to display all PowerShell
variables using the variable drive:

```powershell
Get-ChildItem variable:
```

## Using cmd.exe variables

PowerShell can use the same environment variables available to any Windows process, including
**cmd.exe**. These variables are exposed through a drive named `env:`. You can view these
variables by typing the following command:

```powershell
Get-ChildItem env:
```

The standard `*-Variable` cmdlets aren't designed to work with environment variables. Environment
variables are accessed using the `env:` drive prefix. For example, the **%SystemRoot%** variable in
**cmd.exe** contains the operating system's root directory name. In PowerShell, you use
`$env:SystemRoot` to access the same value.

```
PS> $env:SystemRoot
C:\WINDOWS
```

You can also create and modify environment variables from within PowerShell. Environment variables
in PowerShell follow the same rules for environment variables used elsewhere in the operating
system. The following example creates a new environment variable:

```powershell
$env:LIB_PATH='/usr/local/lib'
```

Though not required, it's common for environment variable names to use all uppercase letters.
