---
author: sdwheeler
ms.author: sewhee
ms.date: 07/12/2022
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

|    Alpine     | 7.0 (LTS) |    7.1    | 7.2 (LTS-current) | 7.3 (preview) |
| ------------- | :-------: | :-------: | :---------------: | :-----------: |
| &#x2705; 3.14 | &#x274c;  | &#x1f7e1; |     &#x2705;      |   &#x2705;    |
| &#x2705; 3.13 | &#x274c;  | &#x1f7e1; |     &#x2705;      |   &#x2705;    |
| &#x2705; 3.12 | &#x2705;  | &#x1f7e1; |     &#x2705;      |   &#x2705;    |
| &#x2705; 3.11 | &#x274c;  | &#x1f7e1; |     &#x274c;      |   &#x274c;    |
| &#x274c; 3.10 | &#x1f7e1; | &#x1f7e1; |     &#x274c;      |   &#x274c;    |
| &#x274c; 3.9  | &#x1f7e1; | &#x1f7e1; |     &#x274c;      |   &#x274c;    |

Alpine 3.15 is in the process of being tested for PowerShell 7.3 (preview).

PowerShell is supported on Alpine for the following processor architectures.

|         Alpine         | 7.0 (LTS) | 7.2 (LTS-current) | 7.3 (preview) |
| ---------------------- | :-------: | :---------------: | :-----------: |
| All supported versions |    x64    |        x64        |      x64      |

PowerShell hasn't been tested on Alpine using Arm processors.

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-alpine]: https://alpinelinux.org/releases/
