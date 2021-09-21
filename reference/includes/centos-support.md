---
author: sdwheeler
ms.author: sewhee
ms.date: 08/09/2021
ms.topic: include
ms.prod: powershell
---
The following table is a list of currently supported PowerShell releases and the versions of CentOS
they are supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[CentOS reaches end-of-support][eol-centos].

- A &#x2705; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x1f7e1; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2705;, that combination is
  supported

|   CentOS   | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ---------- | :-------: | :-----------: | :---------------: |
| &#x2705; 8 | &#x2705;  |   &#x2705;    |     &#x2705;      |
| &#x2705; 7 | &#x2705;  |   &#x2705;    |     &#x2705;      |

Microsoft does not officially support PowerShell on the CentOS Stream releases. For more
information, see [Comparing CentOS Linux and CentOS Stream][stream]. CentOS Stream is community
supported. For more information, see [Community supported distributions][community].

PowerShell is supported on CentOS for the following processor architectures.

|         CentOS         | 7.0 (LTS) | 7.1 (current) | 7.2 (LTS-preview) |
| ---------------------- | :-------: | :-----------: | :---------------: |
| All supported versions |    x64    |      x64      |        x64        |

[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[eol-centos]: https://www.centos.org/centos-linux-eol/
[stream]: https://www.centos.org/cl-vs-cs/
[community]: community-support.md
