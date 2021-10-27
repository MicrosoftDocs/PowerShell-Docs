---
description: Information about installing PowerShell on Windows
ms.date: 10/22/2021
title: Installing PowerShell on Windows
---
# Installing PowerShell on Windows

There are multiple ways to install PowerShell in Windows. Each install method is designed to support
different scenarios and workflows. Choose the method that best suits your needs.

- [MSI package](#msi) - The best choice for the everyday user.
- [ZIP package](#zip) - The easiest way to install multiple versions or use in a CI/CD pipeline.
  This is the install method for Windows Nano Server, Windows IoT, and Arm-based systems.
- [.NET Global tool](#dotnet) - A good choice for .NET developers that install and use other global
  tools.
- [Winget](#winget) - For users that prefer to use the new Windows Package Manager tool.
- [Microsoft Store package](#msstore) - An easy way to install for casual users of PowerShell but
  has limitations.

> [!NOTE]
> The installation commands in this article are for the latest stable release of PowerShell. To
> install a different version of PowerShell, adjust the command to match the version you need. The
> following links direct you to the release page for each version in the PowerShell repository on
> GitHub.
>
> - Stable release: [https://aka.ms/powershell-release?tag=stable][current]
> - LTS release: [https://aka.ms/powershell-release?tag=lts][lts]
> - Preview release: [https://aka.ms/powershell-release?tag=preview][preview]
>
> Download links for every package are found in the **Assets** section of the Release page. The
> **Assets** section may be collapsed, so you may need to click to expand it.

## <a id="msi" />Installing the MSI package

To install PowerShell on Windows, use the following links to download the install package from
GitHub.

- [PowerShell-7.1.5-win-x64.msi][x64msi]
- [PowerShell-7.1.5-win-x86.msi][x86msi]

Once downloaded, double-click the installer file and follow the prompts.

The installer creates a shortcut in the Windows Start Menu.

- By default the package is installed to `$env:ProgramFiles\PowerShell\<version>`
- You can launch PowerShell via the Start Menu or `$env:ProgramFiles\PowerShell\<version>\pwsh.exe`

> [!NOTE]
> PowerShell 7.1 installs to a new directory and runs side-by-side with Windows PowerShell 5.1.
> PowerShell 7.1 is an in-place upgrade that replaces PowerShell 7.0 and lower.
>
> - PowerShell 7.1 is installed to `$env:ProgramFiles\PowerShell\7`
> - The `$env:ProgramFiles\PowerShell\7` folder is added to `$env:PATH`
> - Folders for previously released versions are deleted
>
> If you need to run PowerShell 7.1 side-by-side with other versions, use the [ZIP install](#zip)
> method to install the other version to a different folder.

### Administrative install from the command line

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

The following example shows how to silently install PowerShell with all the install options enabled.

```powershell
msiexec.exe /package PowerShell-7.1.5-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
```

For a full list of command-line options for `Msiexec.exe`, see
[Command line options](/windows/desktop/Msi/command-line-options).

## <a id="zip" />Installing the ZIP package

PowerShell binary ZIP archives are provided to enable advanced deployment scenarios. Download one of
the following ZIP archives from the [current release][current] page.

- [PowerShell-7.1.5-win-x64.zip][x64zip]
- [PowerShell-7.1.5-win-x86.zip][x86zip]
- [PowerShell-7.1.5-win-arm64.zip][arm64zip]
- [PowerShell-7.1.5-win-arm32.zip][arm32zip]

Depending on how you download the file you may need to unblock the file using the `Unblock-File`
cmdlet. Unzip the contents to the location of your choice and run `pwsh.exe` from there. Unlike
installing the MSI packages, installing the ZIP archive doesn't check for prerequisites. For
remoting over WSMan to work properly, ensure that you've met the
[prerequisites](#powershell-remoting).

Use this method to install the ARM-based version of PowerShell on computers like the Microsoft
Surface Pro X. For best results, install PowerShell to the to `$env:ProgramFiles\PowerShell\7`
folder.

## <a id="dotnet" />Install as a .NET Global tool

If you already have the [.NET Core SDK](/dotnet/core/sdk) installed, you can install PowerShell as a
[.NET Global tool](/dotnet/core/tools/global-tools).

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `$env:USERPROFILE\.dotnet\tools` to your `$env:PATH` environment
variable. However, the currently running shell doesn't have the updated `$env:PATH`. You can start
PowerShell from a new shell by typing `pwsh`.

## <a id="winget" />Install PowerShell using Winget

Winget, the Windows Package Manager, is a command-line tool enables developers to discover, install,
upgrade, remove, and configure applications on Windows 10 computers. This tool is the client
interface to the Windows Package Manager service.

> [!NOTE]
> See the [winget documentation][winget] for a list of system requirements and install instructions.

The following commands can be used to install PowerShell using the published `winget` packages:

Search for the latest version of PowerShell

```powershell
winget search Microsoft.PowerShell
```

```Output
Name               Id                           Version  Source
----------------------------------------------------------------
PowerShell         Microsoft.PowerShell         7.1.5.0  winget
Powershell Preview Microsoft.PowerShell.Preview 7.2.0.10 winget
```

Install Powershell or Powershell Preview using the `id` parameter

```powershell
winget install --id Microsoft.Powershell --source winget
winget install --id Microsoft.Powershell.Preview --source winget
```

Install Powershell or Powershell Preview using the `name` parameter

```powershell
winget install --name Powershell --source winget
winget install --name "Powershell Preview" --source winget
```

Install a particular version of Powershell or Powershell Preview using either the `id` or `name` parameter

```powershell
winget install --id Microsoft.Powershell --source winget --version 7.1.5.0
winget install --id Microsoft.Powershell.Preview --source winget --version 7.2.0.10
winget install --name Powershell --source winget --version 7.1.5.0
winget install --name "Powershell Preview" --source winget --version 7.2.0.10
```

## <a id="msstore" />Installing from the Microsoft Store

PowerShell 7.1 has been published to the Microsoft Store. You can find the PowerShell release in the
[Microsoft Store][store-app] site or in the Store application in Windows.

Benefits of the Microsoft Store package:

- Automatic updates built right into Windows
- Integrates with other software distribution mechanisms like Intune and SCCM

### Known limitations

Windows Store packages run in an application sandbox that virtualizes access to some filesystem and
registry locations.

- All registry changes under HKEY_CURRENT_USER are copied on write to a private, per-user, per-app
  location. Therefore, those values are not available to other applications.
- Any system-level configuration settings stored in `$PSHOME` cannot be modified. This includes the
  WSMAN configuration. This prevents remote sessions from connecting to Store-based installs of
  PowerShell. User-level configurations and SSH remoting are supported.

For more information, see
[Understanding how packaged desktop apps run on Windows](/windows/msix/desktop/desktop-to-uwp-behind-the-scenes).

## Installing a preview version

The preview version of PowerShell 7.2 can be downloaded using the following link:

- [PowerShell-7.2.0-preview.10-win-x64.msi][72x64msi]

Preview releases of PowerShell 7 install to `$env:ProgramFiles\PowerShell\7-preview` so they can
be run side-by-side with non-preview releases of PowerShell. PowerShell 7.2-preview.10 is the
current preview release.

### Support for Microsoft Update in PowerShell 7.2

PowerShell 7.2-preview.10 has support for Microsoft Update. When you enable this feature, you'll get
the latest PowerShell 7 updates in your traditional Microsoft Update (MU) management flow, whether
that's with Windows Update for Business, WSUS, SCCM, or the interactive MU dialog in Settings.

The PowerShell 7.2 MSI package includes following command-line options:

- `USE_MU` - This property has two possible values:
  - `1` (default) - Opts into updating through Microsoft Update, WSUS, or SCCM
  - `0` -  Do not opt into updating through Microsoft Update, WSUS, or SCCM
- `ENABLE_MU`
  - `1` (default) - Opts into using Microsoft Update for Automatic Updates
  - `0` - Do not opt into using Microsoft Update

> [!NOTE]
> Enabling updates may have been set in a previous installation or manual configuration. Using
> `ENABLE_MU=0` does not remove the existing settings. Also, this setting can be overruled by Group
> Policy settings controlled by your administrator.

For more information, see the [PowerShell Microsoft Update FAQ](microsoft-update-faq.yml).

## Upgrading an existing installation

For best results when upgrading, you should use the same install method you used when you first
installed PowerShell. Each installation method installs PowerShell in a different location. If you
are not sure how PowerShell was installed, you can compare the installed location with the package
information in this article. If you installed via the MSI package, that information appears in the
**Programs and Features** Control Panel.

## Deploying on Windows 10 IoT Enterprise

Windows 10 IoT Enterprise comes with Windows PowerShell, which we can use to deploy PowerShell 7.

```powershell
# Replace the placeholder information for the following variables:
$deviceip = '<device ip address'
$zipfile = 'PowerShell-7.1.5-win-Arm64.zip'
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
Expand-Archive .\PowerShell-7.1.5-win-Arm64.zip

# Set up remoting to PowerShell 7
Set-Location .\PowerShell-7.1.5-win-Arm64
# Be sure to use the -PowerShellHome parameter otherwise it tries to create a new
# endpoint with Windows PowerShell 5.1
.\Install-PowerShellRemoting.ps1 -PowerShellHome .
```

When you set up PowerShell Remoting you get an error message and are disconnected from the device.
PowerShell has to restart WinRM. Now you can connect to PowerShell 7 endpoint on device.

```powershell

# Be sure to use the -Configuration parameter. If you omit it, you connect to Windows PowerShell 5.1
Enter-PSSession -ComputerName $deviceIp -Credential Administrator -Configuration PowerShell.7.1.5
```

## Deploying on Windows 10 IoT Core

Windows 10 IoT Core adds Windows PowerShell when you include _IOT_POWERSHELL_ feature, which we can
use to deploy PowerShell 7. The steps defined above for Windows 10 IoT Enterprise can be followed
for IoT Core as well.

For adding the latest PowerShell in the shipping image, use [Import-PSCoreRelease][iotimport]
command to include the package in the workarea and add _OPENSRC_POWERSHELL_ feature to your image.

> [!NOTE]
> For ARM64 architecture, Windows PowerShell is not added when you include _IOT_POWERSHELL_. So the
> zip based install does not work. You need to use `Import-PSCoreRelease` command to add it in
> the image.

## Deploying on Nano Server

These instructions assume that the Nano Server is a "headless" OS that has a version of PowerShell
is already running on it. For more information, see the
[Nano Server Image Builder](/windows-server/get-started/deploy-nano-server) documentation.

PowerShell binaries can be deployed using two different methods.

1. Offline - Mount the Nano Server VHD and unzip the contents of the zip file to your chosen
   location within the mounted image.
1. Online - Transfer the zip file over a PowerShell Session and unzip it in your chosen location.

In both cases, you need the [Windows x64 ZIP release package][x64zip]. Run the commands within an
"Administrator" instance of PowerShell.

### Offline Deployment of PowerShell

1. Use your favorite zip utility to unzip the package to a directory within the mounted Nano Server
   image.
1. Unmount the image and boot it.
1. Connect to the built-in instance of Windows PowerShell.
1. Follow the instructions to create a remoting endpoint using the
   ["another instance technique"][instance].

### Online Deployment of PowerShell

Deploy PowerShell to Nano Server using the following steps.

```powershell
# Replace the placeholder information for the following variables:
$ipaddr = '<Nano Server IP address>'
$credential = Get-Credential # <An Administrator account on the system>
$zipfile = 'PowerShell-7.1.5-win-x64.zip'
# Connect to the built-in instance of Windows PowerShell
$session = New-PSSession -ComputerName $ipaddr -Credential $credential
# Copy the file to the Nano Server instance
Copy-Item $zipfile c:\ -ToSession $session
# Enter the interactive remote session
Enter-PSSession $session
# Extract the ZIP file
Expand-Archive -Path C:\PowerShell-7.1.5-win-x64.zip -DestinationPath 'C:\Program Files\PowerShell 7'
```

If you want WSMan-based remoting, follow the instructions to create a remoting endpoint using the
["another instance technique"][instance].

## PowerShell remoting

PowerShell supports the PowerShell Remoting Protocol (PSRP) over both WSMan and SSH. For more
information, see:

- [SSH Remoting in PowerShell][ssh-remoting]
- [WSMan Remoting in PowerShell][wsman-remoting]

The following prerequisites must be met to enable PowerShell remoting over WSMan on older versions
of Windows.

- Install the Windows Management Framework (WMF) 5.1 (as necessary). For more information about WMF,
  see [WMF Overview](/powershell/scripting/wmf/overview).
- Install the [Universal C Runtime](https://www.microsoft.com/download/details.aspx?id=50410) on
  Windows versions predating Windows 10. It's available via direct download or Windows Update. Fully
  patched systems already have this package installed.

## Supported versions of Windows

[!INCLUDE [Windows support](../../includes/windows-support.md)]

You can check the version that you are using by running `winver.exe`.

## Installation support

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
cannot support those methods.

<!-- link references -->

[client-faq]: /lifecycle/faq/windows
[current]: https://aka.ms/powershell-release?tag=stable
[lts]: https://aka.ms/powershell-release?tag=lts
[preview]: https://aka.ms/powershell-release?tag=preview
[eol-windows]: /lifecycle/products/?terms=Windows%20Server&products=windows
[instance]: ../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md#executed-by-another-instance-of-powershell-on-behalf-of-the-instance-that-it-will-register
[iotimport]: https://github.com/ms-iot/iot-adk-addonkit/blob/master/Tools/IoTCoreImaging/Docs/Import-PSCoreRelease.md#Import-PSCoreRelease
[modern]: /lifecycle/#gp/LifeWinFAQ
[mu-faq]: microsoft-update-faq.yml
[releases]: https://github.com/PowerShell/PowerShell/releases
[ssh-remoting]: ../learn/remoting/SSH-Remoting-in-PowerShell-Core.md
[store-app]: https://www.microsoft.com/store/apps/9MZ1SNWT0N5D
[winget]: /windows/package-manager/winget
[wsman-remoting]: ../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md
[arm32zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/PowerShell-7.1.5-win-arm32.zip
[arm64zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/PowerShell-7.1.5-win-arm64.zip
[x64msi]: https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/PowerShell-7.1.5-win-x64.msi
[x64zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/PowerShell-7.1.5-win-x64.zip
[x86msi]: https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/PowerShell-7.1.5-win-x86.msi
[x86zip]: https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/PowerShell-7.1.5-win-x86.zip
[72x64msi]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.10/PowerShell-7.2.0-preview.10-win-x64.msi
