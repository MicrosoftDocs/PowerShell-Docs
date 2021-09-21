---
title: PowerShell on Arm-based systems
description:   PowerShell on Arm-based systems
ms.date: 08/09/2021
---

# PowerShell  on Arm processors

PowerShell 7.2 is based on the [.NET 6.0 Supported OS Lifecycle Policy][net60os] and supports the
following platforms:

|                 OS                 | Architectures |          Lifecycle           |
| ---------------------------------- | ------------- | ---------------------------- |
| Windows 10 Client Version 1607+    | Arm64         | [Windows][Windows-lifecycle] |
| macOS 10.14+                       | Arm64         | [macOS][macOS-lifecycle]     |
| Alpine Linux 3.13+                 | Arm32, Arm64  | [Alpine][Alpine-lifecycle]   |
| Debian 10+                         | Arm32, Arm64  | [Debian][Debian-lifecycle]   |
| Red Hat Enterprise Linux (RHEL) 7+ | Arm64         | [Red Hat][RHEL-lifecycle]    |
| Ubuntu 20.10, 20.04, 18.04, 16.04  | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]   |

PowerShell 7.1 is based on the [.NET 5.0 Supported OS Lifecycle Policy][net50os] and supports the
following platforms:

|                OS                 | Architectures |          Lifecycle           |
| --------------------------------- | ------------- | ---------------------------- |
| Windows 10 Client Version 1607+   | Arm64         | [Windows][Windows-lifecycle] |
| Alpine Linux 3.11+                | Arm64         | [Alpine][Alpine-lifecycle]   |
| Debian 9+                         | Arm64, Arm32  | [Debian][Debian-lifecycle]   |
| Ubuntu 21.04, 20.04, 18.04, 16.04 | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]   |

Support of PowerShell on Arm is based on the **.NET Core Supported OS Lifecycle Policies**.

PowerShell 7.0 is based on the [.NET Core 3.1 Supported OS Lifecycle Policy][net31os] and supports
the following platforms:

|                OS                 | Architectures |          Lifecycle           |
| --------------------------------- | ------------- | ---------------------------- |
| Windows Nano Server Version 1803+ | Arm32         | [Windows][Windows-lifecycle] |
| Alpine Linux 3.10+                | Arm64         | [Alpine][Alpine-lifecycle]   |
| Debian 9+                         | Arm32, Arm64  | [Debian][Debian-lifecycle]   |
| Ubuntu 20.10, 20.04, 18.04, 16.04 | Arm32, Arm64  | [Ubuntu][Ubuntu-lifecycle]   |

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
[RHEL-lifecycle]: https://access.redhat.com/support/policy/updates/errata/
[Ubuntu-lifecycle]: https://wiki.ubuntu.com/Releases
[Windows-lifecycle]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
