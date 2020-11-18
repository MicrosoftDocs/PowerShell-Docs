---
title: Installing PowerShell Core on Arm
description: Installing PowerShell Core on Arm-based systems
ms.date: 11/11/2020
---

# PowerShell Core on Arm

Support of PowerShell on Arm is based on the **.NET Core Supported OS Lifecycle Policies**.

PowerShell 7.1 is based on the [.NET Core 3.1 Supported OS Lifecycle Policy](https://github.com/dotnet/core/blob/master/release-notes/3.1/3.1-supported-os.md) and supports the following platforms:

|         OS          |          Version           | Architectures |          Lifecycle           |
| ------------------- | -------------------------- | ------------- | ---------------------------- |
| Windows Nano Server | Version 1803+              | Arm32         | [Windows][Windows-lifecycle] |
| Alpine Linux        | 3.10+                      | Arm64         | [Alpine][Alpine-lifecycle]   |
| Debian              | 9+                         | Arm32, Arm64  | [Debian][Debian-lifecycle]   |
| Ubuntu              | 20.10, 20.04, 18.04, 16.04 | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]   |

PowerShell 7.0 is based on the [.NET Core 5.0 Supported OS Lifecycle Policy](https://github.com/dotnet/core/blob/master/release-notes/5.0/5.0-supported-os.md) and supports the following platforms:

|        OS         |          Version           | Architectures |          Lifecycle           |
| ----------------- | -------------------------- | ------------- | ---------------------------- |
| Windows 10 Client | Version 1607+              | Arm64         | [Windows][Windows-lifecycle] |
| Alpine Linux      | 3.11+                      | Arm64         | [Alpine][Alpine-lifecycle]   |
| Debian            | 9+                         | Arm32, Arm64  | [Debian][Debian-lifecycle]   |
| Ubuntu            | 20.10, 20.04, 18.04, 16.04 | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]   |

[Windows-lifecycle]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
[Alpine-lifecycle]: https://wiki.alpinelinux.org/wiki/Alpine_Linux:Releases
[Debian-lifecycle]: https://wiki.debian.org/DebianReleases
[Ubuntu-lifecycle]: https://wiki.ubuntu.com/Releases

For installation instructions, see the following articles:

- [Windows 10 on Arm](installing-powershell-core-on-windows.md#installing-the-zip-package)
- [Windows 10 IoT Enterprise](installing-powershell-core-on-windows.md#deploying-on-windows-10-iot-enterprise)
- [Windows 10 IoT Core](installing-powershell-core-on-windows.md#deploying-on-windows-10-iot-core)
- [Raspbian](installing-powershell-core-on-linux.md#raspbian)
