---
description: Information about installing PowerShell on Debian Linux
ms.date: 05/18/2022
title: Installing PowerShell on Debian Linux
---
# Installing PowerShell on Debian Linux

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release. Before
installing, check the list of [Supported versions](#supported-versions) below.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall the previous
> version using the [binary archive](install-other-linux.md#binary-archives) method.

Debian uses APT (Advanced Package Tool) as a package manager.

## Installation via direct download

PowerShell 7.2 introduced a universal package that makes installation easier. Download the universal
package from the [releases][releases] page onto the Debian 10 machine. The link to the current
version is:

- PowerShell 7.2.5 - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/powershell-lts_7.2.5-1.deb_amd64.deb`
- PowerShell 7.0.11
  - Debian 10 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.11/powershell-lts_7.0.11-1.debian.10_amd64.deb`

## Installation on Debian 11 via Package Repository

PowerShell for Linux is published to package repositories for easy installation and updates.

The preferred method is as follows:

```sh
# Install system components
sudo apt update  && sudo apt install -y curl gnupg apt-transport-https

# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Product feed
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'

# Install PowerShell
sudo apt update && sudo apt install -y powershell

# Start PowerShell
pwsh
```

## Installation on Debian 10 via Package Repository

PowerShell for Linux is published to package repositories for easy installation and updates.

The preferred method is as follows:

```sh
# Download the Microsoft repository GPG keys
wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

## Uninstallation

```sh
sudo apt-get remove powershell
```

## Support for Arm processors

PowerShell 7.2 supports running on Debian using 32-bit or 64-bit Arm processors. Use the binary
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

[!INCLUDE [Debian support](../../includes/debian-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft cannot support those methods.

<!-- link references -->
[releases]: https://aka.ms/PowerShell-Release?tag=stable
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[lifecycle]: ../PowerShell-Support-Lifecycle.md
[eol-debian]: https://wiki.debian.org/DebianReleases
