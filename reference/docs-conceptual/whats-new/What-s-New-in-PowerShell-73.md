---
title: What's New in PowerShell 7.3-preview.1
description: New features and changes released in PowerShell 7.3-preview.1
ms.date: 03/24/2022
---

# What's New in PowerShell 7.3

PowerShell 7.3 is the next preview release, built on .NET 7.0.

PowerShell 7.3-preview.3 includes the following features, updates, and breaking changes.

Known issues in 7.3-preview.3

These issues should be fixed in the next release of .NET 7

- `Test-Connection` is broken due to an
  [intentional breaking change](https://github.com/dotnet/runtime/issues/66746) in .NET 7. It's
  tracked by [#17018](https://github.com/PowerShell/PowerShell/issues/17018)
- `AssemblyName.FullName` has unexpected behavior due to a
  [regression](https://github.com/dotnet/runtime/issues/66785) in .NET 7

Improved error handling

- Set `$?` correctly for command expression with redirections (#16046)
- Fix a casting error when using `$PSNativeCommandUseErrorActionPreference` (#15993)
- Make the native command error handling optionally honor `ErrorActionPreference` (#15897)
- Specify the executable path as `TargetObject` for non-zero exit code ErrorRecord (#16108) (Thanks
  @rkeithhill!)

Tab completion improvements

- Fix tab completion within the script block specified for the `ValidateScriptAttribute`. (#14550)
  (Thanks @MartinGC94!)
- Added tab completion for loop labels after `break`/`continue` (#16438) (Thanks @MartinGC94!)
- Improve Hashtable completion in multiple scenarios (#16498)  (Thanks @MartinGC94!)
  - Parameter splatting
  - **Arguments** parameter for `Invoke-CimMethod`
  - **FilterHashtable** parameter for `Get-WinEvent`
  - **Property** parameter for the CIM cmdlets
  - Removes duplicates from member completion scenarios
- Support forward slashes in network share (UNC path) completion (#17111) (#17117) (Thanks @sba923!)
- Improve member auto completion (#16504) (Thanks @MartinGC94!)
- Prioritize ValidateSet completions over Enums for parameters (#15257) (Thanks @MartinGC94!)

Updated cmdlets

- Add `-HttpVersion` parameter to web cmdlets (#15853) (Thanks @hayhay27!)
- Add support to web cmdlets for open-ended input tags (#16193) (Thanks @farmerau!)
- Fix `ConvertTo-Json -Depth` to allow 100 at maximum (#16197) (Thanks @KevRitchie!)
  @rkeithhill!)
- Improve variable handling when calling `Invoke-Command` with the `$using:` expression (#16113)
  (Thanks @dwtaber!)
- Add `-StrictMode` to `Invoke-Command` to allow specifying strict mode when invoking command locally
- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)
  (#16545) (Thanks @Thomas-Yu!)
- Add `-Options` to the PSRP over SSH commands to allow passing OpenSSH options directly (#12802)
  (Thanks @BrannenGH!)

For a complete list of changes, see the [Change Log][CHANGELOG] in the GitHub repository.

## Experimental Features

PowerShell 7.3 introduces the following experimental features:

- [PSExec][exp-psexec] - Adds the new `Switch-Process` cmdlet (alias `exec`) to provide `exec`
  compatibility for non-Windows systems.
- [PSCleanBlock][exp-clean] - Adds `clean` block to script block as a peer to `begin`, `process`,
  and `end` to allow easy resource cleanup.
- [PSStrictModeAssignment][exp-strict] - Adds the **StrictMode** parameter to `Invoke-Command` to
  allow specifying strict mode when invoking command locally.
- [PSNativeCommandErrorActionPreference][exp-error] - Adds the
  `$PSNativeCommandUseErrorActionPreference` variable to enable errors produced by native commands
  to be PowerShell errors.
- [PSAMSIMethodInvocationLogging][exp-amsi] - Extends the data that is sent to AMSI for inspection
  to include all invocations of .NET method members.

For more information about the Experimental Features, see [Using Experimental Features][exp].

## Breaking Changes and Improvements

- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)
- Change default for `$PSStyle.OutputRendering` to **Ansi**

<!-- end of content -->
<!-- reference links -->

[CHANGELOG]: https://github.com/PowerShell/PowerShell/releases/tag/v7.3.0-preview.3
[exp-clean]: ../learn/experimental-features.md#pscleanblock
[exp-psexec]: ../learn/experimental-features.md#psexec
[exp-strict]: ../learn/experimental-features.md#psstrictmodeassignment
[exp-error]: ../learn/experimental-features.md#psnativecommanderroractionpreference
[exp-amsi]: ../learn/experimental-features.md?#psamsimethodinvocationlogging
