---
description: Learn about the Linux distributions supported by PowerShell.
ms.date: 01/09/2023
title: Install PowerShell on Linux
---
# Install PowerShell on Linux

PowerShell can be installed on different Linux distributions. Most Linux platforms and distributions
have a major release each year, and provide a package manager that's used to install PowerShell.
This article lists the currently supported Linux distributions and package managers.

The rest of this article is a breakdown of each Linux distribution that PowerShell supports. All
PowerShell releases remain supported until either the version of
[PowerShell reaches end-of-support][05] or the Linux distribution reaches end-of-life.

For the best compatibility, choose a long-term release (LTS) version.

## Alpine

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

For more information, see [Install PowerShell on Alpine][13].

## Debian

Debian uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Debian support](../../includes/debian-support.md)]

For more information, see [Install PowerShell on Debian][14].

## Red Hat Enterprise Linux (RHEL)

RHEL 7 uses yum and RHEL 8 uses the dnf package manager.

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

For more information, see [Install PowerShell on RHEL][17].

## Ubuntu

Ubuntu uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

For more information, see [Install PowerShell on Ubuntu][18].

## Raspberry Pi OS

[Raspberry Pi OS][12] (formerly Raspbian) is a free operating system based on Debian.

> [!IMPORTANT]
> .NET isn't supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi
> devices prior to Raspberry Pi 2.

For more information, see [Install PowerShell on Raspberry Pi OS][16].

## Community supported distributions

There are many distributions of Linux that aren't officially supported by Microsoft. In some cases,
PowerShell may be supported by the community for these releases. For more information, see
[Community support for PowerShell on Linux][06].

CentOS and Fedora distributions are no longer supported. The versions of these operating systems
that were supported have reached their end-of-life dates. We aren't supporting any newer versions.

## Alternate installation methods

There are three other ways to install PowerShell on Linux, including Linux distributions that aren't
officially supported. You can try to install PowerShell using the PowerShell Snap Package. You can
also try deploying PowerShell binaries directly using the Linux `tar.gz`. For more information, see
[Alternate ways to install PowerShell on Linux][15].

<!-- link references -->
[05]: ../PowerShell-Support-Lifecycle.md
[06]: community-support.md
[12]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md
[13]: install-alpine.md
[14]: install-debian.md
[15]: install-other-linux.md
[16]: install-raspbian.md
[17]: install-rhel.md
[18]: install-ubuntu.md
