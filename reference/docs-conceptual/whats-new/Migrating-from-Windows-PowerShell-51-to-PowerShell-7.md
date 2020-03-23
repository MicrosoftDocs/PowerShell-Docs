---
title: Migrating from Windows PowerShell 5.1 to PowerShell 7
description: Migrate to PowerShell 7 with these helpful notes
ms.date: 03/25/2020
---

# Migrating from Windows PowerShell 5.1 to PowerShell 7

PowerShell 7 is a cross-platform (Windows, Linux, and macOS) automation tool and configuration
framework optimized for dealing with structured data, REST APIs, and object models. PowerShell
includes a command-line shell, object-oriented scripting language, and a set of tools for executing
scripts/cmdlets and managing modules. Designed for Cloud, Hybrid-Cloud and on-premises, the latest
release of PowerShell is packed with performance enhancements and features over previous versions.

Migrate with minimal investment time and lower the risk of failure. PowerShell 7 is designed to work
fully side-by-side with Windows PowerShell letting you easily and quickly test and compare before
deployment.

## PowerShell 7 Supported on Windows

PowerShell 7 is ready to deploy for Microsoft Windows client and server operating systems.
PowerShell 7 is supported on the following Windows operating systems:

- Windows 8.1, and 10
- Windows Server 2012, 2012 R2, 2016, and 2019

For more information about the supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle](/powershell/scripting/powershell-support-lifecycle?view=powershell-7).

## Installing PowerShell 7?

To support the needs and flexibility requirements of IT, DevOps and Development, there are several
options for installing PowerShell 7. For most administrators working with Windows client or server,
you can reduce the installation options to the two below:

1. To install PowerShell 7 on your Windows client 8.1/10 computer, open the Microsoft Store and
   enter `PowerShell 7` in the search bar.

2. To deploy to Windows Server, get the binary **.msi** or **.zip** package. You can download the
   packages from [GitHub Release page](https://github.com/PowerShell/PowerShell/releases).

> [!NOTE]
> The **.msi** package is updated and supported with management products such as Microsoft
> System Center Configuration Manager (SCCM)

For details on installing PowerShell 7 on Windows, macOS or Linux, see [Installing PowerShell](https://aka.ms/Get-PowerShell)

## Running PowerShell 7

PowerShell 7 installs in a new directory on Microsoft Windows to permit side-by-side execution with
Windows PowerShell 5.1. The new installation directory is added to your path allowing you to execute
both Windows PowerShell and PowerShell 7. If your migrating from PowerShell Core 6.x to PowerShell
7, the installation is upgraded and the path replaced.

PowerShell 7 installation path is added to Microsoft Windows:

- Windows PowerShell 5.1 : `C:\Windows\System32\WindowsPowerShell\v1.0` will add
`%programfiles%\PowerShell\7`

- PowerShell Core 6.x on Windows: `%programfiles%\PowerShell\6` is upgraded to
 `%programfiles%\PowerShell\7`

In Windows PowerShell, the executable to launch PowerShell is named `powershell.exe`. In version 6
and above, the executable is changed to support side-by-side execution. The new executable to launch
PowerShell 7 is `pwsh.exe`. Preview builds will remain in-place as `pwsh-preview` instead of `pwsh`
under the 7-preview directory.

## Modules and Module paths

PowerShell 7 on Microsoft Windows combines the Windows PowerShell Module paths and the new
PowerShell 7 paths to provide autoloading of both Core and Desktop modules. By default, Windows
PowerShell and PowerShell 7 have different `$Env:PSModulePath` values except for
`%WINDIR%\system32\WindowsPowerShell\v1.0\Modules` module path which is shared by both.

`$Env:PSModulePath` stores the paths to the default module directories. When importing a module,
PowerShell checks the specified directories when a full path to the module is not specified. When
starting a version of PowerShell, the `$Env:PSModulePath` reflects the module search path and only
includes path segments appropriate for the version of PowerShell being started.

> [!NOTE]
> PowerShell sets the value of `$PSHOME\Modules` in the registry. It sets the value of
> `$HOME\Documents\PowerShell\Modules` each time you start PowerShell.

The default value of Windows PowerShell `$Env:PSModulePath` on Windows is:

```powershell
$nv:PSModulePath -split (';')
```

```output
C:\Users\<user>\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules
```

The default value of PowerShell 7 `$Env:PSModulePath` on Windows combines the Windows PowerShell
paths and the PowerShell 7 paths to provide autoloading of modules:

```powershell
$nv:PSModulePath -split (';')
```

```output
C:\Users\<user>\Documents\PowerShell\Modules
C:\Program Files\PowerShell\Modules
C:\Program Files\PowerShell\7\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules
```

> [!NOTE]
> Additional paths may exist if the user has added custom modules or applications that
> impact the path. You will notice additional paths if a user has modified the path through the
> registry or **Environment Variables** in **System Settings**.

For more information, see `PSModulePath` in [about_Environment_Variables](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7)

for more information about Modules, see [about_Modules](https://github.com/MicrosoftDocs/PowerShell-Docs/blob/staging/reference/7.0/Microsoft.PowerShell.Core/About/about_Modules.md)

## What Windows PowerShell 5.1 Modules are compatible with PowerShell 7?

Most of the modules you experience in Windows PowerShell 5.1 already work with PowerShell 7, including:

- Azure PowerShell (Az.*)
- Active Directory
- Many of the modules in Windows 10 and Windows Server (check with `Get-Module -ListAvailable`)

For the current list of supported modules, see [PowerShell 7 module compatability](/powershell/scripting/whats-new/module-compatibility?view=powershell-7).

[!NOTE]
> On Windows, we've also added a **UseWindowsPowerShell** switch to Import-Module to ease the
> transition to PowerShell 7 for those using incompatible modules. This switch creates a proxy
> module in PowerShell 7 that uses a local Windows PowerShell process to implicitly run any cmdlets
> contained in that module. For more information on this functionality, check out the Import-Module
> documentation.

For those modules still incompatible, we're working with a number of teams to add native PowerShell
7 support, including Microsoft Graph, Office 365, and more.

Azure Cloud Shell has already been updated to use PowerShell 7, and others like the .NET Core SDK
Docker container images and Azure Functions will be updated soon.

## Where is the ISE (Integrated Scripting Environment)?

The Windows PowerShell Integrated Scripting Environment (ISE) is only supported in Windows
PowerShell. To support the growing needs of the automation and scripting community, along with
DevOps and developers, we recommend [Visual Studio Code (VSCode)](https://code.visualstudio.com/)
and the [PowerShell Extension](https://code.visualstudio.com/docs/languages/powershell) for writing
and debugging scripts and modules.

To make the transition to Visual Studio Code easier, use the **Enable ISE Mode** function available
in the the Command Palette. This function switches VSCode into an ISE-style layout. The ISE-style
layout give you all the new features and capabilities of PowerShell in a familiar user experience.

To switch between the default layout and the new ISE layout, press;

+ <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>

Type and select: **PowerShell:Enable ISE Mode**

To set the layout to the original VSCode layout, open the Command Palette, type and select
**PowerShell: Disable ISE Mode (restore to defaults)**

For details about customizing the VSCode layout to ISE, see
[How to Replicate the ISE Experience in Visual Studio Code](/powershell/scripting/components/vscode/how-to-replicate-the-ise-experience-in-vscode)

> [!NOTE]
> The PowerShell Team and its partners are actively working to improve the scripting
> experience in the PowerShell extension for VSCode. We currently have no plans to update the ISE
> with new features. In the latest versions of Windows 10 and Windows Server, the ISE is now a
> user-uninstallable feature. We have no plans to make the ISE unavailable in the future.

## Profiles

A PowerShell profile is a script that executes when PowerShell starts. You can use the profile as a
logon script to customize the environment. You can add commands, aliases, functions, variables,
snap-ins, modules, and PowerShell drives. You can also add other session-specific elements to your
profile so they are available in every session without having to import or re-create them. Profiles
don't exist until you create them.

The path to the location of the profile has changed in PowerShell 7 and is reflected in the variable
**$PROFILE**. In Windows PowerShell 5.1, the location of the path and the name of the profile is
`$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`.

In PowerShell 7 the path has been changed to reflect the change in the product name from
`Windows PowerShell` to `PowerShell` and is
`$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.

For more information about
[Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7).

## PowerShell Remoting

PowerShell remoting lets you run any PowerShell command on one or more remote computers. You can
establish persistent connections, start interactive sessions, and run scripts on remote computers.

### WS-Management remoting

Windows PowerShell 5.1 and below use the `WS-Management` protocol for connection
negotiation and data transport. If remoting has been
enabled, installing PowerShell 7 will use the existing **WinRM** configuration.

> [!NOTE]
> PowerShell 7 will use the existing Windows PowerShell 5.1 endpoint for remoting
> connections. To update PowerShell 7 to include it own endpoint, run the
> `Install-PowerShellRemoting.ps1` located in **$PSHOME**. For information about connecting to
> specific endpoints, see
> [WS-Management Remoting in PowerShell Core](/powershell/scripting/learn/remoting/wsman-remoting-in-powershell-core?view=powershell-7)

To use Windows PowerShell remoting, the remote computer must be configured for remote management.
For more information, including instructions, see
[About Remote Requirements](/powershell/module/microsoft.powershell.core/about/about_remote_requirements?view=powershell-7).

For more information about working with remoting, see [About Remote](/powershell/module/microsoft.powershell.core/about/about_remote?view=powershell-7)

### SSH-based remoting

Starting with PowerShell Core 6.x to include cross-platform operating systems that can't use a
Windows native components like **WinRM**, **SSH-based** remoting is now available to support
cross-platform management.

SSH remoting creates a PowerShell host process on the target computer as an SSH subsystem. For
details and examples on setting up Windows or Linux for SSH-based remoting, see:
[PowerShell remoting over SSH](/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7).

> [!NOTE]
> The PowerShell Gallery (PSGallery) contains a module and cmdlet that will automatically
> configure **SSH-based** remoting. You can install the `Microsoft.PowerShell.RemotingTools` module
> from
> [PSGallery](https://www.powershellgallery.com/packages/Microsoft.PowerShell.RemotingTools/0.1.0) >
> and execute the `Enable-SSH` cmdlet.

The `New-PSSession`, `Enter-PSSession`, and `Invoke-Command` cmdlets now have a new parameter set to
support this new remoting connection.

```powershell
[-HostName <string>]  [-UserName <string>]  [-KeyFilePath <string>]
```

To create a remote session, specify the target computer with the **HostName** parameter and provide
the user name with **UserName**. When running the cmdlets interactively, you're prompted for a
password.

```powershell
Enter-PSSession -HostName <Computer> -UserName <Username>
```

Alternatively, When using the **HostName** parameter, provide the username information followed by
the **@** sign, followed by the computer name.

```powershell
Enter-PSSession -HostName <Username>@<Computer>
```

You may setup **SSH** key authentication using a private key file with the KeyFilePath parameter.
For more information, see;
[OpenSSH Key Management](https://docs.microsoft.com/windows-server/administration/openssh/openssh_keymanagement).