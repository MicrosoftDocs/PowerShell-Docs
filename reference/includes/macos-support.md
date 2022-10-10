---
author: sdwheeler
ms.author: sewhee
ms.date: 07/25/2022
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

[1]: ../media/shared/check-mark-button_2705.svg
[2]: ../media/shared/construction-sign_1f6a7.svg
[3]: ../media/shared/cross-mark_274c.svg
[4]: ../media/shared/large-yellow-circle_1f7e1.svg

|                 macOS                  |      7.0 (LTS)       |         7.1          |  7.2 (LTS-current)   |    7.3 (preview)     |
| -------------------------------------- | :------------------: | :------------------: | :------------------: | :------------------: |
| ![Supported][1] Big Sur 11.5           |   ![Supported][1]    | ![Out of Support][4] |   ![Supported][1]    |   ![Supported][1]    |
| ![Out of Support][4] Catalina 10.15    | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] |
| ![Out of Support][4] Mojave 10.14      | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] | ![Out of Support][4] |
| ![Out of Support][4] High Sierra 10.13 | ![Out of Support][4] | ![Out of Support][4] | ![Not Supported][3]  | ![Not Supported][3]  |

macOS Monterey 12.0 has not been tested.

Support of macOS is defined by Apple. For more information, see:

- [macOS release notes](https://developer.apple.com/documentation/macos-release-notes)
- [Apple Security Updates](https://support.apple.com/HT201222)

PowerShell is supported on macOS for the following processor architectures:

|          macOS           | 7.0 (LTS) | 7.2 (LTS-current) | 7.3 (preview) |
| ------------------------ | :-------: | :---------------: | :-----------: |
| macOS Big Sur 11.5       |    x64    |    x64, Arm64     |  x64, Arm64   |
| macOS High Sierra 10.13+ |    x64    |        x64        |      x64      |

[lifecycle]: /powershell/scripting/install/powershell-support-lifecycle
