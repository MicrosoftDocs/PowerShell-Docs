---
author: sdwheeler
ms.author: sewhee
ms.date: 08/09/2021
ms.topic: include
ms.prod: powershell
---
The following table is a list of currently supported PowerShell releases and the versions of Debian
they're supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Debian reaches end-of-life][eol-debian].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|   Debian    | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ----------- | :-------: | :-----------: | :---------------: |
| &#x2705; 10 | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x2705; 9  | &#x2705;  |   &#x2705;    |     &#x274c;      |
| &#x274c; 8  | &#x1f7e1; |   &#x274c;    |     &#x274c;      |

PowerShell is supported on Debian for the following processor architectures.

|   Debian   |     7.0 (LTS)     |   7.1 (current)   | 7.2 (LTS-preview) |
| ---------- | :---------------: | :---------------: | :---------------: |
| Version 9+ | x64, Arm32, Arm64 | x64, Arm32, Arm64 | x64, Arm32, Arm64 |

[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[eol-debian]: https://wiki.debian.org/DebianReleases
