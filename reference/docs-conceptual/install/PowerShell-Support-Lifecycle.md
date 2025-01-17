---
description: Details the policies governing support for PowerShell.
ms.date: 01/17/2025
ms.topic: lifecycle
title: PowerShell Support Lifecycle
---
# PowerShell Support Lifecycle

> [!NOTE]
> This document is about support for PowerShell. Windows PowerShell (1.0 - 5.1) is a component of
> the Windows operating system. For more information, see
> [Product and Services Lifecycle Information][03].

PowerShell follows the [Microsoft Modern Lifecycle Policy][02]. Support dates follow the
[.NET Support Policy][06]. In this servicing approach, customers can choose Long Term Support (LTS)
releases or current releases.

An **LTS** release of PowerShell is built on an **LTS** release of .NET. Updates to an **LTS**
release only contain critical security updates and servicing fixes that are designed to minimize
impact on existing workloads.

A **current** release is a release that occurs between **LTS** releases. Current releases can
contain critical fixes, innovations, and new features. Microsoft supports a **current** release for
six months after the next **LTS** release.

Both **LTS** and **current** versions of PowerShell receive security updates and bug fixes.
Microsoft only supports the latest update version of a release.

## Getting support

Microsoft provides support for PowerShell on a best-effort basis. Support for Windows PowerShell 5.1
is provided through Windows support channels. You can use the standard paid support channels to get
support for PowerShell.

- [Support for business][18]
- [Contact support][17]

There are many free support options available from the PowerShell community. The most active
community support channels are available through **Discord** or **Slack**. The discussion channels
are mirrored on both platforms, so you can choose the platform that you prefer. These channels can
help you troubleshoot issues, answer questions, and provide guidance on how to use PowerShell.

If you think that you found a bug, you can file an issue on [GitHub][16]. The PowerShell team can't
provide support through GitHub, but they welcome bug reports. The [community support][04] page
provides links to the most popular community support channels.

## Supported platforms

PowerShell runs on multiple operating systems (OS) and processor architecture platforms. The
platform must meet the following criteria:

- The target platform (OS version and processor architecture) is supported by .NET.
- Microsoft has tested and approved PowerShell on the target platform.
- The OS version is supported by the distributor for at least one year.
- The OS version isn't an interim release or equivalent.
- The OS version is currently supported by the distributor.

Support for PowerShell ends when either of the following conditions are met:

- The target platform reaches end-of-life as defined by the platform owner
- The specific version of PowerShell reaches end-of-life

After a version of PowerShell reaches end-of-life, no further updates, including security updates,
are provided. Microsoft encourages customers to upgrade to a supported version of PowerShell to
continue receiving updates and support.

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

### Support for PowerShell modules

The support lifecycle for PowerShell doesn't cover modules that ship outside of the PowerShell
release package. For example, using the `ActiveDirectory` module that ships as part of Windows
Server is supported under the [Windows Support Lifecycle][01].

## Support for experimental features

[Experimental features][05] aren't intended to be used in production environments. We appreciate
feedback on experimental features and we provide best-effort support for them.

## Notes on licensing

PowerShell is released under the [MIT license][15]. Under this license, and without a paid support
agreement, users are limited to [community support][04]. With community support, Microsoft makes no
guarantees of responsiveness or fixes.

## PowerShell end-of-support dates

The PowerShell support lifecycle follows the [support lifecycle of .NET][06]. The following table
lists the end-of-support dates for the current versions of PowerShell:

|  Version  |   Release Date     |  End-of-support    |
| --------- | ------------------ | ------------------ |
| 7.4 (LTS) | November 16, 2023  | November 10, 2026  |

The following table lists the end-of-support dates for retired versions of PowerShell:

|  Version  |    Release Date    |   End-of-support   |
| --------- | ------------------ | ------------------ |
| 7.3       | November 9, 2022   | May 8, 2024        |
| 7.2 (LTS) | November 8, 2021   | November 8, 2024   |
| 7.0 (LTS) | March 4, 2020      | December 3, 2022   |
| 7.1       | November 11, 2020  | May 8, 2022        |
| 6.2       | March 28, 2019     | September 4, 2020  |
| 6.1       | September 13, 2018 | September 28, 2019 |
| 6.0       | January 20, 2018   | February 13, 2019  |

## Release history

The following table contains a historical timeline of the major releases of PowerShell.

|         Version          | Release Date |                                    Note                                    |
| ------------------------ | :----------: | -------------------------------------------------------------------------- |
| PowerShell 7.6 (preview) |    Future    | Built on [.NET 9.0.0][14]                                                  |
| PowerShell 7.5 (RC)      |    Future    | Built on [.NET 9.0.0][14]                                                  |
| PowerShell 7.4 (LTS)     |   Nov-2023   | Built on [.NET 8.0.0][13]                                                  |
| PowerShell 7.3           |   Nov-2022   | Built on [.NET 7.0][12]                                                    |
| PowerShell 7.2 (LTS)     |   Nov-2021   | Built on [.NET 6.0][11]                                                    |
| PowerShell 7.1           |   Nov-2020   | Built on [.NET 5.0][10]                                                    |
| PowerShell 7.0 (LTS)     |   Mar-2020   | Built on [.NET Core 3.1][09]                                               |
| PowerShell 6.2           |   Mar-2019   | Built on [.NET Core 2.1][08]                                               |
| PowerShell 6.1           |   Sep-2018   | Built on [.NET Core 2.1][08]                                               |
| PowerShell 6.0           |   Jan-2018   | Built on [.NET Core 2.0][07]. Installable on Windows, Linux, and macOS     |
| Windows PowerShell 5.1   |   Aug-2016   | Released in Windows 10 Anniversary Update and Windows Server 2016, WMF 5.1 |
| Windows PowerShell 5.0   |   Feb-2016   | Released in Windows Management Framework (WMF) 5.0                         |
| Windows PowerShell 4.0   |   Oct-2013   | Released in Windows 8.1 and with Windows Server 2012 R2, WMF 4.0           |
| Windows PowerShell 3.0   |   Oct-2012   | Released in Windows 8 and with Windows Server 2012 WMF 3.0                 |
| Windows PowerShell 2.0   |   Jul-2009   | Released in Windows 7 and Windows Server 2008 R2, WMF 2.0                  |
| Windows PowerShell 1.0   |   Nov-2006   | Released as optional component of Windows Server 2008                      |

Run the following command to see the full version number of .NET used by the version of PowerShell
you're running:

```powershell
[System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription
```

<!-- link references -->
[01]: /lifecycle/faq/windows
[02]: /lifecycle/policies/modern
[03]: /lifecycle/products/
[04]: /powershell/scripting/community/community-support
[05]: /powershell/scripting/learn/experimental-features
[06]: https://dotnet.microsoft.com/platform/support/policy/dotnet-core
[07]: https://github.com/dotnet/core/blob/main/release-notes/2.0/2.0-supported-os.md
[08]: https://github.com/dotnet/core/blob/main/release-notes/2.1/2.1-supported-os.md
[09]: https://github.com/dotnet/core/blob/main/release-notes/3.1/3.1-supported-os.md
[10]: https://github.com/dotnet/core/blob/main/release-notes/5.0/5.0-supported-os.md
[11]: https://github.com/dotnet/core/blob/main/release-notes/6.0/supported-os.md
[12]: https://github.com/dotnet/core/blob/main/release-notes/7.0/supported-os.md
[13]: https://github.com/dotnet/core/blob/main/release-notes/8.0/supported-os.md
[14]: https://github.com/dotnet/core/blob/main/release-notes/9.0/supported-os.md
[15]: https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt
[16]: https://github.com/PowerShell/PowerShell/issues/new/choose
[17]: https://support.microsoft.com/contactus
[18]: https://support.serviceshub.microsoft.com/
