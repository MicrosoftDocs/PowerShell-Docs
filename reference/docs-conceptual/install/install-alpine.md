---
description: How to install PowerShell on Alpine Linux
ms.date: 03/18/2026
title: Install PowerShell 7 on Alpine Linux
---
# Install PowerShell 7 on Alpine Linux

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][04] article.

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions. If you need to run PowerShell 7.5 side-by-side
with a previous version, reinstall the previous version using the [binary archive][03] method.

## Install PowerShell 7

On Alpine Linux, PowerShell is installed from the `tar.gz` package downloaded from the
[releases][01] page. Select the URL of the package version you want to install.

- PowerShell 7.6 (LTS) - `https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-linux-musl-x64.tar.gz`
- PowerShell 7.5 - `https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-linux-musl-x64.tar.gz`
- PowerShell 7.4 (LTS) - `https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell-7.4.14-linux-musl-x64.tar.gz`

Use the following shell commands to install PowerShell 7:

```sh
#!/bin/bash
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
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz

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

## Start PowerShell 7

After the package is installed, run `pwsh` from a terminal. If you have installed a Preview package,
run `pwsh-preview`.

- The location of `$PSHOME` varies based on the package you installed.
  - For Stable and LTS packages: `/opt/microsoft/powershell/7/`
  - For Preview packages: `/opt/microsoft/powershell/7-preview/`
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

PowerShell respects the [XDG Base Directory Specification][02] on Linux.

## Uninstall PowerShell 7

```sh
sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell
```

## Supported OS versions

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

## Supported installation methods

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods.

<!-- link references -->
[01]: https://github.com/PowerShell/PowerShell/releases
[02]: https://specifications.freedesktop.org/basedir/latest/
[03]: install-other-linux.md#binary-archives
[04]: PowerShell-Support-Lifecycle.md
