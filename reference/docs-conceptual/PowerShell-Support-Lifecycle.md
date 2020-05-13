---
title: PowerShell Core Support Lifecycle
description: Policies governing support for PowerShell Core
ms.date: 08/06/2018
---

# PowerShell Core Support Lifecycle

PowerShell Core is a distinct set of tools and components that is shipped, installed, and configured
separately from Windows PowerShell. So, PowerShell Core isn't included in the Windows 7/8.1/10 or
Windows Server licensing agreements.

However, PowerShell Core is supported under traditional Microsoft support agreements, including [Premier][],
[Microsoft Enterprise Agreements][enterprise-agreement], and [Microsoft Software Assurance][assurance].
You can also pay for [assisted support][] for PowerShell Core by filing a support request for your
problem.

## Community Support

We also offer [community support][] on GitHub where you can file an issue, bug, or feature request.
Also, you may find help from other members of the community in the Microsoft [PowerShell Tech Community][]
or any of the forums listed in the community section of [PowerShell][pshub] hub page. We offer no
guarantee there that the community will address or resolve your issue in a timely manner. If you
have a problem that requires immediate attention, you should use the traditional, paid support
options.

## Lifecycle of PowerShell Core

PowerShell Core is adopting the [Microsoft Modern Lifecycle Policy][modern]. This support lifecycle
is intended to keep customers up-to-date with the latest versions.

The version 6.x branch of PowerShell Core will be updated approximately once every six months
(examples: 6.0, 6.1, 6.2, etc.)

> [!IMPORTANT]
> You must update within six months after each new minor version release to continue receiving
> support.

For example, if PowerShell Core 6.1 is released on July 1, 2018, you would be expected to update to
PowerShell Core 6.1 by January 1, 2019 to maintain support.

> [!IMPORTANT]
> You must update within 30 days after each new patch version release to continue receiving support.

For example, If you're running PowerShell Core 6.1 and 6.1.3 was released on February 19, 2019, you
would be expected to update to PowerShell Core 6.1.3 by March 21, 2019, which is 30 days after the
release to maintain support. If any fixes are found to be required, the fixes will be released in
our next cumulative update.

The Modern Lifecycle Policy also requires that Microsoft give customers 12 months notice before
discontinuing support for a product (that is, PowerShell Core).

Eventually, we expect PowerShell Core will adopt the long-term servicing approach. In this servicing
approach, we would require only servicing and security updates to stay in support on a specific
branch/version of 6.x.

## Supported platforms

To confirm if your platform and version of PowerShell Core are officially supported, see the
following table.

Our community has also contributed packages for some platforms, but they aren't officially
supported. These packages are marked as `Community` in the table.

Platforms listed as `Experimental` aren't officially supported, but are available for
experimentation and feedback.

| Platform                                          |      6.2      |    7.0    |
| ------------------------------------------------- | :-----------: | :-------: |
| Windows 8.1, and 10                               |   Supported   | Supported |
| Windows Server 2012 R2, 2016                      |   Supported   | Supported |
| [Windows Server Semi-Annual Channel][semi-annual] |   Supported   | Supported |
| Ubuntu 16.04 and 18.04                            |   Supported   | Supported |
| Ubuntu 19.10 (via Snap Package)                   |   Community   | Community |
| Ubuntu 20.04 (via Snap Package)                   |   Community   | Community |
| Debian 9                                          |   Supported   | Supported |
| Debian 10                                         | Not Supported | Supported |
| CentOS 7                                          |   Supported   | Supported |
| CentOS 8                                          | Not Supported | Supported |
| Red Hat Enterprise Linux 7                        |   Supported   | Supported |
| Red Hat Enterprise Linux 8                        | Not Supported | Supported |
| Fedora 30                                         | Not Supported | Supported |
| Alpine 3.8                                        |   See Note    | See Note  |
| Alpine 3.9 and 3.10                               | Not Supported | See Note  |
| macOS 10.12+                                      |   Supported   | Supported |
| Arch                                              |   Community   | Community |
| Raspbian                                          |   Community   | Community |
| Kali                                              |   Community   | Community |
| AppImage (works on multiple Linux platforms)      |   Community   | Community |
| [Snap Package](https://snapcraft.io/powershell)   |   See note    | See note  |

> [!NOTE]
> Snap packages are supported the same as the distribution you're running the package on.

> [!NOTE]
> CIM, PowerShell Remoting, and DSC are not supported on Alpine.

## PowerShell releases end-of-life

Based on [Lifecycle of PowerShell Core](#lifecycle-of-powershell-core), the following table lists
the dates when various releases will no longer be supported.

| Version | End-of-life                   |
|---------|-------------------------------|
| 6.0     | February 13, 2019             |
| 6.1     | September 28, 2019            |
| 6.2     | 6 months after 7 releases     |

## Unsupported platforms

When a platform version reaches end-of-life as defined by the platform owner, PowerShell Core will
also cease to support that platform version. Previously released packages will remain available for
customers needing access but formal support and updates of any kind will no longer be provided.

So, the distribution owners ended support for the following versions and aren't supported.

| Platform       | Version | End of Life                                                                                                                        |
| -------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Debian         | 8       | [June 2018](https://lists.debian.org/debian-security-announce/2018/msg00132.html)                                                  |
| Fedora         | 24      | [August 2017](https://fedoramagazine.org/fedora-24-eol/)                                                                           |
| Fedora         | 25      | [December 2017](https://fedoramagazine.org/fedora-25-end-life/)                                                                    |
| Fedora         | 26      | [May 2018](https://fedoramagazine.org/fedora-26-end-life/)                                                                         |
| Fedora         | 27      | [November 2018](https://fedoramagazine.org/fedora-27-end-of-life/)                                                                 |
| Fedora         | 28      | [May 2019](https://fedoramagazine.org/fedora-28-end-of-life/)                                                                      |
| openSUSE       | 42.1    | [May 2017](https://lists.opensuse.org/opensuse-security-announce/2017-05/msg00053.html)                                            |
| openSUSE       | 42.2    | [January 2018](https://lists.opensuse.org/opensuse-security-announce/2017-11/msg00066.html)                                        |
| openSUSE       | 42.3    | [July 2019](https://lists.opensuse.org/opensuse-security-announce/2019-07/msg00000.html)                                           |
| Ubuntu         | 14.04   | [April 2019](https://wiki.ubuntu.com/Releases)                                                                                     |
| Ubuntu         | 16.10   | [July 2017](https://lists.ubuntu.com/archives/ubuntu-announce/2017-July/000223.html)                                               |
| Ubuntu         | 17.04   | [January 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-January.txt)                                                 |
| Ubuntu         | 17.10   | [July 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-July/000232.html)                                               |
| Windows        | 7       | [January 2020](https://support.microsoft.com/en-us/help/4057281/windows-7-support-ended-on-january-14-2020)                        |
| Windows Server | 2008 R2 | [January 2020](https://support.microsoft.com/en-us/help/4456235/end-of-support-for-windows-server-2008-and-windows-server-2008-r2) |

## Notes on licensing

PowerShell Core is released under the [MIT license][]. Under this license, and without a paid
support agreement, users are limited to [community support][]. With community support, Microsoft
makes no guarantees of responsiveness or fixes.

## Windows PowerShell Module

Support for PowerShell Core doesn't include product modules, unless those modules explicitly support
PowerShell Core. For example, using the `ActiveDirectory` module that ships as part of Windows
Server is an unsupported scenario.

However, modules that don't explicitly support PowerShell Core may be compatible in some cases. By
installing the [WindowsPSModulePath][] module, you can add the Windows PowerShell `PSModulePath`
to your PowerShell Core `PSModulePath`.

First, install the **WindowsPSModulePath** module from the PowerShell Gallery:

```powershell
# Add `-Scope CurrentUser` if you're installing as non-admin
Install-Module WindowsPSModulePath -Force
```

After installing this module, run the `Add-WindowsPSModulePath` cmdlet to add the Windows PowerShell
`PSModulePath` to PowerShell Core:

```powershell
# Add this line to your profile if you always want Windows PowerShell PSModulePath
Add-WindowsPSModulePath
```

## Experimental features

[Experimental features][] are limited to [community support](#community-support).

## Security Servicing Criteria

PowerShell follows the [Microsoft Security Servicing Criteria for Windows][].
The table below outlines the features that meet the servicing criteria and those that do not.

| Feature                          | Type             | Intent to Service? |
|----------------------------------|------------------|--------------------|
| Execution Policy                 | Defense in Depth | No                 |
| System Lockdown - with AppLocker | Defense in Depth | No                 |
| System Lockdown - with WDAC      | Security Feature | Yes                |

## Release history

The following table contains a timeline of the major releases of PowerShell. This table is provided
for historical reference. It is not intended for use to determine the support lifecycle.

|       Version        | Release Date |                                                                     Note                                                                      |
| -------------------- | :----------: | --------------------------------------------------------------------------------------------------------------------------------------------- |
| PowerShell 7.0 (LTS) |   Mar-2020   | Built on .NET Core 3.1 (LTS)                                                                                                                  |
| PowerShell 6.0       |   Jan-2018   | First release, built on .NET Core 2.1. Installable on Windows, Linux, and macOS.                                                              |
| PowerShell 5.1       |   Aug-2016   | Released in Windows 10 Anniversary Update and Windows Server 2016                                                                             |
| PowerShell 5.0       |   Feb-2016   | Released in Windows Management Framework (WMF) 5.0                                                                                            |
| PowerShell 4.0       |   Oct-2013   | Integrated in Windows 8.1 and with Windows Server 2012 R2. Installable on Windows 7 SP1, Windows Server 2008 R2 SP1, and Windows Server 2012. |
| PowerShell 3.0       |   Oct-2012   | Integrated in Windows 8 and with Windows Server 2012. Installable on Windows 7 SP1, Windows Server 2008 SP1, and Windows Server 2008 R2 SP1.  |
| PowerShell 2.0       |   Jul-2009   | Integrated in Windows 7 and Windows Server 2008 R2. Installable on Windows XP SP3, Windows Server 2003 SP2, and Windows Vista SP1.            |
| PowerShell 1.0       |   Nov-2006   | Installable on Windows XP SP2, Windows Server 2003 SP1 and Windows Vista. Optional component of Windows Server 2008.                          |

<!-- hyperlink references -->
[Premier]: https://www.microsoft.com/en-us/microsoftservices/support.aspx
[enterprise-agreement]: https://www.microsoft.com/en-us/licensing/licensing-programs/enterprise.aspx
[assurance]: https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx
[community support]: https://github.com/powershell/powershell/issues
[pshub]: https://docs.microsoft.com/powershell
[PowerShell Tech Community]: https://techcommunity.microsoft.com/t5/PowerShell/ct-p/WindowsPowerShell
[assisted support]: https://support.microsoft.com/assistedsupportproducts
[modern]: https://support.microsoft.com/help/30881/modern-lifecycle-policy
[lifecycle-chart]: ./images/modern-lifecycle.png
[semi-annual]: https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview
[MIT license]: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
[WindowsPSModulePath]: https://www.powershellgallery.com/packages/WindowsPSModulePath/
[Experimental features]: /powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-6#experimentalfeatures
[Microsoft Security Servicing Criteria for Windows]: https://www.microsoft.com/en-us/msrc/windows-security-servicing-criteria
