---
description: Information about installing PowerShell on Red Hat Enterprise Linux (RHEL)
ms.date: 10/15/2021
title: Installing PowerShell on Red Hat Enterprise Linux (RHEL)
---
# Installing PowerShell on Red Hat Enterprise Linux (RHEL)

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release. Before
installing, check the list of [Supported versions](#supported-versions) below.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall the previous
> version using the [binary archive](install-other-linux.md#binary-archives) method.

RHEL 7 uses yum and RHEL 8 uses the dnf package manager.

## Installation via Package Repository

PowerShell for Linux is published to official Microsoft repositories for easy installation and
updates.

On RHEL 7:

```sh
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install -y powershell

# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository once. After registration, you can update PowerShell
with `sudo yum update powershell`.

On RHEL 8:

```sh
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/8/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo dnf install powershell

# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository once. After registration, you can update PowerShell
with `sudo dnf upgrade powershell`.

### Installation via direct download

PowerShell 7.2 is distributed as a universal RPM package. Previous versions of PowerShell had
separate package for each OS. Download the RPM package you need onto your CentOS machine.

- PowerShell 7.2-preview.10 - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.10/powershell-preview-7.2.0_preview.10-1.rh.x86_64.rpm`
- PowerShell 7.1.5
  - CentOS 7 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/powershell-7.1.5-1.rhel.7.x86_64.rpm`
  - CentOS 8 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/powershell-7.1.5-1.centos.8.x86_64.rpm`
- PowerShell 7.0.8
  - CentOS 7 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.8/powershell-7.0.8-1.rhel.7.x86_64.rpm`
  - CentOS 8 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.8/powershell-7.0.8-1.centos.8.x86_64.rpm`

Use the following shell command to install the RPM package on the target version of RHEL. Change the
URL in the following shell commands to match the version you need.

On RHEL 7:

```sh
sudo yum install https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.10/powershell-preview-7.2.0_preview.10-1.rh.x86_64.rpm
```

On RHEL 8:

```sh
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.10/powershell-preview-7.2.0_preview.10-1.rh.x86_64.rpm
```

## Uninstallation - Red Hat Enterprise Linux (RHEL) 7

```sh
sudo yum remove powershell
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

## Supported versions

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft cannot support those methods.

<!-- link references -->
[releases]: https://aka.ms/PowerShell-Release?tag=stable
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[lifecycle]: ../PowerShell-Support-Lifecycle.md
[eol-rhel]: https://access.redhat.com/support/policy/updates/errata/
