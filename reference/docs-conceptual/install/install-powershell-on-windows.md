---
description: How to install PowerShell on Windows
ms.date: 12/15/2025
title: Install PowerShell on Windows
---
# Install PowerShell on Windows

There are multiple ways to install PowerShell in Windows. Each install method is designed to support
different scenarios and workflows. Choose the method that best suits your needs.

- [WinGet][10] - Recommended way to install PowerShell on Windows clients
- [MSI package][08] - Best choice for Windows Servers and enterprise deployment scenarios
- [ZIP package][11] - Easiest way to _side load_ or install multiple versions
  - Use this method for Windows Nano Server, Windows IoT, and Arm-based systems
- [.NET Global tool][07] - A good choice for .NET developers that install and use other global tools
- [Microsoft Store package][09] - An easy way to install for casual users of PowerShell but has
  limitations

PowerShell 7 installs to a new directory and runs side-by-side with Windows PowerShell 5.1. Newer
versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions of
PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview versions
replace existing previous preview versions.

PowerShell 7 supports updates through Microsoft Update. When you enable this feature, you'll get
the latest PowerShell 7 updates in your traditional Microsoft Update (MU) management flow, whether
that's with Windows Update for Business, WSUS, Microsoft Endpoint Configuration Manager, or the
interactive MU dialog in **Settings**.

For more information, see the [PowerShell Microsoft Update FAQ][23].

## Install PowerShell using WinGet (recommended)

<a id="winget"></a>WinGet, the Windows Package Manager, is a command-line tool enables users to
discover, install, upgrade, remove, and configure applications on Windows client computers. This
tool is the client interface to the Windows Package Manager service. The `winget` command-line tool
is bundled with Windows 11 and modern versions of Windows 10 by default as the **App Installer**.

> [!NOTE]
> See the [winget documentation][06] for a list of system requirements and install instructions.
> `winget` isn't available on Windows Server 2022 or earlier versions. Windows Server 2025 includes
> `winget` for **Windows Server with Desktop Experience** only.

The following commands can be used to install PowerShell using the published `winget` packages:

Search for the latest version of PowerShell

```powershell
winget search --id Microsoft.PowerShell
```

```Output
Name               Id                           Version Source
---------------------------------------------------------------
PowerShell         Microsoft.PowerShell         7.5.4.0 winget
PowerShell Preview Microsoft.PowerShell.Preview 7.6.0.5 winget
```

Install PowerShell or PowerShell Preview using the `--id` parameter

```powershell
winget install --id Microsoft.PowerShell --source winget
```

```powershell
winget install --id Microsoft.PowerShell.Preview --source winget
```

> [!NOTE]
> On Windows systems using X86 or X64 processor, `winget` installs the MSI package. On systems using
> the Arm64 processor, `winget` installs the Microsoft Store (MSIX) package.

## Install the MSI package

<a id="msi"></a>To install PowerShell on Windows, use the following links to download the install
package from GitHub.

Latest stable release:

- [PowerShell-7.5.4-win-x64.msi][14]
- [PowerShell-7.5.4-win-x86.msi][16]
- [PowerShell-7.5.4-win-arm64.msi][12]

Latest Preview release:

- [PowerShell-7.6.0-preview.6-win-x64.msi][19]
- [PowerShell-7.6.0-preview.6-win-x86.msi][20]
- [PowerShell-7.6.0-preview.6-win-arm64.msi][18]

Once downloaded, double-click the installer file and follow the prompts.

The installer creates a shortcut in the Windows Start Menu.

- By default the package is installed to `$Env:ProgramFiles\PowerShell\7`
  - The install location is added to your `$Env:PATH` environment variable
- Preview releases of PowerShell 7 install to `$Env:ProgramFiles\PowerShell\7-preview`
- You can launch PowerShell via the Start Menu or `$Env:ProgramFiles\PowerShell\7\pwsh.exe`

> [!NOTE]
> To run PowerShell 7.5 side-by-side with other versions of PowerShell 7, use the [ZIP install][11]
> method to install the other version to a different folder.

### Install the MSI package from the command line

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
msiexec.exe /package PowerShell-7.5.4-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1
```

For a full list of command-line options for `Msiexec.exe`, see [Command line options][04].

## Install from the ZIP package

<a id="zip"></a>PowerShell binary ZIP archives are provided to enable advanced deployment scenarios.
Download one of the following ZIP archives from the [current release][21] page.

- [PowerShell-7.5.4-win-x64.zip][15]
- [PowerShell-7.5.4-win-x86.zip][17]
- [PowerShell-7.5.4-win-arm64.zip][13]

Depending on how you download the file you may need to unblock the file using the `Unblock-File`
cmdlet. Unzip the contents to the location of your choice and run `pwsh.exe` from there. Unlike
installing the MSI packages, installing the ZIP archive doesn't check for prerequisites. For
remoting over WSMan to work properly, ensure that you've met the [prerequisites][03].

Use this method to install the ARM-based version of PowerShell on computers like the Microsoft
Surface Pro X. For best results, install PowerShell to the to `$Env:ProgramFiles\PowerShell\7`
folder.

## Install as a .NET Global tool

<a id="dotnet"></a>If you already have the [.NET Core SDK][01] installed, you can install PowerShell
as a [.NET Global tool][02].

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `$HOME\.dotnet\tools` to your `$Env:PATH` environment variable.
However, the currently running shell doesn't have the updated `$Env:PATH`. You can start PowerShell
from a new shell by typing `pwsh`.

## Install from the Microsoft Store

<a id="msstore"></a>PowerShell can be installed from the Microsoft Store. You can find the
PowerShell release in the [Microsoft Store][22] site or in the Store application in Windows.

Benefits of the Microsoft Store package:

- Automatic updates built right into Windows
- Integrates with other software distribution mechanisms like Intune and Configuration Manager
- Can install on Windows systems using x86, x64, or Arm64 processors

### Known limitations

By default, Windows Store packages run in an application sandbox that virtualizes access to some
filesystem and registry locations. Changes to virtualized file and registry locations don't persist
outside of the application sandbox.

This sandbox blocks all changes to the application's root folder. Any system-level configuration
settings stored in `$PSHOME` can't be modified. This includes the WSMAN configuration. This prevents
remote sessions from connecting to Store-based installs of PowerShell. User-level configurations and
SSH remoting are supported.

The following commands need write to `$PSHOME`. These commands aren't supported in a Microsoft Store
instance of PowerShell.

- `Register-PSSessionConfiguration`
- `Update-Help -Scope AllUsers`
- `Enable-ExperimentalFeature -Scope AllUsers`
- `Set-ExecutionPolicy -Scope LocalMachine`

For more information, see [Understanding how packaged desktop apps run on Windows][05].

Beginning in PowerShell 7.2, the PowerShell package is now exempt from file and registry
virtualization. Changes to virtualized file and registry locations now persist outside of the
application sandbox. However, changes to the application's root folder are still blocked.

> [!IMPORTANT]
> You must be running on Windows build 1903 or higher for this exemption to work.

## Upgrade an existing installation

For best results when upgrading, you should use the same install method you used when you first
installed PowerShell. If you aren't sure how PowerShell was installed, you can check the value of
the `$PSHOME` variable, which always points to the directory containing PowerShell that the current
session is running.

- If the value is `$HOME\.dotnet\tools`, PowerShell was installed with the [.NET Global tool][07].
- If the value is `$Env:ProgramFiles\PowerShell\7`, PowerShell was installed as an
  [MSI package][08] or with [WinGet][10] on a computer with an X86 or x64 processor.
- If the value starts with `$Env:ProgramFiles\WindowsApps\`, PowerShell was installed as a
  [Microsoft Store package][09] or with [WinGet][10] on computer with an ARM processor.
- If the value is anything else, it's likely that PowerShell was installed as a [ZIP package][11].

If you installed via the MSI package, that information also appears in the
**Programs and Features** Control Panel.

To determine whether PowerShell may be upgraded with WinGet, run the following command:

```powershell
winget list --id Microsoft.PowerShell --upgrade-available
```

If there is an available upgrade, the output indicates the latest available version. Use the
following command to upgrade PowerShell using WinGet:

```powershell
winget upgrade --id Microsoft.PowerShell
```

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

## Installation support

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods.

[!INCLUDE [Latest version](../../includes/latest-install.md)]

<!-- link references -->
[01]: /dotnet/core/sdk
[02]: /dotnet/core/tools/global-tools
[03]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[04]: /windows/desktop/Msi/command-line-options
[05]: /windows/msix/desktop/desktop-to-uwp-behind-the-scenes
[06]: /windows/package-manager/winget
[07]: #dotnet
[08]: #msi
[09]: #msstore
[10]: #winget
[11]: #zip
[12]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-arm64.msi
[13]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-arm64.zip
[14]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x64.msi
[15]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x64.zip
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x86.msi
[17]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x86.zip
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.6/PowerShell-7.6.0-preview.6-win-arm64.msi
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.6/PowerShell-7.6.0-preview.6-win-x64.msi
[20]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.6/PowerShell-7.6.0-preview.6-win-x86.msi
[21]: https://github.com/PowerShell/PowerShell/releases/latest
[22]: https://www.microsoft.com/store/apps/9MZ1SNWT0N5D
[23]: microsoft-update-faq.yml
