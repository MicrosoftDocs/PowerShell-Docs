---
author: sdwheeler
ms.author: sewhee
ms.date: 01/09/2023
ms.prod: powershell
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
The following table is a list of PowerShell releases and the versions of Windows they're supported
on. These versions are supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Windows reaches end-of-support][eol-windows].

- The ![Supported][1] icon indicates that the version of the OS or PowerShell is still supported
- The ![Out of Support][4] icon indicates the version of PowerShell is no longer supported on that
  version of the OS
- The ![In Test][2] icon indicates that we haven't finished testing PowerShell on that OS
- The ![Not Supported][3] icon indicates that the version of the OS or PowerShell isn't supported
- When both the version of the OS and the version of PowerShell have a ![Supported][1] icon, that
  combination is supported

[1]: ../media/shared/check-mark-button-2705.svg
[2]: ../media/shared/construction-sign-1f6a7.svg
[3]: ../media/shared/cross-mark-274c.svg
[4]: ../media/shared/large-yellow-circle-1f7e1.svg

|                         Windows                         | 7.2 (LTS-current) |       7.3       |  7.4 (preview)  |
| ------------------------------------------------------- | :---------------: | :-------------: | :-------------: |
| ![Supported][1] Windows Server 2016, 2019, or 2022      |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] Windows Server 2012 R2                  |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] Windows Server Core (2012 R2 or higher) |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] Windows Server Nano (1809 or higher)    |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] Windows 11                              |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] Windows 10 1607+                        |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |

> [!NOTE]
> Support for a specific version of Windows is determined by the Microsoft Support Lifecycle
> policies. For more information, see:
>
> - [Windows client lifecycle FAQ][client-faq]
> - [Modern Lifecycle Policy FAQ][modern]

PowerShell is supported on Windows for the following processor architectures.

|           Windows            | 7.2 (LTS-current) |       7.3       |  7.4 (preview)  |
| ---------------------------- | :---------------: | :-------------: | :-------------: |
| Nano Server Version 1803+    |        x64        |       x64       |       x64       |
| Windows Server 2012 R2+      |     x64, x86      |    x64, x86     |    x64, x86     |
| Windows Server Core 2012 R2+ |     x64, x86      |    x64, x86     |    x64, x86     |
| Windows 10 or 11 Client      |  x64, x86, Arm64  | x64, x86, Arm64 | x64, x86, Arm64 |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-windows]: /lifecycle/products/?terms=Windows%20Server&products=windows
[client-faq]: /lifecycle/faq/windows
[modern]: /lifecycle/policies/modern
