---
title: What's New in PowerShell 7.3-preview.1
description: New features and changes released in PowerShell 7.3-preview.1
ms.date: 01/18/2022
---

# What's New in PowerShell 7.3

PowerShell 7.3 is the next preview release, built on .NET 6.0.

PowerShell 7.3-preview.1 includes the following features, updates, and breaking changes.

- Set `$?` correctly for command expression with redirections (#16046)
- Fix a casting error when using `$PSNativeCommandUsesErrorActionPreference` (#15993)
- Make the native command error handling optionally honor `ErrorActionPreference` (#15897)
- Fix tab completion within the script block specified for the `ValidateScriptAttribute`. (#14550)
  (Thanks @MartinGC94!)
- Add `-HttpVersion` parameter to web cmdlets (#15853) (Thanks @hayhay27!)
- Add support to web cmdlets for open-ended input tags (#16193) (Thanks @farmerau!)
- Fix `ConvertTo-Json -Depth` to allow 100 at maximum (#16197) (Thanks @KevRitchie!)
- Specify the executable path as `TargetObject` for non-zero exit code ErrorRecord (#16108) (Thanks
  @rkeithhill!)
- Invoke-Command: improve handling of variables with $using: expression (#16113) (Thanks @dwtaber!)
- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)

For a complete list of changes, see the [Change Log][CHANGELOG] in the GitHub repository.

## Experimental Features

> [!NOTE]
> There is a known issue in 7.3.0-preview.1 - Alpine Linux packages are missing the
> `powershell.config.json` file, causing experimental features to be disabled by default. For
> details, see Issue #16636.

PowerShell 7.3 introduces the following experimental features:

- [PSCleanBlock][exp-clean] - Adds `clean` block to script block as a peer to `begin`, `process`,
  and `end` to allow easy resource cleanup
- [PSStrictModeAssignment][strict] - Adds the **StrictMode** parameter to `Invoke-Command` to allow
  specifying strict mode when invoking command locally.

For more information about the Experimental Features, see [Using Experimental Features][exp].

## Breaking Changes and Improvements

- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)
- Change default for `$PSStyle.OutputRendering` to **Ansi**

<!-- reference links -->

[CHANGELOG]: https://github.com/PowerShell/PowerShell/releases/tag/v7.3.0-preview.1
[exp-clean]: ../learn/experimental-features.md#pscleanblock
[strict]: ../learn/experimental-features.md#psstrictmodeassignment
