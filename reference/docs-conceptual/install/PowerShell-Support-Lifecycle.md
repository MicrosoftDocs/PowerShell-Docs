---
description: Details the policies governing support for PowerShell
ms.date: 05/31/2022
title: PowerShell Support Lifecycle
---
# PowerShell Support Lifecycle

> [!NOTE]
> This document is about support for PowerShell. Windows PowerShell (1.0 - 5.1) is a component of
> the Windows operating system. Components receive the same support as their parent product or
> platform. For more information, see
> [Product and Services Lifecycle Information](/lifecycle/products/).

PowerShell is supported under the [Microsoft Modern Lifecycle Policy][modern], but support dates are
linked to [.NET Core's support lifecycle][Long-Term]. In this servicing approach, customers can
choose Long Term Support (LTS) releases or current releases.

An **LTS** release of PowerShell is built on an LTS release of .NET. Updates to an LTS release only
contain critical security updates and servicing fixes that are designed to minimize impact to
existing workloads. LTS releases of PowerShell are supported until the end-of-support for .NET.

A **current** release is a release that occurs between LTS releases. Current releases can contain
critical fixes, innovations, and new features. A current release is supported for six months after
the next release (current or LTS).

> [!IMPORTANT]
> You must have the latest patch update installed to qualify for support. For example, if you're
> running PowerShell 7.0 and 7.0.1 has been released, you must update to 7.0.1 to qualify for
> support.

## Supported platforms

PowerShell runs on multiple operating systems (OS) and processor architectures. To be supported by
Microsoft, the OS must meet the following criteria:

- The version and processor architecture of the OS is supported by .NET Core.
- The version of the OS is supported for at least one year.
- The version of the OS is not an interim release or equivalent.
- The version of the OS is currently supported by the OS publisher.
- The PowerShell team has tested the version of the distribution.

When a platform version reaches end-of-life as defined by the platform owner, PowerShell also ends
support on that platform version. Previously released packages remain available for customers
needing access but formal support and updates of any kind are no longer be provided.

### Windows

[!INCLUDE [Windows support](../../includes/windows-support.md)]

### macOS

[!INCLUDE [macOS support](../../includes/macos-support.md)]

### Alpine Linux

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

### Debian Linux

[!INCLUDE [Debian support](../../includes/debian-support.md)]

### Red Hat Enterprise Linux (RHEL)

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

### Ubuntu Linux

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

### Raspberry Pi OS

[Raspberry Pi OS][raspbian] (formerly Raspbian) is a free operating system based on Debian.

> [!IMPORTANT]
> .NET is not supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi
> devices prior to Raspberry Pi 2.

## Windows PowerShell Compatibility

The support lifecycle for PowerShell doesn't cover modules that ship outside of the PowerShell
release package. For example, using the `ActiveDirectory` module that ships as part of Windows
Server is supported under the [Windows Support Lifecycle][lifecycle].

## Experimental features

[Experimental features][exp] are limited to community support.

## Notes on licensing

PowerShell is released under the [MIT license][mit]. Under this license, and without a paid
support agreement, users are limited to [community support][community]. With community support,
Microsoft makes no guarantees of responsiveness or fixes.

## Getting support

Support for PowerShell is delivered via traditional Microsoft support agreements, including
[paid support][paid], [Microsoft Enterprise Agreements][enterprise-agreement], and
[Microsoft Software Assurance][assurance]. You can also pay for [assisted support][assisted] for
PowerShell by filing a support request for your problem.

There are also [community support][community] options. You can file an issue, bug, or feature
request on GitHub. Also, you may find help from other members of the community in the Microsoft
[PowerShell Tech Community][pscommunity] or any of the forums listed in the community section of
[PowerShell][pshub] hub page. We offer no guarantee there that the community will address or resolve
your issue in a timely manner. If you have a problem that requires immediate attention, you should
use the traditional, paid support options.

> [!IMPORTANT]
> You must have the latest patch update installed to qualify for support. For example, if you're
> running PowerShell 7.0 and 7.0.1 has been released, you must update to 7.0.1 to qualify for
> support.

## PowerShell End-of-support dates

Based on these lifecycle policies, the following table lists the dates when various releases are no
longer be supported.

|      Version      |   End-of-support   |
| ----------------- | ------------------ |
| 7.2 (LTS-current) | November 8, 2024   |
| 7.1               | May 8, 2022        |
| 7.0 (LTS)         | December 3, 2022   |
| 6.2               | September 4, 2020  |
| 6.1               | September 28, 2019 |
| 6.0               | February 13, 2019  |

Support for PowerShell on a specific platforms is based on the support policy of the version of .NET
used.

- PowerShell 7.2 (LTS-current) is based on the [.NET 6.0 Supported OS Lifecycle Policy][net60os]
- PowerShell 7.1 is based on the [.NET 5.0 Supported OS Lifecycle Policy][net50os]
- PowerShell 7.0 (LTS) is based on the [.NET Core 3.1 Supported OS Lifecycle Policy][net31os]

## Release history

The following table contains a timeline of the major releases of PowerShell. This table is provided
for historical reference. It is not intended for use to determine the support lifecycle.

|           Version            | Release Date |                                      Note                                       |
| ---------------------------- | :----------: | ------------------------------------------------------------------------------- |
| PowerShell 7.3 (preview)     |   Jan-2022   | Built on .NET 7.0 (preview)                                                     |
| PowerShell 7.2 (LTS-current) |   Nov-2021   | Built on .NET 6.0 (LTS-current)                                                 |
| PowerShell 7.1               |   Nov-2020   | Built on .NET 5.0                                                               |
| PowerShell 7.0 (LTS)         |   Mar-2020   | Built on .NET Core 3.1 (LTS)                                                    |
| PowerShell 6.2               |   Mar-2019   |                                                                                 |
| PowerShell 6.1               |   Sep-2018   | Built on .NET Core 2.1                                                          |
| PowerShell 6.0               |   Jan-2018   | First release, built on .NET Core 2.0. Installable on Windows, Linux, and macOS |
| Windows PowerShell 5.1       |   Aug-2016   | Released in Windows 10 Anniversary Update and Windows Server 2016, WMF 5.1      |
| Windows PowerShell 5.0       |   Feb-2016   | Released in Windows Management Framework (WMF) 5.0                              |
| Windows PowerShell 4.0       |   Oct-2013   | Integrated in Windows 8.1 and with Windows Server 2012 R2, WMF 4.0              |
| Windows PowerShell 3.0       |   Oct-2012   | Integrated in Windows 8 and with Windows Server 2012 WMF 3.0                    |
| Windows PowerShell 2.0       |   Jul-2009   | Integrated in Windows 7 and Windows Server 2008 R2, WMF 2.0                     |
| Windows PowerShell 1.0       |   Nov-2006   | Optional component of Windows Server 2008                                       |

<!-- hyperlink references -->

[assisted]: https://support.microsoft.com/supportforbusiness/productselection
[assurance]: https://www.microsoft.com/licensing/licensing-programs/software-assurance-default
[community]: /powershell/scripting/community/community-support
[enterprise-agreement]: https://www.microsoft.com/licensing/licensing-programs/enterprise
[exp]: /powershell/scripting/learn/experimental-features
[lifecycle]: /lifecycle/faq/windows
[Long-Term]: https://dotnet.microsoft.com/platform/support/policy/dotnet-core
[mit]: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
[modern]: /lifecycle/policies/modern
[net31os]: https://github.com/dotnet/core/blob/master/release-notes/3.1/3.1-supported-os.md
[net50os]: https://github.com/dotnet/core/blob/master/release-notes/5.0/5.0-supported-os.md
[net60os]: https://github.com/dotnet/core/blob/main/release-notes/6.0/supported-os.md
[paid]: https://support.serviceshub.microsoft.com/supportforbusiness
[pscommunity]: https://techcommunity.microsoft.com/t5/PowerShell/ct-p/WindowsPowerShell
[pshub]: /powershell/scripting/community/community-support
[raspbian]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md
[semi-annual]: /windows-server/get-started-19/servicing-channels-19
