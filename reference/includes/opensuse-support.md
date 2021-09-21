---
author: sdwheeler
ms.author: sewhee
ms.date: 08/09/2021
ms.topic: include
ms.prod: powershell
---
The following table is a list of currently supported PowerShell releases and the versions of
openSUSE they are supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[openSUSE reaches end-of-support][eol-suse].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|   openSUSE    | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ------------- | :-------: | :-----------: | :---------------: |
| &#x2705; 15.3 | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x2705; 15.2 | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x274c; 15.1 | &#x1f7e1; |   &#x1f7e1;   |     &#x1f7e1;     |
| &#x274c; 42.3 | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |

PowerShell is supported on openSUSE for the following processor architectures.

|        openSUSE        | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ---------------------- | :-------: | :-----------: | :---------------: |
| All supported versions |    x64    |      x64      |        x64        |

[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[eol-suse]: https://en.opensuse.org/Lifetime
