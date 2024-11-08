---
title: What's New in PowerShell 7.3
description: New features and changes released in PowerShell 7.3
ms.date: 02/27/2023
---

# What's New in PowerShell 7.3

PowerShell 7.3 is the next stable release, built on .NET 7.0.

PowerShell 7.3 includes the following features, updates, and breaking changes.

## Breaking Changes and Improvements

- In this release, Windows APIs were updated or removed for compliance, which means that PowerShell
  7.3 doesn't run on Windows 7. While Windows 7 is no longer supported, previous builds could run on
  Windows 7.
- PowerShell Direct for Hyper-V is only supported on Windows 10, version 1809 and higher.
- `Test-Connection` is broken due to an intentional [breaking change][09] in .NET 7. It's tracked by
  [#17018][10]
- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup ([#15177][15177])
- Change default for `$PSStyle.OutputRendering` to **Host**
- Make `Out-String` and `Out-File` keep string input unchanged ([#17455][17455])
- Move the type data definition of System.Security.AccessControl.ObjectSecurity to the
  Microsoft.PowerShell.Security module ([#16355][16355]) (Thanks @iSazonov!)
  - Before this change, a user doesn't need to explicitly import the
    **Microsoft.PowerShell.Security** module to use the code properties defined for an instance of
    **System.Security.AccessControl.ObjectSecurity**.
  - After this change, a user needs to explicitly import **Microsoft.PowerShell.Security** module in
    order to use those code properties and code methods.

## Tab completion improvements

- PowerShell 7.3 includes PSReadline 2.2.6, which enables Predictive IntelliSense by default. For
  more information, see [about_PSReadLine][12].
- Fix tab completion within the script block specified for the `ValidateScriptAttribute`.
  ([#14550][14550]) (Thanks @MartinGC94!)
- Added tab completion for loop labels after `break`/`continue` ([#16438][16438]) (Thanks
  @MartinGC94!)
- Improve Hashtable completion in multiple scenarios ([#16498][16498]) (Thanks @MartinGC94!)
  - Parameter splatting
  - **Arguments** parameter for `Invoke-CimMethod`
  - **FilterHashtable** parameter for `Get-WinEvent`
  - **Property** parameter for the CIM cmdlets
  - Removes duplicates from member completion scenarios
- Support forward slashes in network share (UNC path) completion ([#17111][17111]) (Thanks @sba923!)
- Improve member autocompletion ([#16504][16504]) (Thanks @MartinGC94!)
- Prioritize ValidateSet completions over Enums for parameters ([#15257][15257]) (Thanks
  @MartinGC94!)
- Add type inference support for generic methods with type parameters ([#16951][16951]) (Thanks
  @MartinGC94!)
- Improve type inference and completions ([#16963][16963]) (Thanks @MartinGC94!)
  - Allows methods to be shown in completion results for `ForEach-Object -MemberName`
  - Prevents completion on expressions that return void like `([void](""))`
  - Allows non-default Class constructors to show up when class completion is based on the AST
- Improve type inference for `$_` ([#17716][17716]) (Thanks @MartinGC94!)
- Fix type inference for **ICollection** ([#17752][17752]) (Thanks @MartinGC94!)
- Prevent braces from being removed when completing variables ([#17751][17751]) (Thanks
  @MartinGC94!)
- Add completion for index expressions for dictionaries ([#17619][17619]) (Thanks @MartinGC94!)
- Fix type completion for attribute tokens ([#17484][17484]) (Thanks @MartinGC94!)
- Improve dynamic parameter tab completion ([#17661][17661]) (Thanks @MartinGC94!)
- Avoid binding positional parameters when completing parameter in front of value ([#17693][17693])
  (Thanks @MartinGC94!)

## Improved error handling

- Set `$?` correctly for command expression with redirections ([#16046][16046])
- Fix a casting error when using `$PSNativeCommandUseErrorActionPreference` ([#15993][15993])
- Make the native command error handling optionally honor `ErrorActionPreference` ([#15897][15897])
- Specify the executable path as `TargetObject` for non-zero exit code ErrorRecord
  ([#16108][16108]) (Thanks @rkeithhill!)

## Session and remoting improvements

- Add `-Options` to the PSRP over SSH commands to allow passing OpenSSH options directly
  ([#12802][12802]) (Thanks @BrannenGH!)
- Add `-ConfigurationFile` parameter to `pwsh` to allow starting a new process with the session
  configuration defined in a `.pssc` file ([#17447][17447])
- Add support for using `New-PSSessionConfigurationFile` on non-Windows platforms ([#17447][17447])

## Updated cmdlets

- Add `-HttpVersion` parameter to web cmdlets ([#15853][15853]) (Thanks @hayhay27!)
- Add support to web cmdlets for open-ended input tags ([#16193][16193]) (Thanks @farmerau!)
- Fix `ConvertTo-Json -Depth` to allow 100 at maximum ([#16197][16197]) (Thanks @KevRitchie!)
- Improve variable handling when calling `Invoke-Command` with the `$using:` expression
  ([#16113][16113]) (Thanks @dwtaber!)
- Add `-StrictMode` to `Invoke-Command` to allow specifying strict mode when invoking command
  locally ([#16545][16545]) (Thanks @Thomas-Yu!)
- Add `clean` block to script block as a peer to `begin`, `process`, and `end` to allow easy
  resource cleanup ([#15177][15177])
- Add `-Amended` switch to `Get-CimClass` cmdlet ([#17477][17477]) (Thanks @iSazonov)
- Changed `ConvertFrom-Json -AsHashtable` to use ordered hashtable ([#17405][17405])
- Removed ANSI escape sequences in strings before sending to `Out-GridView` ([#17664][17664])
- Added the **Milliseconds** parameter to `New-TimeSpan` ([#17621][17621]) (Thanks @NoMoreFood!)
- Show optional parameters when displaying method definitions and overloads ([#13799][13799])
  (Thanks @eugenesmlv!)
- Allow commands to still be executed even if the current working directory no longer exists
  ([#17579][17579])
- Add support for HTTPS with `Set-AuthenticodeSignature -TimeStampServer` ([#16134][16134]) (Thanks
  @Ryan-Hutchison-USAF!)
- Render decimal numbers in a table using current culture ([#17650][17650])
- Add type accelerator ordered for **OrderedDictionary** ([#17804][17804]) (Thanks @fflaten!)
- Add `find.exe` to legacy argument binding behavior for Windows ([#17715][17715])
- Add `-noprofileloadtime` switch to pwsh ([#17535][17535]) (Thanks @rkeithhill!)

For a complete list of changes, see the [Change Log][11] in the GitHub repository.

## Experimental Features

In PowerShell 7.3, following experimental features became mainstream:

- `PSAnsiRenderingFileInfo` - This feature adds the `$PSStyle.FileInfo` member and enables
  coloring of specific file types.
- `PSCleanBlock` - Adds `clean` block to script block as a peer to `begin`, `process`, and `end`
  to allow easy resource cleanup.
- `PSAMSIMethodInvocationLogging` - Extends the data sent to AMSI for inspection to include all
  invocations of .NET method members.
- [PSNativeCommandArgumentPassing][08] - PowerShell now uses the **ArgumentList** property of the
  **StartProcessInfo** object rather than the old mechanism of reconstructing a string when invoking
  a native executable.

  PowerShell 7.3.1 adds `sqlcmd.exe` to the list of native commands in Windows that use the `Legacy`
  style of argument passing.
- `PSExec` - Adds the new `Switch-Process` cmdlet (alias `exec`) to provide `exec` compatibility for
  non-Windows systems.

  PowerShell 7.3.1 changed the `exec` alias to a function that wraps `Switch-Process`. The function
  allows you to pass parameters to the native command that might have erroneously bound to the
  **WithCommand** parameter.

PowerShell 7.3 introduces the following experimental features:

- [PSNativeCommandErrorActionPreference][06] - Adds the
  `$PSNativeCommandUseErrorActionPreference` variable to enable errors produced by native commands
  to be PowerShell errors.

PowerShell 7.3 removed the following experimental features:

- `PSNativePSPathResolution` experimental feature is no longer supported.
- `PSStrictModeAssignment` experimental feature is no longer supported.

For more information about the Experimental Features, see [Using Experimental Features][01].

<!-- end of content -->
<!-- reference links -->
[01]: ../learn/experimental-features.md
[06]: ../learn/experimental-features.md#psnativecommanderroractionpreference
[08]: ../learn/experimental-features.md#psnativecommandargumentpassing
[09]: https://github.com/dotnet/runtime/issues/66746
[10]: https://github.com/PowerShell/PowerShell/issues/17018
[11]: https://github.com/PowerShell/PowerShell/releases/tag/v7.3.0
[12]: /powershell/module/psreadline/about/about_psreadline#psreadline-release-history
[12802]: https://github.com/PowerShell/PowerShell/pull/12802
[13799]: https://github.com/PowerShell/PowerShell/pull/13799
[14550]: https://github.com/PowerShell/PowerShell/pull/14550
[15177]: https://github.com/PowerShell/PowerShell/pull/15177
[15257]: https://github.com/PowerShell/PowerShell/pull/15257
[15853]: https://github.com/PowerShell/PowerShell/pull/15853
[15897]: https://github.com/PowerShell/PowerShell/pull/15897
[15993]: https://github.com/PowerShell/PowerShell/pull/15993
[16046]: https://github.com/PowerShell/PowerShell/pull/16046
[16108]: https://github.com/PowerShell/PowerShell/pull/16108
[16113]: https://github.com/PowerShell/PowerShell/pull/16113
[16134]: https://github.com/PowerShell/PowerShell/pull/16134
[16193]: https://github.com/PowerShell/PowerShell/pull/16193
[16197]: https://github.com/PowerShell/PowerShell/pull/16197
[16355]: https://github.com/PowerShell/PowerShell/pull/16355
[16438]: https://github.com/PowerShell/PowerShell/pull/16438
[16498]: https://github.com/PowerShell/PowerShell/pull/16498
[16504]: https://github.com/PowerShell/PowerShell/pull/16504
[16545]: https://github.com/PowerShell/PowerShell/pull/16545
[16951]: https://github.com/PowerShell/PowerShell/pull/16951
[16963]: https://github.com/PowerShell/PowerShell/pull/16963
[17111]: https://github.com/PowerShell/PowerShell/pull/17111
[17405]: https://github.com/PowerShell/PowerShell/pull/17405
[17447]: https://github.com/PowerShell/PowerShell/pull/17447
[17455]: https://github.com/PowerShell/PowerShell/pull/17455
[17477]: https://github.com/PowerShell/PowerShell/pull/17477
[17484]: https://github.com/PowerShell/PowerShell/pull/17484
[17535]: https://github.com/PowerShell/PowerShell/pull/17535
[17579]: https://github.com/PowerShell/PowerShell/pull/17579
[17619]: https://github.com/PowerShell/PowerShell/pull/17619
[17621]: https://github.com/PowerShell/PowerShell/pull/17621
[17650]: https://github.com/PowerShell/PowerShell/pull/17650
[17661]: https://github.com/PowerShell/PowerShell/pull/17661
[17664]: https://github.com/PowerShell/PowerShell/pull/17664
[17693]: https://github.com/PowerShell/PowerShell/pull/17693
[17715]: https://github.com/PowerShell/PowerShell/pull/17715
[17716]: https://github.com/PowerShell/PowerShell/pull/17716
[17751]: https://github.com/PowerShell/PowerShell/pull/17751
[17752]: https://github.com/PowerShell/PowerShell/pull/17752
[17804]: https://github.com/PowerShell/PowerShell/pull/17804
