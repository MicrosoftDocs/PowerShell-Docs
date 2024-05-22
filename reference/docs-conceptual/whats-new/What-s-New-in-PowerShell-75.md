---
title: What's New in PowerShell 7.5
description: New features and changes released in PowerShell 7.5
ms.date: 05/16/2024
---

# What's New in PowerShell 7.5

PowerShell 7.5-preview.3 includes the following features, updates, and breaking changes. PowerShell
7.5 is built on .NET 9.0.0-preview.3.

For a complete list of changes, see the [CHANGELOG][chg] in the GitHub repository.

## Breaking Changes

- Fix `-OlderThan` and `-NewerThan` parameters for `Test-Path` when using `PathType` and date range
  ([#20942][20942]) (Thanks @ArmaanMcleod!)
  - Previously `-OlderThan` would be ignored if specified together
- Change `New-FileCatalog -CatalogVersion` default to 2 ([#20428][20428]) (Thanks @ThomasNieto!)
- Block getting help from network locations in restricted remoting sessions ([#20593][20593])
- The Windows installer now remembers installation options used and uses them to initialize options
  for the next installation ([#20420][20420]) (Thanks @reduckted!)
- `ConvertTo-Json` now serializes `BigInteger` as a number ([#21000][21000]) (Thanks @jborean93!)

## Updated modules

PowerShell 7.5-preview.3 includes the following updated modules:

- **Microsoft.PowerShell.PSResourceGet** v1.0.5
- **PSReadLine** v2.3.4

## Tab completion improvements

Many thanks to **@ArmaanMcleod** and others for all their work to improve tab completion.

- Fall back to type inference when hashtable key-value cannot be retrieved from safe expression
  ([#21184][21184]) (Thanks @MartinGC94!)
- Fix the regression when doing type inference for `$_` ([#21223][21223]) (Thanks @MartinGC94!)
- Expand `~` to `$home` on Windows with tab completion ([#21529][21529])
- Don't complete when declaring parameter name and class member ([#21182][21182]) (Thanks
  @MartinGC94!)
- Prevent fallback to file completion when tab completing type names ([#20084][20084]) (Thanks
  @MartinGC94)
- Add argument completer to `-Version` for `Set-StrictMode` ([#20554][20554]) (Thanks
  @ArmaanMcleod!)
- Add `-Verb` argument completer for `Get-Verb`/ `Get-Command` and refactor `Get-Verb`
  ([#20286][20286]) (Thanks @ArmaanMcleod)
- Add `-Verb` argument completer for `Start-Process` ([#20415][20415]) (Thanks @ArmaanMcleod)
- Add `-Scope` argument completer for `*-Variable`, `*-Alias` & `*-PSDrive` commands
  ([#20451][20451]) (Thanks @ArmaanMcleod)
- Add `-Module` completion for `Save-Help`/`Update-Help` commands ([#20678][20678]) (Thanks
  @ArmaanMcleod)

## Web Cmdlets improvements

- Fix `Invoke-WebRequest` to report correct size when `-Resume` is specified ([#20207][20207])
  (Thanks @LNKLEO!)
- Fix Web Cmdlets to allow `WinForm` apps to work correctly ([#20606][20606])

## Other cmdlet improvements

- `Get-Process`: Remove admin requirement for `-IncludeUserName` ([#21302][21302]) (Thanks @jborean93!)
- Fix `Test-Path -IsValid` to check for invalid path and filename characters ([#21358][21358])
- Add `RecommendedAction` to `ConciseView` of the error reporting ([#20826][20826]) (Thanks @JustinGrote!)
- Added progress bar for `Remove-Item` cmdlet ([#20778][20778]) (Thanks @ArmaanMcleod!)
- Fix `Test-Connection` due to .NET 8 changes ([#20369][20369])
- Fix `Get-Service` non-terminating error message to include category ([#20276][20276])
- Add `-Empty` and `-InputObject` parameters to `New-Guid` ([#20014][20014]) (Thanks @CarloToso!)
- Add the alias `r` to the parameter `-Recurse` for the `Get-ChildItem` command ([#20100][20100])
  (Thanks @kilasuit!)
- Add `LP` to `LiteralPath` aliases for functions still missing it ([#20820][20820])
- Add implicit localization fallback to `Import-LocalizedData` ([#19896][19896]) (Thanks
  @chrisdent-de!)
- Add `Aliases` to the properties shown up when formatting the help content of the parameter
  returned by `Get-Help` ([#20994][20994])
- Add `HelpUri` to `Remove-Service` ([#20476][20476])
- Fix completion crash for the SCCM provider (#20815, #20919, #20915) (Thanks @MartinGC94!)
- Fix regression in `Get-Content` when `-Tail 0` and `-Wait` are used together ([#20734][20734])
  (Thanks @CarloToso!)
- Fix `Start-Process -PassThru` to make sure the `ExitCode` property is accessible for the returned
  `Process` object ([#20749][20749]) (Thanks @CodeCyclone!)
- Fix `Group-Object` to use current culture for its output ([#20608][20608])
- Fix `Group-Object` output using interpolated strings ([#20745][20745]) (Thanks @mawosoft!)
- Fix rendering of `DisplayRoot` for network `PSDrive` ([#20793][20793])
- Fix `Copy-Item` progress to only show completed when all files are copied ([#20517][20517])
- Fix UNC path completion regression ([#20419][20419]) (Thanks @MartinGC94!)
- Report error if invalid `-ExecutionPolicy` is passed to `pwsh` ([#20460][20460])
- Add **WinGetCommandNotFound** and **CompletionPredictor** modules to track usage ([#21040][21040])
- Add **DateKind** parameter to `ConvertFrom-Json` ([#20925][20925]) (Thanks @jborean93!)
- Add **DirectoryInfo** to the OutputType for New-Item ([#21126][21126]) (Thanks @MartinGC94!)
- Fix 1 serialization of array values ([#21085][21085]) (Thanks @jborean93!)

## Engine improvements

- Add telemetry to check for specific tags when importing a module ([#20371][20371])
- Add `PSAdapter` and `ConsoleGuiTools` to module load telemetry allowlist ([#20641][20641])
- Add Winget module to track usage ([#21040][21040])
- Ensure the filename is not null when logging WDAC ETW events ([#20910][20910]) (Thanks
  @jborean93!)
- Fix four regressions introduced by the WDAC logging feature ([#20913][20913])
- Leave the input, output, and error handles unset when they are not redirected ([#20853][20853])
- Fix implicit remoting proxy cmdlets to act on common parameters ([#20367][20367])
- Include the module version in error messages when module is not found ([#20144][20144]) (Thanks
  @ArmaanMcleod!)
- Fix `unixmode` to handle `setuid` and `sticky` when file is not an executable ([#20366][20366])
- Fix using assembly to use Path.Combine when constructing assembly paths ([#21169][21169])
- Validate the value for using namespace during semantic checks to prevent declaring invalid
  namespaces ([#21162][21162])

## Experimental features

- Add tilde expansion for windows native executables ([#20402][20402]) (Thanks @domsleee!)
  For more information, see [PSNativeWindowsTildeExpansion][01]

<!-- end of content -->
<!-- reference links -->
[chg]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/preview.md

[01]: ../learn/experimental-features.md#psnativewindowstildeexpansion

[19896]: https://github.com/PowerShell/PowerShell/pull/19896
[20014]: https://github.com/PowerShell/PowerShell/pull/20014
[20084]: https://github.com/PowerShell/PowerShell/pull/20084
[20100]: https://github.com/PowerShell/PowerShell/pull/20100
[20144]: https://github.com/PowerShell/PowerShell/pull/20144
[20207]: https://github.com/PowerShell/PowerShell/pull/20207
[20276]: https://github.com/PowerShell/PowerShell/pull/20276
[20286]: https://github.com/PowerShell/PowerShell/pull/20286
[20366]: https://github.com/PowerShell/PowerShell/pull/20366
[20367]: https://github.com/PowerShell/PowerShell/pull/20367
[20369]: https://github.com/PowerShell/PowerShell/pull/20369
[20371]: https://github.com/PowerShell/PowerShell/pull/20371
[20402]: https://github.com/PowerShell/PowerShell/pull/20402
[20415]: https://github.com/PowerShell/PowerShell/pull/20415
[20419]: https://github.com/PowerShell/PowerShell/pull/20419
[20420]: https://github.com/PowerShell/PowerShell/pull/20420
[20428]: https://github.com/PowerShell/PowerShell/pull/20428
[20451]: https://github.com/PowerShell/PowerShell/pull/20451
[20460]: https://github.com/PowerShell/PowerShell/pull/20460
[20476]: https://github.com/PowerShell/PowerShell/pull/20476
[20517]: https://github.com/PowerShell/PowerShell/pull/20517
[20554]: https://github.com/PowerShell/PowerShell/pull/20554
[20593]: https://github.com/PowerShell/PowerShell/pull/20593
[20606]: https://github.com/PowerShell/PowerShell/pull/20606
[20608]: https://github.com/PowerShell/PowerShell/pull/20608
[20641]: https://github.com/PowerShell/PowerShell/pull/20641
[20678]: https://github.com/PowerShell/PowerShell/pull/20678
[20734]: https://github.com/PowerShell/PowerShell/pull/20734
[20745]: https://github.com/PowerShell/PowerShell/pull/20745
[20749]: https://github.com/PowerShell/PowerShell/pull/20749
[20778]: https://github.com/PowerShell/PowerShell/pull/20778
[20793]: https://github.com/PowerShell/PowerShell/pull/20793
[20820]: https://github.com/PowerShell/PowerShell/pull/20820
[20826]: https://github.com/PowerShell/PowerShell/pull/20826
[20853]: https://github.com/PowerShell/PowerShell/pull/20853
[20910]: https://github.com/PowerShell/PowerShell/pull/20910
[20913]: https://github.com/PowerShell/PowerShell/pull/20913
[20925]: https://github.com/PowerShell/PowerShell/pull/20925
[20942]: https://github.com/PowerShell/PowerShell/pull/20942
[20994]: https://github.com/PowerShell/PowerShell/pull/20994
[21000]: https://github.com/PowerShell/PowerShell/pull/21000
[21040]: https://github.com/PowerShell/PowerShell/pull/21040
[21085]: https://github.com/PowerShell/PowerShell/pull/21085
[21126]: https://github.com/PowerShell/PowerShell/pull/21126
[21162]: https://github.com/PowerShell/PowerShell/pull/21162
[21169]: https://github.com/PowerShell/PowerShell/pull/21169
[21182]: https://github.com/PowerShell/PowerShell/pull/21182
[21184]: https://github.com/PowerShell/PowerShell/pull/21184
[21223]: https://github.com/PowerShell/PowerShell/pull/21223
[21302]: https://github.com/PowerShell/PowerShell/pull/21302
[21358]: https://github.com/PowerShell/PowerShell/pull/21358
[21529]: https://github.com/PowerShell/PowerShell/pull/21529
