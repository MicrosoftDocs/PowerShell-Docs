---
description: Information about installing PowerShell on Red Hat Enterprise Linux (RHEL)
ms.date: 03/18/2026
title: Install PowerShell 7 on Red Hat Enterprise Linux (RHEL)
---
# Install PowerShell 7 on Red Hat Enterprise Linux (RHEL)

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][03] article.

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions.

## Choose an installation method

On RHEL, you can install PowerShell using the universal `.rpm` package from the Microsoft
package repository or by downloading file from the GitHub release page.

### Install PowerShell 7 from the Package Repository

Microsoft builds and supports a variety of software products for Linux systems and makes them
available via Linux packaging clients (apt, dnf, yum, etc). These Linux software packages are hosted
on the _Linux package repository for Microsoft products_, [https://packages.microsoft.com][01], also
known as _PMC_.

Installing PowerShell from PMC is the preferred method of installation.

> [!NOTE]
> This script only works for supported versions of RHEL that have a package published to the
> Microsoft package repository.

```sh
#!/bin/bash
###################################
# Prerequisites

# Get version of RHEL
source /etc/os-release
if [ ${VERSION_ID%.*} -ge 8 ]
then majorver=8
elif [ ${VERSION_ID%.*} -ge 9 ]
then majorver=9
fi

# Download the Microsoft RedHat repository package
curl -sSL -O https://packages.microsoft.com/config/rhel/$majorver/packages-microsoft-prod.rpm

# Register the Microsoft RedHat repository
sudo rpm -i packages-microsoft-prod.rpm

# Delete the downloaded package after installing
rm packages-microsoft-prod.rpm

# Update package index files
sudo dnf update
# Install PowerShell
sudo dnf install powershell -y
```

### Manually download and install PowerShell 7

Download the universal package from the GitHub releases page. Select the URL of the package version
you want to install.

- PowerShell 7.6 (LTS) universal package
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-1.rh.x86_64.rpm`
- PowerShell 7.5 universal package
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-1.rh.x86_64.rpm`
- PowerShell 7.4 (LTS) universal package
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell-7.4.14-1.rh.x86_64.rpm`

The following shell script downloads and installs the current release of PowerShell. You can change
the URL to download the version of PowerShell that you want to install.

```sh
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-1.rh.x86_64.rpm
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

PowerShell respects the [XDG Base Directory Specification][02] on Linux.

## Uninstall PowerShell 7

```sh
sudo dnf remove powershell
```

## Supported versions of RHEL

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

## Supported installation methods

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods.

<!-- link references -->
[01]: https://packages.microsoft.com
[02]: https://specifications.freedesktop.org/basedir/latest/
[03]: PowerShell-Support-Lifecycle.md
