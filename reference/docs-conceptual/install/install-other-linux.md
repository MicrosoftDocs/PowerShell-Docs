---
title: Alternate ways to install PowerShell on Linux
description: Information about installing PowerShell on various Linux distributions
ms.date: 08/16/2021
---
# Alternate ways to install PowerShell on Linux

All packages are available on our GitHub [releases][releases] page. After the package is installed,
run `pwsh` from a terminal. Run `pwsh-preview` if you installed a preview release.

There are three other ways to install PowerShell on a Linux distribution:

- Install using a [Snap Package](#snap-package)
- Install using the [binary archives](#binary-archives)
- Install as a [.NET Global tool](#install-as-a-net-global-tool)

## Snap Package

Snaps are application packages that are easy to install, secure, cross‐platform and dependency‐free.
Snaps are discoverable and installable from the Snap Store. Snap packages are supported the same as
the distribution you're running the package on.

> [!IMPORTANT]
> The Snap Store contains PowerShell snap packages for many Linux distributions that are not
> officially supported by Microsoft. For support, see the list of available
> [Community Support][community] options.

### Getting snapd

`snapd` is required to run snaps. Use [these instructions](https://docs.snapcraft.io/core/install)
to make sure you have `snapd` installed.

### Installation via Snap

PowerShell for Linux is published to the [Snap store](https://snapcraft.io/store) for easy
installation and updates.

The preferred method is as follows:

```sh
# Install PowerShell
sudo snap install powershell --classic

# Start PowerShell
pwsh
```

To install a preview version, use the following method:

```sh
# Install PowerShell
sudo snap install powershell-preview --classic

# Start PowerShell
pwsh-preview
```

After installation, Snap will automatically upgrade. You can trigger an upgrade using
`sudo snap refresh powershell` or `sudo snap refresh powershell-preview`.

### Uninstallation

```sh
sudo snap remove powershell
```

or

```sh
sudo snap remove powershell-preview
```

## Binary Archives

PowerShell binary `tar.gz` archives are provided for Linux platforms to enable advanced deployment
scenarios.

> [!NOTE]
> You can use this method to install any version of PowerShell including the latest:
>
> - Stable release: [https://aka.ms/powershell-release?tag=stable](https://aka.ms/powershell-release?tag=stable)
> - Preview release: [https://aka.ms/powershell-release?tag=preview](https://aka.ms/powershell-release?tag=preview)
> - LTS release: [https://aka.ms/powershell-release?tag=lts](https://aka.ms/powershell-release?tag=lts)

### Dependencies

PowerShell builds portable binaries for all Linux distributions. But, .NET Core runtime requires
different dependencies on different distributions, and PowerShell does too.

It's possible that when you install PowerShell, specific dependencies may not be installed, such as
when manually installing from the binary archives. The following list details Linux distributions
that are supported by Microsoft and have dependencies you may need to install. Check the
distribution page for more information:

- [Alpine](/dotnet/core/install/linux-alpine#dependencies)
- [Debian](/dotnet/core/install/linux-debian#dependencies)
- [CentOS](/dotnet/core/install/linux-centos#dependencies)
- [Fedora](/dotnet/core/install/linux-fedora#dependencies)
- [RHEL](/dotnet/core/install/linux-rhel#dependencies)
- [SLES](/dotnet/core/install/linux-sles#dependencies)
- [Ubuntu](/dotnet/core/install/linux-ubuntu#dependencies)

To deploy PowerShell binaries on Linux distributions that aren't officially supported, you need to
install the necessary dependencies for the target OS in separate steps. For example, our
[Amazon Linux dockerfile][amazon-dockerfile] installs dependencies first, and then extracts the
Linux `tar.gz` archive.

### Installation using a binary archive file

> [!IMPORTANT]
> This method can be used to install PowerShell on any version of Linux, including distributions
> that are not officially supported by Microsoft. Be sure to install any necessary dependencies. For
> support, see the list of available [Community Support][community] options.

The following example shows the steps for installing the x64 binary archive. You must choose the
correct binary archive that matches the processor type for your platform.

- powershell-7.1.4-linux-arm32.tar.gz
- powershell-7.1.4-linux-arm64.tar.gz
- powershell-7.1.4-linux-x64.tar.gz

Use the following shell commands to download and install PowerShell from the `tar.gz` binary
archive. Change the URL to match the version of PowerShell you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-linux-x64.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
sudo chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
```

### Uninstalling binary archives

```sh
sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell
```

## Install as a .NET Global tool

If you already have the [.NET Core SDK](/dotnet/core/sdk) installed, it's easy to install PowerShell
as a [.NET Global tool](/dotnet/core/tools/global-tools).

```sh
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `~/.dotnet/tools` to your `PATH` environment variable. However, the
currently running shell does not have the updated `PATH`. You should be able to start PowerShell
from a new shell by typing `pwsh`.

[releases]: https://aka.ms/PowerShell-Release?tag=stable
[community]: /powershell/scripting/community/community-support
[amazon-dockerfile]: https://github.com/PowerShell/PowerShell-Docker/blob/master/release/community-stable/amazonlinux/docker/Dockerfile
