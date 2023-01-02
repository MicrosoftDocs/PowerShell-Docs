---
description: PowerShell on Arm-based systems
ms.date: 01/02/2023
title: PowerShell on Arm-based systems
---

# PowerShell on Arm processors

PowerShell 7.3 is based on the [.NET 7.0 Supported OS Lifecycle Policy][net70os] and supports the
following platforms:

|                 OS                 | Architectures |           Lifecycle           |
| ---------------------------------- | ------------- | ----------------------------- |
| Windows 10 Client Version 1607+    | Arm64         | [Windows][Windows-lifecycle]  |
| Windows 11 Client Version 22000+   | Arm64         | [Windows][Windows-lifecycle]  |
| macOS 11.5+                        | Arm64         | [macOS][macOS-lifecycle]      |
| Debian 10+                         | Arm32, Arm64  | [Debian][Debian-lifecycle]    |
| RaspberryPi 10+                    | Arm32         | [Raspberry Pi][Rpi-lifecycle] |
| Red Hat Enterprise Linux (RHEL) 7+ | Arm64         | [Red Hat][RHEL-lifecycle]     |
| Ubuntu 18.04+                      | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]    |

PowerShell 7.2 is based on the [.NET 6.0 Supported OS Lifecycle Policy][net60os] and supports the
following platforms:

|                 OS                 | Architectures |           Lifecycle           |
| ---------------------------------- | ------------- | ----------------------------- |
| Windows 10 Client Version 1607+    | Arm64         | [Windows][Windows-lifecycle]  |
| Windows 11 Client Version 22000+   | Arm64         | [Windows][Windows-lifecycle]  |
| macOS 11.5+                        | Arm64         | [macOS][macOS-lifecycle]      |
| Debian 10+                         | Arm32, Arm64  | [Debian][Debian-lifecycle]    |
| RaspberryPi 10+                    | Arm32         | [Raspberry Pi][Rpi-lifecycle] |
| Red Hat Enterprise Linux (RHEL) 7+ | Arm64         | [Red Hat][RHEL-lifecycle]     |
| Ubuntu 18.04+                      | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]    |

For installation instructions, see the following articles:

Windows

- [Windows 10 on Arm](installing-powershell-on-windows.md#installing-the-zip-package)
- [Windows 10 IoT Enterprise](installing-powershell-on-windows.md#deploying-on-windows-10-iot-enterprise)
- [Windows 10 IoT Core](installing-powershell-on-windows.md#deploying-on-windows-10-iot-core)

Linux - install from the binary archives

- [Alternate ways to install PowerShell on Linux](install-other-linux.md#binary-archives)

macOS

- [Installing PowerShell on macOS](installing-powershell-on-macos.md)

Raspbery Pi

- [Raspberry Pi OS](install-raspbian.md)

[Alpine-lifecycle]: https://alpinelinux.org/releases/
[Debian-lifecycle]: https://wiki.debian.org/DebianReleases
[macOS-lifecycle]: https://support.apple.com/macos
[net31os]: https://github.com/dotnet/core/blob/master/release-notes/3.1/3.1-supported-os.md
[net50os]: https://github.com/dotnet/core/blob/master/release-notes/5.0/5.0-supported-os.md
[net60os]: https://github.com/dotnet/core/blob/main/release-notes/6.0/supported-os.md
[net70os]: https://github.com/dotnet/core/blob/main/release-notes/7.0/supported-os.md
[Rpi-lifecycle]: https://www.raspberrypi.com/software/operating-systems/
[RHEL-lifecycle]: https://access.redhat.com/support/policy/updates/errata/
[Ubuntu-lifecycle]: https://wiki.ubuntu.com/Releases
[Windows-lifecycle]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
