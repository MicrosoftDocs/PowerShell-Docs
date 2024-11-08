---
author: sdwheeler
ms.author: sewhee
ms.date: 11/02/2024
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
Microsoft supports PowerShell until [PowerShell reaches end-of-support][lifecycle] or the version of
[Windows reaches end-of-support][eol-windows].

- Docker images containing PowerShell 7.4 and PowerShell 7.5-preview for x64 for Windows Server
  2022, Windows Server Core 2022, and Windows Server Nano build 1809 are available from the
  [Microsoft Artifact Registry][mcr].
- PowerShell 7.4 and higher can be installed on Windows 10 build 1607 and higher, Windows 11,
  Windows Server 2016 and higher.

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
