---
title: Install PowerShell on Linux
description: Learn about the Linux distributions supported by PowerShell.
ms.date: 08/05/2021
---
# Install PowerShell on Linux

PowerShell can be installed on different Linux distributions. Most Linux platforms and distributions
have a major release each year, and most provide a package manager that is used to install
PowerShell. This article describes what is currently supported and which package manager is used.

The rest of this article is a breakdown of each Linux distribution that PowerShell supports. All
PowerShell releases remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the Linux distribution reaches end-of-life.

For the best compatibility, choose a long-term release (LTS) version.

## Alpine

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

For more information, see [Install .NET on Alpine](install-alpine.md).

## CentOS

CentOS 7 uses Yum as a package manager and CentOS 8 uses DNF.

[!INCLUDE [CentOS support](../../includes/centos-support.md)]

For more information, see [Install PowerShell on CentOS](install-centos.md).

## Debian

Debian uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Debian support](../../includes/debian-support.md)]

For more information, see [Install PowerShell on Debian](install-debian.md).

## Fedora

Fedora uses DNF as its package manager.

[!INCLUDE [Fedora support](../../includes/fedora-support.md)]

For more information, see [Install .NET on Fedora](install-fedora.md).

## openSUSE

openSUSE uses zypper as the package manager.

[!INCLUDE [openSUSE support](../../includes/opensuse-support.md)]

For more information, see [Install PowerShell on openSUSE](install-opensuse.md).

## Red Hat Enterprise Linux (RHEL)

RHEL 7 uses yum and RHEL 8 uses the dnf package manager.

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

For more information, see [Install PowerShell on RHEL](install-rhel.md).

## Ubuntu

Ubuntu uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

For more information, see [Install PowerShell on Ubuntu](install-ubuntu.md).

## Raspberry Pi OS

[Raspberry Pi OS][raspbian] (formerly Raspbian) is a free operating system based on Debian.

> [!IMPORTANT]
> .NET is not supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi
> devices prior to Raspberry Pi 2.

For more information, see [Install PowerShell on Raspberry Pi OS](install-raspbian.md).

## Community supported distributions

There are many distributions of Linux that are not officially supported by Microsoft. In some cases,
PowerShell may be supported by the community for these releases. For more information, see
[Community support for PowerShell on Linux][community].

## Alternate installation methods

There are three other ways to install PowerShell on Linux, including Linux distributions that aren't officially supported. You can try to install PowerShell using
the PowerShell Snap Package. You can also try deploying PowerShell binaries directly using the Linux
`tar.gz`. For more information, see [Alternate ways to install PowerShell on Linux][other-linux].

[community]: community-support.md
[other-linux]: install-other-linux.md
[lifecycle]: ../PowerShell-Support-Lifecycle.md
[eol-alpine]: https://alpinelinux.org/releases/
[eol-centos]: https://www.centos.org/centos-linux-eol/
[eol-debian]: https://wiki.debian.org/DebianReleases
[eol-fedora]: https://fedoraproject.org/wiki/End_of_life
[eol-suse]: https://en.opensuse.org/Lifetime
[eol-rhel]: https://access.redhat.com/support/policy/updates/errata/
[eol-ubuntu]: https://wiki.ubuntu.com/Releases
[raspbian]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md
