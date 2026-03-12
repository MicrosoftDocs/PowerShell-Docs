---
description: This article lists the Linux distributions and package managers that are supported for installing PowerShell.
ms.date: 03/12/2026
title: Install PowerShell on Linux
---
# Install PowerShell on Linux

PowerShell can be installed on several different Linux distributions. Most Linux platforms and
distributions have a major release each year, and provide a package manager that's used to install
PowerShell. PowerShell can be installed on some distributions of Linux that aren't supported by
Microsoft. In those cases, you may find support from the community for PowerShell on those
platforms.

For more information, see the [PowerShell Support Lifecycle][01] documentation.

This article lists the supported Linux distributions and package managers. All PowerShell releases
remain supported until either the version of PowerShell or the version of the Linux distribution
reaches end-of-support.

For the best compatibility, choose a long-term release (LTS) version.

## Alpine

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

For more information, see [Install PowerShell on Alpine][03].

## Debian

Debian uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Debian support](../../includes/debian-support.md)]

For more information, see [Install PowerShell on Debian][04].

## Red Hat Enterprise Linux (RHEL)

RHEL 7 uses yum and RHEL 8 uses the dnf package manager.

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

For more information, see [Install PowerShell on RHEL][06].

## Ubuntu

Ubuntu uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

For more information, see [Install PowerShell on Ubuntu][07].

## Community supported distributions

PowerShell can be installed on many distributions of Linux that aren't supported by Microsoft. In
those cases, you may find support from the community for PowerShell on those platforms

To be supported by Microsoft, the Linux distribution must meet the following criteria:

- The version and architecture of the distribution is supported by .NET Core.
- The version of the distribution is supported for at least one year.
- The version of the distribution isn't an interim release or equivalent.
- The PowerShell team has tested the version of the distribution.

For more information, see [Community support for PowerShell on Linux][02].

## Alternate installation methods

There are three other ways to install PowerShell on Linux, including Linux distributions that aren't
officially supported. You can try to install PowerShell using the PowerShell Snap Package. You can
also try deploying PowerShell binaries directly using the Linux `tar.gz` package. For more
information, see [Alternate ways to install PowerShell on Linux][05].

<!-- link references -->
[01]: ../PowerShell-Support-Lifecycle.md
[02]: community-support.md
[03]: install-alpine.md
[04]: install-debian.md
[05]: alternate-install-methods.md
[06]: install-rhel.md
[07]: install-ubuntu.md
