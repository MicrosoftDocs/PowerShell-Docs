---
title: What's New in PowerShell 7.4 (preview)
description: New features and changes released in PowerShell 7.4 (preview)
ms.date: 01/05/2023
---

# What's New in PowerShell 7.4 (preview)

PowerShell 7.4-preview.1 includes the following features, updates, and breaking changes.

For a complete list of changes, see the [Change Log][07] in the GitHub repository.

## Breaking changes

- Snap packages aren't available for this release
- Nano server docker images aren't available for this release

## Tab completion improvements

- Fix issue when completing the first command in a script with an empty array expression
  ([[#18355][18355]]) (Thanks @MartinGC94!)
- Fix positional argument completion ([#17796][17796]) (Thanks @MartinGC94!)
- Improve type inference of hashtable keys ([#17907][17907]) (Thanks @MartinGC94!)
- Fix type inference error for empty return statements ([#18351][18351]) (Thanks @MartinGC94!)
- Improve enumeration of inferred types in pipeline ([#17799][17799]) (Thanks @MartinGC94!)
- Fix member completion in attribute argument ([#17902][17902]) (Thanks @MartinGC94!)
- Improve pseudo binding for dynamic parameters ([#18030][18030]) (Thanks @MartinGC94!)
- Add completion for values in comparisons when comparing Enums ([#17654][17654]) (Thanks
  @MartinGC94!)

## Cmdlet and engine improvements

Update to Web cmdlets

- Web cmdlets get **Retry-After** interval from response headers if the status code is 429
  ([#18717][18717]) (Thanks @CarloToso!)
- Web cmdlets set default charset encoding to UTF8 ([#18219][18219]) (Thanks @CarloToso!)

Other cmdlets

- `Update-Help` now reports an error when using implicit culture on non-US systems.
  ([#17780][17780]) (Thanks @dkaszews!)
- Add **Confirm** and **WhatIf** parameters to `Stop-Transcript`([#18731][18731]) (Thanks
  @JohnLBevan!)
- Add **FuzzyMinimumDistance** parameter to `Get-Command` ([#18261][18261])

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

- [PSCustomTableHeaderLabelDecoration][03] - Add formatting differentiation for table header labels
  that aren't property members.
  - This feature also adds the **CustomTableHeaderLabel** property to `$PSStyle.Formatting` that
    allows you to change the formatting of the header label.
- [PSFeedbackProvider][04] - Replaces the hard-coded suggestion framework with an extensible
  feedback provider.
  - This feature also adds the **FeedbackProvider** and **FeedbackText** properties to
    `$PSStyle.Formatting` that allow you to change the formatting of feedback messages.
- [PSModuleAutoLoadSkipOfflineFiles][05] - Module discovery now skips over files that are marked by
  cloud providers as not fully on disk.

PowerShell 7.4 changed the following experimental features:

- [PSNativeCommandErrorActionPreference][06] - `$PSNativeCommandUseErrorActionPreference` is set to
  `$true` when feature is enabled ([#18695][18695])
- [PSCommandNotFoundSuggestion][02] - This feature now uses an extensible feedback provider rather
  than hard-coded suggestions

For more information about the Experimental Features, see [Using Experimental Features][01].

<!-- end of content -->
<!-- reference links -->

[01]: ../learn/experimental-features.md
[02]: /powershell/scripting/learn/experimental-features#pscommandnotfoundsuggestion
[03]: /powershell/scripting/learn/experimental-features#pscustomtableheaderlabeldecoration
[04]: /powershell/scripting/learn/experimental-features#psfeedbackprovider
[05]: /powershell/scripting/learn/experimental-features#psmoduleautoloadskipofflinefiles
[06]: /powershell/scripting/learn/experimental-features#psnativecommanderroractionpreference
[07]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/preview.md
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
[18559]: https://github.com/PowerShell/PowerShell/pull/18559
[18653]: https://github.com/PowerShell/PowerShell/pull/18653
[18695]: https://github.com/PowerShell/PowerShell/pull/18695
[18717]: https://github.com/PowerShell/PowerShell/pull/18717
[18731]: https://github.com/PowerShell/PowerShell/pull/18731
