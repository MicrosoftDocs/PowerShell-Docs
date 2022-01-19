---
author: sdwheeler
ms.author: sewhee
ms.date: 01/19/2022
ms.prod: powershell
ms.topic: include
---
The following table is a list of currently supported PowerShell releases and the versions of
Windows they are supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[macOS reaches end-of-support][eol-windows].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|              macOS               | 7.0 (LTS) |   7.1    | 7.2 (LTS-current) | 7.3 (preview) |
| -------------------------------- | :-------: | :------: | :---------------: | :-----------: |
| &#x2705; macOS Big Sur 11.5      | &#x2705;  | &#x2705; |     &#x2705;      |   &#x2705;    |
| &#x2705; macOS Catalina 10.15    | &#x2705;  | &#x2705; |     &#x2705;      |   &#x2705;    |
| &#x2705; macOS Mojave 10.14      | &#x2705;  | &#x2705; |     &#x2705;      |   &#x2705;    |
| &#x2705; macOS High Sierra 10.13 | &#x2705;  | &#x2705; |     &#x274c;      |   &#x274c;    |

macOS Monterey 12.0 has not been tested.

Support of macOS is defined by Apple. For more information, see:

- [Apple Support Sitemap](https://support.apple.com/sitemap)
- [Apple Security Updates](https://support.apple.com/HT201222)

PowerShell is supported on macOS for the following processor architectures:

|          macOS           | 7.0 (LTS) |  7.1  | 7.2 (LTS-current) | 7.3 (preview) |
| ------------------------ | :-------: | :---: | :---------------: | :-----------: |
| macOS Big Sur 11.5       |    x64    |  x64  |    x64, Arm64     |  x64, Arm64   |
| macOS High Sierra 10.13+ |    x64    |  x64  |        x64        |      x64      |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
