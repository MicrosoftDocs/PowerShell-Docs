---
description: How to install PowerShell on Debian Linux
ms.date: 03/18/2026
title: Install PowerShell 7 on Debian
---
# Install PowerShell 7 on Debian

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][05] article.

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions. If you need to run PowerShell 7.5 side-by-side
with a previous version, reinstall the previous version using the [binary archive][04] method.

## Choose an installation method

On Debian Linux, you can install PowerShell using the universal `.deb` package from the Microsoft
package repository or by downloading a file from the GitHub [releases][01] page.

### Install PowerShell 7 from the Package Repository

Microsoft builds and supports a variety of software products for Linux systems and makes them
available via Linux packaging clients (apt, dnf, yum, etc). These Linux software packages are hosted
on the _Linux package repository for Microsoft products_, [https://packages.microsoft.com][02], also
known as _PMC_.

Installing PowerShell from PMC is the preferred method of installation.

> [!NOTE]
> This script only works for supported versions of Debian that have a package published to the
> Microsoft package repository.

```sh
#!/bin/bash
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

### Manually download and install PowerShell 7

Download the universal package from the GitHub releases page. Choose the link for the version you
want to install.

- PowerShell 7.6 (LTS) universal package for supported versions of Debian
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell_7.6.0-1.deb_amd64.deb`
- PowerShell 7.5 universal package for supported versions of Debian
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell_7.5.5-1.deb_amd64.deb`
- PowerShell 7.4 (LTS) universal package for supported versions of Debian
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell_7.4.14-1.deb_amd64.deb`

The following shell script downloads and installs the current release of PowerShell. You can
change the URL to download the version of PowerShell that you want to install.

```sh
#!/bin/bash
###################################
# Prerequisites

# Update the list of packages
sudo apt-get update

# Install pre-requisite packages.
sudo apt-get install -y wget

# Download the PowerShell package file
wget https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell_7.6.0-1.deb_amd64.deb

###################################
# Install the PowerShell package
sudo dpkg -i powershell_7.6.0-1.deb_amd64.deb

# Resolve missing dependencies and finish the install (if necessary)
sudo apt-get install -f

# Delete the downloaded package file
rm powershell_7.6.0-1.deb_amd64.deb

# Start PowerShell
pwsh
```

## Start PowerShell 7

After the package is installed, run `pwsh` from a terminal. If you have installed a Preview package,
run `pwsh-preview`.

- The location of `$PSHOME` varies based on the package you installed.
  - For Stable and LTS packages: `/opt/microsoft/powershell/7/`
  - For Preview packages: `/opt/microsoft/powershell/7-preview/`
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

The profiles respect PowerShell's per-host configuration, so the default host-specific profiles
exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][03] on Linux.

## Uninstall PowerShell 7

```sh
sudo apt-get remove powershell
```

## Supported OS versions

[!INCLUDE [Debian support](../../includes/debian-support.md)]

## Supported installation methods

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft can't support those methods.

<!-- link references -->
[01]: https://github.com/PowerShell/PowerShell/releases
[02]: https://packages.microsoft.com
[03]: https://specifications.freedesktop.org/basedir/latest/
[04]: install-other-linux.md#binary-archives
[05]: PowerShell-Support-Lifecycle.md
