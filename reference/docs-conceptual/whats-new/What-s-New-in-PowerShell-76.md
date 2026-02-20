---
title: What's New in PowerShell 7.6
description: New features and changes released in PowerShell 7.6
ms.date: 02/20/2026
---

# What's New in PowerShell 7.6

PowerShell 7.6-rc1 includes the following features, updates, and breaking changes. PowerShell
7.6 is built on .NET 10.0.

For a complete list of changes, see the [CHANGELOG][log] in the GitHub repository.

## Updated modules

PowerShell 7.6-rc1 includes the following updated modules:

- **Microsoft.PowerShell.PSResourceGet** v1.2.0-rc3
- **PSReadLine** v2.4.5
- **Microsoft.PowerShell.ThreadJob** v2.2.0

## Breaking Changes

- The **Microsoft.PowerShell.ThreadJob** replaces the **ThreadJob** module. The `Start-ThreadJob`
  cmdlet hasn't changed, so there shouldn't be an impact unless you have scripts that use the module
  qualified name. If you are using the module qualified name, update the name to
  `Microsoft.PowerShell.ThreadJob\Start-ThreadJob`.
- Fix `WildcardPattern.Escape` to escape lone backticks correctly ([#25211][25211]) (Thanks
  @ArmaanMcleod!)
- Convert `-ChildPath` parameter to `string[]` for `Join-Path` cmdlet ([#24677][24677]) (Thanks
  @ArmaanMcleod!)
- Remove trailing space from event source name ([#24192][24192]) (Thanks @MartinGC94!)

## Tab completion improvements

- Properly Expand Aliases to their actual ResolvedCommand ([#26571][26571]) (Thanks @kilasuit!)
- Use parameter `HelpMessage` for tool tip in parameter completion ([#25108][25108]) (Thanks
  @jborean93!)
- Remove duplicate modules from completion results ([#25538][25538]) (Thanks @MartinGC94!)
- Add completion for variables assigned in `ArrayLiteralAst` and `ParenExpressionAst`
  ([#25303][25303]) (Thanks @MartinGC94!)
- Fix tab completion for env/function variables ([#25346][25346]) (Thanks @jborean93!)
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

- Add `-Delimiter` parameter to `Get-Clipboard` ([#26572][26572]) (Thanks @MartinGC94!)
- Fix Out-GridView by replacing use of obsolete BinaryFormatter with custom implementation
  ([#25497][25497]) (Thanks @mawosoft!)
- Improve verbose and debug logging level messaging in web cmdlets ([#25510][25510]) (Thanks
  @JustinGrote!)
- Improve debug logging of Web cmdlet request and response ([#25479][25479]) (Thanks @JustinGrote!)
- Add the parameter `Register-ArgumentCompleter -NativeFallback` to support registering a cover-all
  completer for native commands ([#25230][25230])
- Treat `-Target` as literal in `New-Item` ([#25186][25186]) (Thanks @GameMicrowave!)
- Update PATH environment variable for package manager executable on Windows ([#25847][25847])
- Update `Get-Service` to ignore common errors when retrieving non-critical properties for a service
  ([#24245][24245]) (Thanks @jborean93!)
- Add single/double quote support for `Join-String` Argument Completer ([#25283][25283]) (Thanks
  @ArmaanMcleod!)
- Remove `IsScreenReaderActive()` check from `ConsoleHost` ([#26118][26118])
- Improve the `$using` expression support in `Invoke-Command` ([#24025][24025]) (Thanks @jborean93!)
- Change the default feedback provider timeout from 300ms to 1000ms ([#25910][25910])
- Add support for thousands separators in `[bigint]` casting ([#25396][25396]) (Thanks
  @AbishekPonmudi!)
- Add `MethodInvocation` trace for overload tracing ([#21320][21320]) (Thanks @jborean93!)
- Fix `ConvertFrom-Json` to ignore comments inside array literals ([#14553][14553])
  ([#26050][26050]) (Thanks @MatejKafka!)
- Fix `-Debug` to not trigger the `ShouldProcess` prompt ([#26081][26081])
- Fix `Write-Host` to respect `OutputRendering = PlainText` ([#21188][21188])
- Fix debug tracing error with magic extents ([#25726][25726]) (Thanks @jborean93!)
- Fix quoting in completion if the path includes a double quote character ([#25631][25631]) (Thanks
  @MartinGC94!)
- Fix the common parameter `-ProgressAction` for advanced functions ([#24591][24591]) (Thanks
  @cmkb3!)
- Fix the `NullReferenceException` when writing progress records to console from multiple threads
  ([#25440][25440]) (Thanks @kborowinski!)
- Use absolute path in `FileSystemProvider.CreateDirectory` ([#24615][24615]) (Thanks @Tadas!)
- Make inherited protected internal instance members accessible in PowerShell class scope
  ([#25245][25245]) (Thanks @mawosoft!)
- Add internal methods to check Preferences ([#25514][25514]) (Thanks @iSazonov!)
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

- Fix a regression in the API `CompletionCompleters.CompleteFilename()` that causes null reference
  exception ([#26487][26487])
- Close pipe client handles after creating the child ssh process ([#26564][26564])
- Update the **PSDiagnostics** module to manage the PowerShellCore provider in PowerShell 7
  ([#25590][25590])
- Allow opt-out of the named-pipe listener using the environment variable
  `POWERSHELL_DIAGNOSTICS_OPTOUT` ([#26086][26086])
- Ensure that socket timeouts are set only during the token validation ([#26066][26066])
- Fix `stderr` output of console host to respect `NO_COLOR` ([#24391][24391])
- Update PSRP protocol to deprecate session key exchange between newer client and server
  ([#25774][25774])
- Fix the `ssh` PATH check in `SSHConnectionInfo` when the default Runspace is not available
  ([#25780][25780]) (Thanks @jborean93!)
- Adding hex format for native command exit codes ([#21067][21067]) (Thanks @sba923!)
- Fix infinite loop crash in variable type inference ([#25696][25696]) (Thanks @MartinGC94!)
- Add `PSForEach` and `PSWhere` as aliases for the PowerShell intrinsic methods `Where` and
  `Foreach` ([#25511][25511]) (Thanks @powercode!)
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
- Use script filepath when completing relative paths for using statements ([#20017][20017]) (Thanks
  @MartinGC94!)
- Allow DSC parsing through OS architecture translation layers ([#24852][24852]) (Thanks @bdeb1337!)

## Experimental features

PowerShell 7.6-preview.6 includes the following changes to experimental features.

The following features have been converted to mainstream features:

- [PSFeedbackProvider][01]
- [PSNativeWindowsTildeExpansion][02]
- [PSRedirectToVariable][04]
- [PSSubsystemPluginModel][06]

This release includes the following experimental features:

- [PSSerializeJSONLongEnumAsNumber][05] - `ConvertTo-Json` now treats large enums as numbers
- [PSProfileDSCResource][03] - Add DSC v3 resource for PowerShell Profiles

<!-- end of content -->
<!-- reference links -->
[01]: ../learn/experimental-features.md#psfeedbackprovider
[02]: ../learn/experimental-features.md#psnativewindowstildeexpansion
[03]: ../learn/experimental-features.md#psprofiledscresource
[04]: ../learn/experimental-features.md#psredirecttovariable
[05]: ../learn/experimental-features.md#psserializejsonlongenumasnumber
[06]: ../learn/experimental-features.md#pssubsystempluginmodel

[log]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/preview.md

[14553]: https://github.com/PowerShell/PowerShell/pull/14553
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
[21067]: https://github.com/PowerShell/PowerShell/pull/21067
[21113]: https://github.com/PowerShell/PowerShell/pull/21113
[21115]: https://github.com/PowerShell/PowerShell/pull/21115
[21117]: https://github.com/PowerShell/PowerShell/pull/21117
[21131]: https://github.com/PowerShell/PowerShell/pull/21131
[21134]: https://github.com/PowerShell/PowerShell/pull/21134
[21137]: https://github.com/PowerShell/PowerShell/pull/21137
[21143]: https://github.com/PowerShell/PowerShell/pull/21143
[21188]: https://github.com/PowerShell/PowerShell/pull/21188
[21320]: https://github.com/PowerShell/PowerShell/pull/21320
[24025]: https://github.com/PowerShell/PowerShell/pull/24025
[24192]: https://github.com/PowerShell/PowerShell/pull/24192
[24194]: https://github.com/PowerShell/PowerShell/pull/24194
[24245]: https://github.com/PowerShell/PowerShell/pull/24245
[24391]: https://github.com/PowerShell/PowerShell/pull/24391
[24591]: https://github.com/PowerShell/PowerShell/pull/24591
[24615]: https://github.com/PowerShell/PowerShell/pull/24615
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
[25108]: https://github.com/PowerShell/PowerShell/pull/25108
[25112]: https://github.com/PowerShell/PowerShell/pull/25112
[25122]: https://github.com/PowerShell/PowerShell/pull/25122
[25129]: https://github.com/PowerShell/PowerShell/pull/25129
[25172]: https://github.com/PowerShell/PowerShell/pull/25172
[25177]: https://github.com/PowerShell/PowerShell/pull/25177
[25186]: https://github.com/PowerShell/PowerShell/pull/25186
[25206]: https://github.com/PowerShell/PowerShell/pull/25206
[25211]: https://github.com/PowerShell/PowerShell/pull/25211
[25224]: https://github.com/PowerShell/PowerShell/pull/25224
[25230]: https://github.com/PowerShell/PowerShell/pull/25230
[25245]: https://github.com/PowerShell/PowerShell/pull/25245
[25283]: https://github.com/PowerShell/PowerShell/pull/25283
[25303]: https://github.com/PowerShell/PowerShell/pull/25303
[25346]: https://github.com/PowerShell/PowerShell/pull/25346
[25396]: https://github.com/PowerShell/PowerShell/pull/25396
[25440]: https://github.com/PowerShell/PowerShell/pull/25440
[25479]: https://github.com/PowerShell/PowerShell/pull/25479
[25497]: https://github.com/PowerShell/PowerShell/pull/25497
[25510]: https://github.com/PowerShell/PowerShell/pull/25510
[25511]: https://github.com/PowerShell/PowerShell/pull/25511
[25514]: https://github.com/PowerShell/PowerShell/pull/25514
[25538]: https://github.com/PowerShell/PowerShell/pull/25538
[25590]: https://github.com/PowerShell/PowerShell/pull/25590
[25631]: https://github.com/PowerShell/PowerShell/pull/25631
[25696]: https://github.com/PowerShell/PowerShell/pull/25696
[25726]: https://github.com/PowerShell/PowerShell/pull/25726
[25774]: https://github.com/PowerShell/PowerShell/pull/25774
[25780]: https://github.com/PowerShell/PowerShell/pull/25780
[25847]: https://github.com/PowerShell/PowerShell/pull/25847
[25910]: https://github.com/PowerShell/PowerShell/pull/25910
[26050]: https://github.com/PowerShell/PowerShell/pull/26050
[26066]: https://github.com/PowerShell/PowerShell/pull/26066
[26081]: https://github.com/PowerShell/PowerShell/pull/26081
[26086]: https://github.com/PowerShell/PowerShell/pull/26086
[26118]: https://github.com/PowerShell/PowerShell/pull/26118
[26487]: https://github.com/PowerShell/PowerShell/pull/26487
[26564]: https://github.com/PowerShell/PowerShell/pull/26564
[26571]: https://github.com/PowerShell/PowerShell/pull/26571
[26572]: https://github.com/PowerShell/PowerShell/pull/26572
