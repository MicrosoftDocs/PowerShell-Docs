---
title: What's New in PowerShell 7.6
description: New features and changes released in PowerShell 7.6
ms.date: 03/26/2025
---

# What's New in PowerShell 7.6

PowerShell 7.6-preview.4 includes the following features, updates, and breaking changes. PowerShell
7.6 is built on .NET 9.0.101 GA release.

For a complete list of changes, see the [CHANGELOG][04] in the GitHub repository.

## Updated modules

PowerShell 7.6-preview.3 includes the following updated modules:

- **Microsoft.PowerShell.PSResourceGet** v1.1.0
- **PSReadLine** v2.3.6
- **Microsoft.PowerShell.ThreadJob** v2.2.0
- **ThreadJob** v2.1.0

The **ThreadJob** was renamed to **Microsoft.PowerShell.ThreadJob** module. There is no difference
in the functionality of the module. To ensure backward compatibility for scripts that use the old
name, the **ThreadJob** v2.1.0 module is a proxy module that points to the
**Microsoft.PowerShell.ThreadJob** v2.2.0.

## Breaking Changes

- Fix `WildcardPattern.Escape` to escape lone backticks correctly ([#25211][25211]) (Thanks
  @ArmaanMcleod!)
- Convert `-ChildPath` parameter to `string[]` for `Join-Path` cmdlet ([#24677][24677]) (Thanks
  @ArmaanMcleod!)
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
- Fix share completion with provider and spaces (#[19440][19440]) (Thanks @MartinGC94!)
- Improve variable type inference ([#19830][19830]) (Thanks @MartinGC94!)
- Add tooltips for hashtable key completions ([#17864][17864]) (Thanks @MartinGC94!)
- Fix type inference of parameters in classic functions ([#25172][25172]) (Thanks @MartinGC94!)
- Improve assignment type inference ([#21143][21143]) (Thanks @MartinGC94!)
- Exclude **OutVariable** assignments within the same `CommandAst` when inferring variables
  ([#25224][25224]) (Thanks @MartinGC94!)
- Fix parameter completion when script requirements fail ([#17687][17687]) (Thanks @MartinGC94!)
- Improve the completion for attribute arguments ([#25129][25129]) (Thanks @MartinGC94!)
- Fix completion that relies on pseudobinding in script blocks ([#25122][25122]) (Thanks
  @MartinGC94!)
- Don't complete duplicate command names ([#21113][21113]) (Thanks @MartinGC94!)
- Add completion for variables assigned by command redirection ([#25104][25104]) (Thanks
  @MartinGC94!)
- Fix `TypeName.GetReflectionType()` to work when the `TypeName` instance represents a generic type
  definition within a `GenericTypeName` ([#24985][24985])
- Update variable/property assignment completion so it can fallback to type inference
  ([#21134][21134]) (Thanks @MartinGC94!)
- Handle type inference for redirected commands ([#21131][21131]) (Thanks @MartinGC94!)
- Use `Get-Help` approach to find `about_*.help.txt` files with correct locale for completions
  ([#24194][24194]) (Thanks @MartinGC94!)
- Fix completion of variables assigned inside Do loops ([#25076][25076]) (Thanks @MartinGC94!)
- Fix completion of provider paths when a path returns itself instead of its children
  ([#24755][24755]) (Thanks @MartinGC94!)
- Enable completion of scoped variables without specifying scope ([#20340][20340]) (Thanks
  @MartinGC94!)
- Fix issue with incomplete results when completing paths with wildcards in non-filesystem providers
  ([#24757][24757]) (Thanks @MartinGC94!)

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
- Add `PipelineStopToken` to `Cmdlet` which will be signaled when the pipeline is stopping
  ([#24620][24620]) (Thanks @jborean93!)
- Fallback to AppLocker after `WldpCanExecuteFile` ([#24912][24912])
- Move .NET method invocation logging to after the needed type conversion is done for method
  arguments ([#25022][25022])
- Fix infinite loop in variable type inference ([#25206][25206]) (Thanks @MartinGC94!)
- Remove the old fuzzy suggestion and fix the local script file name suggestion ([#25177][25177])
- Make `SystemPolicy` public APIs visible but non-op on Unix platforms so that they can be included
  in `PowerShellStandard.Library` ([#25051][25051])
- Set standard handles explicitly when starting a process with `-NoNewWindow` ([#25061][25061])
- Fix tooltip for variable expansion and include desc ([#25112][25112]) (Thanks @jborean93!)
- Allow empty prefix string in 'Import-Module -Prefix' to override default prefix in manifest
  ([#20409][20409]) (Thanks @MartinGC94!)
- Use script filepath when completing relative paths for using statements ([#20017][20017]) (Thanks
  @MartinGC94!)
- Allow DSC parsing through OS architecture translation layers ([#24852][24852]) (Thanks @bdeb1337!)

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

[17687]: https://github.com/PowerShell/PowerShell/pull/17687
[17785]: https://github.com/PowerShell/PowerShell/pull/17785
[17864]: https://github.com/PowerShell/PowerShell/pull/17864
[18019]: https://github.com/PowerShell/PowerShell/pull/18019
[18955]: https://github.com/PowerShell/PowerShell/pull/18955
[19440]: https://github.com/PowerShell/PowerShell/pull/19440
[19830]: https://github.com/PowerShell/PowerShell/pull/19830
[20017]: https://github.com/PowerShell/PowerShell/pull/20017
[20330]: https://github.com/PowerShell/PowerShell/pull/20330
[20340]: https://github.com/PowerShell/PowerShell/pull/20340
[20409]: https://github.com/PowerShell/PowerShell/pull/20409
[21113]: https://github.com/PowerShell/PowerShell/pull/21113
[21115]: https://github.com/PowerShell/PowerShell/pull/21115
[21117]: https://github.com/PowerShell/PowerShell/pull/21117
[21131]: https://github.com/PowerShell/PowerShell/pull/21131
[21134]: https://github.com/PowerShell/PowerShell/pull/21134
[21137]: https://github.com/PowerShell/PowerShell/pull/21137
[21143]: https://github.com/PowerShell/PowerShell/pull/21143
[24192]: https://github.com/PowerShell/PowerShell/pull/24192
[24194]: https://github.com/PowerShell/PowerShell/pull/24194
[24620]: https://github.com/PowerShell/PowerShell/pull/24620
[24669]: https://github.com/PowerShell/PowerShell/pull/24669
[24677]: https://github.com/PowerShell/PowerShell/pull/24677
[24711]: https://github.com/PowerShell/PowerShell/pull/24711
[24714]: https://github.com/PowerShell/PowerShell/pull/24714
[24747]: https://github.com/PowerShell/PowerShell/pull/24747
[24755]: https://github.com/PowerShell/PowerShell/pull/24755
[24757]: https://github.com/PowerShell/PowerShell/pull/24757
[24839]: https://github.com/PowerShell/PowerShell/pull/24839
[24852]: https://github.com/PowerShell/PowerShell/pull/24852
[24879]: https://github.com/PowerShell/PowerShell/pull/24879
[24880]: https://github.com/PowerShell/PowerShell/pull/24880
[24907]: https://github.com/PowerShell/PowerShell/pull/24907
[24912]: https://github.com/PowerShell/PowerShell/pull/24912
[24936]: https://github.com/PowerShell/PowerShell/pull/24936
[24949]: https://github.com/PowerShell/PowerShell/pull/24949
[24963]: https://github.com/PowerShell/PowerShell/pull/24963
[24971]: https://github.com/PowerShell/PowerShell/pull/24971
[24977]: https://github.com/PowerShell/PowerShell/pull/24977
[24985]: https://github.com/PowerShell/PowerShell/pull/24985
[25022]: https://github.com/PowerShell/PowerShell/pull/25022
[25051]: https://github.com/PowerShell/PowerShell/pull/25051
[25061]: https://github.com/PowerShell/PowerShell/pull/25061
[25076]: https://github.com/PowerShell/PowerShell/pull/25076
[25104]: https://github.com/PowerShell/PowerShell/pull/25104
[25112]: https://github.com/PowerShell/PowerShell/pull/25112
[25122]: https://github.com/PowerShell/PowerShell/pull/25122
[25129]: https://github.com/PowerShell/PowerShell/pull/25129
[25172]: https://github.com/PowerShell/PowerShell/pull/25172
[25177]: https://github.com/PowerShell/PowerShell/pull/25177
[25206]: https://github.com/PowerShell/PowerShell/pull/25206
[25211]: https://github.com/PowerShell/PowerShell/pull/25211
[25224]: https://github.com/PowerShell/PowerShell/pull/25224
