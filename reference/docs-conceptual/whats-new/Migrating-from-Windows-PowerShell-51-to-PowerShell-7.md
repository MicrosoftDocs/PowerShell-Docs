---
description: Update from PowerShell 5.1 to PowerShell 7 for your Windows platforms.
ms.date: 04/02/2024
title: Migrating from Windows PowerShell 5.1 to PowerShell 7
---

# Migrating from Windows PowerShell 5.1 to PowerShell 7

Designed for cloud, on-premises, and hybrid environments, PowerShell 7 is packed with enhancements
and [new features][09].

- Installs and runs side-by-side with Windows PowerShell
- Improved compatibility with existing Windows PowerShell modules
- New language features, like ternary operators and `ForEach-Object -Parallel`
- Improved performance
- SSH-based remoting
- Cross-platform interoperability
- Support for Docker containers

PowerShell 7 works side-by-side with Windows PowerShell letting you easily test and compare between
editions before deployment. Migration is simple, quick, and safe.

PowerShell 7 is supported on the following Windows operating systems:

- Windows 10, and 11
- Windows Server 2016, 2019, and 2022

PowerShell 7 also runs on macOS and several Linux distributions. For a list of supported operating
systems and information about the support lifecycle, see the [PowerShell Support Lifecycle][06].

## Installing PowerShell 7

For flexibility and to support the needs of IT, DevOps engineers, and developers, there are several
options available to install PowerShell 7. In most cases, the installation options can be reduced to
the following methods:

- Deploy PowerShell using the [MSI package][03]
- Deploy PowerShell using the [ZIP package][05]

> [!NOTE]
> The MSI package can be deployed and updated with management products such as
> [Microsoft Configuration Manager][12]. Download the packages from
> [GitHub Release page][24].

Deploying the MSI package requires Administrator permission. The ZIP package can be deployed by any
user. The ZIP package is the easiest way to install PowerShell 7 for testing, before committing to a
full installation.

You may also install PowerShell 7 via the Windows Store or `winget`. For more information about both
of these methods, see the detailed instructions in [Installing PowerShell on Windows][04].

## Using PowerShell 7 side-by-side with Windows PowerShell 5.1

PowerShell 7 is designed to coexist with Windows PowerShell 5.1. The following features ensure that
your investment in PowerShell is protected and your migration to PowerShell 7 is simple.

- Separate installation path and executable name
- Separate PSModulePath
- Separate profiles for each version
- Improved module compatibility
- New remoting endpoints
- Group policy support
- Separate Event logs

### Differences in .NET versions

PowerShell 7.4 is built on .NET 8.0. Windows PowerShell 5.1 is built on .NET Framework 4.x. The
differences between the .NET versions might affect the behavior of your scripts, especially if you
are calling .NET method directly. For more information,
[Differences between Windows PowerShell 5.1 and PowerShell 7.x][10].

### Separate installation path and executable name

PowerShell 7 installs to a new directory, enabling side-by-side execution with Windows PowerShell
5.1.

Install locations by version:

- Windows PowerShell 5.1: `$env:WINDIR\System32\WindowsPowerShell\v1.0`
- PowerShell 6.x: `$env:ProgramFiles\PowerShell\6`
- PowerShell 7: `$env:ProgramFiles\PowerShell\7`

The new location is added to your PATH allowing you to run both Windows PowerShell 5.1 and
PowerShell 7. If you're migrating from PowerShell 6.x to PowerShell 7, PowerShell 6 is removed and
the PATH replaced.

In Windows PowerShell, the PowerShell executable is named `powershell.exe`. In version 6 and above,
the executable is named `pwsh.exe`. The new name makes it easy to support side-by-side execution of
both versions.

### Separate PSModulePath

By default, Windows PowerShell and PowerShell 7 store modules in different locations. PowerShell 7
combines those locations in the `$Env:PSModulePath` environment variable. When importing a module by
name, PowerShell checks the location specified by `$Env:PSModulePath`. This allows PowerShell 7 to
load both Core and Desktop modules.

|            Install Scope            |                Windows PowerShell 5.1                 |              PowerShell 7.0              |
| ----------------------------------- | ----------------------------------------------------- | ---------------------------------------- |
| PowerShell modules                  | `$env:WINDIR\system32\WindowsPowerShell\v1.0\Modules` | `$env:ProgramFiles\PowerShell\7\Modules` |
| User installed<br>AllUsers scope    | `$env:ProgramFiles\WindowsPowerShell\Modules`         | `$env:ProgramFiles\PowerShell\Modules`   |
| User installed<br>CurrentUser scope | `$HOME\Documents\WindowsPowerShell\Modules`           | `$HOME\Documents\PowerShell\Modules`     |

The following examples show the default values of `$Env:PSModulePath` for each version.

- For Windows PowerShell 5.1:

  ```powershell
  $Env:PSModulePath -split (';')
  ```

  ```Output
  C:\Users\<user>\Documents\WindowsPowerShell\Modules
  C:\Program Files\WindowsPowerShell\Modules
  C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules
  ```

- For PowerShell 7:

  ```powershell
  $Env:PSModulePath -split (';')
  ```

  ```Output
  C:\Users\<user>\Documents\PowerShell\Modules
  C:\Program Files\PowerShell\Modules
  C:\Program Files\PowerShell\7\Modules
  C:\Program Files\WindowsPowerShell\Modules
  C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules
  ```

Notice that PowerShell 7 includes the Windows PowerShell paths and the PowerShell 7 paths to provide
autoloading of modules.

> [!NOTE]
> Additional paths may exist if you have changed the PSModulePath environment variable or installed
> custom modules or applications.

For more information, see [about_PSModulePath][17].

For more information about Modules, see [about_Modules][15].

### Separate profiles

A PowerShell profile is a script that executes when PowerShell starts. This script customizes your
environment by adding commands, aliases, functions, variables, modules, and PowerShell drives. The
profile script makes these customizations available in every session without having to manually
recreate them.

The path to the location of the profile has changed in PowerShell 7.

- In Windows PowerShell 5.1, the location of the profile is `$HOME\Documents\WindowsPowerShell`.
- In PowerShell 7, the location of the profile is `$HOME\Documents\PowerShell`.

The profile filenames have also changed:

   ```powershell
   $PROFILE | Select-Object *Host* | Format-List
  ```

  ```Output
   AllUsersAllHosts       : C:\Program Files\PowerShell\7\profile.ps1
   AllUsersCurrentHost    : C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1
   CurrentUserAllHosts    : C:\Users\<user>\Documents\PowerShell\profile.ps1
   CurrentUserCurrentHost : C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
   ```

For more information
[about_Profiles][16].

### PowerShell 7 compatibility with Windows PowerShell 5.1 modules

Most of the modules you use in Windows PowerShell 5.1 already work with PowerShell 7, including
Azure PowerShell and Active Directory. We're continuing to work with other teams to add native
PowerShell 7 support for more modules including Microsoft Graph, Office 365, and others. For the
current list of supported modules, see [PowerShell 7 module compatibility][11].

> [!NOTE]
> On Windows, we've also added a **UseWindowsPowerShell** switch to `Import-Module` to ease the
> transition to PowerShell 7 for those using incompatible modules. For more information on this
> functionality, see [about_Windows_PowerShell_Compatibility][20].

## PowerShell Remoting

PowerShell remoting lets you run any PowerShell command on one or more remote computers. You can
establish persistent connections, start interactive sessions, and run scripts on remote computers.

### WS-Management remoting

Windows PowerShell 5.1 and below use the WS-Management (WSMAN) protocol for connection negotiation
and data transport. Windows Remote Management (WinRM) uses the WSMAN protocol. If WinRM has been
enabled, PowerShell 7 uses the existing Windows PowerShell 5.1 endpoint named `Microsoft.PowerShell`
for remoting connections. To update PowerShell 7 to include its own endpoint, run the
`Enable-PSRemoting` cmdlet. For information about connecting to specific endpoints, see
[WS-Management Remoting in PowerShell][08]

To use Windows PowerShell remoting, the remote computer must be configured for remote management.
For more information, including instructions, see [About Remote Requirements][19].

For more information about working with remoting, see [About Remote][18]

### SSH-based remoting

SSH-based remoting was added in PowerShell 6.x to support other operating systems that can't use
Windows native components like **WinRM**. SSH remoting creates a PowerShell host process on the
target computer as an SSH subsystem. For details and examples on setting up SSH-based remoting on
Windows or Linux, see: [PowerShell remoting over SSH][07].

> [!NOTE]
> The PowerShell Gallery (PSGallery) contains a module and cmdlet that automatically configures
> SSH-based remoting. Install the `Microsoft.PowerShell.RemotingTools` module from the
> [PSGallery][25] and run the `Enable-SSH` cmdlet.

The `New-PSSession`, `Enter-PSSession`, and `Invoke-Command` cmdlets have new parameter sets to
support SSH connections.

```powershell
[-HostName <string>]  [-UserName <string>]  [-KeyFilePath <string>]
```

To create a remote session, specify the target computer with the **HostName** parameter and provide
the user name with **UserName**. When running the cmdlets interactively, you're prompted for a
password.

```powershell
Enter-PSSession -HostName <Computer> -UserName <Username>
```

Alternatively, when using the **HostName** parameter, provide the username information followed by
the at sign (`@`), followed by the computer name.

```powershell
Enter-PSSession -HostName <Username>@<Computer>
```

You may set up SSH key authentication using a private key file with the **KeyFilePath** parameter.
For more information, see [OpenSSH Key Management][21].

## Group Policy supported

PowerShell includes Group Policy settings to help you define consistent option values for servers in
an enterprise environment. These settings include:

- Console session configuration: Sets a configuration endpoint in which PowerShell is run.
- Turn on Module Logging: Sets the LogPipelineExecutionDetails property of modules.
- Turn on PowerShell Script Block Logging: Enables detailed logging of all PowerShell scripts.
- Turn on Script Execution: Sets the PowerShell execution policy.
- Turn on PowerShell Transcription: enables capturing of input and output of PowerShell commands
  into text-based transcripts.
- Set the default source path for Update-Help: Sets the source for Updatable Help to a directory,
  not the Internet.

For more information, see [about_Group_Policy_Settings][13].

PowerShell 7 includes Group Policy templates and an installation script in `$PSHOME`.

Group Policy tools use administrative template files (`.admx`, `.adml`) to populate policy settings
in the user interface. This allows administrators to manage registry-based policy settings. The
`InstallPSCorePolicyDefinitions.ps1` script installs PowerShell Administrative Templates on the
local machine.

```powershell
Get-ChildItem -Path $PSHOME -Filter *Core*Policy*
```

```Output
    Directory: C:\Program Files\PowerShell\7

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           2/27/2020 12:38 AM          15861 InstallPSCorePolicyDefinitions.ps1
-a---           2/27/2020 12:28 AM           9675 PowerShellCoreExecutionPolicy.adml
-a---           2/27/2020 12:28 AM           6201 PowerShellCoreExecutionPolicy.admx
```

## Separate Event Logs

Windows PowerShell and PowerShell 7 log events to separate event logs. Use the following command to
get a list of the PowerShell logs.

```powershell
Get-WinEvent -ListLog *PowerShell*
```

For more information, see [about_Logging_Windows][14].

## Improved editing experience with Visual Studio Code

[Visual Studio Code (VSCode)][22] with the [PowerShell Extension][23] is the supported scripting
environment for PowerShell 7. The Windows PowerShell Integrated Scripting Environment (ISE) only
supports Windows PowerShell.

The updated PowerShell extension includes:

- New ISE compatibility mode
- PSReadLine in the Integrated Console, including syntax highlighting, multi-line editing, and back
  search
- Stability and performance improvements
- New CodeLens integration
- Improved path autocompletion

To make the transition to Visual Studio Code easier, use the **Enable ISE Mode** function available
in the **Command Palette**. This function switches VSCode into an ISE-style layout. The ISE-style
layout gives you all the new features and capabilities of PowerShell in a familiar user experience.

To switch to the new ISE layout, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the
**Command Palette**, type `PowerShell` and select **PowerShell: Enable ISE Mode**.

To set the layout to the original layout, open the **Command Palette**, select
**PowerShell: Disable ISE Mode (restore to defaults)**.

For details about customizing the VSCode layout to ISE, see
[How to Replicate the ISE Experience in Visual Studio Code][01]

> [!NOTE]
> There are no plans to update the ISE with new features. In the latest versions of Windows 10 or
> Windows Server 2019 and higher, the ISE is now a user-uninstallable feature. There are no plans to
> permanently remove the ISE. The PowerShell Team and its partners are focused on improving the
> scripting experience in the PowerShell extension for Visual Studio Code.

## Next Steps

Armed with the knowledge to effectively migrate, [install PowerShell 7][02] now!

<!-- link references -->
[01]: ../dev-cross-plat/vscode/how-to-replicate-the-ise-experience-in-vscode.md
[02]: ../install/installing-powershell-on-windows.md
[03]: ../install/installing-powershell-on-windows.md#msi
[04]: ../install/installing-powershell-on-windows.md#winget
[05]: ../install/installing-powershell-on-windows.md#zip
[06]: ../install/powershell-support-lifecycle.md
[07]: ../security/remoting/ssh-remoting-in-powershell.md
[08]: ../security/remoting/wsman-remoting-in-powershell.md
[09]: ../whats-new/What-s-New-in-PowerShell-70.md
[10]: ./differences-from-windows-powershell.md
[11]: ./module-compatibility.md
[12]: /configmgr/apps/
[13]: /powershell/module/microsoft.powershell.core/about/about_group_policy_settings
[14]: /powershell/module/microsoft.powershell.core/about/about_logging_windows
[15]: /powershell/module/Microsoft.PowerShell.Core/About/about_Modules
[16]: /powershell/module/microsoft.powershell.core/about/about_profiles
[17]: /powershell/module/microsoft.powershell.core/about/about_psmodulepath
[18]: /powershell/module/microsoft.powershell.core/about/about_remote
[19]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[20]: /powershell/module/Microsoft.PowerShell.Core/About/about_windows_powershell_compatibility
[21]: /windows-server/administration/openssh/openssh_keymanagement
[22]: https://code.visualstudio.com/
[23]: https://code.visualstudio.com/docs/languages/powershell
[24]: https://github.com/PowerShell/PowerShell/releases
[25]: https://www.powershellgallery.com/packages/Microsoft.PowerShell.RemotingTools
