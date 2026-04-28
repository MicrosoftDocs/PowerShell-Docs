---
title: What's New in PowerShell 7.7
description: New features and changes released in PowerShell 7.7
ms.date: 04/07/2026
---

# What's New in PowerShell 7.7

PowerShell 7.7-preview.1 includes the following features, updates, and breaking changes. PowerShell
7.7.0 is built on the .NET 11.0.0-preview.3 runtime.

For a complete list of changes, see the [CHANGELOG][04] in the GitHub repository.

## Updated modules

PowerShell 7.7 includes the following updated modules:

- **Microsoft.PowerShell.PSResourceGet** v1.2.0
- **PSReadLine** v2.4.5

## Breaking Changes

- Add `ValidateNotNullOrEmpty` attribute to the `-Property` of `Format-Table`, `Format-List`, and
  `Format-Custom` ([#26552][26552])
- Use ArgumentException.ThrowIfNullOrEmpty for not-null-not-empty argument validation.
  ([#26668][26668])
  - The exception thrown changes to `System.ArgumentException` from
    `System.Management.Automation.PSArgumentNullException`.
- Correct handling of explicit `-[<Operator>]:$false` parameter values in `Where-Object`
  ([#26485][26485]) (Thanks @yotsuda!)

## Tab completion improvements

- Add tab completion for `$PSBoundParameters.Keys` switch cases and access patterns
  ([#26483][26483]) (Thanks @yotsuda!)

## Cmdlet improvements

- Correct handling of explicit `-<SwitchParameter>:$false` parameter values for the following
  cmdlets:
  - `ConvertFrom-Csv`, `ConvertTo-Csv`, `Export-Csv`, and `Import-Csv` ([#26719][26719]) (Thanks
    @yotsuda!)
  - `Get-Random` ([#26457][26457]) (Thanks @yotsuda!)
  - `Get-SecureRandom` ([#26460][26460]) (Thanks @yotsuda!)
  - `Get-TimeZone` ([#26463][26463]) (Thanks @yotsuda!)
  - `Get-Uptime` ([#26141][26141]) (Thanks @logiclrd!)
  - `New-Guid` ([#26140][26140]) (Thanks @logiclrd!)
  - `New-PSSession` ([#26469][26469]) (Thanks @yotsuda!)
  - `Split-Path` ([#26474][26474]) (Thanks @yotsuda!)
  - `Test-Connection` ([#26479][26479]) (Thanks @yotsuda!)
  - `Where-Object` ([#26485][26485]) (Thanks @yotsuda!)
- Add `-ExcludeProperty` parameter to `Format-*` cmdlets ([#26514][26514]) (Thanks @yotsuda!)
- Add `-Extension` parameter to `Join-Path` cmdlet ([#26482][26482]) (Thanks @yotsuda!)
- Make `Export-Csv` `-Append` and `-NoHeader` mutually exclusive ([#26472][26472]) (Thanks
  @yotsuda!)
- Mark `-NoTypeInformation` as obsolete no-op and evaluate `-IncludeTypeInformation` on by value on
  Csv cmdlets ([#26719][26719]) (Thanks @yotsuda!)
- Add `SubjectAlternativeName` property to the `Signature` object returned from
  `Get-AuthenticodeSignature` ([#26252][26252])
- Add property and event for debug attach ([#25788][25788]) (Thanks @jborean93!)
- Add `$PSApplicationOutputEncoding` variable ([#21219][21219]) (Thanks @jborean93!)
- Add `ToRegex` method to `WildcardPattern` class ([#26515][26515]) (Thanks @yotsuda!)
- Update PowerShell Profile DSC resource manifests to allow null for content ([#26929][26929])
- DSC v3 resource for PowerShell Profile ([#26157][26157])
- Dynamically evaluate width of `LastWriteTime` for formatting output on Unix ([#24624][24624])
  (Thanks @MathiasMagnus!)
- Fix formatting to properly handle the `Reset` VT sequences that appear in the middle of a string
  ([#26424][26424])
- Fix `Invoke-RestMethod` to support read-only files in multipart form data ([#26454][26454])
  (Thanks @yotsuda!)
- Fix memory leak in `GetFileShares` ([#25896][25896]) (Thanks @xtqqczze!)
- Fix **NOTES** section formatting in comment-based help ([#26512][26512]) (Thanks @yotsuda!)
- Fix `Test-Json` false positive errors when using `oneOf` or `anyOf` in schema ([#26618][26618])
  (Thanks @yotsuda!)
- Fix the CLR internal error and null ref exception when running `Show-Command` with PowerShell API
  ([#26669][26669])
- Handle null reference exception in `CsvCommands.cs`: `ConvertPSObjectToCSV` ([#26144][26144])
  (Thanks @mikkas456!)
- Improve `ValidateLength` error message consistency and refactor validation tests ([#25806][25806])
  (Thanks @jorgeasaurus!)
- Support **TargetObject** position in `ParserErrors` ([#26649][26649]) (Thanks @jborean93!)
- Add verbose message to `Get-Service` when properties cannot be returned ([#27109][27109]) (Thanks
  @reabr!)
- Fix `Remove-Item` confirmation message to use provider path instead ([#27123][27123]) (Thanks
  @scuzqy!)
- PSStyle: validate background index against `BackgroundColorMap` ([#27106][27106]) (Thanks
  @cuiweixie!)

## Engine improvements

- Fix up default value for parameters with the `in` modifier ([#26785][26785]) (Thanks @jborean93!)
- Fix `WSManInstance` COM interface with `ResourceURI` ([#26692][26692]) (Thanks @jborean93!)
- Refactor the module path construction code to make it more robust and easier to maintain
  ([#26565][26565])
- Fix checks for local user config file paths ([#26269][26269])
- Delay update notification for one week to ensure all packages become available ([#27095][27095])
- Disable AMSI content logging in release ([#26235][26235]) (Thanks @xtqqczze!)
- Add property and event for debug attach ([#25788][25788]) (Thanks @jborean93!)
- Enable usage in AppContainers ([#27266][27266])

## Experimental features

PowerShell 7.7 includes the following experimental features.

- [PSLoadAssemblyFromNativeCode][01] - Load assemblies from native code
- [PSSerializeJSONLongEnumAsNumber][03] - `ConvertTo-Json` now treats large enums as numbers
- [PSProfileDSCResource][02] - Add DSC v3 resource for PowerShell Profiles

<!-- end of content -->
<!-- reference links -->
[01]: ../learn/experimental-features.md#psloadassemblyfromnativecode
[02]: ../learn/experimental-features.md#psprofiledscresource
[03]: ../learn/experimental-features.md#psserializejsonlongenumasnumber
[04]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/preview.md

[21219]: https://github.com/PowerShell/PowerShell/pull/21219
[24624]: https://github.com/PowerShell/PowerShell/pull/24624
[25788]: https://github.com/PowerShell/PowerShell/pull/25788
[25806]: https://github.com/PowerShell/PowerShell/pull/25806
[25896]: https://github.com/PowerShell/PowerShell/pull/25896
[26140]: https://github.com/PowerShell/PowerShell/pull/26140
[26141]: https://github.com/PowerShell/PowerShell/pull/26141
[26144]: https://github.com/PowerShell/PowerShell/pull/26144
[26157]: https://github.com/PowerShell/PowerShell/pull/26157
[26235]: https://github.com/PowerShell/PowerShell/pull/26235
[26252]: https://github.com/PowerShell/PowerShell/pull/26252
[26269]: https://github.com/PowerShell/PowerShell/pull/26269
[26424]: https://github.com/PowerShell/PowerShell/pull/26424
[26454]: https://github.com/PowerShell/PowerShell/pull/26454
[26457]: https://github.com/PowerShell/PowerShell/pull/26457
[26460]: https://github.com/PowerShell/PowerShell/pull/26460
[26463]: https://github.com/PowerShell/PowerShell/pull/26463
[26469]: https://github.com/PowerShell/PowerShell/pull/26469
[26472]: https://github.com/PowerShell/PowerShell/pull/26472
[26474]: https://github.com/PowerShell/PowerShell/pull/26474
[26479]: https://github.com/PowerShell/PowerShell/pull/26479
[26482]: https://github.com/PowerShell/PowerShell/pull/26482
[26483]: https://github.com/PowerShell/PowerShell/pull/26483
[26485]: https://github.com/PowerShell/PowerShell/pull/26485
[26512]: https://github.com/PowerShell/PowerShell/pull/26512
[26514]: https://github.com/PowerShell/PowerShell/pull/26514
[26515]: https://github.com/PowerShell/PowerShell/pull/26515
[26552]: https://github.com/PowerShell/PowerShell/pull/26552
[26565]: https://github.com/PowerShell/PowerShell/pull/26565
[26618]: https://github.com/PowerShell/PowerShell/pull/26618
[26649]: https://github.com/PowerShell/PowerShell/pull/26649
[26668]: https://github.com/PowerShell/PowerShell/pull/26668
[26669]: https://github.com/PowerShell/PowerShell/pull/26669
[26692]: https://github.com/PowerShell/PowerShell/pull/26692
[26719]: https://github.com/PowerShell/PowerShell/pull/26719
[26785]: https://github.com/PowerShell/PowerShell/pull/26785
[26929]: https://github.com/PowerShell/PowerShell/pull/26929
[27095]: https://github.com/PowerShell/PowerShell/pull/27095
[27106]: https://github.com/PowerShell/PowerShell/pull/27106
[27109]: https://github.com/PowerShell/PowerShell/pull/27109
[27123]: https://github.com/PowerShell/PowerShell/pull/27123
[27266]: https://github.com/PowerShell/PowerShell/pull/27266
