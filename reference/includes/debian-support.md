---
author: sdwheeler
ms.author: sewhee
ms.date: 07/12/2024
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Debian reaches end-of-life][eol-debian].

Docker images containing PowerShell 7.2, PowerShell 7.4, and PowerShell 7.5-preview for x64 are
available from the [Microsoft Artifact Registry][mcr] for the following versions of Debian:

- Debian 12 (Bookworm) - OS support ends on 2026-06-10
- Debian 11 (Bullseye) - OS support ends on 2024-07-31

Preview versions of PowerShell are provided for testing and feedback only.

Install package files (`.deb`) are also available from [https://packages.microsoft.com/][pcm].

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-debian]: https://wiki.debian.org/DebianReleases
[mcr]: https://mcr.microsoft.com/product/powershell/tags
[pcm]: https://packages.microsoft.com/
