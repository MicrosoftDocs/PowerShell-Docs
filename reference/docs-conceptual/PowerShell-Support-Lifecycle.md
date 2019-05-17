---
title: PowerShell Core Support Lifecycle
description: Policies governing support for PowerShell Core
ms.date: 08/06/2018
---

# PowerShell Core Support Lifecycle

PowerShell Core is a distinct set of tools and components that is shipped,
installed, and configured separately from Windows PowerShell.
So, PowerShell Core is not included in the Windows 7/8.1/10 or Windows Server licensing agreements.

However, PowerShell Core is supported under traditional Microsoft support agreements,
including [Premier][], [Microsoft Enterprise Agreements][enterprise-agreement],
and [Microsoft Software Assurance][assurance].
You can also pay for [assisted support][] for PowerShell Core by filing a support request for your problem.

## Community Support

We also offer [community support][] on GitHub where you can file an issue, bug, or feature request.
Also, you may find help from other members of the community on the general
[Microsoft Community][] or the Microsoft [PowerShell Tech Community][].
We offer no guarantee there that the community will address or resolve your issue in a timely manner.
If you have a problem that requires immediate attention,
you should use the traditional, paid support options.

## Lifecycle of PowerShell Core

PowerShell Core is adopting the [Microsoft Modern Lifecycle Policy][modern].
This support lifecycle is intended to keep customers up-to-date with the latest versions.

The version 6.x branch of PowerShell Core will be updated approximately
once every six months (examples: 6.0, 6.1, 6.2, etc.)

> [!IMPORTANT]
> You must update within six months after each new minor version release to continue receiving support.

For example, if PowerShell Core 6.1 is released on July 1, 2018,
you would be expected to update to PowerShell Core 6.1 by January 1, 2019 to maintain support.

> [!IMPORTANT]
> You must update within 30 days after each new patch version release to continue receiving support.

For example, If you are running PowerShell Core 6.1 and 6.1.3 was released on February 19, 2019,
you would be expected to update to PowerShell Core 6.1.3 by March 21, 2019,
which is 30 days after the release to maintain support.
If any fixes are found to be required,
the fixes will be released in our next cumulative update.

The Modern Lifecycle Policy also requires that Microsoft give customers 12 months
notice before discontinuing support for a product (that is, PowerShell Core).

Eventually, we expect PowerShell Core will adopt the "long-term servicing" approach.
In this servicing approach, we would require only servicing and
security updates to stay in support on a specific branch/version of 6.x.

## Supported platforms

The following table to see what platform the version of PowerShell Core
you are using is officially supported.

Our community has also contributed packages for some platforms,
but they are not officially supported.
These packages are marked as `Community` in the table.

Platforms listed as `Experimental` are not officially supported, but are available
for experimentation and feedback.

|                                                   | 6.1         | 6.2         |
|---------------------------------------------------|:-----------:|:-----------:|
| Windows 7, 8.1, and 10                            | Supported   | Supported   |
| Windows Server 2008 R2, 2012 R2, 2016             | Supported   | Supported   |
| [Windows Server Semi-Annual Channel][semi-annual] | Supported   | Supported   |
| Ubuntu 16.04 and 18.04                            | Supported   | Supported   |
| Ubuntu 18.10 (via Snap Package)                   | Community   | Community   |
| Debian 9                                          | Supported   | Supported   |
| CentOS 7                                          | Supported   | Supported   |
| Red Hat Enterprise Linux 7                        | Supported   | Supported   |
| openSUSE 42.3                                     | Supported   | Supported   |
| Fedora 28                                         | Supported   | Supported   |
| macOS 10.12+                                      | Supported   | Supported   |
| Arch                                              | Community   | Community   |
| Raspbian                                          | Community   | Community   |
| Kali                                              | Community   | Community   |
| AppImage  (works on multiple Linux platforms)     | Community   | Community   |
| [Snap Package](https://snapcraft.io/powershell)   | See note    | See note    |

> [!NOTE]
> Snap packages are supported the same as the distribution you are running the package on.

## PowerShell release end of life

Based on [Lifecycle of PowerShell Core](#lifecycle-of-powershell-core),
the following table lists the dates when various release will no longer be supported.

| Version | End Of Life                   |
|---------|-------------------------------|
| 6.0     | February 13, 2019             |
| 6.1     | September 28, 2019            |
| 6.2     | 6 months after 7 releases     |

## Platforms, which are out of support

When a platform version reaches end-of-life as defined by the platform owner,
PowerShell Core will also cease to support that platform version.
Previously released packages will remain available for customers needing access but
formal support and updates of any kind will no longer be provided.

So, the distribution owners ended support for the following versions and are not supported.

| OS       | Version | End of Life                                                                                 |
|----------|---------|---------------------------------------------------------------------------------------------|
| Fedora   | 24      | [August 2017](https://fedoramagazine.org/fedora-24-eol/)                                    |
| Fedora   | 25      | [December 2017](https://fedoramagazine.org/fedora-25-end-life/)                             |
| Fedora   | 26      | [May 2018](https://fedoramagazine.org/fedora-26-end-life/)                                  |
| openSUSE | 42.1    | [May 2017](https://lists.opensuse.org/opensuse-security-announce/2017-05/msg00053.html)     |
| openSUSE | 42.2    | [January 2018](https://lists.opensuse.org/opensuse-security-announce/2017-11/msg00066.html) |
| Ubuntu   | 16.10   | [July 2017](https://lists.ubuntu.com/archives/ubuntu-announce/2017-July/000223.html)        |
| Ubuntu   | 17.04   | [January 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-January.txt)          |
| Ubuntu   | 17.10   | [July 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-July/000232.html)        |
| Debian   | 8       | [June 2018](https://lists.debian.org/debian-security-announce/2018/msg00132.html)           |
| Fedora   | 27      | [November 2018](https://fedoramagazine.org/fedora-27-end-of-life/)                          |
| Ubuntu   | 14.04   | [April 2019](https://wiki.ubuntu.com/Releases)                                              |

## Notes on licensing

PowerShell Core is released under the [MIT license][].
Under this license, and without a paid support agreement,
users are limited to [community support][].
With community support, Microsoft makes no guarantees of responsiveness or fixes.

## Windows PowerShell Module

Support for PowerShell Core does not include product modules, unless those modules explicitly
support PowerShell Core.
For example,
using the `ActiveDirectory` module that ships as part of Windows Server is an unsupported scenario.

However, modules that do not explicitly support PowerShell Core may be compatible in some cases.
By installing the [`WindowsPSModulePath`][] module,
you can add the Windows PowerShell `PSModulePath` to your PowerShell Core `PSModulePath`.

First, install the `WindowsPSModulePath` module from the PowerShell Gallery:

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

[Premier]: https://www.microsoft.com/en-us/microsoftservices/support.aspx
[enterprise-agreement]: https://www.microsoft.com/en-us/licensing/licensing-programs/enterprise.aspx
[assurance]: https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx
[community support]: https://github.com/powershell/powershell/issues
[Microsoft Community]: https://answers.microsoft.com/
[PowerShell Tech Community]: https://techcommunity.microsoft.com/t5/PowerShell/ct-p/WindowsPowerShell
[assisted support]: https://support.microsoft.com/assistedsupportproducts
[modern]: https://support.microsoft.com/help/30881/modern-lifecycle-policy
[lifecycle-chart]: ./images/modern-lifecycle.png
[semi-annual]: https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview
[MIT license]: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
[`WindowsPSModulePath`]: https://www.powershellgallery.com/packages/WindowsPSModulePath/
[Experimental features]: /powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-6#experimentalfeatures
