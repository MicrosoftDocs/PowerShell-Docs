---
author: sdwheeler
ms.author: sewhee
ms.date: 08/09/2021
ms.topic: include
ms.prod: powershell
---
The following table is a list of currently supported versions of PowerShell and the versions of RHEL
they are supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[RHEL reaches end-of-support][eol-rhel].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|    RHEL    | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ---------- | :-------: | :-----------: | :---------------: |
| &#x2705; 8 | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x2705; 7 | &#x2705;  |   &#x2705;    |     &#x2705;      |

PowerShell is supported on RHEL for the following processor architectures.

|          RHEL          | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ---------------------- | :-------: | :-----------: | :---------------: |
| All supported versions |    x64    |      x64      |    x64, Arm64     |

[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[eol-rhel]: https://access.redhat.com/support/policy/updates/errata/
