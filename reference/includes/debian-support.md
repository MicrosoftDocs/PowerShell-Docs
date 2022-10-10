---
author: sdwheeler
ms.author: sewhee
ms.date: 06/30/2022
ms.prod: powershell
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
The following table is a list of currently supported PowerShell releases and the versions of Debian
they're supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Debian reaches end-of-life][eol-debian].

- The ![Supported][1] icon indicates that the version of the OS or PowerShell is still supported
- The ![Out of Support][4] icon indicates the version of PowerShell is no longer supported on that
  version of the OS
- The ![In Test][2] icon indicates that we haven't finished testing PowerShell on that OS
- The ![Not Supported][3] icon indicates that the version of the OS or PowerShell isn't supported
- When both the version of the OS and the version of PowerShell have a ![Supported][1] icon, that
  combination is supported

[1]: ../media/shared/check-mark-button_2705.svg
[2]: ../media/shared/construction-sign_1f6a7.svg
[3]: ../media/shared/cross-mark_274c.svg
[4]: ../media/shared/large-yellow-circle_1f7e1.svg

|        Debian         |      7.0 (LTS)       |         7.1          |  7.2 (LTS-current)   |    7.3 (preview)     |
| --------------------- | :------------------: | :------------------: | :------------------: | :------------------: |
| ![Supported][1] 11    |   ![Supported][1]    | ![Out of Support][4] |   ![Supported][1]    |   ![Supported][1]    |
| ![Supported][1] 10    |   ![Supported][1]    | ![Out of Support][4] |   ![Supported][1]    |   ![Supported][1]    |
| ![Supported][1] 9     | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] |
| ![Not Supported][3] 8 | ![Out of Support][4] | ![Not Supported][3]  | ![Not Supported][3]  | ![Not Supported][3]  |

PowerShell is supported on Debian for the following processor architectures.

|   Debian   |     7.0 (LTS)     | 7.2 (LTS-current) |   7.3 (preview)   |
| ---------- | :---------------: | :---------------: | :---------------: |
| Version 9+ | x64, Arm32, Arm64 | x64, Arm32, Arm64 | x64, Arm32, Arm64 |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-debian]: https://wiki.debian.org/DebianReleases
