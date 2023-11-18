---
author: sdwheeler
ms.author: sewhee
ms.date: 11/14/2023
ms.prod: powershell
ms.topic: include
---
<!-- markdownlint-disable first-line-h1 -->
The following table contains a list of PowerShell releases and the status of support for versions of
macOS. These versions remain supported until either the version of
[PowerShell reaches end-of-support][lifecycle] or the version of macOS reaches end-of-support.

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

|             macOS             | 7.2 (LTS-previous) |       7.3       | 7.4 (LTS-current) |
| ----------------------------- | :----------------: | :-------------: | :---------------: |
| ![Supported][1] 14 (Sonoma)   |   ![In Test][2]    |  ![In Test][2]  |   ![In Test][2]   |
| ![Supported][1] 13 (Ventura)  |   ![In Test][2]    |  ![In Test][2]  |   ![In Test][2]   |
| ![Supported][1] 12 (Monterey) |   ![In Test][2]    |  ![In Test][2]  |   ![In Test][2]   |
| ![Supported][1] 11 (Big Sur)  |  ![Supported][1]   | ![Supported][1] |  ![Supported][1]  |

Support of macOS is defined by Apple. For more information, see the following:

- [macOS release notes](https://developer.apple.com/documentation/macos-release-notes)
- [Apple Security Updates](https://support.apple.com/HT201222)

PowerShell is supported on macOS for the following processor architectures:

|       macOS        | 7.2 (LTS-current) |    7.3     | 7.4 (LTS-current) |
| ------------------ | :---------------: | :--------: | :-----------: |
| macOS Big Sur 11.5 |    x64, Arm64     | x64, Arm64 |  x64, Arm64   |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
