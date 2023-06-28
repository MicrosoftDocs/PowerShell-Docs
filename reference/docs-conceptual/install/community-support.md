---
description: PowerShell may run on Linux distributions that aren't officially supported by Microsoft.
ms.date: 06/28/2023
title: Community support for PowerShell on Linux
---
# Community support for PowerShell on Linux

There are many distributions of Linux that aren't officially supported by Microsoft. In some cases,
PowerShell may be supported by the community for these releases.

To be supported by Microsoft, the Linux distribution must meet the following criteria:

- The version and architecture of the distribution is supported by .NET Core.
- The version of the distribution is supported for at least one year.
- The version of the distribution isn't an interim release or equivalent.
- The PowerShell team has tested the version of the distribution.

For more information, see the [PowerShell Support Lifecycle][10]
documentation.

The following distributions are supported by the community. Each distribution has its own community
support mechanisms. Consult the distribution's website to find their community resources. You may
also get help from these [PowerShell Community][01] resources.

## Ubuntu interim releases

The documented steps to install PowerShell on [Ubuntu][08] may work on Ubuntu interim releases.
However, PowerShell is only supported on the LTS releases of Ubuntu. Microsoft doesn't support
[interim releases][05] of Ubuntu.

## Arch Linux

> [!NOTE]
> Arch support isn't officially supported by Microsoft and is maintained by the community.

PowerShell is available from the [Arch Linux][07] User Repository (AUR).

- It can be compiled with the [latest tagged release][04]
- It can be compiled from the [latest commit to master][03]
- It can be installed using the [latest release binary][02]

Packages in the AUR are maintained by the community. For more information on installing packages
from the AUR, see the [Arch Linux wiki][06] or [Using PowerShell in Docker][09].

## Kali

Kali support isn't officially supported by Microsoft and is maintained by the community.

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

<!-- link references -->
[01]: ../community/community-support.md
[02]: https://aur.archlinux.org/packages/powershell-bin/
[03]: https://aur.archlinux.org/packages/powershell-git/
[04]: https://aur.archlinux.org/packages/powershell/
[05]: https://ubuntu.com/about/release-cycle
[06]: https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages
[07]: https://www.archlinux.org/download/
[08]: install-ubuntu.md
[09]: powershell-in-docker.md
[10]: powershell-support-lifecycle.md
