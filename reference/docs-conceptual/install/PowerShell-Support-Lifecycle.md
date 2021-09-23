---
description: Details the policies governing support for PowerShell
ms.date: 09/23/2021
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
critical fixes, innovations, and new features. A current release is supported for three months after
the next release (current or LTS).

> [!IMPORTANT]
> You must have the latest patch update installed to qualify for support. For example, if you're
> running PowerShell 7.0 and 7.0.1 has been released, you must update to 7.0.1 to qualify for
> support.

## Supported platforms

PowerShell runs on multiple operating systems (OS) and processor architectures. In order to be
supported by Microsoft, the must meet the following criteria:

- The version and processor architecture of the OS is supported by .NET Core.
- The version of the OS is supported for at least one year.
- The version of the OS is not an interim release or equivalent.
- The version of the OS is currently supported by the OS publisher.
- The PowerShell team has tested the version of the distribution.

When a platform version reaches end-of-life as defined by the platform owner, PowerShell also ends
support on that platform version. Previously released packages remain available for customers
needing access but formal support and updates of any kind are no longer be provided.

|                     Platform                      |      7.0      |      7.1      |      7.2      |
| ------------------------------------------------- | :-----------: | :-----------: | :-----------: |
| Windows 8.1, and 10                               |   Supported   |   Supported   |   Supported   |
| Windows Server 2012 R2, 2016, 2019, 2022          |   Supported   |   Supported   |   Supported   |
| [Windows Server Semi-Annual Channel][semi-annual] |   Supported   |   Supported   |   Supported   |
| Ubuntu 16.04 LTS, 18.04 LTS                       |   Supported   |   Supported   |   Supported   |
| Ubuntu 20.04 LTS                                  | Not Supported |   Supported   |   Supported   |
| Ubuntu 21.04                                      | Not Supported | Not Supported |   Supported   |
| Debian 9                                          |   Supported   |   Supported   |   Supported   |
| Debian 10                                         |   Supported   |   Supported   |   Supported   |
| CentOS 7                                          |   Supported   |   Supported   |   Supported   |
| CentOS 8                                          |   Supported   |   Supported   |   Supported   |
| Red Hat Enterprise Linux 7                        |   Supported   |   Supported   |   Supported   |
| Red Hat Enterprise Linux 8                        |   Supported   |   Supported   |   Supported   |
| Fedora 31+                                        |   Supported   | Not Supported | Not Supported |
| Alpine 3.10                                       |  See Note 1   | Not Supported | Not Supported |
| Alpine 3.11+                                      |  See Note 1   |  See Note 1   |  See Note 1   |
| macOS 10.13+                                      |   Supported   |   Supported   |   Supported   |
| Arch                                              |   Community   |   Community   |   Community   |
| Raspbian                                          |   Community   |   Community   |   Community   |
| Kali                                              |   Community   |   Community   |   Community   |
| AppImage (works on multiple Linux platforms)      |   Community   |   Community   |   Community   |
| [Snap Package](https://snapcraft.io/powershell)   |  See note 2   |   See note    |   See note    |

> [!NOTE]
> - 1 - CIM, PowerShell Remoting, and DSC are not supported on Alpine.
> - 2 - Snap packages are supported the same as the distribution you're running the package on.

## PowerShell End-of-support dates

Based on these lifecycle policies, the following table lists the dates when various releases are no
longer be supported.

|      Version      |      End-of-support       |
| ----------------- | ------------------------- |
| 7.2 (LTS-preview) | November 2024 (projected) |
| 7.1 (current)     | May 31, 2022  (projected) |
| 7.0 (LTS)         | December 3, 2022          |
| 6.2               | September 4, 2020         |
| 6.1               | September 28, 2019        |
| 6.0               | February 13, 2019         |

Support for PowerShell on a specific platforms is based on the support policy of the version of .NET
used.

- PowerShell 7.2 (LTS-preview) is based on the [.NET 6.0 Supported OS Lifecycle Policy][net60os]
- PowerShell 7.1 (current) is based on the [.NET 5.0 Supported OS Lifecycle Policy][net50os]
- PowerShell 7.0 (LTS) is based on the [.NET Core 3.1 Supported OS Lifecycle Policy][net31os]

## Unsupported platforms

When a platform version reaches end-of-life as defined by the platform owner, PowerShell also ceases
to support that platform version. Previously released packages remain available for customers
needing access but formal support and updates are no longer provided.

So, the distribution owners ended support for the following versions and aren't supported.

|    Platform    | Version |                                                         End of Life                                                          |
| -------------- | :-----: | ---------------------------------------------------------------------------------------------------------------------------- |
| Debian         |    8    | [June 2018](https://lists.debian.org/debian-security-announce/2018/msg00132.html)                                            |
| Fedora         |   24    | [August 2017](https://fedoramagazine.org/fedora-24-eol/)                                                                     |
| Fedora         |   25    | [December 2017](https://fedoramagazine.org/fedora-25-end-life/)                                                              |
| Fedora         |   26    | [May 2018](https://fedoramagazine.org/fedora-26-end-life/)                                                                   |
| Fedora         |   27    | [November 2018](https://fedoramagazine.org/fedora-27-end-of-life/)                                                           |
| Fedora         |   28    | [May 2019](https://fedoramagazine.org/fedora-28-end-of-life/)                                                                |
| openSUSE       |  42.1   | [May 2017](https://lists.opensuse.org/opensuse-security-announce/2017-05/msg00053.html)                                      |
| openSUSE       |  42.2   | [January 2018](https://lists.opensuse.org/opensuse-security-announce/2017-11/msg00066.html)                                  |
| openSUSE       |  42.3   | [July 2019](https://lists.opensuse.org/opensuse-security-announce/2019-07/msg00000.html)                                     |
| Ubuntu         |  14.04  | [April 2019](https://wiki.ubuntu.com/Releases)                                                                               |
| Ubuntu         |  16.10  | [July 2017](https://lists.ubuntu.com/archives/ubuntu-announce/2017-July/000223.html)                                         |
| Ubuntu         |  17.04  | [January 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-January.txt)                                           |
| Ubuntu         |  17.10  | [July 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-July/000232.html)                                         |
| Ubuntu         |  18.10  | [July 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2019-July/000246.html)                                         |
| Ubuntu         |  19.10  | [July 2020](https://lists.ubuntu.com/archives/ubuntu-announce/2020-July/000258.html)                                         |
| Ubuntu         |  20.10  | [July 2021](https://lists.ubuntu.com/archives/ubuntu-announce/2021-July/000270.html)                                         |
| Windows        |    7    | [January 2020](https://support.microsoft.com/help/4057281/windows-7-support-ended-on-january-14-2020)                        |
| Windows Server | 2008 R2 | [January 2020](https://support.microsoft.com/help/4456235/end-of-support-for-windows-server-2008-and-windows-server-2008-r2) |

## Windows PowerShell Compatibility

The support lifecycle for PowerShell doesn't cover modules that ship outside of the PowerShell
release package. For example, using the `ActiveDirectory` module that ships as part of Windows
Server is supported under the [Windows Support Lifecycle][lifecycle].

## Experimental features

[Experimental features][exp] are limited to community support.

## Notes on licensing

PowerShell Core is released under the [MIT license][mit]. Under this license, and without a paid
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


## Release history

The following table contains a timeline of the major releases of PowerShell. This table is provided
for historical reference. It is not intended for use to determine the support lifecycle.

|           Version            | Release Date |                                       Note                                       |
| ---------------------------- | :----------: | -------------------------------------------------------------------------------- |
| PowerShell 7.2 (LTS-preview) |     TBD      | Built on .NET 6.0 (LTS-preview).                                                 |
| PowerShell 7.1 (current)     |   Nov-2020   | Built on .NET 5.0 (current).                                                     |
| PowerShell 7.0 (LTS)         |   Mar-2020   | Built on .NET Core 3.1 (LTS).                                                    |
| PowerShell 6.2               |   Mar-2019   |                                                                                  |
| PowerShell 6.1               |   Sep-2018   | Built on .NET Core 2.1.                                                          |
| PowerShell 6.0               |   Jan-2018   | First release, built on .NET Core 2.0. Installable on Windows, Linux, and macOS. |
| Windows PowerShell 5.1       |   Aug-2016   | Released in Windows 10 Anniversary Update and Windows Server 2016, WMF 5.1       |
| Windows PowerShell 5.0       |   Feb-2016   | Released in Windows Management Framework (WMF) 5.0                               |
| Windows PowerShell 4.0       |   Oct-2013   | Integrated in Windows 8.1 and with Windows Server 2012 R2, WMF 4.0               |
| Windows PowerShell 3.0       |   Oct-2012   | Integrated in Windows 8 and with Windows Server 2012 WMF 3.0                     |
| Windows PowerShell 2.0       |   Jul-2009   | Integrated in Windows 7 and Windows Server 2008 R2, WMF 2.0                      |
| Windows PowerShell 1.0       |   Nov-2006   | Optional component of Windows Server 2008                                        |

<!-- hyperlink references -->

[assisted]: https://support.microsoft.com/assistedsupportproducts
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
[semi-annual]: /windows-server/get-started-19/servicing-channels-19
