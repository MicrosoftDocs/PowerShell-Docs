---
title: What's New in PowerShell 7.3-preview.1
description: New features and changes released in PowerShell 7.3-preview.1
ms.date: 12/16/2021
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

For a complete list of changes, see the [Change Log][CHANGELOG] in the GitHub repository.

## Experimental Features

There is a known issue about 7.3.0-preview.1 - Alpine Linux packages are missing the
`powershell.config.json` file, causing experimental features to be disabled by default. For details,
see Issue #16636.

## Breaking Changes and Improvements

- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)
- Change default for `$PSStyle.OutputRendering` to **Ansi**

<!-- reference links -->

[CHANGELOG]: https://github.com/PowerShell/PowerShell/releases/tag/v7.3.0-preview.1
