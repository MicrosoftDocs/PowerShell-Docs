---
description: This article is explains the support policy for WSMan-based remoting on non-Windows platforms.
ms.date: 06/28/2023
title: WSMan remoting is not supported on non-Windows platforms
---
# WSMan remoting is not supported on non-Windows platforms

Since the release of PowerShell 6, support for remoting over WS-Management (WSMan) on non-Windows
platforms has only been available to a limited set of Linux distributions. All versions of those
distributions that supported WSMan are no longer supported by the Linux vendors that created them.

On non-Windows, WSMan relied on the [Open Management Infrastructure (OMI)][01] project, which no
longer supports PowerShell remoting. The OMI WSMan client is dependent on **OpenSSL 1.0**. Most
Linux distributions have moved to **OpenSSL 2.0**, which is not backward-compatible. At this time,
there is no supported distribution that has the dependencies needed for the OMI WSMan client to
work.

Our plan for PowerShell 7.3 is to remove outdated libraries and supporting code for non-Windows
platforms. WSMan-based remoting is still supported between Windows systems. Remoting over SSH is
supported for all platforms. For more information, see [PowerShell remoting over SSH][03].

> [!NOTE]
> Users may be able to get WSMan remoting to work using the [PSWSMan][02] module. This module is not
> supported or maintained by Microsoft.

<!-- link references -->
[01]: https://github.com/Microsoft/omi
[02]: https://www.powershellgallery.com/packages/PSWSMan
[03]: SSH-Remoting-in-PowerShell-Core.md
