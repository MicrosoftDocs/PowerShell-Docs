---
author: sdwheeler
ms.author: sewhee
ms.date: 11/02/2024
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Ubuntu reaches end-of-support][eol-ubuntu].

Install package files (`.deb`) are also available from [https://packages.microsoft.com/][pcm].

Docker images containing PowerShell 7.4 and PowerShell 7.5-preview for x64 and Arm32 are available
from the [Microsoft Artifact Registry][mcr] for the following versions of Ubuntu:

- Ubuntu 24.04 (Noble Numbat) - OS support ends on 2029-04-01
- Ubuntu 22.04 (Jammy Jellyfish) - OS support ends on 2027-04-01
- Ubuntu 20.04 (Focal Fossa) - OS support ends on 2025-04-02

Ubuntu 24.10 (Oracular Oriole) is an interim release. Microsoft doesn't support
[interim releases][interim] of Ubuntu. For more information, see
[Community supported distributions][community].

> [!IMPORTANT]
> The Docker images are built from official operating system (OS) images provide by the OS
> distributor. These images may not have the latest security updates. Microsoft recommends that you
> update the OS packages to the latest version to ensure the latest security updates are applied.

[eol-ubuntu]: https://endoflife.date/ubuntu
[interim]: https://ubuntu.com/about/release-cycle
[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[community]: /powershell/scripting/install/community-support
[mcr]: https://mcr.microsoft.com/product/powershell/tags
[pcm]: https://packages.microsoft.com/
