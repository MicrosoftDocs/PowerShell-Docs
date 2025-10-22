---
author: sdwheeler
ms.author: sewhee
ms.date: 09/16/2025
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Ubuntu reaches end-of-support][eol-ubuntu].

Install package files (`.deb`) are also available from [https://packages.microsoft.com/][pcm].

The Docker images for the .NET SDK contain the latest versions of PowerShell. You can download these
images from the [Microsoft Artifact Registry][mcr].

These images are built from official operating system (OS) images provide by the OS distributor.
These images may not have the latest security updates. Microsoft recommends that you update the OS
packages to the latest version to ensure the latest security updates are applied.

These images are provided for testing purposes. If you need a Docker image for a production
workload, you should build and maintain your own.

> [!NOTE]
> Ubuntu 25.04 (Plucky Puffin) is an interim release. Microsoft doesn't support
> [interim releases][interim] of Ubuntu. For more information, see
> [Community supported distributions][community].

[eol-ubuntu]: https://endoflife.date/ubuntu
[interim]: https://ubuntu.com/about/release-cycle
[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[community]: /powershell/scripting/install/community-support
[mcr]: https://mcr.microsoft.com/en-us/artifact/mar/dotnet/sdk/tags
[pcm]: https://packages.microsoft.com/
