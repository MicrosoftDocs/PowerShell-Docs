---
description: How to install PowerShell on Windows
ms.date: 05/01/2026
title: Install PowerShell 7 on Windows
---
# Install PowerShell 7 on Windows

PowerShell 7 doesn't replace Windows PowerShell 5.1. It installs to a new directory and runs
side-by-side with Windows PowerShell 5.1. There are some Windows PowerShell modules that can be run
using the PowerShell 7 Windows Compatibility feature. Other modules require that you run them in
Windows PowerShell 5.1. For more information, see [PowerShell 7 module compatibility][01].

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][25] article.

## Choose an installation method

There are multiple ways to install PowerShell in Windows. Each install method is designed to support
different scenarios and workflows. Choose the method that best suits your needs.

- [WinGet][11] - Recommended way to install PowerShell on Windows clients
- [MSI package][09] - Best choice for Windows Servers and enterprise deployment scenarios
- [MSIX package][10] - An easy way to install for casual users of PowerShell but has limitations
- [ZIP package][12] - Easiest way to _side load_ or install multiple versions or install on Windows
  Server Core, Windows IoT, and Arm-based systems
- [.NET Global tool][08] - A good choice for .NET developers that install and use other global tools

### Install PowerShell using WinGet

<a id="winget"></a>WinGet, the Windows Package Manager, is a command-line tool that enables you to
discover, install, upgrade, remove, and configure applications on Windows client computers. This
tool is the client interface to the Windows Package Manager service. The `winget` command-line tool
is included in Windows 11 and Windows Server 2025 as part of the **App Installer**. The `winget`
command can be run from any command shell, including the Windows Command shell (`cmd.exe`), Windows
PowerShell (`powershell.exe`), or PowerShell (`pwsh.exe`).

> [!NOTE]
> See the [winget documentation][07] for a list of system requirements and install instructions.
> `winget` isn't available on Windows Server 2022 or earlier versions. Windows Server 2025 includes
> `winget` for **Windows Server with Desktop Experience** only.

Use the following `winget` commands to install PowerShell:

Search for the latest version of PowerShell

```powershell
winget search --id Microsoft.PowerShell --exact
```

```Output
Name               Id                           Version   Source
-----------------------------------------------------------------
PowerShell         Microsoft.PowerShell         7.6.1.0   winget
```

Beginning with the winget package for PowerShell 7.6.0, winget installs the MSIX package by default.

Install the PowerShell 7 MSIX package:

```powershell
winget install --id Microsoft.PowerShell --source winget
```

Use the following command to install the PowerShell 7 MSI package:

```powershell
winget install --id Microsoft.PowerShell --source winget --installer-type wix
```

Alternatively, you can manually download and install the [MSI package][09].

Beginning with the winget package for PowerShell 7.7.0-preview.1, there is no MSI package available.
WinGet only installs the MSIX package.

Use the following command to install PowerShell 7.7-preview packages:

```powershell
winget install --id Microsoft.PowerShell.Preview --source winget
```

### Install the MSI package

<a id="msi"></a>To install PowerShell on Windows, use the following links to download the install
package from GitHub.

Latest stable release:

- [PowerShell-7.6.1-win-x64.msi][17]
- [PowerShell-7.6.1-win-arm64.msi][15]

Once downloaded, double-click the installer file and follow the prompts.

### Install the MSI package with command-line options

MSI packages can be installed from the command line allowing administrators to deploy packages
without user interaction. The MSI package includes the following properties to control the
installation options:

- `USE_MU` - This property has two possible values:
  - `1` (default) - Opts into updating through Microsoft Update, WSUS, or Configuration Manager
  - `0` -  Don't opt into updating through Microsoft Update, WSUS, or Configuration Manager
- `ENABLE_MU`
  - `1` (default) - Opts into using Microsoft Update for Automatic Updates
  - `0` - Don't opt into using Microsoft Update

    > [!NOTE]
    > Enabling updates may have been set in a previous installation or manual configuration. Using
    > `ENABLE_MU=0` doesn't remove the existing settings. Also, this setting can be overruled by
    > Group Policy settings controlled by your administrator.

- `ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL` - This property controls the option for adding the
  `Open PowerShell` item to the context menu in Windows Explorer.
- `ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL` - This property controls the option for adding the
  `Run with PowerShell` item to the context menu in Windows Explorer.
- `ENABLE_PSREMOTING` - This property controls the option for enabling PowerShell remoting during
  installation.
- `REGISTER_MANIFEST` - This property controls the option for registering the Windows Event
  Logging manifest.
- `ADD_PATH` - This property controls the option for adding PowerShell to the Windows PATH
  environment variable.
- `DISABLE_TELEMETRY` - This property controls the option for disabling PowerShell's telemetry by
  setting the `POWERSHELL_TELEMETRY_OPTOUT` environment variable.
- `INSTALLFOLDER` - This property controls the installation directory. The default is
  `$Env:ProgramFiles\PowerShell\`. This is the location where the installer creates the versioned
  subfolder. You can't change the name of the versioned subfolder.
  - For current releases, the versioned subfolder is `7`
  - For preview releases, the versioned subfolder is `7-preview`

The following example shows how to silently install PowerShell with all the install options enabled.

```powershell
$msiParams = @(
    '/package PowerShell-7.6.1-win-x64.msi'
    '/quiet'
    'ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1'
    'ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1'
    'ENABLE_PSREMOTING=1'
    'REGISTER_MANIFEST=1'
    'USE_MU=1'
    'ENABLE_MU=1'
    'ADD_PATH=1'
)
msiexec.exe @msiParams
```

For a full list of command-line options for `Msiexec.exe`, see [Command line options][05].

### Install the ZIP package

<a id="zip"></a>PowerShell binary ZIP archives are provided to enable advanced deployment scenarios.
Download one of the following ZIP archives from the [current release][21] page.

- [PowerShell-7.6.1-win-x64.zip][18]
- [PowerShell-7.6.1-win-arm64.zip][16]

Depending on how you download the file you may need to unblock the file using the `Unblock-File`
cmdlet. Unzip the contents to the location of your choice and run `pwsh.exe` from there. Unlike
installing the MSI packages, installing the ZIP archive doesn't check for prerequisites. For
remoting over WSMan to work properly, ensure that you've met the [prerequisites][04].

Use this method to install the ARM-based version of PowerShell on computers like the Microsoft
Surface Pro X. For best results, install PowerShell to the `$Env:ProgramFiles\PowerShell\7` folder.
If you are installing an additional version of PowerShell 7 side-by-side with an existing version of
PowerShell 7, install the additional version to a different folder. You must manually add a shortcut
to the Start Menu and add the location to the PATH environment variable.

### Install as a .NET Global tool

<a id="dotnet"></a>If you already have the [.NET Core SDK][02] installed, you can install PowerShell
as a [.NET Global tool][03].

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `$HOME\.dotnet\tools` to your `$Env:PATH` environment variable.
However, the currently running shell doesn't have the updated `$Env:PATH`. You can start PowerShell
from a new shell by typing `pwsh`.

### Install the MSIX package

<a id="msstore"></a>PowerShell can be installed from the [Microsoft Store][22] or by manually
downloading the MSIX package.

Benefits of the Microsoft Store package:

- Automatic updates built right into Windows
- Integrates with other software distribution mechanisms like Intune and Configuration Manager
- Can install on Windows systems using x64 or Arm64 processors

To manually install the MSIX package, download one of the following packages from the GitHub
releases page and double-click the file to install it.

- Latest LTS - [PowerShell-7.6.1.msixbundle][19]
- Latest stable - [PowerShell-7.5.6.msixbundle][14]
- Previous LTS - [PowerShell-7.4.15.msixbundle][13]
- Current preview - [PowerShell-7.7.0-preview.1.msixbundle][20]

Alternatively, you can use the following command to install the MSIX package from the command line:

```powershell
Add-AppxPackage -Path ".\PowerShell-7.6.1.msixbundle"
```

#### Limitations of a MSIX-based installation

Store-based installations are installed for a single user. There is no option to install it for all
users. Microsoft Store packages run in an application sandbox that virtualizes access to some
filesystem and registry locations. Changes to virtualized file and registry locations don't persist
outside of the application sandbox.

Store-based installations don't support PowerShell remoting. The application sandbox blocks all
changes to the application's root folder. Any system-level configuration settings stored in
`$PSHOME` can't be modified. This includes the WSMAN configuration. This prevents remote sessions
from connecting to Store-based installs of PowerShell. User-level configurations and SSH remoting
for outbound connections are supported.

The following commands aren't supported in a Microsoft Store instance of PowerShell. These commands
need write access to `$PSHOME`.

- `Register-PSSessionConfiguration`
- `Update-Help -Scope AllUsers`
- `Enable-ExperimentalFeature -Scope AllUsers`
- `Set-ExecutionPolicy -Scope LocalMachine`

For MSIX-based installations, you can't create or modify the all-users profile scripts
`$PROFILE.AllUsersAllHosts` and `$PROFILE.AllUsersCurrentHost` because those profiles must be
stored in `$PSHOME`. Current-user profiles are still supported.

The PowerShell package is exempt from file and registry virtualization. Changes to virtualized file
and registry locations now persist outside of the application sandbox. However, changes to the
application's root folder are still blocked.

For more information, see [Understanding how packaged desktop apps run on Windows][06].

> [!IMPORTANT]
> You must be running on Windows build 1903 or higher for this exemption to work.

## Start PowerShell 7

After installing PowerShell 7, you can start it by running the `pwsh` command or open it from the
Start Menu. The installer creates shortcut entries in the Windows Start Menu.

By default, the installer installs the package in `$Env:ProgramFiles\PowerShell\7`. Preview releases
of PowerShell 7 install to `$Env:ProgramFiles\PowerShell\7-preview`. The installed location is added
to your `$Env:PATH` environment variable.

> [!NOTE]
> To run PowerShell 7.5 side-by-side with other versions of PowerShell 7, use the [ZIP install][12]
> method to install the other version to a different folder. When you install using the ZIP method,
> you must manually add a shortcut to the Start Menu and add the location to the PATH environment
> variable.

The following screenshot shows multiple versions of PowerShell in the Start Menu. Select the item
labeled **PowerShell 7**.

![PowerShell in the Start Menu.][23]

The selected entry is for PowerShell 7. Preview versions of PowerShell 7 install side-by-side with
stable versions. Select the item labeled **PowerShell 7-preview** to start the preview version.

The first and last entries shown are for Windows PowerShell 5.1, which are installed by default on
Windows. If you choose **Windows PowerShell ISE**, that starts the Windows PowerShell Integrated
Scripting Environment (ISE), which is a different application that only works with Windows
PowerShell 5.1.

## Upgrade PowerShell 7

PowerShell 7 supports updates through Microsoft Update. When you enable this feature, you'll get
the latest PowerShell 7 updates in your traditional Microsoft Update (MU) management flow, whether
that's with Windows Update for Business, WSUS, Microsoft Endpoint Configuration Manager, or the
interactive MU dialog in **Settings**. For more information, see the
[PowerShell Microsoft Update FAQ][24].

If you want to upgrade to the latest version of PowerShell 7 before it's available through Microsoft
Update, you should use the same install method you used when you first installed PowerShell. Newer
versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions of
PowerShell can be installed side-by-side with non-preview versions of PowerShell. Newer preview
versions replace existing previous preview versions.

If you aren't sure how PowerShell was installed, you can check the value of the `$PSHOME` variable,
which always points to the directory containing PowerShell that the current session is running.

- If the value is `$HOME\.dotnet\tools`, PowerShell was installed with the [.NET Global tool][08].
- If the value is `$Env:ProgramFiles\PowerShell\7`, PowerShell was probably installed using the
  [MSI package][09]. You can verify this by looking for PowerShell in the **Programs and Features**
  Control Panel.
- If the value starts with `$Env:ProgramFiles\WindowsApps\`, PowerShell was installed using the
  [MSIX package][10].
- If the value is anything else, it's likely that PowerShell was installed as a [ZIP package][12].

To determine whether PowerShell may be upgraded with WinGet, run the following command:

```powershell
winget list --id Microsoft.PowerShell --upgrade-available
```

If there is an available upgrade, the output indicates the latest available version. Use the
following command to upgrade PowerShell using WinGet:

```powershell
winget upgrade --id Microsoft.PowerShell
```

If available in the new version, WinGet uses the same package format (MSI or MSIX) that was used to
install the current version of PowerShell. Alternatively, you can manually download and install
the package you want.

## Uninstall PowerShell 7

The process of uninstalling PowerShell 7 depends on the installation method you used.

- If you installed PowerShell using WinGet, run the following command:

  ```powershell
  winget uninstall --id Microsoft.PowerShell
  ```

- If you installed PowerShell using the MSI package, you can uninstall it from the
  **Programs and Features** Control Panel.
- If you installed PowerShell using the ZIP package, delete the folder where you unzipped the files.
- If you installed PowerShell from the Microsoft Store, open the **Start** menu and search for
  `PowerShell 7`. Select **Uninstall** from the menu of options.
- If you installed PowerShell as a .NET Global tool, run the following command:

  ```powershell
  dotnet tool uninstall --global PowerShell
  ```

## Supported versions of Windows

[!INCLUDE [Windows support](../../includes/windows-support.md)]

You can check the version that you are using by running `winver.exe`.

## Supported installation methods

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods.

[!INCLUDE [Latest version](../../includes/latest-install.md)]

<!-- link references -->
[01]: ../whats-new/module-compatibility.md
[02]: /dotnet/core/sdk
[03]: /dotnet/core/tools/global-tools
[04]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[05]: /windows/desktop/Msi/command-line-options
[06]: /windows/msix/desktop/desktop-to-uwp-behind-the-scenes
[07]: /windows/package-manager/winget
[08]: #dotnet
[09]: #msi
[10]: #msstore
[11]: #winget
[12]: #zip
[13]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.15/PowerShell-7.4.15.msixbundle
[14]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.6/PowerShell-7.5.6.msixbundle
[15]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/PowerShell-7.6.1-win-arm64.msi
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/PowerShell-7.6.1-win-arm64.zip
[17]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/PowerShell-7.6.1-win-x64.msi
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/PowerShell-7.6.1-win-x64.zip
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/PowerShell-7.6.1.msixbundle
[20]: https://github.com/PowerShell/PowerShell/releases/download/v7.7.0-preview.1/PowerShellPreview-7.7.0-preview.1.msixbundle
[21]: https://github.com/PowerShell/PowerShell/releases/latest
[22]: https://www.microsoft.com/store/apps/9MZ1SNWT0N5D
[23]: media/install-powershell-on-windows/powershell-start-menu.png
[24]: microsoft-update-faq.yml
[25]: PowerShell-Support-Lifecycle.md
