---
author: sdwheeler
ms.author: sewhee
ms.date: 07/12/2024
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[RHEL reaches end-of-support][eol-rhel].

Docker images containing PowerShell 7.2, PowerShell 7.4, and PowerShell 7.5-preview for x64 are
available from the [Microsoft Artifact Registry][mcr] for the following versions of RHEL:

- RHEL 8 - OS support ends on 2029-05-31
- RHEL 9 - OS support ends on 2032-05-31

PowerShell is tested on Red Hat Universal Base Images (UBI). For more information, see the
[UBI information page][ubi].

Install package files (`.rpm`) are also available from [https://packages.microsoft.com/][pcm].

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-rhel]: https://access.redhat.com/support/policy/updates/errata/
[ubi]: https://developers.redhat.com/products/rhel/ubi
[mcr]: https://mcr.microsoft.com/product/powershell/tags
[pcm]: https://packages.microsoft.com/
