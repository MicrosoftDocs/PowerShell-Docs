---
title: Migrating from Windows PowerShell 5.1 to PowerShell 7
description: Migrate to PowerShell 7 with these helpful notes
ms.date: 03/11/2020
---

# Migrating from Windows PowerShell 5.1 to PowerShell 7

PowerShell 7 is designed to work fully side-by-side with Windows PowerShell. Migrating to PowerShell
7 won't interfere with your existing work, freely letting you experiment and transition to
PowerShell 7.

## Where can I Install PowerShell?

PowerShell 7 is ready to deploy for Microsoft Windows client and server. Together with Microsoft
Windows, PowerShell 7 will support you on cross-platforms macOS and Linux. See below for the
currently supported operating systems.

PowerShell 7 currently supports the following operating systems on x64, including:

- Windows 8.1, and 10
- Windows Server 2012, 2012 R2, 2016, and 2019
- macOS 10.13+
- Red Hat Enterprise Linux (RHEL) / CentOS 7
- Fedora 30+
- Debian 9
- Ubuntu LTS 16.04+
- Alpine Linux 3.8+

Additionally, PowerShell 7.0 supports ARM32 and ARM64 flavors of Debian, Ubuntu, and ARM64 Alpine
Linux.

> [!NOTE] Debian 10 and CentOS 8 currently do not support WinRM remoting. For details on setting up
> SSH-based remoting, see
> [PowerShell Remoting over SSH](/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7).

For more up-to-date information about supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle](/powershell/scripting/powershell-support-lifecycle?view=powershell-7).

## How do I install PowerShell 7?

To support the needs and flexibility requirements of the IT, DevOps and Development, there are
several options for obtaining methods PowerShell 7. Choose the option that best suits your needs.

To get PowerShell 7 on your Windows 10 laptop, open the Microsoft Store and enter **PowerShell 7**
in the search bar. This will use an MSIX package to install PowerShell 7.

If you already have experience installing PowerShell Core or one of the previews, or need to deploy
PowerShell 7 to servers, get the binary (.zip, .msi, .deb, .rpm) for your operating system. You can
download the binaries from the
[GitHub Release page](https://github.com/PowerShell/PowerShell/releases).

If this is your first time installing PowerShell, check the installation instructions for your
preferred operating system:

[Windows](/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7),
[macOS](/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-7),
or
[Linux](/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7).

While not officially supported, the community has also provided packages for
[Arch](https://aur.archlinux.org/packages/powershell/) and Kali Linux.

Additionally, you may want to use one of our many Docker container images. For more information, see
[PowerShell-Docker](https://hub.docker.com/_/microsoft-powershell) repo.

## Running PowerShell 7

PowerShell 7 installs in a new directory on Microsoft Windows to permit side-by-side execution with
Windows PowerShell 5.1. The new installation directory is added to your path allowing you to execute
both Windows PowerShell and PowerShell 7. If your migrating from PowerShell Core 6.x to PowerShell
7, the installation is upgraded and the path replaced.

PowerShell 7 installation path is added to Microsoft Windows:

- Windows PowerShell 5.1 : `C:\Windows\System32\WindowsPowerShell\v1.0` will add
`%programfiles%\PowerShell\7`

PowerShell 7 will upgrade previous versions of PowerShell Core 6.x:

- PowerShell Core 6.x on Windows: `%programfiles%\PowerShell\6` will be replaced by
 `%programfiles%\PowerShell\7`
- Linux: `/opt/microsoft/powershell/6` will be replaced by
`/opt/microsoft/powershell/7`
- macOS: `/usr/local/microsoft/powershell/6` will be replaced by
`/usr/local/microsoft/powershell/7`

> [!NOTE]
> In Windows PowerShell, the executable to launch PowerShell is named `powershell.exe`. In version 6
> and above, the executable is changed to support side-by-side execution. The new executable to
> launch PowerShell 7 is `pwsh.exe`. Preview builds will remain in-place as `pwsh-preview` instead
> of `pwsh` under the 7-preview directory.

## Modules and Module paths

PowerShell 7 on Microsoft Windows combines new module path locations, with those from Windows
PowerShell, to provide easy importing of both Core and Desktop modules. By default, Windows
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
> PowerShell 7 on Windows adds the module path for Windows PowerShell to permit the
> autoloading of modules from Windows PowerShell.

### Starting Windows PowerShell from PowerShell 7

PowerShell 7 on Microsoft Windows combines new module path locations needed for PowerShell 7 with
those from Windows PowerShell to provide easy importing of both Core and Desktop modules. This
includes adding or removing additional module paths created by applications or the user. When
running Windows PowerShell from PowerShell 7, only the paths needed for Windows PowerShell modules
are added.

PowerShell 7 path on Windows before starting Windows PowerShell:

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

Windows PowerShell path after starting `powershell` from PowerShell 7:

```powershell
powershell
$nv:PSModulePath -split (';')
```

```output
C:\Users\<user>\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules
```

> [!NOTE]
> Additional paths may exist if the user has added custom modules or applications that impact
> the path.

For more information, see `PSModulePath` in [about_Environment_Variables](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7)

for more information about Modules, see [about_Modules](https://github.com/MicrosoftDocs/PowerShell-Docs/blob/staging/reference/7.0/Microsoft.PowerShell.Core/About/about_Modules.md)

## Where is the ISE (Integrated Scripting Environment)?

The Windows PowerShell Integrated Scripting Environment (ISE) is only available in Windows
PowerShell. To support the growing needs of the automation and scripting community, along with
DevOps and developers, we recommend [Visual Studio Code (VSCode)](https://code.visualstudio.com/)
and the [PowerShell Extension](https://code.visualstudio.com/docs/languages/powershell) for writing
and debugging scripts and modules.

To make the transition from the **ISE** to **VSCode** smoother, a new option **Enable ISE Mode** is
available in the the Command Palette to switch **VSCode** into an **ISE** style layout. By
transitioning to **VSCode** and the new **ISE** layout, you will continue to get all the new
features and capabilities of PowerShell in a familiar scripting tool.

To switch between the default layout and the new ISE layout, press;

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>

Type and select: **PowerShell:Enable ISE Mode**

To set the layout to the original VSCode layout, open the Command Palette, type and select
**PowerShell: Disable ISE Mode (restore to defaults)**

For more details about customizing the VSCode layout to ISE, see
[How to Replicate the ISE Experience in Visual Studio Code](https://docs.microsoft.com/powershell/scripting/components/vscode/how-to-replicate-the-ise-experience-in-vscode?view=powershell-7)

> [!NOTE]
> The PowerShell Team and partners are actively working to improve the scripting experience in the
> PowerShell extension for VSCode. We currently have no plans to update the ISE with new features
> going forward. In the latest versions of Windows 10 and Windows Server, the ISE is now a
> user-uninstallable feature, but this does not signal any plans to make it unavailable in the  future.

## PowerShell SSH Remoting

In previous versions of Windows PowerShell, Remoting was handled through **WinRM** for connection
negotiation and data transport. To support cross-platform needs for Windows and Linux, **SSH-based**
remoting is now available and allows true multiplatform PowerShell Remoting.

SSH remoting creates a PowerShell host process on the target computer as an SSH subsystem. For
details and examples on setting up Windows or Linux for SSH-based remoting, see:
[PowerShell Remoting over SSH](https://docs.microsoft.com/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7).

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
