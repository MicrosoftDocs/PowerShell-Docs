---
author: sdwheeler
ms.author: sewhee
ms.date: 11/02/2024
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Alpine reaches end-of-life][eol-alpine].

Docker images containing PowerShell 7.4 and PowerShell 7.5-preview for x64 are available from the
[Microsoft Artifact Registry][mcr] for the following versions of Alpine:

- Alpine 3.17 - OS support ends on 2024-11-22

Docker images of PowerShell aren't available for Alpine 3.18, 3.19, and 3.20.

> [!IMPORTANT]
> The Docker images are built from official operating system (OS) images provide by the OS
> distributor. These images may not have the latest security updates. Microsoft recommends that you
> update the OS packages to the latest version to ensure the latest security updates are applied.

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-alpine]: https://alpinelinux.org/releases/
[mcr]: https://mcr.microsoft.com/en-us/product/powershell/tags
