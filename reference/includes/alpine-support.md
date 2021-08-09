---
author: sdwheeler
ms.author: sewhee
ms.date: 08/09/2021
ms.topic: include
ms.prod: powershell
---
The following table is a list of currently supported PowerShell releases and the versions of Alpine
they're supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Alpine reaches end-of-life][eol-alpine].

- A &#x2714;&#xfe0f; indicates that the version of the OS or PowerShell is still supported
- A &#x274c; indicates that the version of the OS or PowerShell isn't supported
- A &#x2b55; indicates the version of PowerShell is no longer supported on that version of the OS
- When both the version of the OS and the version of PowerShell have &#x2714;&#xfe0f;, that
  combination is supported

|        Alpine         |    7.0 (LTS)     |  7.1 (Current)   | 7.2 (LTS-preview) |
| --------------------- | :--------------: | :--------------: | :---------------: |
| &#x2714;&#xfe0f; 3.13 | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; | &#x2714;&#xfe0f;  |
| &#x2714;&#xfe0f; 3.12 | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |     &#x274c;      |
| &#x2714;&#xfe0f; 3.11 | &#x2714;&#xfe0f; | &#x2714;&#xfe0f; |     &#x274c;      |
| &#x274c; 3.10         |     &#x2b55;     |     &#x2b55;     |     &#x274c;      |
| &#x274c; 3.9          |     &#x2b55;     |     &#x2b55;     |     &#x274c;      |

[lifecycle]: ../PowerShell-Support-Lifecycle.md
[eol-alpine]: https://alpinelinux.org/releases/
