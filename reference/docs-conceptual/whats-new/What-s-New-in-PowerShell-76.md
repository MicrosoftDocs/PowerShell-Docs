---
title: What's New in PowerShell 7.6
description: New features and changes released in PowerShell 7.6
ms.date: 02/18/2025
---

# What's New in PowerShell 7.6

PowerShell 7.6-preview.3 includes the following features, updates, and breaking changes. PowerShell
7.6 is built on .NET 9.0.101 GA release.

For a complete list of changes, see the [CHANGELOG][04] in the GitHub repository.

## Updated modules

PowerShell 7.6-preview.3 includes the following updated modules:

- **Microsoft.PowerShell.PSResourceGet** v1.1.0
- **PSReadLine** v2.3.6

## Breaking Changes

- Remove trailing space from event source name ([#24192][24192]) (Thanks @MartinGC94!)

## Tab completion improvements

- Update Named and Statement block type inference to not consider **AssignmentStatements** and
  Increment/decrement operators as part of their output ([#21137][21137]) (Thanks @MartinGC94!)
- Add `-PropertyType` argument completer for `New-ItemProperty` ([#21117][21117]) (Thanks
  @ArmaanMcleod!)
- Add completion single/double quote support for `-Noun` parameter for `Get-Command`
  ([#24977][24977]) (Thanks @ArmaanMcleod!)
- Add completion single/double quote support for `-PSEdition` parameter for `Get-Module`
  ([#24971][24971]) (Thanks @ArmaanMcleod!)
- Convert **InvalidCommandNameCharacters** in AnalysisCache to `SearchValues<char>` for more
  efficient char searching ([#24880][24880]) (Thanks @ArmaanMcleod!)
- Convert **s_charactersRequiringQuotes** in Completion Completers to `SearchValues<char>` for more
  efficient char searching ([#24879][24879]) (Thanks @ArmaanMcleod!)
- Update `IndexOfAny()` calls with invalid path/filename to `SearchValues<char>` for more efficient
  char searching ([#24896][24896]) (Thanks @ArmaanMcleod!)
- Replace `char[]` array in `CompletionRequiresQuotes` with cached `SearchValues<char>`
  ([#24907][24907]) (Thanks @ArmaanMcleod!)
- Add quote handling in `Verb`, `StrictModeVersion`, `Scope` and `PropertyType` Argument
  Completers with single helper method ([#24839][24839]) (Thanks @ArmaanMcleod!)

## Cmdlet improvements

- Add `-ExcludeModule` parameter to `Get-Command` ([#18955][18955]) (Thanks @MartinGC94!)
- Return correct **FileName** property for `Get-Item` when listing alternate data streams
  ([#18019][18019]) (Thanks @kilasuit!)
- Fix `Get-ItemProperty` to report non-terminating error for cast exception ([#21115][21115])
  (Thanks @ArmaanMcleod!)
- Fix a bug in how q handles XmlNode object ([#24669][24669]) (Thanks @brendandburns!)
- Error when `New-Item -Force` is passed an invalid directory name ([#24936][24936]) (Thanks
  @kborowinski!)
- Allow `Start-Transcript` to use `$Transcript` which is a `PSObject` wrapped string to specify the
  transcript path ([#24963][24963]) (Thanks @kborowinski!)
- Improve `Start-Process -Wait` polling efficiency ([#24711][24711]) (Thanks @jborean93!)
- Add completion of modules by their shortname ([#20330][20330]) (Thanks @MartinGC94!)

## Engine improvements

- Added the AIShell module to telemetry collection list ([#24747][24747])
- Added helper in `EnumSingleTypeConverter` to get enum names as array ([#17785][17785]) (Thanks
  @fflaten!)
- Update **DnsNameList** for **X509Certificate2** to use
  `X509SubjectAlternativeNameExtension.EnumerateDnsNames()` Method ([#24714][24714]) (Thanks
  @ArmaanMcleod!)
- Stringify **ErrorRecord** with empty exception message to empty string ([#24949][24949]) (Thanks
  @MatejKafka!)

## Experimental features

The following experimental features are included in PowerShell 7.6-preview.3:

- [PSNativeWindowsTildeExpansion][01] - Add tilde expansion for Windows-native executables
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
[24192]: https://github.com/PowerShell/PowerShell/pull/24192
[24669]: https://github.com/PowerShell/PowerShell/pull/24669
[24711]: https://github.com/PowerShell/PowerShell/pull/24711
[24714]: https://github.com/PowerShell/PowerShell/pull/24714
[24747]: https://github.com/PowerShell/PowerShell/pull/24747
[24839]: https://github.com/PowerShell/PowerShell/pull/24839
[24879]: https://github.com/PowerShell/PowerShell/pull/24879
[24880]: https://github.com/PowerShell/PowerShell/pull/24880
[24907]: https://github.com/PowerShell/PowerShell/pull/24907
[24936]: https://github.com/PowerShell/PowerShell/pull/24936
[24949]: https://github.com/PowerShell/PowerShell/pull/24949
[24963]: https://github.com/PowerShell/PowerShell/pull/24963
[24971]: https://github.com/PowerShell/PowerShell/pull/24971
[24977]: https://github.com/PowerShell/PowerShell/pull/24977
