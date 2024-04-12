---
description: PowerShell may run on Linux distributions that aren't officially supported by Microsoft.
ms.date: 01/12/2024
title: Community support for PowerShell on Linux
---
# Community support for PowerShell on Linux

PowerShell can be installed on some distributions of Linux that aren't supported by Microsoft. In
those cases, you may find support from the community for PowerShell on those platforms.

To be supported by Microsoft, the Linux distribution must meet the following criteria:

- The version and architecture of the distribution is supported by .NET Core.
- The version of the distribution is supported for at least one year.
- The version of the distribution isn't an interim release or equivalent.
- The PowerShell team has tested the version of the distribution.

For more information, see the [PowerShell Support Lifecycle][10]
documentation.

The following distributions are supported by the community. Each distribution has its own community
support mechanisms. Consult the distribution's website to find their community resources. You may
also get help from these [PowerShell Community][01] resources.

## Ubuntu interim releases

The documented steps to install PowerShell on [Ubuntu][08] may work on Ubuntu interim releases.
However, PowerShell is only supported on the LTS releases of Ubuntu. Microsoft doesn't support
[interim releases][05] of Ubuntu.

## Arch Linux

> [!NOTE]
> Arch support isn't officially supported by Microsoft and is maintained by the community.

PowerShell is available from the [Arch Linux][07] User Repository (AUR).

- It can be compiled with the [latest tagged release][04]
- It can be compiled from the [latest commit to master][03]
- It can be installed using the [latest release binary][02]

Packages in the AUR are maintained by the community. For more information on installing packages
from the AUR, see the [Arch Linux wiki][06] or [Using PowerShell in Docker][09].

## Kali

> [!NOTE]
> Kali support isn't officially supported by Microsoft and is maintained by the community.

### Installation - Kali

```sh
# Install PowerShell package
apt update && apt -y install powershell

# Start PowerShell
pwsh
```

### Uninstallation - Kali

```sh
# Uninstall PowerShell package
apt -y remove powershell
```

## Raspberry Pi OS

[Raspberry Pi OS][13] (formerly Raspbian) is a free operating system based on Debian.

> [!IMPORTANT]
> .NET isn't supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi
> devices prior to Raspberry Pi 2.

### Install on Raspberry Pi OS

Download the tar.gz package from the [releases][12] page onto your Raspberry Pi computer. The links
to the current versions are:

- PowerShell 7.4.2 - latest LTS release
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-7.4.2-linux-arm32.tar.gz`
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-7.4.2-linux-arm64.tar.gz`
- PowerShell 7.3.12 - latest stable release
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.3.12/powershell-7.3.12-linux-arm32.tar.gz`
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.3.12/powershell-7.3.12-linux-arm64.tar.gz`

Use the following shell commands to download and install the package. This script detects whether
you are running a 32 or 64-bit OS and installs the latest stable version of PowerShell for that
processor type.

```sh
###################################
# Prerequisites

# Update package lists
sudo apt-get update

# Install dependencies
sudo apt-get install jq libssl1.1 libunwind8 -y

###################################
# Download and extract PowerShell

# Grab the latest tar.gz
bits=$(getconf LONG_BIT)
release=$(curl -sL https://api.github.com/repos/PowerShell/PowerShell/releases/latest)
package=$(echo $release | jq -r ".assets[].browser_download_url" | grep "linux-arm${bits}.tar.gz")
wget $package

# Make folder to put powershell
mkdir ~/powershell

# Unpack the tar.gz file
tar -xvf "./${package##*/}" -C ~/powershell

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

<!-- link references -->
[01]: ../community/community-support.md
[02]: https://aur.archlinux.org/packages/powershell-bin/
[03]: https://aur.archlinux.org/packages/powershell-git/
[04]: https://aur.archlinux.org/packages/powershell/
[05]: https://ubuntu.com/about/release-cycle
[06]: https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages
[07]: https://www.archlinux.org/download/
[08]: install-ubuntu.md
[09]: powershell-in-docker.md
[10]: powershell-support-lifecycle.md
[12]: install-other-linux.md#binary-archives
[13]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md
