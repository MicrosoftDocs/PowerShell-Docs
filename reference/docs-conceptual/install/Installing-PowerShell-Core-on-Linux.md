---
title: Installing PowerShell Core on Linux
description: Information about installing PowerShell Core on various Linux distributions
ms.date: 07/19/2019
---

# Installing PowerShell Core on Linux

Supports [Ubuntu 16.04][u16], [Ubuntu 18.04][u1804], [Ubuntu 18.10][u1810], [Ubuntu 19.04][u1904],
 [Debian 8][deb8], [Debian 9][deb9], [Debian 10][deb10], [CentOS 7][cos],
 [Red Hat Enterprise Linux (RHEL) 7][rhel7], [openSUSE 42.3][opensuse],
 [openSUSE Leap 15][opensuse], [Fedora 27][fedora], [Fedora 28][fedora],
 and [Arch Linux][arch].

For Linux distributions that aren't officially supported, you can try to install PowerShell using
the [PowerShell Snap Package][snap]. You can also try deploying PowerShell binaries directly using
the Linux [`tar.gz` archive][tar], but you would need to set up the necessary dependencies based on
the OS in separate steps.

All packages are available on our GitHub [releases][] page. After the package is installed, run
`pwsh` from a terminal. Run `pwsh-preview` if you installed a [Preview release](#installing-preview-releases).

[u16]: #ubuntu-1604
[u1804]: #ubuntu-1804
[u1810]: #ubuntu-1810
[u1904]: #ubuntu-1904
[deb8]: #debian-8
[deb9]: #debian-9
[deb10]: #debian-10
[cos]: #centos-7
[rhel7]: #red-hat-enterprise-linux-rhel-7
[opensuse]: #opensuse
[fedora]: #fedora
[arch]: #arch-linux
[snap]: #snap-package
[tar]: #binary-archives

> [!TIP]
> If you already have the [.NET Core SDK](/dotnet/core/sdk) installed, it’s easy to install PowerShell as a [.NET Global tool](/dotnet/core/tools/global-tools).
>
> ```
> dotnet tool install --global PowerShell
> ```

## Installing Preview Releases

When installing a PowerShell Core Preview release for Linux via a Package Repository, the package
name changes from `powershell` to `powershell-preview`.

Installing via direct download doesn't change, other than the file name.

The following table contains the commands to install the stable and preview packages using the
various package managers:

|Distribution(s)|Stable Command | Preview Command |
|---------------|---------------|-----------------|
| Ubuntu, Debian |`sudo apt-get install -y powershell`| `sudo apt-get install -y powershell-preview`|
| CentOS, RedHat |`sudo yum install -y powershell` | `sudo yum install -y powershell-preview`|
| Fedora   |`sudo dnf install -y powershell` | `sudo dnf install -y powershell-preview`|

## Ubuntu 16.04

### Installation via Package Repository - Ubuntu 16.04

PowerShell Core for Linux is published to package repositories for easy installation and updates.

The preferred method is as follows:

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

As superuser, register the Microsoft repository once. After registration, you can update
PowerShell with `sudo apt-get upgrade powershell`.

### Installation via Direct Download - Ubuntu 16.04

Download the Debian package `powershell_7.0.0-1.ubuntu.16.04_amd64.deb` from the [releases][] page
onto the Ubuntu machine.

Then, in the terminal, execute the following commands:

```sh
sudo dpkg -i powershell_7.0.0-1.ubuntu.16.04_amd64.deb
sudo apt-get install -f
```

> [!NOTE]
> The `dpkg -i` command fails with unmet dependencies. The next command, `apt-get install -f`
> resolves these issues then finishes configuring the PowerShell package.

### Uninstallation - Ubuntu 16.04

```sh
sudo apt-get remove powershell
```

## Ubuntu 18.04

### Installation via Package Repository - Ubuntu 18.04

PowerShell Core for Linux is published to package repositories for easy installation and updates.

The preferred method is as follows:

```sh
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt-get update

# Enable the "universe" repositories
sudo add-apt-repository universe

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```

As superuser, register the Microsoft repository once. After registration, you can update
PowerShell with `sudo apt-get upgrade powershell`.

### Installation via Direct Download - Ubuntu 18.04

Download the Debian package `powershell_7.0.0-1.ubuntu.18.04_amd64.deb` from the [releases][] page
onto the Ubuntu machine.

Then, in the terminal, execute the following commands:

```sh
sudo dpkg -i powershell_7.0.0-1.ubuntu.18.04_amd64.deb
sudo apt-get install -f
```

> [!NOTE]
> The `dpkg -i` command fails with unmet dependencies. The next command, `apt-get install -f`
> resolves these issues then finishes configuring the PowerShell package.

### Uninstallation - Ubuntu 18.04

```sh
sudo apt-get remove powershell
```

## Ubuntu 18.10

Installation is supported via `snapd`. For instructions, see [Snap Package][snap].

> [!NOTE]
> Ubuntu 18.10 is an [interim release](https://www.ubuntu.com/about/release-cycle) that's [community supported](../powershell-support-lifecycle.md).

## Ubuntu 19.04

Installation is supported via `snapd`. For instructions, see [Snap Package][snap].

> [!NOTE]
> Ubuntu 19.04 is an [interim release](https://www.ubuntu.com/about/release-cycle) that's [community supported](../powershell-support-lifecycle.md).

## Debian 8

### Installation via Package Repository - Debian 8

PowerShell Core for Linux is published to package repositories for easy installation and updates.

The preferred method is as follows:

```sh
# Install system components
sudo apt-get update
sudo apt-get install -y curl apt-transport-https

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

As superuser, register the Microsoft repository once. After registration, you can update
PowerShell with `sudo apt-get upgrade powershell`.

## Debian 9

### Installation via Package Repository - Debian 9

PowerShell Core for Linux is published to package repositories for easy installation and updates.

The preferred method is as follows:

```sh
# Install system components
sudo apt-get update
sudo apt-get install -y curl gnupg apt-transport-https

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

As superuser, register the Microsoft repository once. After registration, you can update
PowerShell with `sudo apt-get upgrade powershell`.

### Installation via Direct Download - Debian 9

Download the Debian package `powershell_7.0.0-1.debian.9_amd64.deb` from the [releases][] page onto
the Debian machine.

Then, in the terminal, execute the following commands:

```sh
sudo dpkg -i powershell_7.0.0-1.debian.9_amd64.deb
sudo apt-get install -f
```

### Uninstallation - Debian 9

```sh
sudo apt-get remove powershell
```

## Debian 10

> [!NOTE]
> Debian 10 is only supported in PowerShell 7.0 and newer.

### Installation via Direct Download - Debian 10

Download the tar.gz package `powershell_7.0.0-preview-7-linux-x64.tar.gz` from the [releases][] page onto
the Debian machine.

Then, in the terminal, execute the following commands:

```sh
sudo apt-get update
# install the requirements
sudo apt-get install -y \
        less \
        locales \
        ca-certificates \
        libicu63 \
        libssl1.1 \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        liblttng-ust0 \
        libstdc++6 \
        zlib1g \
        curl

# Download the powershell '.tar.gz' archive
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.4/powershell-7.0.0-preview.4-linux-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/7-preview

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7-preview

# Set execute permissions
sudo chmod +x /opt/microsoft/powershell/7-preview/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/7-preview/pwsh /usr/bin/pwsh-preview

# Start PowerShell
pwsh-preview
```

## Alpine 3.9 and 3.10

> [!NOTE]
> Alpine 3.9 and 3.10 are only supported in PowerShell 7.0 and newer.

### Installation via Direct Download - Alpine 3.9 and 3.10

Download the tar.gz package `powershell_7.0.0-preview-7-linux-x64.tar.gz` from the [releases][] page onto
the Alpine machine.

Then, in the terminal, execute the following commands:

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
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.4/powershell-7.0.0-preview.4-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/7-preview

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7-preview

# Set execute permissions
sudo chmod +x /opt/microsoft/powershell/7-preview/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/7-preview/pwsh /usr/bin/pwsh-preview

# Start PowerShell
pwsh-preview
```

## CentOS 7

> [!NOTE]
> This package works on Oracle Linux 7.

### Installation via Package Repository (preferred) - CentOS 7

PowerShell Core for Linux is published to official Microsoft repositories for easy installation and
updates.

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

### Installation via Direct Download - CentOS 7

Using [CentOS 7][], download the RPM package `powershell-7.0.0-1.rhel.7.x86_64.rpm` from the [releases][]
page onto the CentOS machine.

Then, in the terminal, execute the following commands:

```sh
sudo yum install powershell-7.0.0-1.rhel.7.x86_64.rpm
```

You can install the RPM without the intermediate step of downloading it:

```sh
sudo yum install https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - CentOS 7

```sh
sudo yum remove powershell
```

[CentOS 7]: https://www.centos.org/download/

## Red Hat Enterprise Linux (RHEL) 7

### Installation via Package Repository (preferred) - Red Hat Enterprise Linux (RHEL) 7

PowerShell Core for Linux is published to official Microsoft repositories for easy installation and
updates.

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

### Installation via Direct Download - Red Hat Enterprise Linux (RHEL) 7

Download the RPM package `powershell-7.0.0-1.rhel.7.x86_64.rpm` from the [releases][] page onto the
Red Hat Enterprise Linux machine.

Then, in the terminal, execute the following commands:

```sh
sudo yum install powershell-7.0.0-1.rhel.7.x86_64.rpm
```

You can install the RPM without the intermediate step of downloading it:

```sh
sudo yum install https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - Red Hat Enterprise Linux (RHEL) 7

```sh
sudo yum remove powershell
```

## openSUSE

### Installation - openSUSE 42.3

```sh
# Install dependencies
zypper update && zypper --non-interactive install curl tar libicu52_1

# Download the powershell '.tar.gz' archive
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-x64.tar.gz -o /tmp/powershell.tar.gz

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

### Installation - openSUSE Leap 15

```sh
# Install dependencies
zypper update && zypper --non-interactive install curl tar gzip libopenssl1_0_0 libicu60_2

# Download the powershell '.tar.gz' archive
curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-x64.tar.gz -o /tmp/powershell.tar.gz

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

### Uninstallation - openSUSE 42.3, openSUSE Leap 15

```sh
rm -rf /usr/bin/pwsh /opt/microsoft/powershell
```

## Fedora

> [!NOTE]
> Fedora 28 is only supported in PowerShell Core 6.1 and newer.

> [!NOTE]
> Fedora 29 and 30 are only supported in PowerShell 7.0 and newer.

### Installation via Package Repository (preferred) - Fedora 28, 29, and 30

PowerShell Core for Linux is published to official Microsoft repositories for easy installation and
updates.

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

### Installation via Direct Download - Fedora 28, 29, and 30

Download the RPM package `powershell-7.0.0-1.rhel.7.x86_64.rpm` from the [releases][] page onto the
Fedora machine.

Then, in the terminal, execute the following commands:

```sh
sudo dnf install compat-openssl10
sudo dnf install powershell-7.0.0-1.rhel.7.x86_64.rpm
```

You can install the RPM without the intermediate step of downloading it:

```sh
sudo dnf install compat-openssl10
sudo dnf install https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-1.rhel.7.x86_64.rpm
```

### Uninstallation - Fedora 28, 29, and 30

```sh
sudo dnf remove powershell
```

## Arch Linux

> [!NOTE]
> Arch support is not officially supported by Microsoft and is maintained by the community.

PowerShell is available from the [Arch Linux][] User Repository (AUR).

* It can be compiled with the [latest tagged release][arch-release]
* It can be compiled from the [latest commit to master][arch-git]
* It can be installed using the [latest release binary][arch-bin]

Packages in the AUR are community maintained; there's no official support.

For more information on installing packages from the AUR, see the [Arch Linux wiki](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages)
or the community [DockerFile](https://github.com/PowerShell/PowerShell/blob/master/docker/community/archlinux/Dockerfile).

[Arch Linux]: https://www.archlinux.org/download/
[arch-release]: https://aur.archlinux.org/packages/powershell/
[arch-git]: https://aur.archlinux.org/packages/powershell-git/
[arch-bin]: https://aur.archlinux.org/packages/powershell-bin/

## Snap Package

### Getting snapd

`snapd` is required to run snaps. Use [these instructions](https://docs.snapcraft.io/core/install)
to make sure you have `snapd` installed.

### Installation via Snap

PowerShell Core for Linux is published to the [Snap store](https://snapcraft.io/store) for easy
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

## Kali

> [!NOTE]
> Kali support is not officially supported by Microsoft and is maintained by the community.

### Installation - Kali

```sh
# Install PowerShell package
apt update && apt -y install powershell

# Start PowerShell
pwsh
```

### Uninstallation - Kali

```sh
# Uninstall PowerShell package
apt -y remove powershell
```

## Raspbian

> [!NOTE]
> Raspbian support is experimental.

Currently, PowerShell is only supported on Raspbian Stretch.

CoreCLR and PowerShell Core will only work on Pi 2 and Pi 3 devices as other devices, like [Pi Zero](https://github.com/dotnet/coreclr/issues/10605),
have an unsupported processor.

Download [Raspbian Stretch](https://www.raspberrypi.org/downloads/raspbian/) and follow the
[installation instructions](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
to get it onto your Pi.

### Installation - Raspbian

```sh
###################################
# Prerequisites

# Update package lists
sudo apt-get update

# Install libunwind8 and libssl1.0
# Regex is used to ensure that we do not install libssl1.0-dev, as it is a variant that is not required
sudo apt-get install '^libssl1.0.[0-9]$' libunwind8 -y

###################################
# Download and extract PowerShell

# Grab the latest tar.gz
wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-arm32.tar.gz

# Make folder to put powershell
mkdir ~/powershell

# Unpack the tar.gz file
tar -xvf ./powershell-7.0.0-linux-arm32.tar.gz -C ~/powershell

# Start PowerShell
~/powershell/pwsh
```

Optionally, you can create a symbolic link to start PowerShell without specifying the path to the
`pwsh` binary.

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

PowerShell binary `tar.gz` archives are provided for Linux platforms to enable advanced deployment
scenarios.

### Dependencies

PowerShell builds portable binaries for all Linux distributions. But, .NET Core runtime requires
different dependencies on different distributions, and PowerShell does too.

The following chart shows the .NET Core 2.0 dependencies that are officially supported on different
Linux distributions.

| OS                 | Dependencies |
| ------------------ | ------------ |
| Ubuntu 16.04       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu55 |
| Ubuntu 17.10       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu57 |
| Ubuntu 18.04       | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu60 |
| Debian 8 (Jessie)  | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.0, libicu52 |
| Debian 9 (Stretch) | libc6, libgcc1, libgssapi-krb5-2, liblttng-ust0, libstdc++6, <br> libcurl3, libunwind8, libuuid1, zlib1g, libssl1.0.2, libicu57 |
| CentOS 7 <br> Oracle Linux 7 <br> RHEL 7 | libunwind, libcurl, openssl-libs, libicu |
| openSUSE 42.3 | libcurl4, libopenssl1_0_0, libicu52_1 |
| openSUSE Leap 15 | libcurl4, libopenssl1_0_0, libicu60_2 |
| Fedora 27 <br> Fedora 28 | libunwind, libcurl, openssl-libs, libicu, compat-openssl10 |

To deploy PowerShell binaries on Linux distributions that aren't officially supported, you need to
install the necessary dependencies for the target OS in separate steps. For example, our [Amazon Linux dockerfile][amazon-dockerfile]
installs dependencies first, and then extracts the Linux `tar.gz` archive.

[amazon-dockerfile]: https://github.com/PowerShell/PowerShell-Docker/blob/master/release/community-stable/amazonlinux/docker/Dockerfile

### Installation - Binary Archives

#### Linux

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-x64.tar.gz

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

## Paths

* `$PSHOME` is `/opt/microsoft/powershell/7/`
* User profiles will be read from `~/.config/powershell/profile.ps1`
* Default profiles will be read from `$PSHOME/profile.ps1`
* User modules will be read from `~/.local/share/powershell/Modules`
* Shared modules will be read from `/usr/local/share/powershell/Modules`
* Default modules will be read from `$PSHOME/Modules`
* PSReadline history will be recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

The profiles respect PowerShell's per-host configuration, so the default host-specific profiles
exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][xdg-bds] on Linux.

[releases]: https://github.com/PowerShell/PowerShell/releases/latest
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
