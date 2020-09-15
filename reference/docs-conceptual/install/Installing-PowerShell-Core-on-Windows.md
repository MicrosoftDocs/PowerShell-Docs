---
title: Installing PowerShell on Windows
description: Information about installing PowerShell on Windows
ms.date: 09/14/2020
---
# Installing PowerShell on Windows

There are multiple ways to install PowerShell in Windows.

## Prerequisites

The latest release of PowerShell is supported on Windows 7 SP1, Server 2008 R2, and later versions.

To enable PowerShell remoting over WSMan, the following prerequisites need to be met:

- Install the [Universal C Runtime](https://www.microsoft.com/download/details.aspx?id=50410) on
  Windows versions predating Windows 10. It's available via direct download or Windows Update. Fully
  patched systems already have this package installed.
- Install the Windows Management Framework (WMF) 4.0 or newer on Windows 7 and Windows Server 2008
  R2. For more information about WMF, see [WMF Overview](/powershell/scripting/wmf/overview).

## Download the installer package

To install PowerShell on Windows, download the install package from our GitHub [releases][releases]
page. Scroll down to the **Assets** section of the Release page. The **Assets** section may be
collapsed, so you may need to click to expand it.

## <a id="msi" />Installing the MSI package

The MSI file looks like `PowerShell-<version>-win-<os-arch>.msi`. For example:

- `PowerShell-7.0.3-win-x64.msi`
- `PowerShell-7.0.3-win-x86.msi`

Once downloaded, double-click the installer and follow the prompts.

The installer creates a shortcut in the Windows Start Menu.

- By default the package is installed to `$env:ProgramFiles\PowerShell\<version>`
- You can launch PowerShell via the Start Menu or `$env:ProgramFiles\PowerShell\<version>\pwsh.exe`

> [!NOTE]
> PowerShell 7 installs to a new directory and runs side-by-side with Windows PowerShell 5.1. For
> PowerShell Core 6.x, PowerShell 7 is an in-place upgrade that removes PowerShell Core 6.x.
>
> - PowerShell 7 is installed to `$env:ProgramFiles\PowerShell\7`
> - The `$env:ProgramFiles\PowerShell\7` folder is added to `$env:PATH`
> - The `$env:ProgramFiles\PowerShell\6` folder is deleted
>
> If you need to run PowerShell 6 side-by-side with PowerShell 7, reinstall PowerShell 6 using the
> [ZIP install](#zip) method.

### Administrative install from the command line

MSI packages can be installed from the command line allowing administrators to deploy packages
without user interaction. The MSI package includes the following properties to control the
installation options:

- **ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL** - This property controls the option for adding the
  **Open PowerShell** item to the context menu in Windows Explorer.
- **ENABLE_PSREMOTING** - This property controls the option for enabling PowerShell remoting during
  installation.
- **REGISTER_MANIFEST** - This property controls the option for registering the Windows Event
  Logging manifest.

The following example shows how to silently install PowerShell with all the install options enabled.

```powershell
msiexec.exe /package PowerShell-7.0.3-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
```

For a full list of command-line options for `Msiexec.exe`, see [Command line options](/windows/desktop/Msi/command-line-options).

### Registry keys created during installation

Beginning in PowerShell 7.1, the MSI package creates registry keys that store the installation
location and version of PowerShell. These values are located in
`HKLM\Software\Microsoft\PowerShellCore\InstalledVersions\<GUID>`. The value of
`<GUID>` is unique for each build type (release or preview), major version, and architecture.

|    Release    | Architecture |                                          Registry Key                                           |
| ------------- | :----------: | ----------------------------------------------------------------------------------------------- |
| 7.1.x Release |     x86      | `HKLM\Software\Microsoft\PowerShellCore\InstalledVersions\1d00683b-0f84-4db8-a64f-2f98ad42fe06` |
| 7.1.x Release |     x64      | `HKLM\Software\Microsoft\PowerShellCore\InstalledVersions\31ab5147-9a97-4452-8443-d9709f0516e1` |
| 7.1.x Preview |     x86      | `HKLM\Software\Microsoft\PowerShellCore\InstalledVersions\86abcfbd-1ccc-4a88-b8b2-0facfde29094` |
| 7.1.x Preview |     x64      | `HKLM\Software\Microsoft\PowerShellCore\InstalledVersions\39243d76-adaf-42b1-94fb-16ecf83237c8` |

This can be used by administrators and developers to find the path to PowerShell. The `<GUID>`
values will be the same for all preview and minor version releases. The `<GUID>`
values are changed for each major release.

## <a id="msix" />Installing the MSIX package

> [!NOTE]
> The MSIX package is not officially supported at this time. We continue to build the package for
> internal testing purposes only.

To manually install the MSIX package on a Windows 10 client, download the MSIX package from our
GitHub [releases][releases] page. Scroll down to the **Assets** section of the Release you want to
install. The Assets section may be collapsed, so you may need to click to expand it.

The MSIX file looks like this - `PowerShell-<version>-win-<os-arch>.msix`

To install the package, you must use the `Add-AppxPackage` cmdlet.

```powershell
Add-AppxPackage PowerShell-<version>-win-<os-arch>.msix
```

## <a id="zip" />Installing the ZIP package

PowerShell binary ZIP archives are provided to enable advanced deployment scenarios. Installing the
ZIP archive doesn't check the prerequisites like the MSI packages do. Download the ZIP archive from
the [releases][releases] page. Depending on how you download the file you may need to unblock the
file using the `Unblock-File` cmdlet. Unzip the contents to the location of your choice and run
`pwsh.exe` from there. For remoting over WSMan to work properly, ensure that you've met the
[prerequisites](#prerequisites).

## Deploying on Windows 10 IoT Enterprise

Windows 10 IoT Enterprise comes with Windows PowerShell, which we can use to deploy PowerShell 7.

1. Create `PSSession` to target device

   ```powershell
   Set-Item -Path WSMan:\localhost\Client\TrustedHosts <deviceip>
   $S = New-PSSession -ComputerName <deviceIp> -Credential Administrator
   ```

1. Copy the ZIP package to the device

   ```powershell
   # change the destination to however you had partitioned it with sufficient
   # space for the zip and the unzipped contents
   # the path should be local to the device
   Copy-Item .\PowerShell-<version>-win-<os-arch>.zip -Destination u:\users\administrator\Downloads -ToSession $s
   ```

1. Connect to the device and expand the archive

   ```powershell
   Enter-PSSession $s
   Set-Location u:\users\administrator\downloads
   Expand-Archive .\PowerShell-<version>-win-<os-arch>.zip
   ```

1. Set up remoting to PowerShell 7

   ```powershell
   Set-Location .\PowerShell-<version>-win-<os-arch>
   # Be sure to use the -PowerShellHome parameter otherwise it'll try to create a new
   # endpoint with Windows PowerShell 5.1
   .\Install-PowerShellRemoting.ps1 -PowerShellHome .
   # You'll get an error message and will be disconnected from the device because it has to restart WinRM
   ```

1. Connect to PowerShell 7 endpoint on device

   ```powershell
   # Be sure to use the -Configuration parameter.  If you omit it, you will connect to Windows PowerShell 5.1
   Enter-PSSession -ComputerName <deviceIp> -Credential Administrator -Configuration powershell.<version>
   ```

## Deploying on Windows 10 IoT Core

Windows 10 IoT Core adds Windows PowerShell when you include *IOT_POWERSHELL* feature, which we can use to deploy PowerShell 7.
The steps defined above for Windows 10 IoT Enterprise can be followed for IoT Core as well.

For adding the latest powershell in the shipping image, use [Import-PSCoreRelease](https://github.com/ms-iot/iot-adk-addonkit/blob/master/Tools/IoTCoreImaging/Docs/Import-PSCoreRelease.md#Import-PSCoreRelease) command to include the package in the workarea and add *OPENSRC_POWERSHELL* feature to your image.

> [!NOTE]
> For ARM64 architecture, Windows Powershell is not added when you include *IOT_POWERSHELL*. So the zip based install will not work.
> You will need to use Import-PSCoreRelease command to add it in the image.

## Deploying on Nano Server

These instructions assume that the Nano Server is a "headless" OS that has a version of PowerShell
is already running on it. For more information, see the
[Nano Server Image Builder](/windows-server/get-started/deploy-nano-server) documentation.

PowerShell binaries can be deployed using two different methods.

1. Offline - Mount the Nano Server VHD and unzip the contents of the zip file to your chosen
   location within the mounted image.
1. Online - Transfer the zip file over a PowerShell Session and unzip it in your chosen location.

In both cases, you need the Windows 10 x64 ZIP release package. Run the commands within an
"Administrator" instance of PowerShell.

### Offline Deployment of PowerShell

1. Use your favorite zip utility to unzip the package to a directory within the mounted Nano Server
   image.
1. Unmount the image and boot it.
1. Connect to the built-in instance of Windows PowerShell.
1. Follow the instructions to create a remoting endpoint using the
   ["another instance technique"](../learn/remoting/wsman-remoting-in-powershell-core.md#executed-by-another-instance-of-powershell-on-behalf-of-the-instance-that-it-will-register).

### Online Deployment of PowerShell

Deploy PowerShell to Nano Server using the following steps.

- Connect to the built-in instance of Windows PowerShell

  ```powershell
  $session = New-PSSession -ComputerName <Nano Server IP address> -Credential <An Administrator account on the system>
  ```

- Copy the file to the Nano Server instance

  ```powershell
  Copy-Item <local PS Core download location>\powershell-<version>-win-x64.zip c:\ -ToSession $session
  ```

- Enter the session

  ```powershell
  Enter-PSSession $session
  ```

- Extract the ZIP file

  ```powershell
  # Insert the appropriate version.
  Expand-Archive -Path C:\powershell-<version>-win-x64.zip -DestinationPath "C:\PowerShell_<version>"
  ```

- If you want WSMan-based remoting, follow the instructions to create a remoting endpoint using the
  ["another instance technique"](../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md#executed-by-another-instance-of-powershell-on-behalf-of-the-instance-that-it-will-register).

## Install as a .NET Global tool

If you already have the [.NET Core SDK](/dotnet/core/sdk) installed, it's easy to install PowerShell
as a [.NET Global tool](/dotnet/core/tools/global-tools).

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `$env:USERPROFILE\dotnet\tools` to your `$env:PATH` environment
variable. However, the currently running shell doesn't have the updated `$env:PATH`. You can start
PowerShell from a new shell by typing `pwsh`.

## Install PowerShell via Winget

The `winget` command-line tool enables developers to discover, install, upgrade, remove and configure
applications on Windows 10 computers. This tool is the client interface to the Windows Package Manager
service.

> [!NOTE]
> The `winget` tool is currently a preview. Not all planned functionality is available at this time.
> The tool's options and features are subject to change. You should not use this method in a
> production deployment scenario. See the [winget] documentation for a list of system requirements
> and install instructions.

The following commands can be used to install PowerShell using the published `winget` packages:

1. Search for the latest version of PowerShell

   ```powershell
   winget search Microsoft.PowerShell
   ```

   ```Output
   Name               Id                           Version
   ---------------------------------------------------------------
   PowerShell         Microsoft.PowerShell         7.0.3
   PowerShell-Preview Microsoft.PowerShell-Preview 7.1.0-preview.5
   ```

1. Install a version of PowerShell using the `--exact` parameter

   ```powershell
   winget install --name PowerShell --exact
   winget install --name PowerShell-Preview --exact
   ```

## How to create a remoting endpoint

PowerShell supports the PowerShell Remoting Protocol (PSRP) over both WSMan and SSH. For more
information, see:

- [SSH Remoting in PowerShell Core][ssh-remoting]
- [WSMan Remoting in PowerShell Core][wsman-remoting]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other sources. While those tools and methods may work, Microsoft cannot
support those methods.

<!-- link references -->

[releases]: https://github.com/PowerShell/PowerShell/releases
[ssh-remoting]: ../learn/remoting/SSH-Remoting-in-PowerShell-Core.md
[wsman-remoting]: ../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md
[AppVeyor]: https://ci.appveyor.com/project/PowerShell/powershell
[winget]: /windows/package-manager/winget
