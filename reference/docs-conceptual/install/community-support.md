---
title: Community support for PowerShell on Linux
description: PowerShell may run on Linux distributions that are not officially supported by Microsoft.
ms.date: 08/16/2021
---
# Community support for PowerShell on Linux

There are many distributions of Linux that are not officially supported by Microsoft. In some cases,
PowerShell may be supported by the community for these releases.

To be supported by Microsoft, the Linux distribution must meet the following criteria:

- The version and architecture of the distribution is supported by .NET Core.
- The version of the distribution is supported for at least one year.
- The version of the distribution is not an interim release or equivalent.
- The PowerShell team has tested the version of the distribution.

For more information, see the [PowerShell Support Lifecycle][powershell-support-lifecycle.md]
documentation.

The following distributions are supported by the community. Each distribution has its own community
support mechanisms. Consult the distribution's website to find their community resources. You may
also get help from these [PowerShell Community][pscommunity] resources.

## CentOS Stream

The documented steps to install PowerShell on [CentOS Linux](install-centos.md) may work on CentOS
Stream. However, Microsoft does not officially support PowerShell on the CentOS Stream releases.
CentOS Stream distributions are continuously updated. This falls into the category of an interim
release.

For more information, see [Comparing CentOS Linux and CentOS Stream][stream].

## Ubuntu interim releases

The documented steps to install PowerShell on [Ubuntu](install-ubuntu.md) may work on Ubuntu interim
releases. However, PowerShell is only supported on the LTS releases of Ubuntu. Microsoft does not
support [interim releases][interim] of Ubuntu.

## Arch Linux

> [!NOTE]
> Arch support is not officially supported by Microsoft and is maintained by the community.

PowerShell is available from the [Arch Linux][arch] User Repository (AUR).

- It can be compiled with the [latest tagged release][arch-release]
- It can be compiled from the [latest commit to master][arch-git]
- It can be installed using the [latest release binary][arch-bin]

Packages in the AUR are maintained by the community. For more information on installing packages
from the AUR, see the [Arch Linux wiki][arch-wiki] or
[Using PowerShell in Docker](powershell-in-docker.md).

## Kali

Kali support is not officially supported by Microsoft and is maintained by the community.

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

[arch]: https://www.archlinux.org/download/
[arch-release]: https://aur.archlinux.org/packages/powershell/
[arch-git]: https://aur.archlinux.org/packages/powershell-git/
[arch-bin]: https://aur.archlinux.org/packages/powershell-bin/
[arch-wiki]: https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages
[stream]: https://www.centos.org/cl-vs-cs/
[pscommunity]:../community/community-support.md
[interim]: https://ubuntu.com/about/release-cycle
