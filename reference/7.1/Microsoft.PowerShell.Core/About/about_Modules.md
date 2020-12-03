---
description: Explains how to install, import, and use PowerShell modules.
Locale: en-US
ms.date: 12/03/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Modules
---
# About Modules

## Short Description
Explains how to install, import, and use PowerShell modules.

## Long Description

A module is a package that contains PowerShell members, such as cmdlets,
providers, functions, workflows, variables, and aliases.

People who write commands can use modules to organize their commands and share
them with others. People who receive modules can add the commands in the
modules to their PowerShell sessions and use them just like the built-in
commands.

This topic explains how to use PowerShell modules. For information about how to
write PowerShell modules, see
[Writing a PowerShell Module](/powershell/scripting/developer/module/writing-a-windows-powershell-module).

## What Is a Module?

A module is a package that contains PowerShell members, such as cmdlets,
providers, functions, workflows, variables, and aliases. The members of this
package can be implemented in a PowerShell script, a compiled DLL, or a
combination of both. These files are usually grouped together in a single
directory. For more information, see
[Understanding a Windows PowerShell Module](/powershell/scripting/developer/module/understanding-a-windows-powershell-module)
in the SDK documentation.

## Module Auto-Loading

Beginning in PowerShell 3.0, PowerShell imports modules automatically the first
time that you run any command in an installed module. You can now use the
commands in a module without any set-up or profile configuration, so there's no
need to manage modules after you install them on your computer.

The commands in a module are also easier to find. The `Get-Command` cmdlet now
gets all commands in all installed modules, even if they are not yet in the
session. You can find a command and use it without importing needing to import
the module first.

Each of the following examples cause the CimCmdlets module, which contains
`Get-CimInstance`, to be imported into your session.

- Run the Command

  ```powershell
  Get-CimInstance Win32_OperatingSystem
  ```

- Get the Command

  ```powershell
  Get-Command Get-CimInstance
  ```

- Get Help for the Command

  ```powershell
  Get-Help Get-CimInstance
  ```

`Get-Command` commands that include a wildcard character (`*`) are considered to
be for discovery, not use, and do not import any modules.

Only modules that are stored in the location specified by the PSModulePath
environment variable are automatically imported. Modules in other locations
must be imported by running the `Import-Module` cmdlet.

Also, commands that use PowerShell providers do not automatically import a
module. For example, if you use a command that requires the WSMan: drive, such
as the `Get-PSSessionConfiguration` cmdlet, you might need to run the
`Import-Module` cmdlet to import the **Microsoft.WSMan.Management** module that
includes the `WSMan:` drive.

You can still run the `Import-Module` command to import a module and use the
`$PSModuleAutoloadingPreference` variable to enable, disable and configure
automatic importing of modules. For more information, see
[about_Preference_Variables](about_Preference_Variables.md).

## How to Use a Module

To use a module, perform the following tasks:

1. Install the module. (This is often done for you.)
1. Find the commands that the module added.
1. Use the commands that the module added.

This topic explains how to perform these tasks. It also includes other useful
information about managing modules.

## How to Install a Module

If you receive a module as a folder with files in it, you need to install it on
your computer before you can use it in PowerShell.

Most modules are installed for you. PowerShell comes with several preinstalled
modules, sometimes called the _core_ modules. On Windows-based computers, if
features that are included with the operating system have cmdlets to manage
them, those modules are preinstalled. When you install a Windows feature, by
using, for example, the Add Roles and Features Wizard in Server Manager, or the
Turn Windows features on or off dialog box in Control Panel, any PowerShell
modules that are part of the feature are installed. Many other modules come in
an installer or Setup program that installs the module.

Use the following command to create a **Modules** directory for the current
user:

```powershell
New-Item -Type Directory -Path $HOME\Documents\PowerShell\Modules
```

Copy the entire module folder into the Modules directory. You can use any
method to copy the folder, including Windows Explorer and Cmd.exe, as well as
PowerShell. In PowerShell use the `Copy-Item` cmdlet. For example, to copy the
MyModule folder from `C:\ps-test\MyModule` to the Modules directory, type:

```powershell
Copy-Item -Path C:\ps-test\MyModule -Destination `
    $HOME\Documents\PowerShell\Modules
```

You can install a module in any location, but installing your modules in a
default module location makes them easier to manage. For more information about
the default module locations, see the
[Module and DSC Resource Locations, and PSModulePath](#module-and-dsc-resource-locations-and-psmodulepath)
section.

## How to Find Installed Modules

To find modules that are installed in a default module location, but not yet
imported into your session, type:

```powershell
Get-Module -ListAvailable
```

To find the modules that have already been imported into your session, at the
PowerShell prompt, type:

```powershell
Get-Module
```

For more information about the `Get-Module` cmdlet, see
[Get-Module](xref:Microsoft.PowerShell.Core.Get-Module).

## How to Find the Commands in a Module

Use the `Get-Command` cmdlet to find all available commands. You can use the
parameters of the `Get-Command` cmdlet to filter commands such as by module,
name, and noun.

To find all commands in a module, type:

```powershell
Get-Command -Module <module-name>
```

For example, to find the commands in the BitsTransfer module, type:

```powershell
Get-Command -Module BitsTransfer
```

For more information about the `Get-Command` cmdlet, see
[Get-Command](xref:Microsoft.PowerShell.Core.Get-Command).

## How to Get Help for the Commands in a Module

If the module contains Help files for the commands that it exports, the
`Get-Help` cmdlet will display the Help topics. Use the same `Get-Help` command
format that you would use to get help for any command in PowerShell.

Beginning in PowerShell 3.0, you can download Help files for a module and
download updates to the Help files so they are never obsolete.

To get help for a commands in a module, type:

```powershell
Get-Help <command-name>
```

To get help online for command in a module, type:

```powershell
Get-Help <command-name> -Online
```

To download and install the help files for the commands in a module, type:

```powershell
Update-Help -Module <module-name>
```

For more information, see [Get-Help](xref:Microsoft.PowerShell.Core.Get-Help)
and [Update-Help](xref:Microsoft.PowerShell.Core.Update-Help).

## How to Import a Module

You might have to import a module or import a module file. Importing is
required when a module is not installed in the locations specified by the
**PSModulePath** environment variable, `$env:PSModulePath`, or the module
consists of file, such as a .dll or .psm1 file, instead of typical module that
is delivered as a folder.

You might also choose to import a module so that you can use the parameters of
the `Import-Module` command, such as the Prefix parameter, which adds a
distinctive prefix to the noun names of all imported commands, or the
**NoClobber** parameter, which prevents the module from adding commands that
would hide or replace existing commands in the session.

To import modules, use the `Import-Module` cmdlet.

To import modules in a PSModulePath location into the current session, use the
following command format.

```powershell
Import-Module <module-name>
```

For example, the following command imports the BitsTransfer module into the
current session.

```powershell
Import-Module BitsTransfer
```

To import a module that is not in a default module location, use the fully
qualified path to the module folder in the command.

For example, to add the TestCmdlets module in the `C:\ps-test` directory to
your session, type:

```powershell
Import-Module C:\ps-test\TestCmdlets
```

To import a module file that is not contained in a module folder, use the fully
qualified path to the module file in the command.

For example, to add the TestCmdlets.dll module in the `C:\ps-test` directory to
your session, type:

```powershell
Import-Module C:\ps-test\TestCmdlets.dll
```

For more information about adding modules to your session, see
[Import-Module](xref:Microsoft.PowerShell.Core.Import-Module).

## How to Import a Module into Every Session

The `Import-Module` command imports modules into your current PowerShell
session. To import a module into every PowerShell session that you start, add
the `Import-Module` command to your PowerShell profile.

For more information about profiles, see [about_Profiles](about_Profiles.md).

## How to Remove a Module

When you remove a module, the commands that the module added are deleted from
the session.

To remove a module from your session, use the following command format.

```powershell
Remove-Module <module-name>
```

For example, the following command removes the BitsTransfer module from the
current session.

```powershell
Remove-Module BitsTransfer
```

Removing a module reverses the operation of importing a module. Removing a
module does not uninstall the module. For more information, see
[Remove-Module](xref:Microsoft.PowerShell.Core.Remove-Module).

## Module and DSC Resource Locations, and PSModulePath

The `$env:PSModulePath` environment variable contains a list of folder
locations that are searched to find modules and resources.

By default, the effective locations assigned to `$env:PSModulePath` are:

- System-wide locations: `$PSHOME\Modules`

  These folders contain modules that ship with Windows and PowerShell.

  DSC resources that are included with PowerShell are stored in the
  `$PSHOME\Modules\PSDesiredStateConfiguration\DSCResources` folder.

- User-specific modules: These are modules installed by the user in the user's
  scope. `Install-Module` has a **Scope** parameter that allows you to specify
  whether the module is installed for the current user or for all users. For
  more information, see [Install-Module](xref:PowerShellGet.Install-Module).

  The user-specific **CurrentUser** location on Windows is the
  `PowerShell\Modules` folder located in the **Documents** location in your
  user profile. The specific path of that location varies by version of Windows
  and whether or not you are using folder redirection. Microsoft OneDrive can
  also change the location of your **Documents** folder.

  By default, on Windows 10, that location is
  `$HOME\Documents\PowerShell\Modules`. On Linux or Mac, the **CurrentUser**
  location is `$HOME/.local/share/powershell/Modules`.

  > [!NOTE]
  > You can verify the location of your **Documents** folder using the
  > following command: `[Environment]::GetFolderPath('MyDocuments')`.

- The **AllUsers** location is `$env:PROGRAMFILES\PowerShell\Modules` on
  Windows. On Linux or Mac the modules are stored at
  `/usr/local/share/powershell/Modules`.

> [!NOTE]
> To add or change files in the `$env:Windir\System32` directory, start
> PowerShell with the **Run as administrator** option.

You can change the default module locations on your system by changing the
value of the **PSModulePath** environment variable, `$Env:PSModulePath`. The
**PSModulePath** environment variable is modeled on the Path environment
variable and has the same format.

To view the default module locations, type:

```powershell
$Env:PSModulePath
```

To add a default module location, use the following command format.

```powershell
$Env:PSModulePath = $Env:PSModulePath + ";<path>"
```

The semi-colon (`;`) in the command separates the new path from the path that
precedes it in the list.

For example, to add the `C:\ps-test\Modules` directory, type:

```powershell
$Env:PSModulePath + ";C:\ps-test\Modules"
```

To add a default module location on Linux or MacOS, use the following command
format:

```powershell
$Env:PSModulePath += ":<path>"
```

For example, to add the `/usr/local/Fabrikam/Modules` directory to the value of
the **PSModulePath** environment variable, type:

```powershell
$Env:PSModulePath += ":/usr/local/Fabrikam/Modules"
```

On Linux or MacOS, the colon (`:`) in the command separates the new path from the
path that precedes it in the list.

When you add a path to **PSModulePath**, `Get-Module` and `Import-Module`
commands include modules in that path.

The value that you set affects only the current session. To make the change
persistent, add the command to your PowerShell profile or use System in Control
Panel to change the value of the **PSModulePath** environment variable in the
registry.

Also, to make the change persistent, you can also use the
**SetEnvironmentVariable** method of the **System.Environment** class to add a
Path to the **PSModulePath** environment variable.

For more information about the **PSModulePath** variable, see
[about_Environment_Variables](about_Environment_Variables.md).

## Modules and Name Conflicts

Name conflicts occur when more than one command in the session has the same
name. Importing a module causes a name conflict when commands in the module
have the same names as commands or items in the session.

Name conflicts can result in commands being hidden or replaced.

### Hidden

A command is hidden when it is not the command that runs when you type the
command name, but you can run it by using another method, such as by qualifying
the command name with the name of the module or snap-in in which it originated.

### Replaced

A command is replaced when you cannot run it because it has been overwritten by
a command with the same name. Even when you remove the module that caused the
conflict, you cannot run a replaced command unless you restart the session.

`Import-Module` might add commands that hide and replace commands in the
current session. Also, commands in your session can hide commands that the
module added.

To detect name conflicts, use the **All** parameter of the `Get-Command`
cmdlet. Beginning in PowerShell 3.0, `Get-Command` gets only that commands that
run when you type the command name. The **All** parameter gets all commands
with the specific name in the session.

To prevent name conflicts, use the **NoClobber** or **Prefix** parameters of
the `Import-Module` cmdlet. The **Prefix** parameter adds a prefix to the names
of imported commands so that they are unique in the session. The **NoClobber**
parameter does not import any commands that would hide or replace existing
commands in the session.

You can also use the **Alias**, **Cmdlet**, **Function**, and **Variable**
parameters of `Import-Module` to select only the commands that you want to
import, and you can exclude commands that cause name conflicts in your session.

Module authors can prevent name conflicts by using the **DefaultCommandPrefix**
property of the module manifest to add a default prefix to all command names.
The value of the **Prefix** parameter takes precedence over the value of
**DefaultCommandPrefix**.

Even if a command is hidden, you can run it by qualifying the command name with
the name of the module or snap-in in which it originated.

The PowerShell command precedence rules determine which command runs when the
session includes commands with the same name.

For example, when a session includes a function and a cmdlet with the same
name, PowerShell runs the function by default. When the session includes
commands of the same type with the same name, such as two cmdlets with the same
name, by default, it runs the most recently added command.

For more information, including an explanation of the precedence rules and
instructions for running hidden commands, see
[about_Command_Precedence](about_Command_Precedence.md).

## Modules and Snap-ins

You can add commands to your session from modules and snap-ins. Modules can add
all types of commands, including cmdlets, providers, and functions, and items,
such as variables, aliases, and PowerShell drives. Snap-ins can add only
cmdlets and providers.

Before removing a module or snap-in from your session, use the following
commands to determine which commands will be removed.

To find the source of a cmdlet in your session, use the following command
format:

```powershell
Get-Command <cmdlet-name> | Format-List -Property verb,noun,pssnapin,module
```

For example, to find the source of the `Get-Date` cmdlet, type:

```powershell
Get-Command Get-Date | Format-List -Property verb,noun,module
```

## Module-related Warnings and Errors

The commands that a module exports should follow the PowerShell command naming
rules. If the module that you import exports cmdlets or functions that have
unapproved verbs in their names, the `Import-Module` cmdlet displays the
following warning message.

> WARNING: Some imported command names include unapproved verbs which might
> make them less discoverable. Use the Verbose parameter for more detail or
> type Get-Verb to see the list of approved verbs.

This message is only a warning. The complete module is still imported,
including the non-conforming commands. Although the message is displayed to
module users, the naming problem should be fixed by the module author.

To suppress the warning message, use the **DisableNameChecking** parameter of
the `Import-Module` cmdlet.

## Built-in Modules and Snap-ins

In PowerShell 2.0 and in older-style host programs in PowerShell 3.0 and later,
the core commands that are installed with PowerShell are packaged in snap-ins
that are added automatically to every PowerShell session.

Beginning in PowerShell 3.0, for host programs that implement the
`InitialSessionState.CreateDefault2` initial session state API the
Microsoft.PowerShell.Core snap-in is added to every session by default. Modules
are loaded automatically on first-use.

> [!NOTE]
> Remote sessions, including sessions that are started by using the
> `New-PSSession` cmdlet, are older-style sessions in which the built-in
> commands are packaged in snap-ins.

The following modules (or snap-ins) are installed with PowerShell.

- CimCmdlets
- Microsoft.PowerShell.Archive
- Microsoft.PowerShell.Core
- Microsoft.PowerShell.Diagnostics
- Microsoft.PowerShell.Host
- Microsoft.PowerShell.Management
- Microsoft.PowerShell.Security
- Microsoft.PowerShell.Utility
- Microsoft.WSMan.Management
- PackageManagement
- PowerShellGet
- PSDesiredStateConfiguration
- PSDiagnostics
- PSReadline

## Logging Module Events

Beginning in PowerShell 3.0, you can record execution events for the cmdlets
and functions in PowerShell modules and snap-ins by setting the
**LogPipelineExecutionDetails** property of modules and snap-ins to `$True`.
You can also use a Group Policy setting, Turn on Module Logging, to enable
module logging in all PowerShell sessions. For more information, see the
logging and group policy articles.

## See Also

[about_Logging_Windows](about_Logging_Windows.md)

[about_Logging_Non-Windows](about_Logging_Non-Windows.md)

[about_Group_Policy_Settings](about_Group_Policy_Settings.md)

[about_Command_Precedence](about_Command_Precedence.md)

[about_Group_Policy_Settings](about_Group_Policy_Settings.md)

[Get-Command](xref:Microsoft.PowerShell.Core.Get-Command)

[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help)

[Get-Module](xref:Microsoft.PowerShell.Core.Get-Module)

[Import-Module](xref:Microsoft.PowerShell.Core.Import-Module)

[Remove-Module](xref:Microsoft.PowerShell.Core.Remove-Module)
