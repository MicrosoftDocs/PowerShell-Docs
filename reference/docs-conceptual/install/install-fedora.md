---
title: Installing PowerShell on Fedora Linux
description: Information about installing PowerShell on Fedora Linux
ms.date: 08/09/2021
---
# Installing PowerShell on Fedora Linux

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall the previous
> version using the [binary archive](install-other-linux.md#binary-archives) method.

Fedora uses DNF as its package manager.

[!INCLUDE [Fedora support](../../includes/fedora-support.md)]

## Installation via Package Repository

PowerShell for Linux is published to official Microsoft repositories for easy installation and
updates.

```sh
# Register the Microsoft signature key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Update the list of products
sudo dnf check-update

# Install a system component
sudo dnf install compat-openssl10

# Install PowerShell
sudo dnf install -y powershell

# Start PowerShell
pwsh
```

## Installation via Direct Download

PowerShell 7.2 introduced a universal package that makes installation easier. The universal package
contains the dependencies needed by the package. Download the RPM package from the
[releases][releases] page onto your openSUSE computer. The links to the current versions are:

- PowerShell 7.2-preview.9 - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-preview-7.2.0_preview.9-1.rh.x86_64.rpm`
- PowerShell 7.1.4 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-1.rhel.7.x86_64.rpm`
- PowerShell 7.0.7 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-7.0.7-1.rhel.7.x86_64.rpm`

The following shell command installs PowerShell 7.2-preview.9:

```sh
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-preview-7.2.0_preview.9-1.rh.x86_64.rpm
```

Use the following shell commands to download and install the package. Change the URL to match the
PowerShell version that you want to install.

```sh
sudo dnf install compat-openssl10
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-1.rhel.7.x86_64.rpm
```

## Uninstall PowerShell from Fedora

```sh
sudo dnf remove powershell
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
[eol-fedora]: https://fedoraproject.org/wiki/End_of_life
