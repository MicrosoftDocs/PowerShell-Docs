---
author: sdwheeler
ms.author: sewhee
ms.date: 11/08/2021
ms.prod: powershell
ms.topic: include
---
The following table is a list of PowerShell releases and the versions of Windows they are supported
on. These versions are supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Windows reaches end-of-support][eol-windows].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|                     Windows                      | 7.0 (LTS) |    7.1    | 7.2 (LTS-current) |
| ------------------------------------------------ | :-------: | :-------: | :---------------: |
| &#x2705; Windows Server 2016, 2019, or 2022      | &#x2705;  | &#x2705;  |     &#x2705;      |
| &#x2705; Windows Server 2012 R2                  | &#x2705;  | &#x2705;  |     &#x2705;      |
| &#x2705; Windows Server Core (2012 R2 or higher) | &#x2705;  | &#x2705;  |     &#x2705;      |
| &#x2705; Windows Server Nano (1809 or higher)    | &#x2705;  | &#x2705;  |     &#x2705;      |
| &#x274c; Windows Server 2012                     | &#x1f7e1; | &#x1f7e1; |     &#x274c;      |
| &#x274c; Windows Server 2008 R2                  | &#x1f7e1; | &#x1f7e1; |     &#x274c;      |
| &#x2705; Windows 11                              | &#x2705;  | &#x2705;  |     &#x2705;      |
| &#x2705; Windows 10 1607+                        | &#x2705;  | &#x2705;  |     &#x2705;      |
| &#x2705; Windows 8.1                             | &#x2705;  | &#x2705;  |     &#x274c;      |

> [!NOTE]
> Support for a specific version of Windows is determined by the Microsoft Support Lifecycle
> policies. For more information, see:
>
> - [Windows client lifecycle FAQ][client-faq]
> - [Modern Lifecycle Policy FAQ][modern]

PowerShell is supported on Windows for the following processor architectures.

|           Windows            | 7.0 (LTS)  |       7.1       | 7.2 (LTS-current) |
| ---------------------------- | :--------: | :-------------: | :---------------: |
| Nano Server Version 1803+    | x64, Arm32 |       x64       |        x64        |
| Windows Server 2012 R2+      |  x64, x86  |    x64, x86     |     x64, x86      |
| Windows Server Core 2012 R2+ |  x64, x86  |    x64, x86     |     x64, x86      |
| Windows 10 or 11 Client      |  x64, x86  | x64, x86, Arm64 |  x64, x86, Arm64  |
| Windows 8.1 Client           |  x64, x86  |    x64, x86     |     x64, x86      |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-windows]: /lifecycle/products/?terms=Windows%20Server&products=windows
[client-faq]: /lifecycle/faq/windows
[modern]: /lifecycle/policies/modern
