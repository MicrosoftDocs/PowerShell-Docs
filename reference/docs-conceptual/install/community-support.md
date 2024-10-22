---
description: PowerShell can run on Linux distributions that aren't officially supported by Microsoft.
ms.date: 08/27/2024
title: Community support for PowerShell on Linux
---
# Community support for PowerShell on Linux

You can install PowerShell on some distributions of Linux that aren't supported by Microsoft. In
those cases, you might find support from the community for PowerShell on those platforms.

Supported Linux distributions must meet the following criteria:

- The version and architecture of the distribution is supported by .NET Core.
- The version of the distribution is supported for at least one year.
- The version of the distribution isn't an interim release or equivalent.
- The PowerShell team has tested the version of the distribution.

For more information, see the [PowerShell Support Lifecycle][12] documentation.

The following distributions are examples of distributions supported by the community. Each
distribution has its own community support mechanisms. Consult the distribution's website to find
their community resources. You can also get help from these [PowerShell Community][01] resources.

## Ubuntu interim releases

The documented steps to install PowerShell on [Ubuntu][10] might work on Ubuntu interim releases.
However, Microsoft only supports PowerShell on the Long Term Servicing (LTS) releases of Ubuntu.
Microsoft doesn't support [interim releases][04] of Ubuntu.

## Arch Linux

PowerShell is available from the [Arch Linux][07] User Repository (AUR). Packages in the AUR are
maintained by the Arch community. To install the [latest release binary][02], see the
[Arch Linux wiki][05] or [Using PowerShell in Docker][11].

## Kali

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

## Gentoo

You can install PowerShell on Gentoo Linux using packages from the Gentoo package repository. For
information about installing these packages, see the [PowerShell][06] page in the Gentoo wiki.

## SLES and openSUSE

You may be able to install PowerShell on SLES and openSUSE using the SNAP package manager. Also,
the following article provides information on how to install PowerShell on openSUSE:

- [PowerShell - openSUSE Wiki][03]

## Raspberry Pi OS

[Raspberry Pi OS][08] (formerly Raspbian) is a free operating system based on Debian.

> [!IMPORTANT]
> .NET isn't supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi
> devices released before Raspberry Pi 2.

### Install on Raspberry Pi OS

Download the tar.gz package from the [releases][09] page onto your Raspberry Pi computer. The links
to the current versions are:

- PowerShell 7.4.6 - latest LTS release
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-linux-arm32.tar.gz`
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-linux-arm64.tar.gz`

Use the following shell commands to download and install the package. This script detects whether
you're running a 32-bit or 64-bit OS and installs the latest stable version of PowerShell for that
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
[03]: https://en.opensuse.org/PowerShell
[04]: https://ubuntu.com/about/release-cycle
[05]: https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages
[06]: https://wiki.gentoo.org/wiki/PowerShell
[07]: https://www.archlinux.org/download/
[08]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md
[09]: install-other-linux.md#binary-archives
[10]: install-ubuntu.md
[11]: powershell-in-docker.md
[12]: powershell-support-lifecycle.md
