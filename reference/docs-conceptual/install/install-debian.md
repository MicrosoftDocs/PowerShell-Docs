---
description: Information about installing PowerShell on Debian Linux
ms.date: 12/12/2024
title: Installing PowerShell on Debian
---
# Installing PowerShell on Debian

All packages are available on our GitHub [releases][02] page. Before installing, check the list of
[Supported versions][01] below. After the package is installed, run `pwsh` from a terminal. Run
`pwsh-lts` if you installed a preview release.

> [!NOTE]
> PowerShell 7.4 is an in-place upgrade that removes previous versions of PowerShell 7. Preview
> versions of PowerShell can be installed side-by-side with other versions of PowerShell. If you
> need to run PowerShell 7.4 side-by-side with a previous version, reinstall the previous version
> using the [binary archive][05] method.

Debian uses APT (Advanced Package Tool) as a package manager.

## Installation on Debian 11 or 12 via the Package Repository

Microsoft builds and supports a variety of software products for Linux systems and makes them
available via Linux packaging clients (apt, dnf, yum, etc). These Linux software packages are hosted
on the _Linux package repository for Microsoft products_, [https://packages.microsoft.com][03], also
known as _PMC_.

Installing PowerShell from PMC is the preferred method of installation.

> [!NOTE]
> This script only works for supported versions of Debian.

```sh
###################################
# Prerequisites

# Update the list of packages
sudo apt-get update

# Install pre-requisite packages.
sudo apt-get install -y wget

# Get the version of Debian
source /etc/os-release

# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/debian/$VERSION_ID/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Delete the Microsoft repository GPG keys file
rm packages-microsoft-prod.deb

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update

###################################
# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

## Installation via direct download

PowerShell 7.2 introduced a universal package that makes installation easier. Download the universal
package from the [releases][02] page onto your Debian machine.

The link to the current version is:

- PowerShell 7.4 (LTS) universal package for supported versions of Debian
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell_7.4.6-1.deb_amd64.deb`
- PowerShell 7.5-preview universal package for supported versions of Debian
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.5.0-rc.1/powershell-preview_7.5.0-rc.1-1.deb_amd64.deb`

The following shell script downloads and installs the current release of PowerShell. You can
change the URL to download the version of PowerShell that you want to install.

```sh
###################################
# Prerequisites

# Update the list of packages
sudo apt-get update

# Install pre-requisite packages.
sudo apt-get install -y wget

# Download the PowerShell package file
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell_7.4.6-1.deb_amd64.deb

###################################
# Install the PowerShell package
sudo dpkg -i powershell_7.4.6-1.deb_amd64.deb

# Resolve missing dependencies and finish the install (if necessary)
sudo apt-get install -f

# Delete the downloaded package file
rm powershell_7.4.6-1.deb_amd64.deb

# Start PowerShell
pwsh
```

## Uninstall PowerShell

```sh
sudo apt-get remove powershell
```

## PowerShell paths

- `$PSHOME` is `/opt/microsoft/powershell/7/`
- The profiles scripts are stored in the following locations:
  - AllUsersAllHosts - `$PSHOME/profile.ps1`
  - AllUsersCurrentHost - `$PSHOME/Microsoft.PowerShell_profile.ps1`
  - CurrentUserAllHosts - `~/.config/powershell/profile.ps1`
  - CurrentUserCurrentHost - `~/.config/powershell/Microsoft.PowerShell_profile.ps1`
- Modules are stored in the following locations:
  - User modules - `~/.local/share/powershell/Modules`
  - Shared modules - `/usr/local/share/powershell/Modules`
  - Default modules - `$PSHOME/Modules`
- PSReadLine history is recorded in `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

PowerShell respects the [XDG Base Directory Specification][04] on Linux.

## Supported versions

[!INCLUDE [Debian support](../../includes/debian-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft can't support those methods.

<!-- link references -->
[01]: #supported-versions
[02]: https://aka.ms/PowerShell-Release?tag=stable
[03]: https://packages.microsoft.com
[04]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[05]: install-other-linux.md#binary-archives
