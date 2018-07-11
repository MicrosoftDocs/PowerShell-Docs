# PowerShell Core Support Lifecycle

PowerShell Core is a distinct set of tools and components that is shipped, installed, and configured separately from Windows PowerShell.
Therefore, PowerShell Core is not included in the Windows 7/8.1/10 or Windows Server licensing agreements.

However, PowerShell Core is supported under traditional Microsoft support agreements, including [Premier][], [Microsoft Enterprise Agreements][enterprise-agreement], and [Microsoft Software Assurance][assurance].
You can also pay for [assisted support][] for PowerShell Core by filing a support request for your problem.

We also offer [community support][] on GitHub where you can file an issue, bug, or feature request.
Alternatively, you may find help from other members of the community on the general [Microsoft Community][] or the Microsoft [PowerShell Tech Community][].
We offer no guarantee there that your issue will be addressed or resolved in a timely manner.
If you have a problem that requires immediate attention,
you should use the traditional, paid support options.

## Lifecycle of PowerShell Core

PowerShell Core is adopting the [Microsoft Modern Lifecycle Policy][modern].
This support lifecycle is intended to keep customers up-to-date with the latest versions.

The version 6.x branch of PowerShell Core will be updated approximately once every six months (e.g. 6.0, 6.1, 6.2, etc.)

> [!IMPORTANT]
> You must update within six months after each new minor version release to continue receiving support.

For example, if PowerShell Core 6.1 is released on July 1st, 2018,
you would be expected to update to PowerShell Core 6.1 by January 1st, 2019 to maintain support.

![PowerShell Core branch lifecycle][lifecycle-chart]

The Modern Lifecycle Policy also requires that Microsoft give customers 12 months notice before discontinuing support for a product (i.e. PowerShell Core).

Eventually, we expect PowerShell Core will adopt the "long-term servicing" approach where we would require only servicing and security updates to stay in support on a specific branch/version of 6.x.

## Supported platforms

Please see the following table to see what platform the version of PowerShell Core you are using is officially supported.

Our community has also contributed packages for some platforms,
but they are not officially supported.
These packages are marked as `Community` in the table.

Platforms listed as `Experimental` are not officially supported, but are available for experimentation and feedback.

|                                                   | 6.0         | 6.1         |
|---------------------------------------------------|:-----------:|:-----------:|
| Windows 7, 8.1, and 10                            | Supported   | Supported   |
| Windows Server 2008 R2, 2012 R2, 2016             | Supported   | Supported   |
| [Windows Server Semi-Annual Channel][semi-annual] | Supported   | Supported   |
| Ubuntu 14.04 and, 16.04                           | Supported   | Supported   |
| Ubuntu 17.10, and 18.04                           |             | Supported   |
| Debian 8.7+, and 9                                | Supported   | Supported   |
| CentOS 7                                          | Supported   | Supported   |
| Red Hat Enterprise Linux 7                        | Supported   | Supported   |
| OpenSUSE 42.2                                     | Supported   | Supported   |
| Fedora 27                                         | Supported   | Supported   |
| Fedora 28                                         |             | Supported   |
| macOS 10.12+                                      | Supported   | Supported   |
| Arch                                              | Community   | Community   |
| Raspbian                                          | Experimental| Community   |
| Kali                                              | Community   | Community   |
| AppImage  (works on multiple Linux platforms)     | Community   | Community   |

## Platform which are out of support

When a platform version reaches end-of-life as defined by the platform owner, PowerShell Core will also cease to provide support for that platform version. Previously released packages will remain available for customers needing access but formal support and updates of any kind will no longer be provided.

Therefore, support for the following versions was ended by the distribution owners and are not supported.

| OS       | Version | End of Life                                                                                 |
|----------|---------|---------------------------------------------------------------------------------------------|
| Fedora   | 26      | [May 2018](https://fedoramagazine.org/fedora-26-end-life/)                                  |
| Fedora   | 25      | [December 2017](https://fedoramagazine.org/fedora-25-end-life/)                             |
| Fedora   | 24      | [August 2017](https://fedoramagazine.org/fedora-24-eol/)                                    |
| openSUSE | 42.2    | [January 2018](https://lists.opensuse.org/opensuse-security-announce/2017-11/msg00066.html) |
| openSUSE | 42.1    | [May 2017](https://lists.opensuse.org/opensuse-security-announce/2017-05/msg00053.html)     |
| Ubuntu   | 17.04   | [January 2018](https://lists.ubuntu.com/archives/ubuntu-announce/2018-January.txt)          |
| Ubuntu   | 16.10   | [July 2017](https://lists.ubuntu.com/archives/ubuntu-announce/2017-July/000223.html)        |

## Notes on licensing

PowerShell Core is released under the [MIT license][].
Under this license, and in the absence of a paid support agreement,
users are limited to [community support][].
With community support, Microsoft makes no guarantees of responsiveness or fixes.

## Windows PowerShell Module

Support for PowerShell Core does not extend to other product modules unless those modules explicitly support PowerShell Core.
For example, using the `ActiveDirectory` module that ships as part of Windows Server is an unsupported scenario.

However, modules that do not explicitly support PowerShell Core may be compatible in some cases.
By installing the [`WindowsPSModulePath`][] module,
you can append the Windows PowerShell `PSModulePath` to your PowerShell Core `PSModulePath`.

First, install the `WindowsPSModulePath` module from the PowerShell Gallery:

```powershell
# Add `-Scope CurrentUser` if you're installing as non-admin
Install-Module WindowsPSModulePath -Force
```

After installing this module, run the `Add-WindowsPSModulePath` cmdlet to add the Windows PowerShell `PSModulePath` to PowerShell Core:

```powershell
# Add this line to your profile if you always want Windows PowerShell PSModulePath
Add-WindowsPSModulePath
```

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
