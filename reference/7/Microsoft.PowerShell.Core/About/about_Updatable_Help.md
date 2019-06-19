---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Updatable_Help
---
# About Updatable Help

## SHORT DESCRIPTION
Describes the updatable help system in PowerShell.

## LONG DESCRIPTION

PowerShell provides several different ways to access the most up-to-date help
topics for PowerShell cmdlets and concepts.

The Updatable Help system, introduced in PowerShell 3.0, is designed to assure
that you always have the newest help topics on your local computer so that you
can read them at the command line. It makes it easy to download and install
help files and to update them whenever newer help files become available.

To provide updated help for multiple computers in an enterprise and for
computers that do not have access to the Internet, Updatable Help lets you
download help files to a file system directory or file share, and then install
the help files from the file share.

In PowerShell 4.0, the HelpInfoUri property is preserved over Windows
PowerShell remoting, which allows Save-Help to work for modules that are
installed on a remote computer, but are not necessarily installed on the local
computer. You can save a PSModuleInfo object to disk or removable media (such
as a USB drive) by running Export-Clixml on a computer that does not have
Internet access, importing the PSModuleInfo object on a computer that does
have Internet access, and then running Save-Help on the PSModuleInfo object.
The saved help can be copied to the remote, disconnected computer by using
removable media, and then installed by running Update-Help. These improvements
in Save-Help functionality let you install help on computers that are without
any kind of network access. For an example of how to use the new Save-Help
functionality, see "HOW TO UPDATE HELP FROM A FILE SHARE: SAVE-HELP" in this
topic.

Updatable Help also supports online access to the newest help topics and basic
help for cmdlets, even when there are no help files on the computer.

PowerShell 3.0 does not come with Help files. You can use the Updatable Help
feature to install the help files for all of the commands that are included by
default in PowerShell and for all Windows modules.

## UPDATABLE HELP CMDLETS

- Update-Help: Downloads the newest help files from the Internet or a file
  share, and installs them on the local computer.

- Save-Help: Downloads the newest help files from the Internet and saves them in
  a file system directory or file share. To install the help files on computers,
  use Update-Help.

- Get-Help: Displays help topics at the command line. Gets help from the
  help files on the computer. Displays auto-generated help for cmdlets and
  functions that do not have help files. Opens online help topics for
  cmdlets, functions, scripts, and workflows in your default Internet browser.

## UPDATE HELP IN PowerShell ISE

You can also update help by using the "Update PowerShell Help" item in the
Help menu in PowerShell Integrated Scripting Environment (ISE).

The "Update PowerShell Help" item runs an Update-Help command without
parameters.

## AUTO-GENERATED HELP: HELP WITHOUT HELP FILES

If you do not have the help file for a cmdlet, function, or workflow on the
computer, the Get-Help cmdlet displays auto-generated help and prompts you to
download the help files or read them online.

Auto-generated help includes syntax and aliases, and remarks that explain how
to use the Updatable Help cmdlets and to access the online help topics.

For example, the following command gets basic help for the Get-Culture cmdlet.
The output shows the Get-Help display when there are no help files on the
computer.

```powershell
Get-Help Get-Culture
```

```output
NAME
    Get-Culture

SYNTAX
    Get-Culture [<CommonParameters>]

ALIASES
    None

REMARKS
    To get the latest Help content including descriptions and examples
    type: Update-Help.
```

## HELP FILES FOR MODULES

The smallest unit of Updatable Help is help for a module. Module help includes
help for all of the cmdlets, functions, workflows, providers, scripts, and
concepts in a module. You can update help for all modules that are installed
on the computer, even if they are not imported into the current session.

You can update help for the entire module, but you cannot update help for
individual cmdlets.

To find the module that contains a particular cmdlet, use the following
command format:

```powershell
(Get-Command <cmdlet-name>).ModuleName
```

For example, to find the module that contains the Set-ExecutionPolicy
cmdlet, type:

```powershell
(Get-Command Set-ExecutionPolicy).ModuleName
```

To update help for a particular module, type:

```powershell
Update-Help -Module <ModuleName>
```

For example, to update help for the module that contains the
Set-ExecutionPolicy cmdlet, type:

```powershell
Update-Help -Module Microsoft.PowerShell.Security
```

## PERMISSIONS FOR UPDATABLE HELP

To update help for the modules in the \$pshome\\Modules directory, you must be
member of the Administrators group on the computer.

If you are not a member of the Administrators group, you cannot update help
for these modules; but if you have Internet access, you can view help online
in the TechNet Library.

Updating help for modules in the \$home\\Documents\\WindowsPowerShell\\Modules
directory or modules in other subdirectories of the \$home directory do not
require special permissions.

The Update-Help and Save-Help cmdlets have a UseDefaultCredentials parameter
that provides the explicit credentials of the current user. This parameter is
designed for accessing secure Internet locations.

The Update-Help and Save-Help cmdlets also have a Credential parameter that
allows you to run the command on a remote computer and access a file share on
a third computer. The Credential parameter is valid only when you use the
SourcePath or LiteralPath parameters of Update-Help and the DestinationPath or
LiteralPath parameters of Save-Help.

## HOW TO INSTALL AND UPDATE HELP FILES

To download and install help files for the first time, or to update the help
files on your computer, use the Update-Help cmdlet.

The Update-Help cmdlet does all of the hard work for you, including the
following tasks.

- Determines which modules support Updatable Help.
- Finds the Internet location where each module stores its Updatable Help files.
- Compares the help files for each module on your computer to the newest help
  files that are available for each module.
- Downloads the new files from the Internet.
- Unwraps the help file package.
- Verifies that the files are valid help files.
- Installs the help files in the language-specific subdirectory of the module
  directory.

To access the new help topics, use the Get-Help cmdlet. You do not need to
restart PowerShell.

To install or update help for all modules on the computer that supports
Updatable Help, type:

```powershell
Update-Help
```

To update help for particular modules, add the Module parameter of
Update-Help. Wildcard characters are permitted in the module name.

For example, to update help for the ServerManager module, type:

```powershell
Update-Help -Module ServerManager
```

Without parameters, Update-Help updates help for all modules in the session
and for all installed modules that support Updatable Help. To be included,
modules must be installed in directories that are listed in the value of the
PSModulePath environment variable. These are also modules that are returned by
a "Get-Help -ListAvailable" command.

If the value of the Module parameter is * (all), Update-Help attempts to
update help for all installed modules, including modules that do not support
Updatable Help. This command typically generates many errors as the cmdlet
encounters modules that do not support Updatable Help.

## HOW TO UPDATE HELP FROM A FILE SHARE:  SAVE-HELP

To support computers that are not connected to the Internet, or to control or
streamline help updating in an enterprise, use the Save-Help cmdlet. The
Save-Help cmdlet downloads help files from the Internet and saves them in a
file system directory that you specify.

Save-Help compares the help files in the specified directory to the newest
help files that are available for each module. If the directory has no help
files or newer help files are available for the module, the Save-Help cmdlet
downloads the new files from the Internet. However, it does not unwrap or
install the help files.

To install or update the help files on a computer from help files that were
saved to a file system directory, use the SourcePath parameter of the
Update-Help cmdlet. The Update-Help cmdlet identifies the newest help files,
unwraps and validates them, and installs them in the language-specific
subdirectories of the module directories.

For example, to save help for all installed modules to the \\\\Server\\Share
directory, type:

```powershell
Save-Help -DestinationPath \\Server\Share
```

Then, to update help from the \\\\Server\\Share directory, type:

```powershell
Update-Help -SourcePath \\Server\Share
```

The following examples show the use of Save-Help to save help for modules that
are not installed on the local computer. In this example, the administrator
runs Save-Help to save the help for the DhcpServer module from an
Internet-connected client computer, without installing the DhcpServer module
or DHCP Server role on the local computer.

Option 1: Run Invoke-Command to get the PSModuleInfo object for the remote
module, save it in a variable, $m, and then run Save-Help on the PSModuleInfo
object by specifying the variable $m as the module name.

```powershell
$m = Invoke-Command -ComputerName RemoteServer -ScriptBlock
{ Get-Module -Name DhcpServer -ListAvailable }
Save-Help -Module $m -DestinationPath C:\SavedHelp
```

Option 2: Open a PSSession, targeted at the computer that is running the DHCP
Server module, to get the PSModuleInfo object for the module, save it in a
variable $m, and then run Save-Help on the object that is saved in the $m
variable.

```powershell
$s = New-PSSession -ComputerName RemoteServer
$m = Get-Module -PSSession $s -Name DhcpServer -ListAvailable
Save-Help -Module $m -DestinationPath C:\SavedHelp
```

Option 3: Open a CIM session, targeted at the computer that is running the
DHCP Server module, to get the PSModuleInfo object for the module, save it in
a variable $m, and then run Save-Help on the object that is saved in the $m
variable.

```powershell
$c = New-CimSession -ComputerName RemoteServer
$m = Get-Module -CimSession $c -Name DhcpServer -ListAvailable
Save-Help -Module $m -DestinationPath C:\SavedHelp
```

In the following example, the administrator installs help for the DHCP Server
module on a computer that does not have network access.

First, run Export-Clixml to export the PSModuleInfo object to a shared folder
or to removable media.

```powershell
$m = Get-Module -Name DhcpServer -ListAvailable
Export-Clixml -Path E:\UsbFlashDrive\DhcpModule.xml -InputObject $m
```

Next, transport the removable media to a computer that has Internet access,
and then import the PSModuleInfo object with Import-Clixml. Run Save-Help to
save the Help for the imported DhcpServer module PSModuleInfo object.

```powershell
$deserialized_m = Import-Clixml E:\UsbFlashDrive\DhcpModule.xml
Save-Help -Module $deserialized_m -DestinationPath `
E:\UsbFlashDrive\SavedHelp
```

Finally, transport the removable media back to the computer that does not have
network access, and then install the help by running Update-Help.

```powershell
Update-Help -Module DhcpServer -SourcePath E:\UsbFlashDrive\SavedHelp
```

Without parameters, Save-Help downloads help for all modules in the session
and for all installed modules that support Updatable Help. To be included,
modules must be installed in directories that are listed in the value of the
PSModulePath environment variable, on either the local computer or on a remote
computer for which you want to save help. These are also modules that are
returned by running a "Get-Help -ListAvailable" command.

## HOW TO UPDATE HELP FILES IN DIFFERENT LANGUAGES

By default, the Update-Help and Save-Help cmdlets download help in the UI
culture and language that is set for Windows on the local computer. If help
files for the specified modules are not available in the local UI culture,
Update-Help and Save-Help use the Windows language fallback rules to find the
best supported language.

However, you can use the UICulture parameters of the Update-Help and Save-Help
cmdlets to download and install help files in any UI cultures in which they
are available.

For example, to save the newest help files for all modules on the session in
Japanese (Ja-jp) and French (fr-FR), type:

```powershell
Save-Help -Path \Server\Share -UICulture ja-jp, fr-fr
```

If help files for the modules are not available in the languages that you
specified, the Update-Help and Save-Help cmdlets return an error message that
lists the languages in which help for each module is available so you can
choose the alternative that best meets your needs.

## HOW TO UPDATE HELP AUTOMATICALLY

To assure that you always have the newest help files, you can add an
Update-Help command to your PowerShell profile.

An internal quota prevents the Update-Help command from running more than once
each day. To override the once-per-day maximum, use the Force parameter.

Use a command like the following one in your profile. This command updates
help for all installed modules in a background job so it doesn't disturb your
work. It uses an Out-Null command to suppress the job that is returned and any
error messages that would otherwise appear when you use the command more than
once per day.

```powershell
Start-Job {Update-Help} | Out-Null
```

You can also create a scheduled job that runs the Update-Help or Save-Help
cmdlet at any interval.

For example, the following command creates a scheduled job that runs an
Update-Help help command every Friday at 5:00 AM. To run this command, start
PowerShell with the "Run as administrator" option.

```powershell
Register-ScheduledJob -Name UpdateHelpJob -ScriptBlock {Update-Help} `
-Trigger (New-JobTrigger -Weekly -DaysOfWeek Friday -At "5:00 AM")
```

## HOW TO USE ONLINE HELP

If you cannot or choose not to update the help files on your local computer,
you can still get the newest help files online.

To open the online help topic for any cmdlet or function, use the Online
parameter of the Get-Help cmdlet.

For example, the following command opens the online help topic for the Get-Job
cmdlet in your default Internet browser:

```powershell
Get-Help Get-Job -Online
```

To get online help for a script, use the Online parameter and the full path to
the script.

The Online parameter does not work with About topics. To see the about topics
for PowerShell Core, including help topics about the PowerShell language, see
[PowerShell Core Module About Topics](about.md).

## HOW TO MINIMIZE OR PREVENT INTERNET DOWNLOADS

To minimize Internet downloads and provide Updatable Help to users who are not
connected to the Internet, use the Save-Help cmdlet. Download help from the
Internet and save it to a network share. Then, create a Group Policy setting
or scheduled job that runs an Update-Help command on all computers. Set the
value of the SourcePath parameter of the Update-Help cmdlet to the network
share.

To prevent users who have Internet access from downloading Updatable Help from
the Internet, use the "Set the default source path for Update-Help" Group
Policy setting.

This Group Policy setting implicitly adds the SourcePath parameter, with the
file system location that you specify, to every Update-Help command on every
affected computer. Users can use the SourcePath parameter explicitly to
specify a different file system location, but they cannot exclude the
SourcePath parameter and download help from the Internet.

NOTE: The "Set the default source path for Update-Help" group policy setting
appears under Computer Configuration and User Configuration. However, only the
policy setting under Computer Configuration is effective. The policy setting
under User Configuration is ignored.

For more information, see [about_Group_Policy_Settings](about_Group_Policy_Settings.md).

## HOW TO UPDATE HELP FOR NON-STANDARD MODULES

To update or save help for a module that is not returned by the ListAvailable
parameter of the Get-Module cmdlet, import the module into the current session
before running an Update-Help or Save-Help command. On a remote computer,
before running the Save-Help command, import the module into the current CIM
or PSSession--or Invoke-Command script block-- that is connected to the remote
computer.

When the module is in the current session, run the Update-Help or Save-Help
cmdlets without parameters, or use the Module parameter to specify the module
name.

The Module parameters of the Update-Help and Save-Help cmdlets accept only a
module name. They do not accept the path to a module file.

Use this technique to update or save help for any module that is not returned
by the ListAvailable parameter of the Get-Module cmdlet, such as a module that
is installed in a location that is not listed in the PSModulePath environment
variable, or a module that is not well-formed (the module directory does not
contain at least one file whose base name is the same as the directory name).

## HOW TO SUPPORT UPDATABLE HELP

If you author a module, you can support online help and Updatable Help for
your modules. For more information, see "Supporting Updatable Help" and
[Supporting Online Help](/powershell/developer/module/supporting-online-help) in the Microsoft Docs.

Updatable help not available for PowerShell snap-ins or comment-based help.

## REMARKS

The Update-Help and Save-Help cmdlets are not supported on Windows
Preinstallation Environment (Windows PE).

## SEE ALSO

[Get-Help](../Get-Help.md)

[Save-Help](../Save-Help.md)

[Update-Help](../Update-Help.md)