---
title: Installing PowerShell Core on Linux
description: Information about installing PowerShell Core on various Linux distributions
ms.date: 08/06/2018
---

# Installing PowerShell Core on Linux

Supports [Ubuntu 14.04][u14], [Ubuntu 16.04][u16], [Ubuntu 18.10][u18], [Debian 8][deb8], [Debian 9][deb9],
[CentOS 7][cos], [Red Hat Enterprise Linux (RHEL) 7][rhel7], [OpenSUSE 42.3][opensuse], [Fedora 27][fedora],
[Fedora 28][fedora], and [Arch Linux][arch].

For Linux distributions that are not officially supported,
you can try using the [PowerShell Snap Package][snap].
You can also try deploying PowerShell binaries directly using the Linux [`tar.gz` archive][tar],
but you would need to set up the necessary dependencies based on the OS in separate steps.

All packages are available on our GitHub [releases][] page.
Once the package is installed, run `pwsh` from a terminal.

[u14]: #ubuntu-1404
[u16]: #ubuntu-1604
[u18]: #ubuntu-1810
[u18]: #ubuntu-1804
[deb8]: #debian-8
[deb9]: #debian-9
[cos]: #centos-7
[rhel7]: #red-hat-enterprise-linux-rhel-7
[opensuse]: #opensuse-423
[fedora]: #fedora
[arch]: #arch-linux
[snap]: #snap-package
[tar]: #binary-archives

## Installing Preview Releases

When installing a PowerShell Core Preview release for Linux via a Package Repository,
the package name changes from `powershell` to `powershell-preview`.

Installing via direct download does not change, other than the file name.

Here is a table of the commands to install the stable and preview packages using the various package managers:

|Distribution(s)|Stable Command | Preview Command |
|---------------|---------------|-----------------|
| Ubuntu, Debian |`sudo apt-get install -y powershell`| `sudo apt-get install -y powershell-preview`|
| CentOS, RedHat |`sudo yum install -y powershell` | `sudo yum install -y powershell-preview`|
| OpenSUSE |`sudo zypper install powershell` | `sudo zypper install powershell-preview`|
| Fedora   |`sudo dnf install -y powershell` | `sudo dnf install -y powershell-preview`|

## Ubuntu 14.04

### Installation via Package Repository - Ubuntu 14.04

PowerShell Core, for Linux, is published to package repositories for easy installation (and updates).
This is the preferred method.

```sh
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/14.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository.
From then on, you just need to use `sudo apt-get upgrade powershell` to update the installation.

### Installation via Direct Download - Ubuntu 14.04

Download the Debian package
`powershell_6.1.0-1.ubuntu.14.04_amd64.deb`
from the [releases][] page onto the Ubuntu machine.

Then execute the following in the terminal:

```sh
sudo dpkg -i powershell_6.1.0-1.ubuntu.14.04_amd64.deb
sudo apt-get install -f
```

> [!NOTE]
> The `dpkg -i` command fails with unmet dependencies.
> The next command, `apt-get install -f` resolves these issues
> then finishes configuring the PowerShell package.

### Uninstallation - Ubuntu 14.04

```sh
sudo apt-get remove powershell
```

## Ubuntu 16.04

### Installation via Package Repository - Ubuntu 16.04

PowerShell Core, for Linux, is published to package repositories for easy installation (and updates).
This is the preferred method.

```sh
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

After registering the Microsoft repository once as superuser,
from then on, you just need to use `sudo apt-get upgrade powershell` to update it.

### Installation via Direct Download - Ubuntu 16.04

Download the Debian package
`powershell_6.1.0-1.ubuntu.16.04_amd64.deb`
from the [releases][] page onto the Ubuntu machine.

Then execute the following in the terminal:

```sh
sudo dpkg -i powershell_6.1.0-1.ubuntu.16.04_amd64.deb
sudo apt-get install -f
```

> [!NOTE]
> The `dpkg -i` command fails with unmet dependencies.
> The next command, `apt-get install -f` resolves these issues
> then finishes configuring the PowerShell package.

### Uninstallation - Ubuntu 16.04

```sh
sudo apt-get remove powershell
```

## Ubuntu 18.04

> [!NOTE]
> Support for Ubuntu 18.04 was added after `6.1.0-preview.2`

### Installation via Package Repository - Ubuntu 18.04

PowerShell Core, for Linux, is published to package repositories for easy installation (and updates).
This is the preferred method.

```sh
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

After registering the Microsoft repository once as superuser,
from then on, you just need to use `sudo apt-get upgrade powershell` to update it.

### Installation via Direct Download - Ubuntu 18.04

Download the Debian package
`powershell_6.1.0-1.ubuntu.18.04_amd64.deb`
from the [releases][] page onto the Ubuntu machine.

Then execute the following in the terminal:

```sh
sudo dpkg -i powershell_6.1.0-1.ubuntu.18.04_amd64.deb
sudo apt-get install -f
```

> [!NOTE]
> The `dpkg -i` command fails with unmet dependencies.
> The next command, `apt-get install -f` resolves these issues
> then finishes configuring the PowerShell package.

### Uninstallation - Ubuntu 18.04

```sh
sudo apt-get remove powershell
```

## Ubuntu 18.10

> [!NOTE]
> Support for Ubuntu 18.10 was added after `6.1.0-preview.3`.
> As 18.10 is a daily build, it is only community supported.

Installing on 18.10 is supported via `snapd`. See [Snap Package][snap] for full instructions;

## Debian 8

### Installation via Package Repository - Debian 8

PowerShell Core, for Linux, is published to package repositories for easy installation (and updates).
This is the preferred method.

```sh
# Install system components
sudo apt-get update
sudo apt-get install curl apt-transport-https

# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Product feed
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-jessie-prod jessie main" > /etc/apt/sources.list.d/microsoft.list'

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

After registering the Microsoft repository once as superuser,
from then on, you just need to use `sudo apt-get upgrade powershell` to update it.

### Installation via Direct Download - Debian 8

Download the Debian package
`powershell_6.1.0-1.debian.8_amd64.deb`
from the [releases][] page onto the Debian machine.

Then execute the following in the terminal:

```sh
sudo dpkg -i powershell_6.1.0-1.debian.8_amd64.deb
sudo apt-get install -f
```

> [!NOTE]
> The `dpkg -i` command fails with unmet dependencies.
> The next command, `apt-get install -f` resolves these issues
> then finishes configuring the PowerShell package.

### Uninstallation - Debian 8

```sh
sudo apt-get remove powershell
```

## Debian 9

### Installation via Package Repository - Debian 9

PowerShell Core, for Linux, is published to package repositories for easy installation (and updates).
This is the preferred method.

```sh
# Install system components
sudo apt-get update
sudo apt-get install curl gnupg apt-transport-https

# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Product feed
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list'

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

After registering the Microsoft repository once as superuser,
from then on, you just need to use `sudo apt-get upgrade powershell` to update it.

### Installation via Direct Download - Debian 9

Download the Debian package
`powershell_6.1.0-1.debian.9_amd64.deb`
from the [releases][] page onto the Debian machine.

Then execute the following in the terminal:

```sh
sudo dpkg -i powershell_6.1.0-1.debian.9_amd64.deb
sudo apt-get install -f
```

### Uninstallation - Debian 9

```sh
sudo apt-get remove powershell
```

## CentOS 7

> [!NOTE]
> This package also works on Oracle Linux 7.

### Installation via Package Repository (preferred) - CentOS 7

PowerShell Core for Linux is published to official Microsoft repositories for easy installation (and updates).

```sh
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install -y powershell

# Start PowerShell
pwsh
```

After registering the Microsoft repository once as superuser,
you just need to use `sudo yum update powershell` to update PowerShell.

### Installation via Direct Download - CentOS 7

Using [CentOS 7][], download the RPM package
`powershell-6.1.0-1.rhel.7.x86_64.rpm`
from the [releases][] page onto the CentOS machine.

Then execute the following in the terminal:

```sh
sudo yum install powershell-6.1.0-1.rhel.7.x86_64.rpm
```

You can also install the RPM without the intermediate step of downloading it:

```sh
sudo yum install https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - CentOS 7

```sh
sudo yum remove powershell
```

[CentOS 7]: https://www.centos.org/download/

## Red Hat Enterprise Linux (RHEL) 7

### Installation via Package Repository (preferred) - Red Hat Enterprise Linux (RHEL) 7

PowerShell Core for Linux is published to official Microsoft repositories for easy installation (and updates).

```sh
# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install -y powershell

# Start PowerShell
pwsh
```

After registering the Microsoft repository once as superuser,
you just need to use `sudo yum update powershell` to update PowerShell.

### Installation via Direct Download - Red Hat Enterprise Linux (RHEL) 7

Download the RPM package
`powershell-6.1.0-1.rhel.7.x86_64.rpm`
from the [releases][] page onto the Red Hat Enterprise Linux machine.

Then execute the following in the terminal:

```sh
sudo yum install powershell-6.1.0-1.rhel.7.x86_64.rpm
```

You can also install the RPM without the intermediate step of downloading it:

```sh
sudo yum install https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - Red Hat Enterprise Linux (RHEL) 7

```sh
sudo yum remove powershell
```

## OpenSUSE 42.3

When installing PowerShell Core, `zypper` may report the following error:

```Output
Problem: nothing provides libcurl needed by powershell-6.1.0-1.rhel.7.x86_64
 Solution 1: do not install powershell-6.1.0-1.rhel.7.x86_64
 Solution 2: break powershell-6.1.0-1.rhel.7.x86_64 by ignoring some of its dependencies
```

In this case, verify that a compatible `libcurl` library is present by checking that the following
command shows the `libcurl4` package as installed:

```sh
zypper search --file-list --match-exact '/usr/lib64/libcurl.so.4'
```

Then choose the `break powershell-6.1.0-1.rhel.7.x86_64 by ignoring some of its dependencies`
solution when installing the PowerShell package.

### Installation via Package Repository (preferred) - OpenSUSE 42.3

PowerShell Core for Linux is published to official Microsoft repositories for easy installation (and updates).

```sh
# Register the Microsoft signature key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add the Microsoft Repository
zypper ar https://packages.microsoft.com/rhel/7/prod/

# Update the list of products
sudo zypper update

# Install PowerShell
sudo zypper install powershell

# Start PowerShell
pwsh
```

### Installation via Direct Download - OpenSUSE 42.3

Download the RPM package `powershell-6.1.0-1.rhel.7.x86_64.rpm`
from the [releases][] page onto the OpenSUSE machine.

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper install powershell-6.1.0-1.rhel.7.x86_64.rpm
```

You can also install the RPM without the intermediate step of downloading it:

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper install https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - OpenSUSE 42.3

```sh
sudo zypper remove powershell
```

## Fedora

> [!NOTE]
> Fedora 28 is only supported in PowerShell Core 6.1 and newer.

### Installation via Package Repository (preferred) - Fedora 27, Fedora 28

PowerShell Core for Linux is published to official Microsoft repositories for easy installation (and updates).

```sh
# Register the Microsoft signature key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Update the list of products
sudo dnf update

# Install a system component
sudo dnf install compat-openssl10

# Install PowerShell
sudo dnf install -y powershell

# Start PowerShell
pwsh
```

### Installation via Direct Download - Fedora 27, Fedora 28

Download the RPM package
`powershell-6.1.0-1.rhel.7.x86_64.rpm`
from the [releases][] page onto the Fedora machine.

Then execute the following in the terminal:

```sh
sudo dnf install compat-openssl10
sudo dnf install powershell-6.1.0-1.rhel.7.x86_64.rpm
```

You can also install the RPM without the intermediate step of downloading it:

```sh
sudo dnf install compat-openssl10
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - Fedora 27, Fedora 28

```sh
sudo dnf remove powershell
```

## Arch Linux

> [!NOTE]
> Arch support is experimental.

PowerShell is available from the [Arch Linux][] User Repository (AUR).

* It can be compiled with the [latest tagged release][arch-release]
* It can be compiled from the [latest commit to master][arch-git]
* It can be installed using the [latest release binary][arch-bin]

Packages in the AUR are community maintained - there is no official support.

For more information on installing packages from the AUR, see the [Arch Linux wiki](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages) or the community [DockerFile](https://github.com/PowerShell/PowerShell/blob/master/docker/community/archlinux/Dockerfile).

[Arch Linux]: https://www.archlinux.org/download/
[arch-release]: https://aur.archlinux.org/packages/powershell/
[arch-git]: https://aur.archlinux.org/packages/powershell-git/
[arch-bin]: https://aur.archlinux.org/packages/powershell-bin/

## Snap Package

### Getting snapd

`snapd` is required to run snaps.
Use [these instructions](https://docs.snapcraft.io/core/install) to make sure you have `snapd` installed.

### Installation via Snap

PowerShell Core, for Linux, is published to the [Snap store](https://snapcraft.io/store) for easy installation (and updates).
This is the preferred method.

```sh
# Install PowerShell
sudo snap install powershell-preview --classic

# Start PowerShell
pwsh-preview
```

After installing Snap will automatically upgrade, but you can trigger an upgrade using `sudo snap refresh powershell-preview`.

### Uninstallation

```sh
sudo snap remove powershell-preview
```

## Kali

### Installation

```sh
# Download & Install prerequisites
wget http://ftp.us.debian.org/debian/pool/main/i/icu/libicu57_57.1-9_amd64.deb
dpkg -i libicu57_57.1-9_amd64.deb
apt-get update && apt-get install -y curl gnupg apt-transport-https

# Add Microsoft public repository key to APT
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Add Microsoft package repository to the source list
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" | tee /etc/apt/sources.list.d/powershell.list

# Install PowerShell package
apt-get update && apt-get install -y powershell

# Start PowerShell
pwsh
```

### Uninstallation - Kali

```sh
# Uninstall PowerShell package
apt-get remove -y powershell
```

## Raspbian

> [!NOTE]
> Raspbian support is experimental.

Currently, PowerShell is only supported on Raspbian Stretch.

Also CoreCLR (and thus PowerShell Core) will only work on Pi 2 and Pi 3 devices as other devices,
like [Pi Zero](https://github.com/dotnet/coreclr/issues/10605), have an unsupported processor.

Download [Raspbian Stretch](https://www.raspberrypi.org/downloads/raspbian/) and follow the [installation instructions](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) to get it onto your Pi.

### Installation

```sh
# Install prerequisites
sudo apt-get install libunwind8

# Grab the latest tar.gz
wget https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-linux-arm32.tar.gz

# Make folder to put powershell
mkdir ~/powershell

# Unpack the tar.gz file
tar -xvf ./powershell-6.1.0-linux-arm32.tar.gz -C ~/powershell

# Start PowerShell
~/powershell/pwsh
```

Optionally you can create a symbolic link to be able to start PowerShell without specifying path to the "pwsh" binary

```sh
# Start PowerShell from bash with sudo to create a symbolic link
sudo ~/powershell/pwsh -c New-Item -ItemType SymbolicLink -Path "/usr/bin/pwsh" -Target "\$PSHOME/pwsh" -Force

# alternatively you can run following to create a symbolic link
# sudo ln -s ~/powershell/pwsh /usr/bin/pwsh

# Now to start PowerShell you can just run "pwsh"
```

### Uninstallation - Raspbian

```sh
rm -rf ~/powershell
```

## Binary Archives

PowerShell binary `tar.gz` archives are provided for Linux platforms to enable advanced deployment scenarios.

### Dependencies

PowerShell builds portable binaries for all Linux distributions.
But .NET Core runtime requires different dependencies on different distributions,
and hence PowerShell does the same.

The following chart shows the .NET Core 2.0 dependencies that are officially supported
on different Linux distributions.

| OS                 | Dependencies |
| ------------------ | ------------ |
| Ubuntu 14.04       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu52 |
| Ubuntu 16.04       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu55 |
| Ubuntu 17.10       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu57 |
| Ubuntu 18.04       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu60 |
| Debian 8 (Jessie)  | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu52 |
| Debian 9 (Stretch) | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.2, libicu57 |
| CentOS 7 <br> Oracle Linux 7 <br> RHEL 7 <br> OpenSUSE OpenSUSE 42.3 | libunwind, libcurl, openssl-libs, libicu |
| Fedora 27 <br> Fedora 28 | libunwind, libcurl, openssl-libs, libicu, compat-openssl10 |

To deploy PowerShell binaries on Linux distributions that are not officially supported,
you need to install the necessary dependencies for the target OS in separate steps.
For example, our [Amazon Linux dockerfile][amazon-dockerfile] installs dependencies first,
and then extracts the Linux `tar.gz` archive.

[amazon-dockerfile]: https://github.com/PowerShell/PowerShell/blob/master/docker/community/amazonlinux/Dockerfile

### Installation - Binary Archives

#### Linux

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-linux-x64.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/6.1.0

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/6.1.0

# Set execute permissions
sudo chmod +x /opt/microsoft/powershell/6.1.0/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/6.1.0/pwsh /usr/bin/pwsh
```

### Uninstalling binary archives

```sh
sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell
```

## Paths

* `$PSHOME` is `/opt/microsoft/powershell/6.1.0/`
* User profiles will be read from `~/.config/powershell/profile.ps1`
* Default profiles will be read from `$PSHOME/profile.ps1`
* User modules will be read from `~/.local/share/powershell/Modules`
* Shared modules will be read from `/usr/local/share/powershell/Modules`
* Default modules will be read from `$PSHOME/Modules`
* PSReadline history will be recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

The profiles respect PowerShell's per-host configuration,
so the default host-specific profiles exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][xdg-bds] on Linux.

[releases]: https://github.com/PowerShell/PowerShell/releases/latest
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
