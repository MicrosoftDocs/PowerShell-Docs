---
description: Information about installing PowerShell on Raspberry Pi OS
ms.date: 06/28/2023
title: Installing PowerShell on Raspberry Pi OS
---
# Installing PowerShell on Raspberry Pi OS

All packages are available on our GitHub [releases][01] page. After the package is installed, run
`pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release.

> [!NOTE]
> PowerShell 7.3 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.3 side-by-side with a previous version, reinstall the previous
> version using the [binary archive][04] method.

## Raspberry Pi OS

[Raspberry Pi OS][03] (formerly Raspbian) is a free operating system based on Debian.

> [!IMPORTANT]
> .NET isn't supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi
> devices prior to Raspberry Pi 2.

### Install on Raspberry Pi OS

Download the tar.gz package from the [releases][01] page onto your Raspberry Pi computer. The links
to the current versions are:

- PowerShell 7.3.5 - `https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-linux-arm32.tar.gz`
- PowerShell 7.2.12 - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.12/powershell-7.2.12-linux-arm32.tar.gz`

Use the following shell commands to download and install the package. Change the URL to match the
PowerShell version that you want to install.

```sh
###################################
# Prerequisites

# Update package lists
sudo apt-get update

# Install dependencies
sudo apt-get install libssl1.1 libunwind8 -y

###################################
# Download and extract PowerShell

# Grab the latest tar.gz
wget https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-linux-arm32.tar.gz

# Make folder to put powershell
mkdir ~/powershell

# Unpack the tar.gz file
tar -xvf ./powershell-7.3.5-linux-arm32.tar.gz -C ~/powershell

# Start PowerShell
~/powershell/pwsh
```

Optionally, you can create a symbolic link to start PowerShell without specifying the path to the
`pwsh` binary.

```sh
# Start PowerShell from bash with sudo to create a symbolic link
sudo ~/powershell/pwsh -command 'New-Item -ItemType SymbolicLink -Path "/usr/bin/pwsh" -Target "$PSHOME/pwsh" -Force'

# alternatively you can run following to create a symbolic link
# sudo ln -s ~/powershell/pwsh /usr/bin/pwsh

# Now to start PowerShell you can just run "pwsh"
```

### Uninstallation - Raspberry Pi OS

```sh
rm -rf ~/powershell
```

## PowerShell paths

- `$PSHOME` is `/opt/microsoft/powershell/7/`
- User profiles are read from `~/.config/powershell/profile.ps1`
- Default profiles are read from `$PSHOME/profile.ps1`
- User modules are read from `~/.local/share/powershell/Modules`
- Shared modules are read from `/usr/local/share/powershell/Modules`
- Default modules are read from `$PSHOME/Modules`
- PSReadLine history is recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

The profiles respect PowerShell's per-host configuration, so the default host-specific profiles
exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][02] on Linux.

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft can't support those methods.

The Raspberry Pi OS is available for Arm 64 processors. PowerShell hasn't been tested on Arm 64
for the Raspberry Pi OS.

<!-- link references -->
[01]: https://aka.ms/PowerShell-Release?tag=stable
[02]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[03]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md
[04]: install-other-linux.md#binary-archives
