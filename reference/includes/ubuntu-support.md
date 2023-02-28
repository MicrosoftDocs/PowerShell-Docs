---
author: sdwheeler
ms.author: sewhee
ms.date: 01/09/2023
ms.prod: powershell
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
The following table is a list of currently supported PowerShell releases and the versions of
Ubuntu they're supported on. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of
[Ubuntu reaches end-of-support][eol-ubuntu].

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

|           Ubuntu            | 7.2 (LTS-current) |       7.3       |  7.4 (preview)  |
| --------------------------- | :---------------: | :-------------: | :-------------: |
| ![Supported][1] 22.04 (LTS) |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] 20.04 (LTS) |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |
| ![Supported][1] 18.04 (LTS) |  ![Supported][1]  | ![Supported][1] | ![Supported][1] |

Only the LTS releases of Ubuntu are officially supported. Microsoft does not support
[interim releases][interim] or their equivalent. Interim releases are community supported. For more
information, see [Community supported distributions][community].

PowerShell is supported on Ubuntu for the following processor architectures.

|         Ubuntu         | 7.2 (LTS-current) |    7.3     | 7.4 (preview) |
| ---------------------- | :---------------: | :--------: | :-----------: |
| All supported versions |    x64, Arm32     | x64, Arm32 |  x64, Arm32   |

[eol-ubuntu]: https://wiki.ubuntu.com/Releases
[interim]: https://ubuntu.com/about/release-cycle
[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
[community]: /powershell/scripting/install/community-support
