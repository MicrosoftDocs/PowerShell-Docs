---
description: Information about installing PowerShell on Alpine Linux
ms.date: 09/22/2021
title: Installing PowerShell on Alpine Linux
---
# Installing PowerShell on Alpine Linux

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell.
>
> If you need to run PowerShell 7.2 side-by-side with a previous version, reinstall the previous
> version using the [binary archive](install-other-linux.md#binary-archives) method.

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

## Installation steps

Installation on Alpine is based on downloading tar.gz package from the [releases][releases] page. The
URL to the package depends on the version of PowerShell you want to install.

- PowerShell 7.2-preview.10 - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.10/powershell-7.2.0-preview.10-linux-alpine-x64.tar.gz`
- PowerShell 7.1 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-linux-alpine-x64.tar.gz`
- PowerShell 7.0 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-7.0.7-linux-alpine-x64.tar.gz`

Then, in the terminal, execute the following shell commands to install PowerShell 7.2-preview.10:

```sh
# install the requirements
sudo apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl

sudo apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

# Download the powershell '.tar.gz' archive
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.10/powershell-7.2.0-preview.10-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz

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

## Uninstall PowerShell from Alpine

```sh
sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell
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
[eol-alpine]: https://alpinelinux.org/releases/
