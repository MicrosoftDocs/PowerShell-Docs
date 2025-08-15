---
author: sdwheeler
ms.author: sewhee
ms.date: 07/03/2025
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Windows reaches end-of-support][eol-windows].

The Docker images for the .NET SDK contain the latest versions of PowerShell. These images are
available from the [Microsoft Artifact Registry][mcr].

These images may not have the latest security updates. Microsoft recommends that you update the OS
packages to the latest version to ensure the latest security updates are applied.

These images are provided for testing purposes. If you need a Docker image for a production
workload, you should build and maintain your own.

> [!NOTE]
> Support for a specific version of Windows is determined by the Microsoft Support Lifecycle
> policies. For more information, see:
>
> - [Windows client lifecycle FAQ][client-faq]
> - [Modern Lifecycle Policy FAQ][modern]

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-windows]: /lifecycle/products/?terms=Windows%20Server&products=windows
[client-faq]: /lifecycle/faq/windows
[modern]: /lifecycle/policies/modern
[mcr]: https://mcr.microsoft.com/product/powershell/tags
