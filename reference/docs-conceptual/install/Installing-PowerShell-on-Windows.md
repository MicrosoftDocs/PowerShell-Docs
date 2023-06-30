---
description: Information about installing PowerShell on Windows
ms.date: 06/30/2023
title: Installing PowerShell on Windows
---
# Installing PowerShell on Windows

There are multiple ways to install PowerShell in Windows. Each install method is designed to support
different scenarios and workflows. Choose the method that best suits your needs.

- [Winget][19] - Recommended way to install PowerShell on Windows clients
- [MSI package][16] - Best choice for Windows Servers and enterprise deployment scenarios
- [ZIP package][20] - Easiest way to "side load" or install multiple versions
  - Use this method for Windows Nano Server, Windows IoT, and Arm-based systems
- [.NET Global tool][15] - A good choice for .NET developers that install and use other global tools
- [Microsoft Store package][17] - An easy way to install for casual users of PowerShell but has
  limitations

> [!NOTE]
> The installation commands in this article are for the latest stable release of PowerShell. To
> install a different version of PowerShell, adjust the command to match the version you need. The
> following links direct you to the release page for each version in the PowerShell repository on
> GitHub.
>
> - Stable release: [https://aka.ms/powershell-release?tag=stable][23]
> - LTS release: [https://aka.ms/powershell-release?tag=lts][21]
> - Preview release: [https://aka.ms/powershell-release?tag=preview][22]
>
> Download links for every package are found in the **Assets** section of the Release page. The
> **Assets** section may be collapsed, so you may need to click to expand it.

## <a id="winget" />Install PowerShell using Winget (recommended)

Winget, the Windows Package Manager, is a command-line tool enables users to discover, install,
upgrade, remove, and configure applications on Windows client computers. This tool is the client
interface to the Windows Package Manager service. The `winget` command-line tool is bundled with
Windows 11 and modern versions of Windows 10 by default as the **App Installer**.

> [!NOTE]
> See the [winget documentation][14] for a list of system requirements and install instructions.
> `Winget` doesn't currently run on Windows servers.

The following commands can be used to install PowerShell using the published `winget` packages:

Search for the latest version of PowerShell

```powershell
winget search Microsoft.PowerShell
```

```Output
Name               Id                           Version Source
--------------------------------------------------------------
PowerShell         Microsoft.PowerShell         7.3.5.0 winget
PowerShell Preview Microsoft.PowerShell.Preview 7.4.0.3 winget
```

Install PowerShell or PowerShell Preview using the `id` parameter

```powershell
winget install --id Microsoft.Powershell --source winget
winget install --id Microsoft.Powershell.Preview --source winget
```

> [!NOTE]
> On Windows systems using X86 or X64 processor, `winget` installs the MSI package. On systems using
> the Arm64 processor, `winget` installs the Microsoft Store (MSIX) package. For more information,
> see [Installing from the Microsoft Store][17].

## <a id="msi" />Installing the MSI package

To install PowerShell on Windows, use the following links to download the install package from
GitHub.

- [PowerShell-7.3.5-win-x64.msi][28]
- [PowerShell-7.3.5-win-x86.msi][30]

Once downloaded, double-click the installer file and follow the prompts.

The installer creates a shortcut in the Windows Start Menu.

- By default the package is installed to `$env:ProgramFiles\PowerShell\<version>`
- You can launch PowerShell via the Start Menu or `$env:ProgramFiles\PowerShell\<version>\pwsh.exe`

> [!NOTE]
> PowerShell 7.3 installs to a new directory and runs side-by-side with Windows PowerShell 5.1.
> PowerShell 7.3 is an in-place upgrade that replaces PowerShell 7.0 and lower.
>
> - PowerShell 7.3 is installed to `$env:ProgramFiles\PowerShell\7`
> - The `$env:ProgramFiles\PowerShell\7` folder is added to `$env:PATH`
> - Folders for previously released versions are deleted
>
> If you need to run PowerShell 7.3 side-by-side with other versions, use the [ZIP install][20]
> method to install the other version to a different folder.

### Support for Microsoft Update in PowerShell 7.2 and newer

PowerShell 7.2 and newer has support for Microsoft Update. When you enable this feature, you'll get
the latest PowerShell 7 updates in your traditional Microsoft Update (MU) management flow, whether
that's with Windows Update for Business, WSUS, Microsoft Endpoint Configuration Manager, or the
interactive MU dialog in Settings.

The PowerShell 7.3 MSI package includes following command-line options:

- `USE_MU` - This property has two possible values:
  - `1` (default) - Opts into updating through Microsoft Update, WSUS, or Configuration Manager
  - `0` -  Don't opt into updating through Microsoft Update, WSUS, or Configuration Manager
- `ENABLE_MU`
  - `1` (default) - Opts into using Microsoft Update for Automatic Updates
  - `0` - Don't opt into using Microsoft Update

> [!NOTE]
> Enabling updates may have been set in a previous installation or manual configuration. Using
> `ENABLE_MU=0` doesn't remove the existing settings. Also, this setting can be overruled by Group
> Policy settings controlled by your administrator.

For more information, see the [PowerShell Microsoft Update FAQ][34].

### Install the MSI package from the command line

MSI packages can be installed from the command line allowing administrators to deploy packages
without user interaction. The MSI package includes the following properties to control the
installation options:

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

The following example shows how to silently install PowerShell with all the install options enabled.

```powershell
msiexec.exe /package PowerShell-7.3.5-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1
```

For a full list of command-line options for `Msiexec.exe`, see
[Command line options][12].

## <a id="zip" />Installing the ZIP package

PowerShell binary ZIP archives are provided to enable advanced deployment scenarios. Download one of
the following ZIP archives from the [current release][23] page.

- [PowerShell-7.3.5-win-x64.zip][29]
- [PowerShell-7.3.5-win-x86.zip][31]
- [PowerShell-7.3.5-win-arm64.zip][27]

Depending on how you download the file you may need to unblock the file using the `Unblock-File`
cmdlet. Unzip the contents to the location of your choice and run `pwsh.exe` from there. Unlike
installing the MSI packages, installing the ZIP archive doesn't check for prerequisites. For
remoting over WSMan to work properly, ensure that you've met the [prerequisites][18].

Use this method to install the ARM-based version of PowerShell on computers like the Microsoft
Surface Pro X. For best results, install PowerShell to the to `$env:ProgramFiles\PowerShell\7`
folder.

## <a id="dotnet" />Install as a .NET Global tool

If you already have the [.NET Core SDK][05] installed, you can install PowerShell as a
[.NET Global tool][06].

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `$HOME\.dotnet\tools` to your `$env:PATH` environment variable.
However, the currently running shell doesn't have the updated `$env:PATH`. You can start PowerShell
from a new shell by typing `pwsh`.

## <a id="msstore" />Installing from the Microsoft Store

PowerShell 7.3 can be installed from the Microsoft Store. You can find the PowerShell release in the
[Microsoft Store][33] site or in the Store application in Windows.

Benefits of the Microsoft Store package:

- Automatic updates built right into Windows
- Integrates with other software distribution mechanisms like Intune and Configuration Manager
- Can install on Windows systems using x86, x64, or Arm64 processors

### Known limitations

By default, Windows Store packages run in an application sandbox that virtualizes access to some
filesystem and registry locations. Changes to virtualized file and registry locations don't persist
outside of the application sandbox.

This sandbox all blocks any changes to the application's root folder. Any system-level configuration
settings stored in `$PSHOME` can't be modified. This includes the WSMAN configuration. This prevents
remote sessions from connecting to Store-based installs of PowerShell. User-level configurations and
SSH remoting are supported.

The following commands need write to `$PSHOME`. These commands aren't supported in a Microsoft Store
instance of PowerShell.

- `Register-PSSessionConfiguration`
- `Update-Help -Scope AllUsers`
- `Enable-ExperimentalFeature -Scope AllUsers`
- `Set-ExecutionPolicy -Scope LocalMachine`

For more information, see
[Understanding how packaged desktop apps run on Windows][13].

### Changes for PowerShell 7.2

Beginning in PowerShell 7.2, the PowerShell package is now exempt from file and registry
virtualization. Changes to virtualized file and registry locations now persist outside of the
application sandbox. However, changes to the application's root folder are still blocked.

> [!IMPORTANT]
> You must be running on Windows build 1903 or higher for this exemption to work.

## Installing a preview version

Preview releases of PowerShell 7 install to `$env:ProgramFiles\PowerShell\7-preview` so they can be
run side-by-side with non-preview releases of PowerShell. PowerShell 7.4 is the next preview
release.

## Upgrading an existing installation

For best results when upgrading, you should use the same install method you used when you first
installed PowerShell. Each installation method installs PowerShell in a different location. If you
aren't sure how PowerShell was installed, you can compare the installed location with the package
information in this article. If you installed via the MSI package, that information appears in the
**Programs and Features** Control Panel.

> [!NOTE]
> When upgrading, PowerShell won't upgrade from an LTS version to a non-LTS version. It only
> upgrades to the latest version of LTS, for example, from 7.2.3 to 7.2.12. To upgrade from an
> LTS release to a newer stable version or the next LTS, you need to install the new version with
> the MSI for that release.
>
> When the installed version isn't an LTS version, PowerShell upgrades to the latest stable
> version.

## Deploying on Windows 10 IoT Enterprise

Windows 10 IoT Enterprise comes with Windows PowerShell, which we can use to deploy PowerShell 7.

```powershell
# Replace the placeholder information for the following variables:
$deviceip = '<device ip address'
$zipfile = 'PowerShell-7.3.5-win-arm64.zip'
$downloadfolder = 'u:\users\administrator\Downloads'  # The download location is local to the device.
    # There should be enough  space for the zip file and the unzipped contents.

# Create PowerShell session to target device
Set-Item -Path WSMan:\localhost\Client\TrustedHosts $deviceip
$S = New-PSSession -ComputerName $deviceIp -Credential Administrator
# Copy the ZIP package to the device
Copy-Item $zipfile -Destination $downloadfolder -ToSession $S

#Connect to the device and expand the archive
Enter-PSSession $S
Set-Location u:\users\administrator\Downloads
Expand-Archive .\PowerShell-7.3.5-win-arm64.zip

# Set up remoting to PowerShell 7
Set-Location .\PowerShell-7.3.5-win-arm64
# Be sure to use the -PowerShellHome parameter otherwise it tries to create a new
# endpoint with Windows PowerShell 5.1
.\Install-PowerShellRemoting.ps1 -PowerShellHome .
```

When you set up PowerShell Remoting you get an error message and are disconnected from the device.
PowerShell has to restart WinRM. Now you can connect to PowerShell 7 endpoint on device.

```powershell

# Be sure to use the -Configuration parameter. If you omit it, you connect to Windows PowerShell 5.1
Enter-PSSession -ComputerName $deviceIp -Credential Administrator -Configuration PowerShell.7.3.5
```

## Deploying on Windows 10 IoT Core

Windows 10 IoT Core adds Windows PowerShell when you include _IOT_POWERSHELL_ feature, which we can
use to deploy PowerShell 7. The steps defined above for Windows 10 IoT Enterprise can be followed
for IoT Core as well.

For adding the latest PowerShell in the shipping image, use [Import-PSCoreRelease][24] command to
include the package in the workarea and add _OPENSRC_POWERSHELL_ feature to your image.

> [!NOTE]
> For ARM64 architecture, Windows PowerShell isn't added when you include _IOT_POWERSHELL_. So the
> zip based install doesn't work. You need to use `Import-PSCoreRelease` command to add it in
> the image.

## Deploying on Nano Server

These instructions assume that the Nano Server is a "headless" OS that has a version of PowerShell
already running on it. For more information, see the [Nano Server Image Builder][11]
documentation.

PowerShell binaries can be deployed using two different methods.

1. Offline - Mount the Nano Server VHD and unzip the contents of the zip file to your chosen
   location within the mounted image.
1. Online - Transfer the zip file over a PowerShell Session and unzip it in your chosen location.

In both cases, you need the [Windows x64 ZIP release package][29]. Run the commands within an
"Administrator" instance of PowerShell.

### Offline Deployment of PowerShell

1. Use your favorite zip utility to unzip the package to a directory within the mounted Nano Server
   image.
1. Unmount the image and boot it.
1. Connect to the built-in instance of Windows PowerShell.
1. Follow the instructions to create a remoting endpoint using the
   ["another instance technique"][04].

### Online Deployment of PowerShell

Deploy PowerShell to Nano Server using the following steps.

```powershell
# Replace the placeholder information for the following variables:
$ipaddr = '<Nano Server IP address>'
$credential = Get-Credential # <An Administrator account on the system>
$zipfile = 'PowerShell-7.3.5-win-x64.zip'
# Connect to the built-in instance of Windows PowerShell
$session = New-PSSession -ComputerName $ipaddr -Credential $credential
# Copy the file to the Nano Server instance
Copy-Item $zipfile c:\ -ToSession $session
# Enter the interactive remote session
Enter-PSSession $session
# Extract the ZIP file
Expand-Archive -Path C:\PowerShell-7.3.5-win-x64.zip -DestinationPath 'C:\Program Files\PowerShell 7'
```

If you want WSMan-based remoting, follow the instructions to create a remoting endpoint using the
["another instance technique"][04].

## PowerShell remoting

PowerShell supports the PowerShell Remoting Protocol (PSRP) over both WSMan and SSH. For more
information, see:

- [SSH Remoting in PowerShell][02]
- [WSMan Remoting in PowerShell][03]

The following prerequisites must be met to enable PowerShell remoting over WSMan on older versions
of Windows.

- Install the Windows Management Framework (WMF) 5.1 (as necessary). For more information about WMF,
  see [WMF Overview][10].
- Install the [Universal C Runtime][32] on Windows versions predating Windows 10. It's available via
  direct download or Windows Update. Fully patched systems already have this package installed.

## Supported versions of Windows

[!INCLUDE [Windows support](../../includes/windows-support.md)]

You can check the version that you are using by running `winver.exe`.

## Installation support

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods.

<!-- link references -->
[02]: ../learn/remoting/SSH-Remoting-in-PowerShell-Core.md
[03]: ../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md
[04]: ../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md#executed-by-another-instance-of-powershell-on-behalf-of-the-instance-that-it-will-register
[05]: /dotnet/core/sdk
[06]: /dotnet/core/tools/global-tools
[10]: /powershell/scripting/wmf/overview
[11]: /windows-server/get-started/deploy-nano-server
[12]: /windows/desktop/Msi/command-line-options
[13]: /windows/msix/desktop/desktop-to-uwp-behind-the-scenes
[14]: /windows/package-manager/winget
[15]: #dotnet
[16]: #msi
[17]: #msstore
[18]: #powershell-remoting
[19]: #winget
[20]: #zip
[21]: https://aka.ms/powershell-release?tag=lts
[22]: https://aka.ms/powershell-release?tag=preview
[23]: https://aka.ms/powershell-release?tag=stable
[24]: https://github.com/ms-iot/iot-adk-addonkit/blob/master/Tools/IoTCoreImaging/Docs/Import-PSCoreRelease.md#Import-PSCoreRelease
[27]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-arm64.zip
[28]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x64.msi
[29]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x64.zip
[30]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x86.msi
[31]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x86.zip
[32]: https://www.microsoft.com/download/details.aspx?id=50410
[33]: https://www.microsoft.com/store/apps/9MZ1SNWT0N5D
[34]: microsoft-update-faq.yml
