---
title: Installing PowerShell on openSUSE Linux
description: Information about installing PowerShell on openSUSE Linux
ms.date: 08/06/2021
---
# Installing PowerShell on openSUSE

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall PowerShell 6
> using the [binary archive](install-other-linux.md#binary-archives) method.

openSUSE uses zypper as the package manager.

[!INCLUDE [openSUSE support](../../includes/opensuse-support.md)]

### Installation PowerShell 7.2-preview.8

PowerShell 7.2 introduced a universal package that makes installation easier. Download the universal
package from the [releases][releases] page onto your openSUSE computer. The link to the current
version is:

- PowerShell 7.2-preview.8 - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.8/powershell-preview-7.2.0_preview.8-1.rh.x86_64.rpm`

```sh
# Download and install the universal package
sudo zypper install https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.8/powershell-preview-7.2.0_preview.8-1.rh.x86_64.rpm
```

### Installation older versions of PowerShell

Download the tar.gz package from the [releases][releases] page onto your openSUSE computer.

- PowerShell 7.1.3 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/powershell-7.1.3-linux-x64.tar.gz`
- PowerShell 7.0.6 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.6/powershell-7.0.6-linux-x64.tar.gz`

Use the following shell commands to download and install the package. Change the URL to match the
PowerShell version that you want.

```sh
# Install dependencies
zypper update && zypper --non-interactive install curl tar gzip libopenssl1_0_0 libicu60_2

# Download the powershell '.tar.gz' archive
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/powershell-7.1.3-linux-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

# Start PowerShell
pwsh
```

### Uninstall openSUSE

```sh
rm -rf /usr/bin/pwsh /opt/microsoft/powershell
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
[eol-suse]: https://en.opensuse.org/Lifetime
