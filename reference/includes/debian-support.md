---
author: sdwheeler
ms.author: sewhee
ms.date: 11/02/2024
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Debian reaches end-of-life][eol-debian].

Install package files (`.deb`) are also available from [https://packages.microsoft.com/][pcm].

Docker images containing PowerShell 7.4 and PowerShell 7.5-preview for x64 are available from the
[Microsoft Artifact Registry][mcr] for the following versions of Debian:

- Debian 12 (Bookworm) - OS support ends on 2026-06-10

> [!IMPORTANT]
> The Docker images are built from official operating system (OS) images provide by the OS
> distributor. These images may not have the latest security updates. Microsoft recommends that you
> update the OS packages to the latest version to ensure the latest security updates are applied.

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-debian]: https://wiki.debian.org/DebianReleases
[mcr]: https://mcr.microsoft.com/product/powershell/tags
[pcm]: https://packages.microsoft.com/
