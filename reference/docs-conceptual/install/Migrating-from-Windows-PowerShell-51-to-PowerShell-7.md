---
title: Migrating from Windows PowerShell 5.1 to PowerShell 7
description: Update from PowerShell 5.1 to PowerShell 7 for your Windows platforms.
ms.date: 03/25/2020
---

# Migrating from Windows PowerShell 5.1 to PowerShell 7

Designed for cloud, on-premises, and hybrid environments, PowerShell 7 is packed with
enhancements and [new features](../whats-new/What-s-New-in-PowerShell-70.md).

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

- Windows 8.1 and 10
- Windows Server 2012, 2012 R2, 2016, and 2019

PowerShell 7 also runs on macOS and several Linux distributions. For a list of supported operating
systems and information about the support lifecycle, see the
[PowerShell Support Lifecycle](/powershell/scripting/powershell-support-lifecycle).

## Installing PowerShell 7

For flexibility and to support the needs of IT, DevOps engineers, and developers, there are several
options available to install PowerShell 7. In most cases, the installation options can be reduced to
the following methods:

- Deploy PowerShell using the [MSI package](/powershell/scripting/install/installing-powershell-core-on-windows#installing-the-msi-package)
- Deploy PowerShell using the [ZIP package](/powershell/scripting/install/installing-powershell-core-on-windows#installing-the-zip-package)

> [!NOTE]
> The MSI package can be deployed and updated with management products such as
> [System Center Configuration Manager (SCCM)](/configmgr/apps/). Download the packages from
> [GitHub Release page](https://github.com/PowerShell/PowerShell/releases).

Deploying the MSI package requires Administrator permission. The ZIP package can be deployed by any
user. The ZIP package is the easiest way to install PowerShell 7 for testing, before committing to a
full installation.

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

### Separate installation path and executable name

PowerShell 7 installs to a new directory, enabling side-by-side execution with Windows PowerShell
5.1.

Install locations by version:

- Windows PowerShell 5.1: `$env:WINDIR\System32\WindowsPowerShell\v1.0`
- PowerShell Core 6.x: `$env:ProgramFiles\PowerShell\6`
- PowerShell 7: `$env:ProgramFiles\PowerShell\7`

The new location is added to your PATH allowing you to run both Windows PowerShell 5.1 and
PowerShell 7. If you're migrating from PowerShell Core 6.x to PowerShell 7, PowerShell 6 is removed
and the PATH replaced.

In Windows PowerShell, the PowerShell executable is named `powershell.exe`. In version 6 and above,
the executable is named `pwsh.exe`. The new name makes it easy to support side-by-side execution of
both versions.

### Separate PSModulePath

By default, Windows PowerShell and PowerShell 7 store modules in different locations. PowerShell 7
combines those locations in the `$Env:PSModulePath` environment variable. When importing a module by
name, PowerShell checks the location specified by `$Env:PSModulePath`. This allows PowerShell 7 to
load both Core and Desktop modules.

|            Install Scope            |                Windows PowerShell 5.1                 |             PowerShell 7.0             |
| ----------------------------------- | ----------------------------------------------------- | -------------------------------------- |
| PowerShell modules                  | `$env:WINDIR\system32\WindowsPowerShell\v1.0\Modules` | `$PSHOME\Modules`                      |
| User installed<br>AllUsers scope    | `$env:ProgramFiles\WindowsPowerShell\Modules`         | `$env:ProgramFiles\PowerShell\Modules` |
| User installed<br>CurrentUser scope | `$HOME\Documents\WindowsPowerShell\Modules`           | `$HOME\Documents\PowerShell\Modules`   |

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

For more information, see `PSModulePath` in
[about_Environment_Variables](/powershell/module/microsoft.powershell.core/about/about_environment_variables#environment-variables-that-store-preferences).

For more information about Modules, see
[about_Modules](/powershell/module/Microsoft.PowerShell.Core/About/about_Modules).

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
   PS> $PROFILE | Select-Object *Host* | Format-List

   AllUsersAllHosts       : C:\Program Files\PowerShell\7\profile.ps1
   AllUsersCurrentHost    : C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1
   CurrentUserAllHosts    : C:\Users\<user>\Documents\PowerShell\profile.ps1
   CurrentUserCurrentHost : C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
   ```

For more information [about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles).

### PowerShell 7 compatibility with Windows PowerShell 5.1 modules

Most of the modules you use in Windows PowerShell 5.1 already work with PowerShell 7, including
Azure PowerShell and Active Directory. We're continuing to work with other teams to add native
PowerShell 7 support for more modules including Microsoft Graph, Office 365, and others. For the
current list of supported modules, see
[PowerShell 7 module compatibility](/powershell/scripting/whats-new/module-compatibility).

> [!NOTE]
> On Windows, we've also added a **UseWindowsPowerShell** switch to `Import-Module` to ease the
> transition to PowerShell 7 for those using incompatible modules. For more information on this
> functionality, see
> [about_Windows_PowerShell_Compatibility](/powershell/module/Microsoft.PowerShell.Core/About/about_windows_powershell_compatibility).

### PowerShell Remoting

PowerShell remoting lets you run any PowerShell command on one or more remote computers. You can
establish persistent connections, start interactive sessions, and run scripts on remote computers.

#### WS-Management remoting

Windows PowerShell 5.1 and below use the WS-Management (WSMAN) protocol for connection negotiation
and data transport. Windows Remote Management (WinRM) uses the WSMAN protocol. If WinRM has been
enabled, PowerShell 7 uses the existing Windows PowerShell 5.1 endpoint named `Microsoft.PowerShell`
for remoting connections. To update PowerShell 7 to include its own endpoint, run the
`Enable-PSRemoting` cmdlet. For information about connecting to specific endpoints, see
[WS-Management Remoting in PowerShell Core](/powershell/scripting/learn/remoting/wsman-remoting-in-powershell-core)

To use Windows PowerShell remoting, the remote computer must be configured for remote management.
For more information, including instructions, see
[About Remote Requirements](/powershell/module/microsoft.powershell.core/about/about_remote_requirements).

For more information about working with remoting, see
[About Remote](/powershell/module/microsoft.powershell.core/about/about_remote)

#### SSH-based remoting

SSH-based remoting was added in PowerShell Core 6.x to support other operating systems that can't
use Windows native components like **WinRM**. SSH remoting creates a PowerShell host process on the
target computer as an SSH subsystem. For details and examples on setting up SSH-based remoting on
Windows or Linux, see:
[PowerShell remoting over SSH](/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core).

> [!NOTE]
> The PowerShell Gallery (PSGallery) contains a module and cmdlet that automatically configures
> SSH-based remoting. Install the `Microsoft.PowerShell.RemotingTools` module from the
> [PSGallery](https://www.powershellgallery.com/packages/Microsoft.PowerShell.RemotingTools/0.1.0)
> and run the `Enable-SSH` cmdlet.

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
For more information, see [OpenSSH Key Management](/windows-server/administration/openssh/openssh_keymanagement).

### Group Policy supported

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

For more information, see
[about_Group_Policy_Settings](/powershell/module/microsoft.powershell.core/about/about_group_policy_settings).

PowerShell 7 includes Group Policy templates and an installation script in `$PSHOME`.

Group Policy tools use administrative template files (`.admx`, `.adml`) to populate policy settings
in the user interface. This allows administrators to manage registry-based policy settings. The
`InstallPSCorePolicyDefinitions.ps1` script installs PowerShell Core Administrative Templates on the
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

### Separate Event Logs

Windows PowerShell and PowerShell 7 log events to separate event logs. Use the following command to
get a list of the PowerShell logs.

```powershell
Get-WinEvent -ListLog *PowerShell*
```

For more information, see [about_Logging_Windows](/powershell/module/microsoft.powershell.core/about/about_logging_windows).

## Improved editing experience with Visual Studio Code

[Visual Studio Code (VSCode)](https://code.visualstudio.com/) with the
[PowerShell Extension](https://code.visualstudio.com/docs/languages/powershell) is the supported
scripting environment for PowerShell 7. The Windows PowerShell Integrated Scripting Environment
(ISE) only supports Windows PowerShell.

The updated PowerShell extension includes:

- New ISE compatibility mode
- PSReadLine in the Integrated Console, including syntax highlighting, multi-line editing, and back
  search
- Stability and performance improvements
- New CodeLens integration
- Improved path auto-completion

To make the transition to Visual Studio Code easier, use the **Enable ISE Mode** function available
in the **Command Palette**. This function switches VSCode into an ISE-style layout. The ISE-style
layout gives you all the new features and capabilities of PowerShell in a familiar user experience.

To switch to the new ISE layout, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the
**Command Palette**, type `PowerShell` and select **PowerShell: Enable ISE Mode**.

To set the layout to the original layout, open the **Command Palette**, select
**PowerShell: Disable ISE Mode (restore to defaults)**.

For details about customizing the VSCode layout to ISE, see
[How to Replicate the ISE Experience in Visual Studio Code](/powershell/scripting/components/vscode/how-to-replicate-the-ise-experience-in-vscode)

> [!NOTE]
> There are no plans to update the ISE with new features. The ISE is now a user-uninstallable feature in
> the latest versions of Windows 10 and Windows Server. There are no plans to permanently remove the
> ISE. The PowerShell Team and its partners are focused on improving the scripting experience in the
> PowerShell extension for Visual Studio Code.

## Next Steps

Armed with the knowledge to effectively migrate,
[install PowerShell 7](/powershell/scripting/install/installing-powershell-core-on-windows) now!
