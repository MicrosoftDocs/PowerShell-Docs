---
author: sdwheeler
ms.author: sewhee
ms.date: 01/09/2023
ms.prod: powershell
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
The following table is a list of currently supported versions of PowerShell and the versions of RHEL
they're supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[RHEL reaches end-of-support][eol-rhel].

- The ![Supported][1] icon indicates that the version of the OS or PowerShell is still supported
- The ![Out of Support][4] icon indicates the version of PowerShell is no longer supported on that
  version of the OS
- The ![In Test][2] icon indicates that we haven't finished testing PowerShell on that OS
- The ![Not Supported][3] icon indicates that the version of the OS or PowerShell isn't supported
- When both the version of the OS and the version of PowerShell have a ![Supported][1] icon, that
  combination is supported

[1]: ../media/shared/check-mark-button-2705.svg
[2]: ../media/shared/construction-sign-1f6a7.svg
[3]: ../media/shared/cross-mark-274c.svg
[4]: ../media/shared/large-yellow-circle-1f7e1.svg

|       RHEL        | 7.2 (LTS-current) |       7.3       |  7.4 (preview)      |
| ----------------- | :---------------: | :-------------: | :-----------------: |
| ![Supported][1] 9 |  ![Supported][1]  | ![Supported][1] | ![Supported][1]     |
| ![Supported][1] 8 |  ![Supported][1]  | ![Supported][1] | ![Supported][1]     |
| ![Supported][1] 7 |  ![Supported][1]  | ![Supported][1] | ![Not Supported][3] |

PowerShell is supported on RHEL for the following processor architectures.

|          RHEL          | 7.2 (LTS-current) |  7.3  | 7.4 (preview) |
| ---------------------- | :---------------: | :---: | :-----------: |
| All supported versions |        x64        |  x64  |      x64      |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[eol-rhel]: https://access.redhat.com/support/policy/updates/errata/
