---
author: sdwheeler
ms.author: sewhee
ms.date: 10/10/2022
ms.prod: powershell
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
The following table lists the supported PowerShell releases and the versions of Alpine they're
supported on. These versions are supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Alpine reaches end-of-life][eol-alpine].

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

|          Alpine          |      7.0 (LTS)       |         7.1          |  7.2 (LTS-current)   |    7.3 (preview)     |
| :----------------------: | :------------------: | :------------------: | :------------------: | :------------------: |
| ![Supported][1] 3.15     | ![Not Supported][3]  | ![Not Supported][3]  |    ![In Test][2]     |    ![In Test][2]     |
| ![Supported][1] 3.14     | ![Not Supported][3]  | ![Out of Support][4] |   ![Supported][1]    |   ![Supported][1]    |
| ![Not Supported][3] 3.13 | ![Not Supported][3]  | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] |
| ![Not Supported][3] 3.12 | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] |
| ![Not Supported][3] 3.11 | ![Not Supported][3]  | ![Out of Support][4] | ![Not Supported][3]  | ![Not Supported][3]  |
| ![Not Supported][3] 3.10 | ![Out of Support][4] | ![Out of Support][4] | ![Not Supported][3]  | ![Not Supported][3]  |
| ![Not Supported][3] 3.9  | ![Out of Support][4] | ![Out of Support][4] | ![Not Supported][3]  | ![Not Supported][3]  |

Alpine 3.15 is in the process of being tested.

PowerShell is supported on Alpine for the following processor architectures.

|         Alpine         | 7.0 (LTS) | 7.2 (LTS-current) | 7.3 (preview) |
| ---------------------- | :-------: | :---------------: | :-----------: |
| All supported versions |    x64    |        x64        |      x64      |

PowerShell hasn't been tested on Alpine using Arm processors.

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-alpine]: https://alpinelinux.org/releases/
