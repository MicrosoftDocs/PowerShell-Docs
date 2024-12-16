---
description: Information about installing PowerShell on Alpine Linux
ms.date: 12/16/2024
title: Installing PowerShell on Alpine Linux
---
# Installing PowerShell on Alpine Linux

All packages are available on our GitHub [releases][03] page. After the package is installed, run
`pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release. Before installing,
check the list of [Supported versions][02] below.

> [!NOTE]
> PowerShell 7.4 is an in-place upgrade that removes previous versions of PowerShell 7. Preview
> versions of PowerShell can be installed side-by-side with other versions of PowerShell. If you
> need to run PowerShell 7.4 side-by-side with a previous version, reinstall the previous version
> using the [binary archive][05] method.

## Installation steps

Installation on Alpine is based on downloading tar.gz package from the [releases][03] page. The URL
to the package depends on the version of PowerShell you want to install.

- PowerShell 7.4.6 - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-linux-musl-x64.tar.gz`
- PowerShell 7.5.0-rc.1 - `https://github.com/PowerShell/PowerShell/releases/download/v7.5.0-rc.1/powershell-7.5.0-rc.1-linux-musl-x64.tar.gz`

Then, in the terminal, execute the following shell commands to install PowerShell 7.4:

```sh
# install the requirements
sudo apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl3 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl

apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust \
    openssh-client \

# Download the powershell '.tar.gz' archive
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
sudo chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

# Start PowerShell
pwsh
```

## Uninstall PowerShell

```sh
sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell
```

## PowerShell paths

- `$PSHOME` is `/opt/microsoft/powershell/7/`
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

PowerShell respects the [XDG Base Directory Specification][04] on Linux.

## Supported versions

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other third-party sources. While those tools and methods may work,
Microsoft can't support those methods.

<!-- link references -->
[02]: #supported-versions
[03]: https://aka.ms/PowerShell-Release?tag=stable
[04]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[05]: install-other-linux.md#binary-archives
