---
title: What's New in PowerShell 7.4
description: New features and changes released in PowerShell 7.4
ms.date: 06/19/2024
---

# What's New in PowerShell 7.4

PowerShell 7.4 includes the following features, updates, and breaking changes. PowerShell 7.4 is
built on .NET 8.0.0.

For a complete list of changes, see the [CHANGELOG][chg] in the GitHub repository.

## Breaking changes

- Nano server docker images aren't available for this release
- Added the **ProgressAction** parameter to the Common Parameters
- Update some PowerShell APIs to throw **ArgumentException** instead of **ArgumentNullException**
  when the argument is an empty string ([#19215][19215]) (Thanks @xtqqczze!)
- Remove code related to `#requires -pssnapin` ([#19320][19320])
- `Test-Json` now uses JsonSchema.NET instead of Newtonsoft.Json.Schema.
  - With this change, `Test-Json` no longer supports the older Draft 4 schemas. ([#18141][18141])
    (Thanks @gregsdennis!). For more information about JSON schemas, see [JSON Schema][14]
    documentation. This also breaks `Test-Json` for JSON and JSONC files with comments.
  - `ConvertFrom-Json` support still uses Newtonsoft.Json.Schema so it can convert JSON files
    with comments.
- Output from `Test-Connection` now includes more detailed information about TCP connection tests
- .NET introduced changes that affected `Test-Connection`. The cmdlet now returns an error about
  the need to use `sudo` on Linux platforms when using a custom buffer size ([#20369][20369])
- Experimental feature [PSNativeCommandPreserveBytePipe][10] is now mainstream. PowerShell now
  preserves the byte-stream data when redirecting the **stdout** stream of a native command to a
  file or when piping byte-stream data to the stdin stream of a native command.
- Change how relative paths in `Resolve-Path` are handled when using the **RelativeBasePath**
  parameter ([#19755][19755]) (Thanks @MartinGC94!)
- Remove unused PSv2 code - removes TabExpansion function ([#18337][18337])

## Installer updates

The Windows MSI package now provides an option to disable PowerShell telemetry during installation.
For more information, see [Install the msi package from the command line][01].

## Updated versions of PSResourceGet and PSReadLine

PowerShell 7.4 includes **Microsoft.PowerShell.PSResourceGet** v1.0.1. This module is installed
side-by-side with **PowerShellGet** v2.2.5 and **PackageManagement** v1.4.8.1. For more information,
see the documentation for [Microsoft.PowerShell.PSResourceGet][12].

PowerShell 7.4 now includes **PSReadLine** v2.3.4. For more information, see the documentation for
[PSReadLine][13].

## Tab completion improvements

Many thanks to **@MartinGC94** and others for all their work to improve tab completion.

- Fix issue when completing the first command in a script with an empty array expression
  ([#18355][18355])
- Fix positional argument completion ([#17796][17796])
- Prioritize the default parameter set when completing positional arguments ([#18755][18755])
- Improve pseudo binding for dynamic parameters ([#18030][18030])
- Improve type inference of hashtable keys ([#17907][17907])
- Fix type inference error for empty return statements ([#18351][18351])
- Improve type inference for Get-Random ([#18972][18972])
- Fix type inference for all scope variables ([#18758][18758])
- Improve enumeration of inferred types in pipeline ([#17799][17799])
- Add completion for values in comparisons when comparing Enums ([#17654][17654])
- Add property assignment completion for enums ([#19178][19178])
- Fix completion for PSCustomObject variable properties ([#18682][18682])
- Fix member completion in attribute argument ([#17902][17902])
- Exclude redundant parameter aliases from completion results ([#19382][19382])
- Fix class member completion for classes with base types ([#19179][19179])
- Add completion for Using keywords ([#16514][18758])
- Fix TabExpansion2 variable leak when completing variables ([#18763][18763])
- Enable completion of variables across ScriptBlock scopes ([#19819][19819])
- Fix completion of the foreach statement variable ([#19814][19814])
- Fix variable type inference precedence ([#18691][18691])
- Fix member completion for PowerShell Enum class ([#19740][19740])
- Fix parsing for array literals in index expressions in method calls ([#19224][19224])
- Improve path completion ([#19489][19489])
- Fix an indexing out of bound error in CompleteInput for empty script input ([#19501][19501])
- Improve variable completion performance ([#19595][19595])
- Improve Hashtable key completion for type constrained variable assignments, nested Hashtables and
  more ([#17660][17660])
- Infer external application output as strings ([#19193][19193])
- Update parameter completion for enums to exclude values not allowed by `ValidateRange` attributes
  ([#17750][17750]) (Thanks @fflaten!).
- Fix dynamic parameter completion ([#19510][19510])
- Add completion for variables assigned by the Data statement ([#19831][19831])
- Fix expanding tilde (`~`) on Windows systems to `$home` to prevent breaking use cases with native
  commands ([#21529][21529])

## Web cmdlet improvements

Many thanks to **@CarloToso** and others for all the work on improving web cmdlets.

- Fix decompression in web cmdlets to include Brotli ([#17955][17955]) (Thanks @iSazonov!)
- Webcmdlets add 308 to redirect codes and small cleanup ([#18536][18536])
- Complete the progress bar rendering in Invoke-WebRequest when downloading is complete or cancelled
  ([#18130][18130])
- Web cmdlets get **Retry-After** interval from response headers if the status code is 429
  ([#18717][18717])
- Web cmdlets set default charset encoding to UTF8 ([#18219][18219])
- Preserve WebSession.MaximumRedirection from changes ([#19190][19190])
- WebCmdlets parse XML declaration to get encoding value, if present. ([#18748][18748])
- Fix using xml -Body in webcmdlets without an encoding ([#19281][19281])
- Adjust PUT method behavior to POST one for default content type in WebCmdlets ([#19152][19152])
- Take into account ContentType from Headers in WebCmdlets ([#19227][19227])
- Allow to preserve the original HTTP method by adding **-PreserveHttpMethodOnRedirect** to Web
  cmdlets ([#18894][18894])
- Webcmdlets display an error on https to http redirect ([#18595][18595])
- Add **AllowInsecureRedirect** switch to Web cmdlets ([#18546][18546])
- Improve verbose message in web cmdlets when content length is unknown ([#19252][19252])
- Build the relative URI for links from the response in `Invoke-WebRequest` ([#19092][19092])
- Fix redirection for `-CustomMethod POST` in WebCmdlets ([#19111][19111])
- Dispose previous response in Webcmdlets ([#19117][19117])
- Improve `Invoke-WebRequest` xml and json errors format ([#18837][18837])
- Add ValidateNotNullOrEmpty to **OutFile** and **InFile** parameters of WebCmdlets
  ([#19044][19044])
- HttpKnownHeaderNames update headers list ([#18947][18947])
- `Invoke-RestMethod -FollowRelLink` fix links containing commas ([#18829][18829])
- Fix bug with managing redirection and KeepAuthorization in Web cmdlets ([#18902][18902])
- Add **StatusCode** to **HttpResponseException** ([#18842][18842])
- Support HTTP persistent connections in Web Cmdlets ([#19249][19249]) (Thanks @stevenebutler!)
- Small cleanup `Invoke-RestMethod` ([#19490][19490])
- Improve the verbose message of WebCmdlets to show correct HTTP version ([#19616][19616])
- Add **FileNameStar** to **MultipartFileContent** in WebCmdlets ([#19467][19467])
- Fix HTTP status from 409 to 429 for WebCmdlets to get retry interval from Retry-After header.
  ([#19622][19622]) (Thanks @mkht!)
- Change `-TimeoutSec` to `-ConnectionTimeoutSeconds` and add `-OperationTimeoutSeconds` to web
  cmdlets ([#19558][19558]) (Thanks @stevenebutler!) Other cmdlets
- Support Ctrl+c when connection hangs while reading data in WebCmdlets ([#19330][19330]) (Thanks
  @stevenebutler!)
- Support Unix domain socket in WebCmdlets ([#19343][19343])

## Other cmdlet improvements

- `Test-Connection` now returns error about the need to use `sudo` on Linux platforms when using a
  custom buffer size ([#20369][20369])
- Add output types to Format commands ([#18746][18746]) (Thanks @MartinGC94!)
- Add output type attributes for `Get-WinEvent` ([#17948][17948]) (Thanks @MartinGC94!)
- Add **Path** and **LiteralPath** parameters to `Test-Json` cmdlet ([#19042][19042]) (Thanks
  @ArmaanMcleod!)
- Add **NoHeader** parameter to `ConvertTo-Csv` and `Export-Csv` cmdlets ([#19108][19108]) (Thanks
  @ArmaanMcleod!)
- Add **Confirm** and **WhatIf** parameters to `Stop-Transcript`([#18731][18731]) (Thanks
  @JohnLBevan!)
- Add **FuzzyMinimumDistance** parameter to `Get-Command` ([#18261][18261])
- Make **Encoding** parameter able to take `ANSI` encoding in PowerShell ([#19298][19298]) (Thanks
  @CarloToso!)
- Add progress to `Copy-Item` ([#18735][18735])
- `Update-Help` now reports an error when using implicit culture on non-US systems.
  ([#17780][17780]) (Thanks @dkaszews!)
- Don't require activity when creating a completed progress record ([#18474][18474]) (Thanks
  @MartinGC94!)
- Disallow negative values for `Get-Content` cmdlet parameters `-Head` and `-Tail`
  ([#19715][19715]) (Thanks @CarloToso!)
- Make `Update-Help` throw proper error when current culture isn't associated with a language
  ([#19765][19765]) (Thanks @josea!)
- Allow combining of `-Skip` and `-SkipLast` parameters in `Select-Object` cmdlet.
  ([#18849][18849]) (Thanks @ArmaanMcleod!)
- Add `Get-SecureRandom` cmdlet ([#19587][19587])
- `Set-Clipboard -AsOSC52` for remote usage ([#18222][18222]) (Thanks @dkaszews!)
- Speed up `Resolve-Path` relative path resolution ([#19171][19171]) (Thanks @MartinGC94!)
- Added the switch parameter `-CaseInsensitive` to `Select-Object` and `Get-Unique` cmdlets
  ([#19683][19683]) (Thanks @ArmaanMcleod!)
- `Restart-Computer` and `Stop-Computer` should fail with error when not running via sudo on Unix
  ([#19824][19824])

## Engine improvements

Updates to `$PSStyle`

- Adds **Dim** and **DimOff** properties ([#18653][18653])
- Added static methods to the **PSStyle** class that map foreground and background **ConsoleColor**
  values to ANSI escape sequences ([#17938][17938])
- Table headers for calculated fields are formatted in italics by default
- Add support of respecting `$PSStyle.OutputRendering` on the remote host ([#19601][19601])
- Updated telemetry data to include use of `CrescendoBuilt` modules ([#20371][20371])

Other Engine updates

- Make PowerShell class not affiliate with Runspace when declaring the `NoRunspaceAffinity`
  attribute ([#18138][18138])
- Add the `ValidateNotNullOrWhiteSpace` attribute ([#17191][17191]) (Thanks @wmentha!)
- Add `sqlcmd` to the list for legacy argument passing ([#18559][18559])
- Add the function `cd~` ([#18308][18308]) (Thanks @GigaScratch!)
- Fix array type parsing in generic types ([#19205][19205]) (Thanks @MartinGC94!)
- Fix wildcard globbing in root of device paths ([#19442][19442]) (Thanks @MartinGC94!)
- Add a public API for getting locations of PSModulePath elements ([#19422][19422])
- Fix incorrect string to type conversion ([#19560][19560]) (Thanks @MartinGC94!)
- Fix slow execution when many breakpoints are used ([#14953][14953]) (Thanks @nohwnd!)
- Remove code related to `#requires -pssnapin` ([#19320][19320])

## Experimental Features

PowerShell 7.4 introduces the following experimental features:

- [PSFeedbackProvider][06] - Replaces the hard-coded suggestion framework with an extensible
  feedback provider.
  - This feature also adds the **FeedbackName**, **FeedbackText**, and **FeedbackAction** properties
    to `$PSStyle.Formatting` that allow you to change the formatting of feedback messages.
- [PSModuleAutoLoadSkipOfflineFiles][07] - Module discovery now skips over files that are marked by
  cloud providers as not fully on disk.
- [PSCommandWithArgs][05] - Add support for passing arguments to commands as a single string

The following experimental features became mainstream:

- [PSConstrainedAuditLogging][02]
- [PSCustomTableHeaderLabelDecoration][08]
- [PSNativeCommandErrorActionPreference][10]
- [PSNativeCommandPreserveBytePipe][11]
- [PSWindowsNativeCommandArgPassing][09]

PowerShell 7.4 changed the following experimental features:

- [PSCommandNotFoundSuggestion][04] - This feature now uses an extensible feedback provider rather
  than hard-coded suggestions ([#18726][18726])

For more information about the Experimental Features, see [Using Experimental Features][03].

<!-- end of content -->
<!-- reference links -->
[01]: ../install/installing-powershell-on-windows.md
[02]: ../security/application-control.md#wdac-policy-auditing
[03]: ../learn/experimental-features.md
[04]: ../learn/experimental-features.md#pscommandnotfoundsuggestion
[05]: ../learn/experimental-features.md#pscommandwithargs
[06]: ../learn/experimental-features.md#psfeedbackprovider
[07]: ../learn/experimental-features.md#psmoduleautoloadskipofflinefiles
[08]: /powershell/module/microsoft.powershell.core/about/about_ansi_terminals
[09]: /powershell/module/microsoft.powershell.core/about/about_preference_variables#psnativecommandargumentpassing
[10]: /powershell/module/microsoft.powershell.core/about/about_preference_variables#psnativecommanduseerroractionpreference
[11]: /powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7.4&preserve-view=true#redirecting-output-from-native-commands
[12]: /powershell/module/microsoft.powershell.psresourceget
[13]: /powershell/module/psreadline
[14]: https://json-schema.org/understanding-json-schema/reference/schema

[chg]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/7.4.md
[14953]: https://github.com/PowerShell/PowerShell/pull/14953
[17191]: https://github.com/PowerShell/PowerShell/pull/17191
[17654]: https://github.com/PowerShell/PowerShell/pull/17654
[17660]: https://github.com/PowerShell/PowerShell/pull/17660
[17750]: https://github.com/PowerShell/PowerShell/pull/17750
[17780]: https://github.com/PowerShell/PowerShell/pull/17780
[17796]: https://github.com/PowerShell/PowerShell/pull/17796
[17799]: https://github.com/PowerShell/PowerShell/pull/17799
[17902]: https://github.com/PowerShell/PowerShell/pull/17902
[17907]: https://github.com/PowerShell/PowerShell/pull/17907
[17938]: https://github.com/PowerShell/PowerShell/pull/17938
[17948]: https://github.com/PowerShell/PowerShell/pull/17948
[17955]: https://github.com/PowerShell/PowerShell/pull/17955
[18030]: https://github.com/PowerShell/PowerShell/pull/18030
[18130]: https://github.com/PowerShell/PowerShell/pull/18130
[18138]: https://github.com/PowerShell/PowerShell/pull/18138
[18141]: https://github.com/PowerShell/PowerShell/pull/18141
[18219]: https://github.com/PowerShell/PowerShell/pull/18219
[18222]: https://github.com/PowerShell/PowerShell/pull/18222
[18261]: https://github.com/PowerShell/PowerShell/pull/18261
[18308]: https://github.com/PowerShell/PowerShell/pull/18308
[18337]: https://github.com/PowerShell/PowerShell/pull/18337
[18351]: https://github.com/PowerShell/PowerShell/pull/18351
[18355]: https://github.com/PowerShell/PowerShell/pull/18355
[18474]: https://github.com/PowerShell/PowerShell/pull/18474
[18536]: https://github.com/PowerShell/PowerShell/pull/18536
[18546]: https://github.com/PowerShell/PowerShell/pull/18546
[18559]: https://github.com/PowerShell/PowerShell/pull/18559
[18595]: https://github.com/PowerShell/PowerShell/pull/18595
[18653]: https://github.com/PowerShell/PowerShell/pull/18653
[18682]: https://github.com/PowerShell/PowerShell/pull/18682
[18691]: https://github.com/PowerShell/PowerShell/pull/18691
[18717]: https://github.com/PowerShell/PowerShell/pull/18717
[18726]: https://github.com/PowerShell/PowerShell/pull/18726
[18731]: https://github.com/PowerShell/PowerShell/pull/18731
[18735]: https://github.com/PowerShell/PowerShell/pull/18735
[18746]: https://github.com/PowerShell/PowerShell/pull/18746
[18748]: https://github.com/PowerShell/PowerShell/pull/18748
[18755]: https://github.com/PowerShell/PowerShell/pull/18755
[18758]: https://github.com/PowerShell/PowerShell/pull/18758
[18763]: https://github.com/PowerShell/PowerShell/pull/18763
[18829]: https://github.com/PowerShell/PowerShell/pull/18829
[18837]: https://github.com/PowerShell/PowerShell/pull/18837
[18842]: https://github.com/PowerShell/PowerShell/pull/18842
[18849]: https://github.com/PowerShell/PowerShell/pull/18849
[18894]: https://github.com/PowerShell/PowerShell/pull/18894
[18902]: https://github.com/PowerShell/PowerShell/pull/18902
[18947]: https://github.com/PowerShell/PowerShell/pull/18947
[18972]: https://github.com/PowerShell/PowerShell/pull/18972
[19042]: https://github.com/PowerShell/PowerShell/pull/19042
[19044]: https://github.com/PowerShell/PowerShell/pull/19044
[19092]: https://github.com/PowerShell/PowerShell/pull/19092
[19108]: https://github.com/PowerShell/PowerShell/pull/19108
[19111]: https://github.com/PowerShell/PowerShell/pull/19111
[19117]: https://github.com/PowerShell/PowerShell/pull/19117
[19152]: https://github.com/PowerShell/PowerShell/pull/19152
[19171]: https://github.com/PowerShell/PowerShell/pull/19171
[19178]: https://github.com/PowerShell/PowerShell/pull/19178
[19179]: https://github.com/PowerShell/PowerShell/pull/19179
[19190]: https://github.com/PowerShell/PowerShell/pull/19190
[19193]: https://github.com/PowerShell/PowerShell/pull/19193
[19205]: https://github.com/PowerShell/PowerShell/pull/19205
[19215]: https://github.com/PowerShell/PowerShell/pull/19215
[19224]: https://github.com/PowerShell/PowerShell/pull/19224
[19227]: https://github.com/PowerShell/PowerShell/pull/19227
[19249]: https://github.com/PowerShell/PowerShell/pull/19249
[19252]: https://github.com/PowerShell/PowerShell/pull/19252
[19281]: https://github.com/PowerShell/PowerShell/pull/19281
[19298]: https://github.com/PowerShell/PowerShell/pull/19298
[19320]: https://github.com/PowerShell/PowerShell/pull/19320
[19330]: https://github.com/PowerShell/PowerShell/pull/19330
[19343]: https://github.com/PowerShell/PowerShell/pull/19343
[19382]: https://github.com/PowerShell/PowerShell/pull/19382
[19422]: https://github.com/PowerShell/PowerShell/pull/19422
[19442]: https://github.com/PowerShell/PowerShell/pull/19442
[19467]: https://github.com/PowerShell/PowerShell/pull/19467
[19489]: https://github.com/PowerShell/PowerShell/pull/19489
[19490]: https://github.com/PowerShell/PowerShell/pull/19490
[19501]: https://github.com/PowerShell/PowerShell/pull/19501
[19510]: https://github.com/PowerShell/PowerShell/pull/19510
[19558]: https://github.com/PowerShell/PowerShell/pull/19558
[19560]: https://github.com/PowerShell/PowerShell/pull/19560
[19587]: https://github.com/PowerShell/PowerShell/pull/19587
[19595]: https://github.com/PowerShell/PowerShell/pull/19595
[19601]: https://github.com/PowerShell/PowerShell/pull/19601
[19616]: https://github.com/PowerShell/PowerShell/pull/19616
[19622]: https://github.com/PowerShell/PowerShell/pull/19622
[19683]: https://github.com/PowerShell/PowerShell/pull/19683
[19715]: https://github.com/PowerShell/PowerShell/pull/19715
[19740]: https://github.com/PowerShell/PowerShell/pull/19740
[19755]: https://github.com/PowerShell/PowerShell/pull/19755
[19765]: https://github.com/PowerShell/PowerShell/pull/19765
[19814]: https://github.com/PowerShell/PowerShell/pull/19814
[19819]: https://github.com/PowerShell/PowerShell/pull/19819
[19824]: https://github.com/PowerShell/PowerShell/pull/19824
[19831]: https://github.com/PowerShell/PowerShell/pull/19831
[20369]: https://github.com/PowerShell/PowerShell/pull/20369
[20371]: https://github.com/PowerShell/PowerShell/pull/20371
[21529]: https://github.com/PowerShell/PowerShell/pull/21529
