---
description: PowerShell on Arm-based systems
ms.date: 02/05/2024
title: PowerShell on Arm-based systems
---

# PowerShell on Arm processors

Support for the Arm processor is based on the support policy of the version of .NET that PowerShell
uses. While .NET supports many more operating systems and versions, PowerShell support is limited to
the versions that have been tested.

It may be possible to use Arm-based versions of PowerShell on other Linux distributions and
versions, but we don't officially support it.

## PowerShell 7.4

Arm versions of PowerShell 7.4 can be installed on the following platforms:

|                OS                | Architectures |               Lifecycle                |
| -------------------------------- | ------------- | -------------------------------------- |
| Windows 11 Client Version 22000+ | Arm64         | [Windows][06]                          |
| Windows 10 Client Version 1607+  | Arm64         | [Windows][06]                          |
| macOS 10.15+                     | Arm64         | [macOS][05]                            |
| Raspberry Pi OS (Debian 10)      | Arm32         | [Raspberry Pi OS][09] and [Debian][07] |
| Ubuntu 22.04, 20.04, 18.04       | Arm32         | [Ubuntu][08]                           |

Support is based on the [.NET 8.0 Supported OS Lifecycle Policy][04].

## PowerShell 7.3

Arm versions of PowerShell 7.3 can be installed on the following platforms:

|                OS                | Architectures |               Lifecycle                |
| -------------------------------- | ------------- | -------------------------------------- |
| Windows 11 Client Version 22000+ | Arm64         | [Windows][06]                          |
| Windows 10 Client Version 1607+  | Arm64         | [Windows][06]                          |
| macOS 10.15+                     | Arm64         | [macOS][05]                            |
| Raspberry Pi OS (Debian 10)      | Arm32         | [Raspberry Pi OS][09] and [Debian][07] |
| Ubuntu 22.04, 20.04, 18.04       | Arm32         | [Ubuntu][08]                           |

Support is based on the [.NET 7.0 Supported OS Lifecycle Policy][03].

## PowerShell 7.2

Arm versions of PowerShell 7.2 can be installed on the following platforms:

|                OS                | Architectures |               Lifecycle                |
| -------------------------------- | ------------- | -------------------------------------- |
| Windows 11 Client Version 22000+ | Arm64         | [Windows][06]                          |
| Windows 10 Client Version 1607+  | Arm64         | [Windows][06]                          |
| macOS 10.14+                     | Arm64         | [macOS][05]                            |
| Raspberry Pi OS (Debian 10)      | Arm32         | [Raspberry Pi OS][09] and [Debian][07] |
| Ubuntu 22.04, 20.04, 18.04       | Arm32         | [Ubuntu][08]                           |

Support is based on the [.NET 6.0 Supported OS Lifecycle Policy][02].

## Installing PowerShell on Arm-based systems

For installation instructions, see the following articles:

Windows

- [Windows 10 on Arm][14]
- [Windows 10 IoT Enterprise][13]
- [Windows 10 IoT Core][12]

Linux - install from the binary archives

- [Alternate ways to install PowerShell on Linux][10]

macOS

- [Installing PowerShell on macOS][11]

Raspbery Pi

- [Raspberry Pi OS][01]

<!-- link references -->
[01]: community-support.md#raspberry-pi-os
[02]: https://github.com/dotnet/core/blob/main/release-notes/6.0/supported-os.md
[03]: https://github.com/dotnet/core/blob/main/release-notes/7.0/supported-os.md
[04]: https://github.com/dotnet/core/blob/main/release-notes/8.0/supported-os.md
[05]: https://support.apple.com/macos
[06]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
[07]: https://wiki.debian.org/DebianReleases
[08]: https://wiki.ubuntu.com/Releases
[09]: https://www.raspberrypi.com/software/operating-systems/
[10]: install-other-linux.md#binary-archives
[11]: installing-powershell-on-macos.md
[12]: installing-powershell-on-windows.md#deploying-on-windows-10-iot-core
[13]: installing-powershell-on-windows.md#deploying-on-windows-10-iot-enterprise
[14]: installing-powershell-on-windows.md#installing-the-zip-package
