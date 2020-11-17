---
title: PowerShell Core Support Lifecycle
description: Details the policies governing support for PowerShell
ms.date: 11/11/2020
---
# PowerShell Support Lifecycle

PowerShell is a distinct set of tools and components that is shipped, installed, and configured
separately from Windows PowerShell. PowerShell isn't included in the Windows
licensing agreements.

PowerShell is supported under traditional Microsoft support agreements, including [paid support][],
[Microsoft Enterprise Agreements][enterprise-agreement], and
[Microsoft Software Assurance][assurance]. You can also pay for [assisted support][] for PowerShell
by filing a support request for your problem.

## Community Support

We also offer [community support][] on GitHub where you can file an issue, bug, or feature request.
Also, you may find help from other members of the community in the Microsoft
[PowerShell Tech Community][] or any of the forums listed in the community section of
[PowerShell][pshub] hub page. We offer no guarantee there that the community will address or resolve
your issue in a timely manner. If you have a problem that requires immediate attention, you should
use the traditional, paid support options.

## Lifecycle of PowerShell 7

With the release of PowerShell 7, PowerShell continues to be supported under the
[Microsoft Modern Lifecycle Policy][modern], but support dates are linked to
[.NET Core's support lifecycle][Long-Term]. In this servicing approach, customers can choose Long
Term Support (LTS) releases or Current releases. PowerShell 7.0 is an LTS release. Support ends with
the support of .NET Core 3.1. The next LTS release follows the next .NET Core LTS release. See the
[PowerShell releases end of life table](#powershell-releases-end-of-life) for current ending support
dates. LTS release updates only contain critical security and servicing updates and fixes that are
designed to avoid or minimize impact to existing workloads.

A Current release is a release that occurs between LTS releases. Current releases can contain
critical fixes, innovations, and new features. A Current release is supported for three months after
the next Current or LTS release.

> [!IMPORTANT]
> You must have the latest patch update installed to qualify for support. For example, if you're
> running PowerShell 7.0 and 7.0.1 has been released, you must update to 7.0.1 to qualify for
> support.

## Supported platforms

To confirm if your platform and version of PowerShell Core are officially supported, see the
following table.

Our community has also contributed packages for some platforms, but they aren't officially
supported. These packages are marked as `Community` in the table.

Platforms listed as `Experimental` aren't officially supported, but are available for
experimentation and feedback.

<!-- TODO: update OS list -->

|                     Platform                      |      7.0      |      7.1      |
| ------------------------------------------------- | :-----------: | :-----------: |
| Windows 8.1, and 10                               |   Supported   |   Supported   |
| Windows Server 2012 R2, 2016, 2019                |   Supported   |   Supported   |
| [Windows Server Semi-Annual Channel][semi-annual] |   Supported   |   Supported   |
| Ubuntu 16.04, 18.04                               |   Supported   |   Supported   |
| Ubuntu 20.04                                      | Not Supported |   Supported   |
| Ubuntu 19.10, 20.10 (via Snap Package)            |   Community   |   Supported   |
| Debian 9                                          |   Supported   |   Supported   |
| Debian 10                                         |   Supported   |   Supported   |
| CentOS 7                                          |   Supported   |   Supported   |
| CentOS 8                                          |   Supported   |   Supported   |
| Red Hat Enterprise Linux 7                        |   Supported   |   Supported   |
| Red Hat Enterprise Linux 8                        |   Supported   |   Supported   |
| Fedora 31+                                        |   Supported   | Not Supported |
| Alpine 3.10                                       |   See Note 1  | Not Supported |
| Alpine 3.11+                                      |   See Note 1  |   See Note 1  |
| macOS 10.13+                                      |   Supported   |   Supported   |
| Arch                                              |   Community   |   Community   |
| Raspbian                                          |   Community   |   Community   |
| Kali                                              |   Community   |   Community   |
| AppImage (works on multiple Linux platforms)      |   Community   |   Community   |
| [Snap Package](https://snapcraft.io/powershell)   |   See note 2  |   See note    |

> [!NOTE]
> - 1 - CIM, PowerShell Remoting, and DSC are not supported on Alpine.
> - 2 - Snap packages are supported the same as the distribution you're running the package on.

## PowerShell releases end of life

Based on the [Lifecycle of PowerShell](#lifecycle-of-powershell-7), the following table lists
the dates when various releases will no longer be supported.

| Version |          End-of-life           |
| :-----: | ------------------------------ |
|   7.1   | mid-February 2022  (projected) |
|   7.0   | December 3, 2022               |
|   6.2   | September 4, 2020              |
|   6.1   | September 28, 2019             |
|   6.0   | February 13, 2019              |

> [!NOTE]
> This document is about support for PowerShell Core. Windows PowerShell (1.0 - 5.1) is a component
> of the Windows OS. Components receive the same support as their parent product or platform. For
> more information, see [Product and Services Lifecycle Information](/lifecycle/products/).

## Unsupported platforms

When a platform version reaches end-of-life as defined by the platform owner, PowerShell Core will
also cease to support that platform version. Previously released packages will remain available for
customers needing access but formal support and updates of any kind will no longer be provided.

So, the distribution owners ended support for the following versions and aren't supported.

<!-- TODO: Update this table Jason-->

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
| Windows        |    7    | [January 2020](https://support.microsoft.com/help/4057281/windows-7-support-ended-on-january-14-2020)                        |
| Windows Server | 2008 R2 | [January 2020](https://support.microsoft.com/help/4456235/end-of-support-for-windows-server-2008-and-windows-server-2008-r2) |

## Notes on licensing

PowerShell Core is released under the [MIT license][]. Under this license, and without a paid
support agreement, users are limited to [community support][]. With community support, Microsoft
makes no guarantees of responsiveness or fixes.

## Windows PowerShell Compatibility

The support lifecycle for PowerShell doesn't cover modules that ship outside of the PowerShell 7
release package. For example, using the `ActiveDirectory` module that ships as part of Windows
Server is supported under the [Windows Support Lifecycle][].

PowerShell 7 improves compatibility with existing PowerShell modules written for Windows PowerShell.
For more information, see the [about_Windows_Compatibility][] article and the
[module compatibility list][].

> [!NOTE]
> The [**WindowsPSModulePath**](https://www.powershellgallery.com/packages/WindowsPSModulePath)
> module is no longer necessary in PowerShell 7 and is not supported.

## Experimental features

[Experimental features][] are limited to [community support](#community-support).

## Security Servicing Criteria

PowerShell follows the [Microsoft Security Servicing Criteria for Windows][].
The table below outlines the features that meet the servicing criteria and those that do not.

| Feature                          | Type             |
|----------------------------------|------------------|
| Execution Policy                 | Defense in Depth |
| System Lockdown - with AppLocker | Defense in Depth |
| System Lockdown - with WDAC      | Security Feature |

## Release history

The following table contains a timeline of the major releases of PowerShell. This table is provided
for historical reference. It is not intended for use to determine the support lifecycle.

|         Version          | Release Date |                                                                     Note                                                                      |
| ------------------------ | :----------: | --------------------------------------------------------------------------------------------------------------------------------------------- |
| PowerShell 7.1 (current) |   Nov-2020   | Built on .NET Core 5.0 (current)                                                                                                              |
| PowerShell 7.0 (LTS)     |   Mar-2020   | Built on .NET Core 3.1 (LTS)                                                                                                                  |
| PowerShell 6.0           |   Jan-2018   | First release, built on .NET Core 2.1. Installable on Windows, Linux, and macOS.                                                              |
| PowerShell 5.1           |   Aug-2016   | Released in Windows 10 Anniversary Update and Windows Server 2016                                                                             |
| PowerShell 5.0           |   Feb-2016   | Released in Windows Management Framework (WMF) 5.0                                                                                            |
| PowerShell 4.0           |   Oct-2013   | Integrated in Windows 8.1 and with Windows Server 2012 R2. Installable on Windows 7 SP1, Windows Server 2008 R2 SP1, and Windows Server 2012. |
| PowerShell 3.0           |   Oct-2012   | Integrated in Windows 8 and with Windows Server 2012. Installable on Windows 7 SP1, Windows Server 2008 SP1, and Windows Server 2008 R2 SP1.  |
| PowerShell 2.0           |   Jul-2009   | Integrated in Windows 7 and Windows Server 2008 R2. Installable on Windows XP SP3, Windows Server 2003 SP2, and Windows Vista SP1.            |
| PowerShell 1.0           |   Nov-2006   | Installable on Windows XP SP2, Windows Server 2003 SP1 and Windows Vista. Optional component of Windows Server 2008.                          |

<!-- hyperlink references -->
[paid support]: https://support.microsoft.com/hub/4343728/support-for-business
[enterprise-agreement]: https://www.microsoft.com/licensing/licensing-programs/enterprise.aspx
[assurance]: https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx
[community support]: /powershell/scripting/community/community-support
[pshub]: /powershell
[PowerShell Tech Community]: https://techcommunity.microsoft.com/t5/PowerShell/ct-p/WindowsPowerShell
[assisted support]: https://support.microsoft.com/assistedsupportproducts
[modern]: https://support.microsoft.com/help/30881/modern-lifecycle-policy
[Long-Term]: https://dotnet.microsoft.com/platform/support/policy/dotnet-core
[lifecycle-chart]: ./images/modern-lifecycle.png
[semi-annual]: /windows-server/get-started/semi-annual-channel-overview
[MIT license]: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
[about_Windows_Compatibility]: /powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility
[Windows Support Lifecycle]: https://support.microsoft.com/help/13853/windows-lifecycle-fact-sheet
[module compatibility list]: /powershell/scripting/whats-new/module-compatibility
[WindowsPSModulePath]: https://www.powershellgallery.com/packages/WindowsPSModulePath/
[Experimental features]: /powershell/module/microsoft.powershell.core/about/about_powershell_config#experimentalfeatures
[Microsoft Security Servicing Criteria for Windows]: https://www.microsoft.com/msrc/windows-security-servicing-criteria
