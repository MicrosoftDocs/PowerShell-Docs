---
author: sdwheeler
ms.author: sewhee
ms.date: 09/22/2021
ms.prod: powershell
ms.topic: include
---
The following table lists the supported PowerShell releases and the versions of Alpine they're
supported on. These versions are supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Alpine reaches end-of-life][eol-alpine].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|    Alpine     | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ------------- | :-------: | :-----------: | :---------------: |
| &#x2705; 3.12 | &#x2705;  |   &#x2705;    |     &#x274c;      |
| &#x2705; 3.11 | &#x2705;  |   &#x2705;    |     &#x274c;      |
| &#x274c; 3.10 | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |
| &#x274c; 3.9  | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |

PowerShell has not been tested on Alpine versions 3.13 and 3.14.

> [!NOTE]
> CIM, PowerShell Remoting, and DSC are not supported on Alpine.

PowerShell is supported on Alpine for the following processor architectures.

|         Alpine         | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ---------------------- | :-------: | :-----------: | :---------------: |
| All supported versions |    x64    |      x64      |        x64        |

PowerShell has not been tested on Alpine using Arm processors.

[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[eol-alpine]: https://alpinelinux.org/releases/
