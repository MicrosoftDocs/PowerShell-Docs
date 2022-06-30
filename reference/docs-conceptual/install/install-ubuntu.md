---
description: Information about installing PowerShell on Ubuntu
ms.date: 05/18/2022
title: Installing PowerShell on Ubuntu
---
# Installing PowerShell on Ubuntu

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release. Before
installing, check the list of [Supported versions](#supported-versions) below.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall the previous
> version using the [binary archive](install-other-linux.md#binary-archives) method.

Ubuntu uses APT (Advanced Package Tool) as a package manager.

## Installation via Package Repository

PowerShell for Linux is published to package repositories for easy installation and updates. The URL
to the package varies by OS version:

- Ubuntu 22.04 - `https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb`
- Ubuntu 20.04 - `https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb`
- Ubuntu 18.04 - `https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb`

Use the following shell commands to install PowerShell on the target OS.

> [!NOTE]
> This only works for supported versions of Ubuntu.

```sh
# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
sudo apt-get install -y powershell
# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository once. After registration, you can update
PowerShell with `sudo apt-get install powershell`.

## Installation via Direct Download

PowerShell 7.2 introduced a universal package that makes installation easier. Download the installer
package from the [releases][releases] page onto the Ubuntu machine. The link to the current
version is:

- PowerShell 7.2.5 (universal package) for any support version of Ubuntu
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/powershell-lts_7.2.5-1.deb_amd64.deb`
- PowerShell 7.0.11
  - Ubuntu 20.04 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.11/powershell-lts_7.0.11-1.ubuntu.20.04_amd64.deb`
  - Ubuntu 18.04 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.11/powershell-lts_7.0.11-1.ubuntu.18.04_amd64.deb`

Use the following shell commands to install the package. Change the filename of the package to match
the version you downloaded.

```sh
# Install the downloaded package
sudo dpkg -i powershell-lts_7.2.5-1.deb_amd64.deb

# Resolve missing dependencies and finish the install (if necessary)
sudo apt-get install -f
```

> [!NOTE]
> If the `dpkg -i` command fails with unmet dependencies, the next command, `apt-get install -f`
> resolves these issues then finishes configuring the PowerShell package.

## Uninstallation - Ubuntu 16.04

```sh
sudo apt-get remove powershell
```

## Support for Arm processors

PowerShell 7.2 supports running on Ubuntu using 32-bit or 64-bit Arm processors. Use the binary
archive installation method of installing PowerShell that is described in
[Alternate ways to install PowerShell on Linux](install-other-linux.md#binary-archives).

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

PowerShell respects the [XDG Base Directory Specification][xdg-bds] on Linux.

## Supported versions

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft cannot support those methods.

<!-- link references -->
[releases]: https://aka.ms/PowerShell-Release?tag=stable
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[lifecycle]: ../PowerShell-Support-Lifecycle.md
[eol-ubuntu]: https://wiki.ubuntu.com/Releases
