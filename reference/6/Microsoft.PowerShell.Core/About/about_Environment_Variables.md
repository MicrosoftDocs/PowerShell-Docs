---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Environment_Variables
---

# About Environment Variables

## SHORT DESCRIPTION

Describes how to access Windows environment variables in Windows
PowerShell.

## LONG DESCRIPTION

Environment variables store information about the operating system
environment. This information includes details such as the operating system
path, the number of processors used by the operating system, and the location
of temporary folders.

The environment variables store data that is used by the operating system and
other programs. For example, the WINDIR environment variable contains the
location of the Windows installation directory. Programs can query the value
of this variable to determine where Windows operating system files are
located.

Windows PowerShell lets you view and change Windows environment variables,
including the variables set in the registry, and those set for a particular
session. The Windows PowerShell environment provider simplifies this process
by making it easy to view and change the environment variables.

Unlike other types of variables in Windows PowerShell, environment variables
and their values are inherited by child sessions, such as local background
jobs and the sessions in which module members run. This makes environment
variables well suited to storing values that are needed in both parent and
child sessions.

### Windows PowerShell Environment Provider

The Windows PowerShell environment provider lets you access Windows
environment variables in Windows PowerShell in a Windows PowerShell drive (the
Env: drive). This drive looks much like a file system drive. To go to the Env:
drive, type:

```powershell
Set-Location Env:
```

Then, to display the contents of the Env: drive, type:

```powershell
Get-ChildItem
```

You can view the environment variables in the Env: drive from any other
Windows PowerShell drive, and you can go into the Env: drive to view and
change the environment variables.

### Environment Variable Objects

In Windows PowerShell, each environment variable is represented by an object
that is an instance of the System.Collections.DictionaryEntry class.

In each DictionaryEntry object, the name of the environment variable is the
dictionary key. The value of the variable is the dictionary value.

To display an environment variable in Windows PowerShell, get an object that
represents the variable, and then display the values of the object properties.
When you change an environment variable in Windows PowerShell, use the methods
that are associated with the DictionaryEntry object.

To display the properties and methods of the object that represents an
environment variable in Windows PowerShell, use the Get-Member cmdlet. For
example, to display the methods and properties of all the objects in the Env:
drive, type:

```powershell
Get-Item -Path Env:* | Get-Member
```

### Displaying Environment Variables

You can use the cmdlets that contain the Item noun (the Item cmdlets) to
display and change the values of environment variables. Because environment
variables do not have child items, the output of Get-Item and Get-ChildItem is
the same.

When you refer to an environment variable, type the Env: drive name followed
by the name of the variable. For example, to display the value of the
COMPUTERNAME environment variable, type:

```powershell
Get-Childitem Env:Computername
```

To display the values of all the environment variables, type:

```powershell
Get-ChildItem Env:
```

By default, Windows PowerShell displays the environment variables in the order
in which it retrieves them. To sort the list of environment variables by
variable name, pipe the output of a Get-ChildItem command to the Sort-Object
cmdlet. For example, from any Windows PowerShell drive, type:

```powershell
Get-ChildItem Env: | Sort Name
```

You can also go into the Env: drive by using the Set-Location cmdlet:

```powershell
Set-Location Env:
```

When you are in the Env: drive, you can omit the Env: drive name from the
path. For example, to display all the environment variables, type:

```powershell
Get-ChildItem
```

To display the value of the COMPUTERNAME variable from within the Env:
drive, type:

```powershell
Get-ChildItem ComputerName
```

You can also display and change the values of environment variables without
using a cmdlet by using the expression parser in Windows PowerShell. To
display the value of an environment variable, use the following syntax:

```powershell
$Env:<variable-name>
```

For example, to display the value of the WINDIR environment variable, type the
following command at the Windows PowerShell command prompt:

```powershell
$Env:windir
```

In this syntax, the dollar sign (\$) indicates a variable, and the drive name
indicates an environment variable.

### Changing Environment Variables

To make a persistent change to an environment variable, use System in Control
Panel (Advanced tab or the Advanced System Settings item) to store the change
in the registry.

When you change environment variables in Windows PowerShell, the change
affects only the current session. This behavior resembles the behavior of the
Set command in Windows-based environments and the Setenv command in UNIX-based
environments.

You must also have permission to change the values of the variables. If you
try to change a value without sufficient permission, the command fails, and
Windows PowerShell displays an error.

You can change the values of variables without using a cmdlet by using the
following syntax:

```powershell
$Env:<variable-name> = "<new-value>"
```

For example, to append ";c:\\temp" to the value of the Path environment
variable, use the following syntax:

```powershell
$Env:path = $env:path + ";c:\temp"
```

You can also use the Item cmdlets, such as Set-Item, Remove-Item, and
Copy-Item to change the values of environment variables. For example, to use
the Set-Item cmdlet to append ";c:\\temp" to the value of the Path environment
variable, use the following syntax:

```powershell
Set-Item -Path Env:Path -Value ($Env:Path + ";C:\Temp")
```

In this command, the value is enclosed in parentheses so that it is
interpreted as a unit.

### Saving Changes to Environment Variables

To create or change the value of an environment variable in every Windows
PowerShell session, add the change to your Windows PowerShell profile.

For example, to add the C:\\Temp directory to the Path environment variable in
every Windows PowerShell session, add the following command to your Windows
PowerShell profile.

```powershell
$Env:Path = $Env:Path + ";C:\Temp"
```

To add the command to an existing profile, such as the CurrentUser,AllHosts
profile, type:

```powershell
Add-Content -Path $Profile.CurrentUserAllHosts -Value '$Env:Path = `
$Env:Path + ";C:\Temp"'
```

### Environment Variables That Store Preferences

Windows PowerShell features can use environment variables to store user
preferences. These variables work like preference variables, but they are
inherited by child sessions of the sessions in which they are created. For
more information about preference variables, see
[about_preference_variables](about_Preference_Variables.md).

The environment variables that store preferences include:

* PSExecutionPolicyPreference

  Stores the execution policy set for the current session. This environment
  variable exists only when you set an execution policy for a single session.
  You can do this in two different ways.

  - Use PowerShell.exe to start a session at the command line and
    use its ExecutionPolicy parameter to set the execution policy for
    the session.

  - Use the Set-ExecutionPolicy cmdlet. Use the Scope parameter with
    a value of "Process".

    For more information, see [about_Execution_Policies](about_Execution_Policies.md).

* PSModulePath

  Stores the paths to the default module directories. Windows PowerShell looks
  for modules in the specified directories when you do not specify a full path
  to a module.

  The default value of $Env:PSModulePath is:

  ```
  $home\Documents\WindowsPowerShell\Modules; $pshome\Modules
  ```

Windows PowerShell sets the value of "\$pshome\\Modules" in the registry. It
sets the value of "\$home\\Documents\\WindowsPowerShell\\Modules" each time you
start Windows PowerShell.

In addition, setup programs that install modules in other directories, such as
the Program Files directory, can append their locations to the value of
PSModulePath.

To change the default module directories for the current session, use the
following command format to change the value of the PSModulePath environment
variable.

For example, to add the "C:\\Program Files\\Fabrikam\\Modules" directory to
the value of the PSModulePath environment variable, type:

```powershell
$Env:PSModulePath = $Env:PSModulePath+";C:\Program Files\Fabrikam\Modules"
```

The semi-colon (;) in the command separates the new path from the path that
precedes it in the list.

To change the value of PSModulePath in every session, add the previous command
to your Windows PowerShell profile or use the SetEnvironmentVariable method of
the Environment class.

The following command uses the GetEnvironmentVariable method to get the
machine setting of PSModulePath and the SetEnvironmentVariable method to add
the C:\\Program Files\\Fabrikam\\Modules path to the value.

```powershell
$path = [System.Environment]::GetEnvironmentVariable("PSModulePath",
 "Machine")
[System.Environment]::SetEnvironmentVariable("PSModulePath", $path +
";C:\Program Files\Fabrikam\Modules", "Machine")
```

To add a path to the user setting, change the target value to User.

```powershell
$path = [System.Environment]::GetEnvironmentVariable("PSModulePath",
 "User")
[System.Environment]::SetEnvironmentVariable("PSModulePath", $path +
";$home\Documents\Fabrikam\Modules", "User")
```

For more information about the methods of the System.Environment class, see
[Environment Methods](http://go.microsoft.com/fwlink/?LinkId=242783) in
MSDN.

You can add also add a command that changes the value to your profile or use
System in Control Panel to change the value of the PSModulePath environment
variable in the registry.

For more information, see [about_Modules](about_Modules.md).

## SEE ALSO

- [Environment (provider)](../../Microsoft.PowerShell.Core/Providers/Environment-Provider.md)
- [about_Modules](about_Modules.md)
