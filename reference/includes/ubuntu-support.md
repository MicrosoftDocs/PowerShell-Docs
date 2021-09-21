---
author: sdwheeler
ms.author: sewhee
ms.date: 08/09/2021
ms.topic: include
ms.prod: powershell
---
The following table is a list of currently supported PowerShell releases and the versions of
Ubuntu they are supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Ubuntu reaches end-of-support][eol-ubuntu].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|        Ubuntu        | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| -------------------- | :-------: | :-----------: | :---------------: |
| &#x2705; 20.04 (LTS) | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x2705; 18.04 (LTS) | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x274c; 16.04 (LTS) | &#x1f7e1; |   &#x1f7e1;   |     &#x274c;      |

Only the LTS releases of Ubuntu are officially supported. Microsoft does not support
[interim releases][interim] or their equivalent. Interim releases are community supported. For more
information, see [Community supported distributions][community].

PowerShell is supported on Ubuntu for the following processor architectures.

|         Ubuntu         |     7.0 (LTS)     |   7.1 (current)   | 7.2 (LTS-preview) |
| ---------------------- | :---------------: | :---------------: | :---------------: |
| All supported versions | x64, Arm32, Arm64 | x64, Arm32, Arm64 | x64, Arm32, Arm64 |

[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[eol-ubuntu]: https://wiki.ubuntu.com/Releases
[interim]: https://ubuntu.com/about/release-cycle
[community]: community-support.md
