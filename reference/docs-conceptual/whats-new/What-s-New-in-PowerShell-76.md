---
title: What's New in PowerShell 7.6
description: New features and changes released in PowerShell 7.6
ms.date: 01/17/2025
---

# What's New in PowerShell 7.6

PowerShell 7.6-preview.2 includes the following features, updates, and breaking changes. PowerShell
7.6 is built on .NET 9.0.101 GA release.

For a complete list of changes, see the [CHANGELOG][04] in the GitHub repository.

## Breaking Changes

No breaking changes were introduced in PowerShell 7.6-preview.2.

## Updated modules

PowerShell 7.6-preview.2 includes the following updated modules:

- **Microsoft.PowerShell.PSResourceGet** v1.1.0-RC3
- **PSReadLine** v2.3.6

## Tab completion improvements

- Update Named and Statement block type inference to not consider AssignmentStatements and
  Increment/decrement operators as part of their output ([#21137][21137]) (Thanks @MartinGC94!)
- Add -PropertyType argument completer for New-ItemProperty ([#21117][21117]) (Thanks
  @ArmaanMcleod!)

## Cmdlet improvements

- Add -ExcludeModule parameter to Get-Command ([#18955][18955]) (Thanks @MartinGC94!)
- Return correct FileName property for Get-Item when listing alternate data streams
  ([#18019][18019]) (Thanks @kilasuit!)
- Fix Get-ItemProperty to report non-terminating error for cast exception ([#21115][21115]) (Thanks
  @ArmaanMcleod!)
- Fix a bug in how Write-Host handles XmlNode object ([#24669][24669]) (Thanks @brendandburns!)

## Engine improvements

- Added the AIShell module to telemetry collection list ([#24747][24747])
- Added helper in EnumSingleTypeConverter to get enum names as array ([#17785][17785]) (Thanks
  @fflaten!)
- Update DnsNameList for X509Certificate2 to use
  X509SubjectAlternativeNameExtension.EnumerateDnsNames Method ([#24714][24714]) (Thanks
  @ArmaanMcleod!)
- Add completion of modules by their shortname ([#20330][20330]) (Thanks @MartinGC94!)

## Experimental features

The following experimental features are included in PowerShell 7.6-preview.2:

- [PSNativeWindowsTildeExpansion][01] - Add tilde expansion for windows native executables
- [PSRedirectToVariable][02] - Allow redirecting to a variable
- [PSSerializeJSONLongEnumAsNumber][03] - `ConvertTo-Json` now treats large enums as numbers

<!-- end of content -->
<!-- reference links -->
[01]: ../learn/experimental-features.md#psnativewindowstildeexpansion
[02]: ../learn/experimental-features.md#psredirecttovariable
[03]: ../learn/experimental-features.md#psserializejsonlongenumasnumber
[04]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/preview.md

[17785]: https://github.com/PowerShell/PowerShell/pull/17785
[18019]: https://github.com/PowerShell/PowerShell/pull/18019
[18955]: https://github.com/PowerShell/PowerShell/pull/18955
[20330]: https://github.com/PowerShell/PowerShell/pull/20330
[21115]: https://github.com/PowerShell/PowerShell/pull/21115
[21117]: https://github.com/PowerShell/PowerShell/pull/21117
[21137]: https://github.com/PowerShell/PowerShell/pull/21137
[24669]: https://github.com/PowerShell/PowerShell/pull/24669
[24714]: https://github.com/PowerShell/PowerShell/pull/24714
[24747]: https://github.com/PowerShell/PowerShell/pull/24747
