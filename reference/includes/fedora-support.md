---
author: sdwheeler
ms.author: sewhee
ms.date: 01/19/2022
ms.prod: powershell
ms.topic: include
---
The following table lists the supported PowerShell releases and the versions of Fedora they're
supported on. These versions are supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Fedora reaches end-of-life][eol-fedora].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|   Fedora    | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-current) | 7.3 (preview) |
| ----------- | :-------: | :-----------: | :---------------: | :-----------: |
| &#x2705; 32 | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |   &#x274c;    |
| &#x274c; 31 | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |   &#x274c;    |
| &#x274c; 30 | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |   &#x274c;    |

PowerShell has not been tested on Fedora versions 33 and 34.

PowerShell is supported on Fedora for the following processor architectures.

|         Fedora         | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-current) | 7.3 (preview) |
| ---------------------- | :-------: | :-----------: | :---------------: | :-----------: |
| All supported versions |    x64    |      x64      |        x64        |      x64      |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-fedora]: https://fedoraproject.org/wiki/End_of_life
