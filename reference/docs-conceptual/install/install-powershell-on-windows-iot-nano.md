---
description: How to install PowerShell on Windows IoT and Nano Server.
ms.date: 11/19/2025
title: Install PowerShell on Windows IoT and Nano Server
---
# Install PowerShell on Windows IoT and Nano Server

This article describes how to install PowerShell on Windows IoT and Nano Server.

## Deploy on Windows 11 IoT

Windows 11 IoT Enterprise comes with Windows PowerShell, which is used to deploy PowerShell 7.

```powershell
# Replace the placeholder information for the following variables:
$deviceip = '<device ip address>'
$zipfile = 'PowerShell-7.5.4-win-arm64.zip'
$downloadfolder = 'U:\Users\Administrator\Downloads'
# The download location is local to the device.
# There should be enough space for the zip file and the unzipped contents.

# Create PowerShell session to target device
Set-Item -Path WSMan:\localhost\Client\TrustedHosts $deviceip
$S = New-PSSession -ComputerName $deviceIp -Credential Administrator
# Copy the ZIP package to the device
Copy-Item $zipfile -Destination $downloadfolder -ToSession $S

#Connect to the device and expand the archive
Enter-PSSession $S
Set-Location U:\Users\Administrator\Downloads
Expand-Archive .\PowerShell-7.5.4-win-arm64.zip

# Set up remoting to PowerShell 7
Set-Location .\PowerShell-7.5.4-win-arm64
# Be sure to use the -PowerShellHome parameter otherwise it tries to create a new
# endpoint with Windows PowerShell 5.1
.\Install-PowerShellRemoting.ps1 -PowerShellHome .
```

When you set up PowerShell Remoting you get an error message and are disconnected from the device.
PowerShell has to restart WinRM. Now you can connect to PowerShell 7 endpoint on device.

```powershell

# Be sure to use the -Configuration parameter. If you omit it, you connect to Windows PowerShell 5.1
Enter-PSSession -ComputerName $deviceIp -Credential Administrator -Configuration PowerShell.7.5.4
```

Windows 11 IoT Core adds Windows PowerShell when you include _IOT_POWERSHELL_ feature. Use Windows
PowerShell to deploy PowerShell 7 using the same steps as Windows 11 IoT Enterprise.

To add the latest PowerShell in the shipping image, use the [Import-PSCoreRelease][02] command to
include the package in the workarea and add the _OPENSRC_POWERSHELL_ feature to your image.

> [!NOTE]
> For ARM64 architecture, Windows PowerShell isn't added when you include _IOT_POWERSHELL_. So the
> zip based install doesn't work. You need to use `Import-PSCoreRelease` command to add it in
> the image.

## Deploying on Nano Server

These instructions assume that the Nano Server is a "headless" OS that has a version of PowerShell
already running on it. For more information, see the [Nano Server Image Builder][01]
documentation.

PowerShell binaries can be deployed using two different methods.

1. Offline - Mount the Nano Server VHD and unzip the contents of the zip file to your chosen
   location within the mounted image.
1. Online - Transfer the zip file over a PowerShell Session and unzip it in your chosen location.

In both cases, you need the [Windows x64 ZIP release package][03]. Run the commands within an
"Administrator" instance of PowerShell.

### Offline Deployment of PowerShell

1. Use your favorite zip utility to unzip the package to a directory within the mounted Nano Server
   image.
1. Unmount the image and boot it.
1. Connect to the built-in instance of Windows PowerShell.

### Online Deployment of PowerShell

Deploy PowerShell to Nano Server using the following steps.

```powershell
# Replace the placeholder information for the following variables:
$ipaddr = '<Nano Server IP address>'
$credential = Get-Credential # <An Administrator account on the system>
$zipfile = 'PowerShell-7.5.4-win-x64.zip'
# Connect to the built-in instance of Windows PowerShell
$session = New-PSSession -ComputerName $ipaddr -Credential $credential
# Copy the file to the Nano Server instance
Copy-Item $zipfile C:\ -ToSession $session
# Enter the interactive remote session
Enter-PSSession $session
# Extract the ZIP file
Expand-Archive -Path C:\PowerShell-7.5.4-win-x64.zip -DestinationPath 'C:\Program Files\PowerShell 7'
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
[01]: /windows-server/get-started/deploy-nano-server
[02]: https://github.com/ms-iot/iot-adk-addonkit/blob/master/Tools/IoTCoreImaging/Docs/Import-PSCoreRelease.md#Import-PSCoreRelease
[03]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x64.zip
