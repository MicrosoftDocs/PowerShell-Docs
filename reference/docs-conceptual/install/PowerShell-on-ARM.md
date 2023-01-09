---
description: PowerShell on Arm-based systems
ms.date: 01/09/2023
title: PowerShell on Arm-based systems
---

# PowerShell on Arm processors

Support for the Arm processor is based on the support policy of the version of .NET that PowerShell
uses. While .NET supports many more operating systems and versions, PowerShell support is limited to
the versions that have been tested.

It may be possible to use Arm-based versions of PowerShell on other Linux distributions and
versions, but we don't officially support it.

## PowerShell 7.3

PowerShell 7.3 is based on the [.NET 7.0 Supported OS Lifecycle Policy][02] and supports the
following platforms:

|                OS                | Architectures |               Lifecycle                |
| -------------------------------- | ------------- | -------------------------------------- |
| Windows 11 Client Version 22000+ | Arm64         | [Windows][04]                          |
| Windows 10 Client Version 1607+  | Arm64         | [Windows][04]                          |
| macOS 10.15+                     | Arm64         | [macOS][03]                            |
| Raspberry Pi OS (Debian 10)      | Arm32         | [Raspberry Pi OS][07] and [Debian][05] |
| Ubuntu 22.04, 20.04, 18.04       | Arm32         | [Ubuntu][06]                           |

## PowerShell 7.2

PowerShell 7.2 is based on the [.NET 6.0 Supported OS Lifecycle Policy][01] and supports the
following platforms:

|                OS                | Architectures |               Lifecycle                |
| -------------------------------- | ------------- | -------------------------------------- |
| Windows 11 Client Version 22000+ | Arm64         | [Windows][04]                          |
| Windows 10 Client Version 1607+  | Arm64         | [Windows][04]                          |
| macOS 10.14+                     | Arm64         | [macOS][03]                            |
| Raspberry Pi OS (Debian 10)      | Arm32         | [Raspberry Pi OS][07] and [Debian][05] |
| Ubuntu 22.04, 20.04, 18.04       | Arm32         | [Ubuntu][06]                           |

## Installing PowerShell on Arm-based systems

For installation instructions, see the following articles:

Windows

- [Windows 10 on Arm][13]
- [Windows 10 IoT Enterprise][12]
- [Windows 10 IoT Core][11]

Linux - install from the binary archives

- [Alternate ways to install PowerShell on Linux][08]

macOS

- [Installing PowerShell on macOS][10]

Raspbery Pi

- [Raspberry Pi OS][09]

<!-- link references -->
[01]: https://github.com/dotnet/core/blob/main/release-notes/6.0/supported-os.md
[02]: https://github.com/dotnet/core/blob/main/release-notes/7.0/supported-os.md
[03]: https://support.apple.com/macos
[04]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
[05]: https://wiki.debian.org/DebianReleases
[06]: https://wiki.ubuntu.com/Releases
[07]: https://www.raspberrypi.com/software/operating-systems/
[08]: install-other-linux.md#binary-archives
[09]: install-raspbian.md
[10]: installing-powershell-on-macos.md
[11]: installing-powershell-on-windows.md#deploying-on-windows-10-iot-core
[12]: installing-powershell-on-windows.md#deploying-on-windows-10-iot-enterprise
[13]: installing-powershell-on-windows.md#installing-the-zip-package
