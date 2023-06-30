---
description: Information about installing PowerShell on Red Hat Enterprise Linux (RHEL)
ms.date: 06/28/2023
title: Installing PowerShell on Red Hat Enterprise Linux (RHEL)
---
# Installing PowerShell on Red Hat Enterprise Linux (RHEL)

All packages are available on our GitHub [releases][05] page. After the package is installed, run
`pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release. Before installing,
check the list of [Supported versions][03] below.

> [!NOTE]
> PowerShell 7.3 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.3 side-by-side with a previous version, reinstall the previous
> version using the [binary archive][07] method.

RHEL 7 uses yum and RHEL 8 uses the dnf package manager.

## Installation via Package Repository

PowerShell for Linux is published to official Microsoft repositories for easy installation and
updates.

On RHEL 9:

The PowerShell RPMs aren't published to the RHEL 9 repository yet. For RHEL 9, you need to
[install PowerShell via direct download](#installation-via-direct-download).

On RHEL 8:

```sh
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/8/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo dnf install --assumeyes powershell

# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository once. After registration, you can update PowerShell
with `sudo dnf upgrade powershell`.

On RHEL 7:

```sh
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install --assumeyes powershell

# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository once. After registration, you can update PowerShell
with `sudo yum update powershell`.

### Installation via direct download

Starting with version 7.2, PowerShell is distributed as a universal RPM package. Previous versions
of PowerShell had separate package for each OS. Download the RPM package you need onto your CentOS
machine.

- PowerShell 7.3.5 - `https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-1.rh.x86_64.rpm`
- PowerShell 7.2.12- `https://github.com/PowerShell/PowerShell/releases/download/v7.2.12/powershell-lts-7.2.12-1.rh.x86_64.rpm`

Use the following shell command to install the latest RPM package on the target version of RHEL.
Change the URL in the following shell commands to match the version you need.

On RHEL 9:

```sh
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-1.rh.x86_64.rpm
```

On RHEL 8:

```sh
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-1.rh.x86_64.rpm
```

On RHEL 7:

```sh
sudo yum install https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-1.rh.x86_64.rpm
```

## Uninstallation - Red Hat Enterprise Linux (RHEL) 7

```sh
sudo yum remove powershell
```

## Support for Arm processors

PowerShell 7.2 and newer supports running on RHEL using a 64-bit Arm processor. Use the binary
archive installation method of installing PowerShell that is described in
[Alternate ways to install PowerShell on Linux][07].

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

PowerShell respects the [XDG Base Directory Specification][06] on Linux.

## Supported versions

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft cannot support those methods.

<!-- link references -->
[03]: #supported-versions
[05]: https://aka.ms/PowerShell-Release?tag=stable
[06]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[07]: install-other-linux.md#binary-archives
