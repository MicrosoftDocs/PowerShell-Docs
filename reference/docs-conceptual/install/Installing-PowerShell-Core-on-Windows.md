---
title: Installing PowerShell Core on Windows
description: Information about installing PowerShell Core on Windows
ms.date: 08/06/2018
---
# Installing PowerShell Core on Windows

There are multiple ways to install PowerShell Core in Windows.

## Prerequisites

To enable PowerShell remoting over WSMan, the following prerequisites need to be met:

- Install the [Universal C Runtime](https://www.microsoft.com/download/details.aspx?id=50410) on
  Windows versions prior to Windows 10. It is available via direct download or Windows Update. Fully
  patched (including optional packages), supported systems will already have this installed.
- Install the Windows Management Framework (WMF) 4.0 or newer on Windows 7 and Windows Server 2008
  R2. For more information about WMF, see [WMF Overview](/powershell/scripting/wmf/overview).

## <a id="msi" />Installing the MSI package

To install PowerShell on a Windows client or Windows Server (works on Windows 7 SP1, Server 2008 R2,
and later), download the MSI package from our GitHub [releases][releases] page. Scroll down to the
**Assets** section of the Release you want to install. The Assets section may be collapsed, so you
may need to click to expand it.

The MSI file looks like this - `PowerShell-<version>-win-<os-arch>.msi`

Once downloaded, double-click the installer and follow the prompts.

The installer creates a shortcut in the Windows Start Menu.

- By default the package is installed to `$env:ProgramFiles\PowerShell\<version>`
- You can launch PowerShell via the Start Menu or `$env:ProgramFiles\PowerShell\<version>\pwsh.exe`

> [!NOTE]
> PowerShell 7 installs to a new directory and runs side-by-side with Windows PowerShell 5.1. For
> PowerShell Core 6.x, PowerShell 7 is an in-place upgrade that removes PowerShell Core 6.x.
>
> - PowerShell 7 is installed to `%programfiles%\PowerShell\7`
> - The `%programfiles%\PowerShell\7` folder is added to `$env:PATH`
> - The `%programfiles%\PowerShell\6` folder is deleted
>
> If you need to run PowerShell 6 side-by-side with PowerShell 7, reinstall PowerShell 6 using the
> [ZIP install](#zip) method.

### Administrative install from the command line

MSI packages can be installed from the command line. This allows administrators to deploy packages
without user interaction. The MSI package for PowerShell includes the following properties to
control the installation options:

- **ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL** - This property controls the option for adding the
  **Open PowerShell** item to the context menu in Windows Explorer.
- **ENABLE_PSREMOTING** - This property controls the option for enabling PowerShell remoting during
  installation.
- **REGISTER_MANIFEST** - This property controls the option for registering the Windows Event
  Logging manifest.

The following examples shows how to silently install PowerShell Core with all the install options
enabled.

```powershell
msiexec.exe /package PowerShell-<version>-win-<os-arch>.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
```

For a full list of command line options for Msiexec.exe, see [Command line options](/windows/desktop/Msi/command-line-options).

## <a id="msix" />Installing the MSIX package

To manually install the MSIX package on a Windows 10 client, download the MSIX package from our
GitHub [releases][releases] page. Scroll down to the **Assets** section of the Release you want to
install. The Assets section may be collapsed, so you may need to click to expand it.

The MSI file looks like this - `PowerShell-<version>-win-<os-arch>.msix`

Once downloaded, you cannot simply double-click on the installer as this package requires
use of un-virtualized resources.  To install, you must use the `Add-AppxPackage` cmdlet:

```powershell
Add-AppxPackage PowerShell-<version>-win-<os-arch>.msix
```

## <a id="zip" />Installing the ZIP package

PowerShell binary ZIP archives are provided to enable advanced deployment scenarios. Be noted that
when using the ZIP archive, you won't get the prerequisites check as in the MSI package. For
remoting over WSMan to work properly, ensure that you have met the [prerequisites](#prerequisites).

## Deploying on Windows IoT

Windows IoT already comes with Windows PowerShell which we will use to deploy PowerShell Core 6.

1. Create `PSSession` to target device

   ```powershell
   $s = New-PSSession -ComputerName <deviceIp> -Credential Administrator
   ```

2. Copy the ZIP package to the device

   ```powershell
   # change the destination to however you had partitioned it with sufficient
   # space for the zip and the unzipped contents
   # the path should be local to the device
   Copy-Item .\PowerShell-<version>-win-<os-arch>.zip -Destination u:\users\administrator\Downloads -ToSession $s
   ```

3. Connect to the device and expand the archive

   ```powershell
   Enter-PSSession $s
   Set-Location u:\users\administrator\downloads
   Expand-Archive .\PowerShell-<version>-win-<os-arch>.zip
   ```

4. Setup remoting to PowerShell Core 6

   ```powershell
   Set-Location .\PowerShell-<version>-win-<os-arch>
   # Be sure to use the -PowerShellHome parameter otherwise it'll try to create a new
   # endpoint with Windows PowerShell 5.1
   .\Install-PowerShellRemoting.ps1 -PowerShellHome .
   # You'll get an error message and will be disconnected from the device because it has to restart WinRM
   ```

5. Connect to PowerShell Core 6 endpoint on device

   ```powershell
   # Be sure to use the -Configuration parameter.  If you omit it, you will connect to Windows PowerShell 5.1
   Enter-PSSession -ComputerName <deviceIp> -Credential Administrator -Configuration powershell.<version>
   ```

## Deploying on Nano Server

These instructions assume that a version of PowerShell is already running on the Nano Server image
and that it has been generated by the [Nano Server Image Builder](/windows-server/get-started/deploy-nano-server).
Nano Server is a "headless" OS. Core binaries can be deploy using two different methods.

1. Offline - Mount the Nano Server VHD and unzip the contents of the zip file to your chosen
   location within the mounted image.
2. Online - Transfer the zip file over a PowerShell Session and unzip it in your chosen location.

In both cases, you will need the Windows 10 x64 ZIP release package and will need to run the
commands within an "Administrator" PowerShell instance.

### Offline Deployment of PowerShell Core

1. Use your favorite zip utility to unzip the package to a directory within the mounted Nano Server
   image.
2. Unmount the image and boot it.
3. Connect to the inbox instance of Windows PowerShell.
4. Follow the instructions to create a remoting endpoint using the
   ["another instance technique"](../learn/remoting/wsman-remoting-in-powershell-core.md#executed-by-another-instance-of-powershell-on-behalf-of-the-instance-that-it-will-register).

### Online Deployment of PowerShell Core

The following steps guide you through the deployment of PowerShell Core to a running instance of
Nano Server and the configuration of its remote endpoint.

- Connect to the inbox instance of Windows PowerShell

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
  Expand-Archive -Path C:\powershell-<version>-win-x64.zip -DestinationPath "C:\PowerShellCore_<version>"
  ```

- If you want WSMan-based remoting, follow the instructions to create a remoting endpoint using the
  ["another instance technique"](../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md#executed-by-another-instance-of-powershell-on-behalf-of-the-instance-that-it-will-register).

## Install as a .NET Global tool

If you already have the [.NET Core SDK](/dotnet/core/sdk) installed, it's easy to install PowerShell
as a [.NET Global tool](/dotnet/core/tools/global-tools).

```
dotnet tool install --global PowerShell
```

## How to create a remoting endpoint

PowerShell Core supports the PowerShell Remoting Protocol (PSRP) over both WSMan and SSH. For more
information, see:

- [SSH Remoting in PowerShell Core][ssh-remoting]
- [WSMan Remoting in PowerShell Core][wsman-remoting]

<!-- [download-center]: TODO -->

[releases]: https://github.com/PowerShell/PowerShell/releases
[ssh-remoting]: ../learn/remoting/SSH-Remoting-in-PowerShell-Core.md
[wsman-remoting]: ../learn/remoting/WSMan-Remoting-in-PowerShell-Core.md
[AppVeyor]: https://ci.appveyor.com/project/PowerShell/powershell
