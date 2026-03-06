---
author: sdwheeler
ms.author: sewhee
ms.date: 03/06/2026
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Debian reaches end-of-life][eol-debian].

Support for these versions of Debian ends on the following dates:

- Debian 13 - 2028-08-09
- Debian 12 - 2026-06-10

Install package files (`.deb`) are also available from [https://packages.microsoft.com/][pcm].

The Docker images for the .NET SDK contain the latest versions of PowerShell. These images are
available from the [Microsoft Artifact Registry][mcr].

These images are built from official operating system (OS) images provide by the OS distributor.
These images may not have the latest security updates. Microsoft recommends that you update the OS
packages to the latest version to ensure the latest security updates are applied.

These images are provided for testing purposes. If you need a Docker image for a production
workload, you should build and maintain your own.

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-debian]: https://wiki.debian.org/DebianReleases
[mcr]: https://mcr.microsoft.com/en-us/artifact/mar/dotnet/sdk/tags
[pcm]: https://packages.microsoft.com/
