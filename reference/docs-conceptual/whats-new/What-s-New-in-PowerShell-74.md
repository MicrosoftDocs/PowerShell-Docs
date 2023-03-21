---
title: What's New in PowerShell 7.4 (preview)
description: New features and changes released in PowerShell 7.4 (preview)
ms.date: 03/21/2023
---

# What's New in PowerShell 7.4 (preview)

PowerShell 7.4-preview.2 includes the following features, updates, and breaking changes. PowerShell
7.4 is now built on .NET 8.0.0-preview.2.


For a complete list of changes, see the [Change Log][01] in the GitHub repository.

## Breaking changes

- Nano server docker images aren't available for this release
- Add the **ProgressAction** parameter to the common parameters
- Update some PowerShell APIs to throw **ArgumentException** instead of **ArgumentNullException**
  when the argument is an empty string ([#19215][19215]) (Thanks @xtqqczze!)

## Installer updates

The Windows MSI package now provides an option to disable PowerShell telemetry during installation.
For more information, see [Install the msi package from the command line][11].

## Tab completion improvements

Many thanks to [@MartinGC94][02] for all the work on improving tab completion.

- Fix issue when completing the first command in a script with an empty array expression
  ([[#18355][18355])
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
- Fix class member completion for classes with base types ([#19179][19179])
- Add completion for Using keywords ([#16514][18758])

## Cmdlet and engine improvements

Update to Web cmdlets - Many thanks to [@CarloToso][03] for all the work on improving web cmdlets.

- Web cmdlets get **Retry-After** interval from response headers if the status code is 429
  ([#18717][18717])
- Web cmdlets set default charset encoding to UTF8 ([#18219][18219])
- Preserve WebSession.MaximumRedirection from changes ([#19190][19190])
- WebCmdlets parse XML declaration to get encoding value, if present. ([#18748][18748])
- Fix using xml -Body in webcmdlets without an encoding ([#19281][19281])
- Adjust PUT method behavior to POST one for default content type in WebCmdlets ([#19152][19152])
- Take into account ContentType from Headers in WebCmdlets ([#19227][19227])
- Allow to preserve the original HTTP method by adding -PreserveHttpMethodOnRedirect to Web cmdlets
  ([#18894][18894])
- Webcmdlets display an error on https to http redirect ([#18595][18595])
- Add AllowInsecureRedirect switch to Web cmdlets ([#18546][18546])
- Improve verbose message in web cmdlets when content length is unknown ([#19252][19252])
- Build the relative URI for links from the response in Invoke-WebRequest ([#19092][19092])
- Fix redirection for -CustomMethod POST in WebCmdlets ([#19111][19111])
- Dispose previous response in Webcmdlets ([#19117][19117])
- Improve Invoke-WebRequest xml and json errors format ([#18837][18837])
- Add ValidateNotNullOrEmpty to OutFile and InFile parameters of WebCmdlets ([#19044][19044])
- HttpKnownHeaderNames update headers list ([#18947][18947])
- Invoke-RestMethod -FollowRelLink fix links containing commas ([#18829][18829])
- Fix bug with managing redirection and KeepAuthorization in Web cmdlets ([#18902][18902])
- Add StatusCode to HttpResponseException ([#18842][18842])
- Support HTTP persistent connections in Web Cmdlets ([#19249][19249]) (Thanks @stevenebutler!)

Other cmdlets

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

Updates to `$PSStyle`

- Adds **Dim** and **DimOff** properties ([#18653][18653])
- Added static methods to the **PSStyle** class that map foreground and background **ConsoleColor**
  values to ANSI escape sequences ([#17938][17938])
- New formatting properties added by experimental features

Other Engine updates

- Make PowerShell class not affiliate with Runspace when declaring the `NoRunspaceAffinity`
  attribute ([#18138][18138])
- Add the `ValidateNotNullOrWhiteSpace` attribute ([#17191][17191]) (Thanks @wmentha!)
- Add `sqlcmd` to the list for legacy argument passing ([#18559][18559])
- Add the function `cd~` ([#18308][18308]) (Thanks @GigaScratch!)

## Experimental Features

PowerShell 7.4 introduces the following experimental features:

- [PSCustomTableHeaderLabelDecoration][04] - Add formatting differentiation for table header labels
  that aren't property members.
  - This feature also adds the **CustomTableHeaderLabel** property to `$PSStyle.Formatting` that
    allows you to change the formatting of the header label.
- [PSFeedbackProvider][05] - Replaces the hard-coded suggestion framework with an extensible
  feedback provider.
  - This feature also adds the **FeedbackProvider** and **FeedbackText** properties to
    `$PSStyle.Formatting` that allow you to change the formatting of feedback messages.
- [PSModuleAutoLoadSkipOfflineFiles][06] - Module discovery now skips over files that are marked by
  cloud providers as not fully on disk.
- [PSCommandWithArgs][07] - Add support for passing arguments to commands as a single string

PowerShell 7.4 changed the following experimental features:

- [PSNativeCommandErrorActionPreference][08] - `$PSNativeCommandUseErrorActionPreference` is set to
  `$true` when feature is enabled ([#18695][18695])
- [PSCommandNotFoundSuggestion][09] - This feature now uses an extensible feedback provider rather
  than hard-coded suggestions ([#18726][18726])

For more information about the Experimental Features, see [Using Experimental Features][10].

<!-- end of content -->
<!-- reference links -->
[01]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/preview.md
[02]: https://github.com/MartinGC94
[03]: https://github.com/CarloToso
[04]: ../learn/experimental-features.md#pscustomtableheaderlabeldecoration
[05]: ../learn/experimental-features.md#psfeedbackprovider
[06]: ../learn/experimental-features.md#psmoduleautoloadskipofflinefiles
[07]: ../learn/experimental-features.md#pscommandwithargs
[08]: ../learn/experimental-features.md#psnativecommanderroractionpreference
[09]: ../learn/experimental-features.md#pscommandnotfoundsuggestion
[10]: ../learn/experimental-features.md
[11]: ../install/installing-powershell-on-windows.md
[17191]: https://github.com/PowerShell/PowerShell/pull/17191
[17654]: https://github.com/PowerShell/PowerShell/pull/17654
[17780]: https://github.com/PowerShell/PowerShell/pull/17780
[17796]: https://github.com/PowerShell/PowerShell/pull/17796
[17799]: https://github.com/PowerShell/PowerShell/pull/17799
[17902]: https://github.com/PowerShell/PowerShell/pull/17902
[17907]: https://github.com/PowerShell/PowerShell/pull/17907
[17938]: https://github.com/PowerShell/PowerShell/pull/17938
[18030]: https://github.com/PowerShell/PowerShell/pull/18030
[18138]: https://github.com/PowerShell/PowerShell/pull/18138
[18219]: https://github.com/PowerShell/PowerShell/pull/18219
[18261]: https://github.com/PowerShell/PowerShell/pull/18261
[18308]: https://github.com/PowerShell/PowerShell/pull/18308
[18351]: https://github.com/PowerShell/PowerShell/pull/18351
[18355]: https://github.com/PowerShell/PowerShell/pull/18355
[18546]: https://github.com/PowerShell/PowerShell/pull/18546
[18559]: https://github.com/PowerShell/PowerShell/pull/18559
[18595]: https://github.com/PowerShell/PowerShell/pull/18595
[18653]: https://github.com/PowerShell/PowerShell/pull/18653
[18682]: https://github.com/PowerShell/PowerShell/pull/18682
[18695]: https://github.com/PowerShell/PowerShell/pull/18695
[18717]: https://github.com/PowerShell/PowerShell/pull/18717
[18726]: https://github.com/PowerShell/PowerShell/pull/18726
[18731]: https://github.com/PowerShell/PowerShell/pull/18731
[18735]: https://github.com/PowerShell/PowerShell/pull/18735
[18748]: https://github.com/PowerShell/PowerShell/pull/18748
[18755]: https://github.com/PowerShell/PowerShell/pull/18755
[18758]: https://github.com/PowerShell/PowerShell/pull/18758
[18829]: https://github.com/PowerShell/PowerShell/pull/18829
[18837]: https://github.com/PowerShell/PowerShell/pull/18837
[18842]: https://github.com/PowerShell/PowerShell/pull/18842
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
[19178]: https://github.com/PowerShell/PowerShell/pull/19178
[19179]: https://github.com/PowerShell/PowerShell/pull/19179
[19190]: https://github.com/PowerShell/PowerShell/pull/19190
[19215]: https://github.com/PowerShell/PowerShell/pull/19215
[19227]: https://github.com/PowerShell/PowerShell/pull/19227
[19249]: https://github.com/PowerShell/PowerShell/pull/19249
[19252]: https://github.com/PowerShell/PowerShell/pull/19252
[19281]: https://github.com/PowerShell/PowerShell/pull/19281
[19298]: https://github.com/PowerShell/PowerShell/pull/19298
