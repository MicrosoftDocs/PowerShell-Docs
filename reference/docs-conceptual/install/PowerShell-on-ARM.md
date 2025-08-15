---
description: PowerShell on Arm-based systems
ms.date: 08/28/2024
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
| Windows 11 Client Version 22000+ | Arm64         | [Windows][05]                          |
| Windows 10 Client Version 1607+  | Arm64         | [Windows][05]                          |
| macOS                            | Arm64         | [macOS][04]                            |
| Raspberry Pi OS (Debian 12)      | Arm32         | [Raspberry Pi OS][08] and [Debian][06] |
| Ubuntu 22.04, 20.04              | Arm32         | [Ubuntu][07]                           |

Support is based on the [.NET 8.0 Supported OS Lifecycle Policy][03].

## Installing PowerShell on Arm-based systems

For installation instructions, see the following articles:

Windows

- [Windows 10 on Arm][13]
- [Windows 10 IoT Enterprise][12]
- [Windows 10 IoT Core][11]

Linux - install from the binary archives

- [Alternate ways to install PowerShell on Linux][09]

macOS

- [Installing PowerShell on macOS][10]

Raspberry Pi

- [Raspberry Pi OS][01]

<!-- link references -->
[01]: community-support.md#raspberry-pi-os
[03]: https://github.com/dotnet/core/blob/main/release-notes/8.0/supported-os.md
[04]: https://support.apple.com/macos
[05]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
[06]: https://wiki.debian.org/DebianReleases
[07]: https://wiki.ubuntu.com/Releases
[08]: https://www.raspberrypi.com/software/operating-systems/
[09]: install-other-linux.md#binary-archives
[10]: installing-powershell-on-macos.md
[11]: installing-powershell-on-windows.md#deploying-on-windows-10-iot-core
[12]: installing-powershell-on-windows.md#deploying-on-windows-10-iot-enterprise
[13]: installing-powershell-on-windows.md#installing-the-zip-package
