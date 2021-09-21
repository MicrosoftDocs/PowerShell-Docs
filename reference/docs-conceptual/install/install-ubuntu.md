---
title: Installing PowerShell on Ubuntu
description: Information about installing PowerShell on Ubuntu
ms.date: 08/09/2021
---
# Installing PowerShell on Ubuntu

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall the previous
> version using the [binary archive](install-other-linux.md#binary-archives) method.

Ubuntu uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

## Installation via Package Repository

PowerShell for Linux is published to package repositories for easy installation and updates. The URL
to the package varies by OS version:

- Ubuntu 21.04 - `https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb`
- Ubuntu 20.04 - `https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb`
- Ubuntu 18.04 - `https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb`

Use the following shell commands to install PowerShell on the target OS. Change the URL to match the
version of the target OS.

```sh
# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
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

- PowerShell 7.2-preview.9 (universal package) for any support version of Ubuntu
  - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-preview_7.2.0-preview.9-1.deb_amd64.deb`
- PowerShell 7.1.4
  - Ubuntu 20.04 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell_7.1.4-1.ubuntu.20.04_amd64.deb`
  - Ubuntu 18.04 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell_7.1.4-1.ubuntu.18.04_amd64.deb`
- PowerShell 7.0.7
  - Ubuntu 20.04 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-lts_7.0.7-1.ubuntu.20.04_amd64.deb`
  - Ubuntu 18.04 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-lts_7.0.7-1.ubuntu.18.04_amd64.deb`

Use the following shell commands to install the package. Change the filename of the package to match
the version you downloaded.

```sh
# Install the downloaded package
sudo dpkg -i powershell-preview_7.2.0-preview.9-1.deb_amd64.deb

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

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft cannot support those methods.

<!-- link references -->
[releases]: https://aka.ms/PowerShell-Release?tag=stable
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[lifecycle]: ../PowerShell-Support-Lifecycle.md
[eol-ubuntu]: https://wiki.ubuntu.com/Releases
