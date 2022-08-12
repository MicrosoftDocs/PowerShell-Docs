---
title: What's New in PowerShell 7.3-preview.5
description: New features and changes released in PowerShell 7.3-preview.5
ms.date: 08/12/2022
---

# What's New in PowerShell 7.3

PowerShell 7.3 is the next preview release, built on .NET 7.0.

PowerShell 7.3-preview.7 includes the following features, updates, and breaking changes.

## Improved error handling

- Set `$?` correctly for command expression with redirections (#16046)
- Fix a casting error when using `$PSNativeCommandUseErrorActionPreference` (#15993)
- Make the native command error handling optionally honor `ErrorActionPreference` (#15897)
- Specify the executable path as `TargetObject` for non-zero exit code ErrorRecord (#16108) (Thanks
  @rkeithhill!)

## Session and remoting improvements

- Add `-Options` to the PSRP over SSH commands to allow passing OpenSSH options directly (#12802)
  (Thanks @BrannenGH!)
- Add `-ConfigurationFile` parameter to `pwsh` to allow starting a new process with the session
  configuration defined in a `.pssc` file (#17447)
- Add support for using `New-PSSessionConfigurationFile` on non-Windows platforms (#17447)

## Tab completion improvements

- Fix tab completion within the script block specified for the `ValidateScriptAttribute`. (#14550)
  (Thanks @MartinGC94!)
- Added tab completion for loop labels after `break`/`continue` (#16438) (Thanks @MartinGC94!)
- Improve Hashtable completion in multiple scenarios (#16498) (Thanks @MartinGC94!)
  - Parameter splatting
  - **Arguments** parameter for `Invoke-CimMethod`
  - **FilterHashtable** parameter for `Get-WinEvent`
  - **Property** parameter for the CIM cmdlets
  - Removes duplicates from member completion scenarios
- Support forward slashes in network share (UNC path) completion (#17111) (Thanks @sba923!)
- Improve member autocompletion (#16504) (Thanks @MartinGC94!)
- Prioritize ValidateSet completions over Enums for parameters (#15257) (Thanks @MartinGC94!)
- Add type inference support for generic methods with type parameters (#16951) (Thanks @MartinGC94!)
- Improve type inference and completions (#16963) (Thanks @MartinGC94!)
  - Allows methods to be shown in completion results for `ForEach-Object -MemberName`
  - Prevents completion on expressions that return void like `([void](""))`
  - Allows non-default Class constructors to show up when class completion is based on the AST
- Improve type inference for `$_` (#17716) (Thanks @MartinGC94!)
- Fix type inference for **ICollection** (#17752) (Thanks @MartinGC94!)
- Prevent braces from being removed when completing variables (#17751) (Thanks @MartinGC94!)
- Add completion for index expressions for dictionaries (#17619) (Thanks @MartinGC94!)
- Fix type completion for attribute tokens (#17484) (Thanks @MartinGC94!)
- Improve dynamic parameter tab completion (#17661) (Thanks @MartinGC94!)
- Avoid binding positional parameters when completing parameter in front of value (#17693) (Thanks
  @MartinGC94!)

## Updated cmdlets

- Add `-HttpVersion` parameter to web cmdlets (#15853) (Thanks @hayhay27!)
- Add support to web cmdlets for open-ended input tags (#16193) (Thanks @farmerau!)
- Fix `ConvertTo-Json -Depth` to allow 100 at maximum (#16197) (Thanks @KevRitchie!)
  @rkeithhill!)
- Improve variable handling when calling `Invoke-Command` with the `$using:` expression (#16113)
  (Thanks @dwtaber!)
- Add `-StrictMode` to `Invoke-Command` to allow specifying strict mode when invoking command
  locally (#16545) (Thanks @Thomas-Yu!)
- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)
- Add `-Amended` switch to `Get-CimClass` cmdlet (#17477) (Thanks @iSazonov)
- Changed `ConvertFrom-Json -AsHashtable` to use ordered hashtable (#17405)
- Removed ANSI escape sequences in strings before sending to `Out-GridView` (#17664)
- Added the **Milliseconds** parameter to `New-TimeSpan` (#17621) (Thanks @NoMoreFood!)
- Show optional parameters when displaying method definitions and overloads (#13799) (Thanks
  @eugenesmlv!)
- Allow commands to still be executed even if the current working directory no longer exists
  (#17579)
- Add support for HTTPS with `Set-AuthenticodeSignature -TimeStampServer` (#16134) (Thanks
  @Ryan-Hutchison-USAF!)
- Render decimal numbers in a table using current culture (#17650)
- Add type accelerator ordered for **OrderedDictionary** (#17804) (Thanks @fflaten!)
- Add `find.exe` to legacy argument binding behavior for Windows (#17715)
- Add `-noprofileloadtime` switch to pwsh (#17535) (Thanks @rkeithhill!)

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
- [PSAMSIMethodInvocationLogging][exp-amsi] - Extends the data sent to AMSI for inspection to
  include all invocations of .NET method members.
- Remove [PSNativePSPathResolution][exp-path] experimental feature

For more information about the Experimental Features, see [Using Experimental Features][exp].

## Breaking Changes and Improvements

- `Test-Connection` is broken due to an intentional
  [breaking change](https://github.com/dotnet/runtime/issues/66746) in .NET 7. It's tracked by
  [#17018](https://github.com/PowerShell/PowerShell/issues/17018)
- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup (#15177)
- Change default for `$PSStyle.OutputRendering` to **Ansi**
- Make `Out-String` and `Out-File` keep string input unchanged (#17455)
- Move the type data definition of System.Security.AccessControl.ObjectSecurity to the
  Microsoft.PowerShell.Security module (#16355) (Thanks @iSazonov!)
  - Before this change, a user doesn't need to explicitly import the
    **Microsoft.PowerShell.Security** module to use the code properties defined for an instance of
    **System.Security.AccessControl.ObjectSecurity**.
  - After this change, a user needs to explicitly import **Microsoft.PowerShell.Security** module in
    order to use those code properties and code methods.

<!-- end of content -->
<!-- reference links -->

[CHANGELOG]: https://github.com/PowerShell/PowerShell/releases/tag/v7.3.0-preview.5
[exp-clean]: ../learn/experimental-features.md#pscleanblock
[exp-psexec]: ../learn/experimental-features.md#psexec
[exp-strict]: ../learn/experimental-features.md#psstrictmodeassignment
[exp-error]: ../learn/experimental-features.md#psnativecommanderroractionpreference
[exp-amsi]: ../learn/experimental-features.md?#psamsimethodinvocationlogging
[exp-path]: ../learn/experimental-features.md?#psnativepspathresolution
