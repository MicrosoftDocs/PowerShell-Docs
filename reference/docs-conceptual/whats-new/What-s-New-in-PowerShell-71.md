---
title: What's New in PowerShell 7.1
description: New features and changes released in PowerShell 7.1
ms.date: 11/11/2020
---

# What's New in PowerShell 7.1

PowerShell 7.1 is an open-source, cross-platform (Windows, macOS, and Linux) edition of PowerShell,
built to manage heterogeneous environments and hybrid cloud.

Building on the foundation established in PowerShell 7.0, our efforts focused on community issues
and include a number of improvements and fixes. We are committed to ensuring that PowerShell remains
a stable and performant platform.

PowerShell 7.1 also include PSReadLine 2.1.0. This version includes Predictive IntelliSense. For
more information about the Predictive IntelliSense feature, see the
[announcement](https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/)
in the PowerShell blog.

## Where can I install PowerShell?

<!-- TODO: Update list of OS below - make sure this is consistent across all docs -->

PowerShell 7.1 currently supports the following operating systems on x64, including:

- Windows 8.1/10 (including ARM64)
- Windows Server 2012 R2, 2016, 2019, and Semi-Annual Channel (SAC)
- Ubuntu 16.04/18.04/20.04 (including ARM64)
- Ubuntu 19.10 (via Snap package)
- Debian 9/10
- CentOS and RHEL 7/8
- Fedora 32
- Alpine 3.11+ (including ARM64)
- macOS 10.13+

We also have community support for:

- Arch Linux
- Raspbian Linux
- Kali Linux

For more up-to-date information about supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle](/powershell/scripting/powershell-support-lifecycle)

PowerShell 7.1 has been published to the Microsoft Store. You can find the PowerShell release on the
[Microsoft Store](https://www.microsoft.com/store/apps/9MZ1SNWT0N5D) website or in the
Store application in Windows.

Benefits of the Microsoft Store package:

- Automatic updates built right into Windows 10
- Integrates with other software distribution mechanisms like Intune and SCCM

> [!NOTE]
> Any system-level configuration settings stored in `$PSHOME` cannot be modified. This includes the
> WSMAN configuration. This prevents remote sessions from connecting to Store-based installs of
> PowerShell. User-level configurations and SSH remoting are supported.

Check the installation instructions for your preferred operating system:

- [Windows](/powershell/scripting/install/installing-powershell-core-on-windows)
- [macOS](/powershell/scripting/install/installing-powershell-core-on-macos)
- [Linux](/powershell/scripting/install/installing-powershell-core-on-linux)

Additionally, PowerShell 7.1 supports ARM32 and ARM64 flavors of Debian, Ubuntu, and ARM64 Alpine
Linux.

While not officially supported, the community has also provided packages for
[Arch](https://aur.archlinux.org/packages/powershell/) and Kali Linux.

> [!NOTE]
> Debian 10+, CentOS 8+, Ubuntu 20.04, Alpine and Arm currently do not support WinRM remoting. For
> details on setting up SSH-based remoting, see
> [PowerShell Remoting over SSH](/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core).

## Running PowerShell 7.1

PowerShell 7.1 installs to a new directory and runs side-by-side with Windows PowerShell 5.1.
PowerShell 7.1 is an in-place upgrade that replaces PowerShell 6.x. or PowerShell 7.0.

- PowerShell 7.1 is installed to `%programfiles%\PowerShell\7`
- The `%programfiles%\PowerShell\7` folder is added to `$env:PATH`

The PowerShell 7.1 installer packages upgrade previous versions of PowerShell Core 6.x:

- PowerShell Core 6.x on Windows: `%programfiles%\PowerShell\6` is replaced by
  `%programfiles%\PowerShell\7`
- Linux: `/opt/microsoft/powershell/6` is replaced by `/opt/microsoft/powershell/7`
- macOS: `/usr/local/microsoft/powershell/6` is replaced by `/usr/local/microsoft/powershell/7`

> [!NOTE]
> In Windows PowerShell, the executable to launch PowerShell is named `powershell.exe`. In version 6
> and above, the executable is changed to support side-by-side execution. The new executable to
> launch PowerShell 7.1 is `pwsh.exe`. Preview builds will remain in-place as `pwsh-preview` instead
> of `pwsh` under the 7-preview directory.

## Breaking Changes and Improvements

For the latest information on changes and improvements, see the
[CHANGELOG](https://github.com/PowerShell/PowerShell/tree/master/CHANGELOG) in the GitHub
repository.

### Breaking Changes

<!-- TODO: Add descriptions for each breaking change - this might need to be a separate article that we link to -->

- Fix `$?` to not be `$false` when native command writes to `stderr` (#13395)
- Rename `-FromUnixTime` to `-UnixTimeSeconds` on `Get-Date` to allow Unix time input (#13084) (Thanks @aetos382!)
- Make `$ErrorActionPreference` not affect `stderr` output of native commands (#13361)
- Allow explicitly specified named parameter to supersede the same one from hashtable splatting (#13162)
- Make the switch parameter `-Qualifier` not positional for `Split-Path` (#12960) (Thanks @yecril71pl!)
- Resolve the working directory as literal path for `Start-Process` when it's not specified (#11946) (Thanks @NoMoreFood!)
- Make `-OutFile` parameter in web cmdlets to work like `-LiteralPath` (#11701) (Thanks @iSazonov!)
- Fix string parameter binding for `BigInteger` numeric literals (#11634) (Thanks @vexx32!)
- On Windows, `Start-Process` creates a process environment with all the environment variables from
  current session, using `-UseNewEnvironment` creates a new default process environment (#10830) (Thanks @iSazonov!)
- Do not wrap return result to `PSObject` when converting ScriptBlock to delegate (#10619)
- Use invariant culture string conversion for `-replace` operator (#10954) (Thanks @iSazonov!)

### Experimental Features

For more information about the Experimental Features, see [Using Experimental Features](../learn/experimental-features.md).

- Move `PSNullConditionalOperators` feature out of experimental (#13529)
- Move `PSUnixFileStat` feature out of experimental
- Add `-Runspace` parameter to all `*-PSBreakpoint` cmdlets (#10492) (Thanks @KirkMunro!)
- Add `PSNativePSPathResolution` to support passing `PSPath` to native commands (#12386)
- Use invariant culture string conversion for `-replace` operator (#10954) (Thanks @iSazonov!)
- Add `PSSubsystemPluginModel` to support future Predictive IntelliSense plug-ins

### General Cmdlet Updates and Fixes

- Emit warning if `ConvertTo-Json` exceeds `-Depth` value (#13692)
- Fix case where exception message contains just ``"`n"`` on Windows (#13684)
- Recognize `CONOUT$` and `CONIN$` as reserved device names (#13508) (Thanks @davidreis97!)
- Fix `ConciseView` for interactive advanced function when writing error (#13623)
- Add support for `TLS` 1.3 in Web cmdlets (#13409) (Thanks @iSazonov!)
- Add null check for `args` in `CommandLineParser` (#13451) (Thanks @iSazonov!)
- Process reparse points for Microsoft Store applications (#13481) (Thanks @iSazonov!)
- Use field if property does not exist for `ObRoot` when using PowerShell Direct to container (#13375) (Thanks @hemisphera!)
- Suppress `UTF-7` obsolete warnings (#13484)
- Avoid multiple enumerations of an `IEnumerable<Expression>` instance in `Compiler.cs` (#13491)
- Change `Add-Type -OutputType` to not support `ConsoleApplication` and `WindowsApplication` (#13440)
- Create warnings when `UTF-7` is specified as an encoding (#13430)
- Fix error message from new symbolic link missing target (#13085) (Thanks @yecril71pl!)
- Make the parameter `args` non-nullable in the public `ConsoleHost` APIs (#13429)
- Add missing dispose for `CancellationTokenSource` (#13420) (Thanks @Youssef1313!)
- Fix `Get-Help` not properly displaying if parameter supports wildcards (#13353) (Thanks @ThomasNieto!)
- Update `pwsh` help for `-InputFormat` parameter (#13355) (Thanks @sethvs!)
- Declare MIT license for files copied from Roslyn (#13305) (Thanks @xtqqczze!)
- Improve `BigInteger` casting behaviors (#12629) (Thanks @vexx32!)
- Fix `Get-Acl -LiteralPath "HKLM:Software\Classes\*"` behavior (#13107) (Thanks @Shriram0908!)
- Add `DefaultVisit` method to the visitor interface and class (#13258)
- Fix conflicting shorthand switch `-s` (STA) for `pwsh` (#13262) (Thanks @iSazonov!)
- Change `Read-Host -MaskInput` to use existing `SecureString` path, but return as plain text (#13256)
- Remove `ComEnumerator` as COM objects using `IEnumerator` is now supported in .NET 5.0 (#13259)
- Use temporary personal path at Runspace startup when the 'HOME' environment variable is not defined (#13239)
- Fix `Invoke-Command` to detect recursive call of the same history entry (#13197)
- Change `pwsh` executable `-inputformat` switch prefix `-in` to `-inp` to fix conflict with `-interactive` (#13205) (Thanks @iSazonov!)
- Handle WSL filesystem path when analyze security zone of a file (#13120)
- Make other switches mandatory in `Split-Path` (#13150) (Thanks @kvprasoon!)
- New Fluent Design icon for PowerShell 7 (#13100) (Thanks @sarthakmalik!)
- Fix `Move-Item` to support cross-mount moves on Unix (#13044)
- Fix `NullReferenceException` in `CommandSearcher.GetNextCmdlet` (#12659) (Thanks @powercode!)
- Prevent `NullReferenceException` in Unix computer cmdlets with test hooks active (#12651) (Thanks @vexx32!)
- Fix issue in `Select-Object` where `Hashtable` members (e.g. `Keys`) cannot be used with `-Property` or `-ExpandProperty` (#11097) (Thanks @vexx32!)
- Fix conflicting shorthand switch `-w` for pwsh (#12945)
- Rename the `CimCmdlet` resource file (#12955) (Thanks @iSazonov!)
- Remove use of `Test-Path` in `ConciseView` (#12778)
- Flag `default` switch statement condition clause as keyword (#10487) (Thanks @msftrncs!)
- Add parameter `SchemaFile` to `Test-Json` cmdlet (#11934) (Thanks @beatcracker!)
- Bring back Certificate provider parameters (#10622) (Thanks @iSazonov!)
- Fix `New-Item` to create symbolic link to relative path target (#12797) (Thanks @iSazonov!)
- Add `CommandLine` property to Process (#12288) (Thanks @iSazonov!)
- Adds `-MaskInput` parameter to `Read-Host` (#10908) (Thanks @davinci26!)
- Change `CimCmdlets` to use `AliasAttribute` (#12617) (Thanks @thlac!)
- Fix incorrect index in format string in ParameterBinderBase (#12630) (Thanks @powercode!)
- Copy the `CommandInfo` property in `Command.Clone()` (#12301) (Thanks @TylerLeonhardt!)
- Apply `-IncludeEqual` in `Compare-Object` when `-ExcludeDifferent` is specified (#12317) (Thanks @davidseibel!)
- Change `Get-FileHash` to close file handles before writing output (#12474) (Thanks @HumanEquivalentUnit!)
- Fix inconsistent exception message in `-replace` operator (#12388) (Thanks @jackdcasey!)
- Fix `WinCompat` module loading to treat PowerShell 7 modules with higher priority (#12269)
- Implement `ForEach-Object -Parallel` runspace reuse (#12122)
- Fix `Get-Service` to not modify collection while enumerating it (#11851) (Thanks @NextTurn!)
- Clean up the IPC named pipe on PowerShell exit (#12187)
- Fix `<img />` detection regex in web cmdlets (#12099) (Thanks @vexx32!)
- Allow shorter signed hex literals with appropriate type suffixes (#11844) (Thanks @vexx32!)
- Update `UseNewEnvironment` parameter behavior of `Start-Process` cmdlet on Windows (#10830) (Thanks @iSazonov!)
- Add `-Shuffle` switch to `Get-Random` command (#11093) (Thanks @eugenesmlv!)
- Make `GetWindowsPowerShellModulePath` compatible with multiple PS installations (#12280)
- Fix `Start-Job` to work on systems that don't have Windows PowerShell registered as default shell (#12296)
- Specifying an alias and `-Syntax` to `Get-Command` returns the aliased commands syntax (#10784) (Thanks @ChrisLGardner!)
- Make CSV cmdlets work when using `-AsNeeded` and there is an incomplete row (#12281) (Thanks @iSazonov!)
- In local invocations, do not require `-PowerShellVersion 5.1` for `Get-FormatData` in order to see all format data. (#11270) (Thanks @mklement0!)
- Added Support For Big Endian `UTF-32` (#11947) (Thanks @NoMoreFood!)
- Fix possible race that leaks PowerShell object dispose in `ForEach-Object -Parallel` (#12227)
- Add `-FromUnixTime` to `Get-Date` to allow Unix time input (#12179) (Thanks @jackdcasey!)
- Change default progress foreground and background colors to provide improved contrast (#11455) (Thanks @rkeithhill!)
- Fix `foreach -parallel` when current drive is not available (#12197)
- Do not wrap return result to `PSObject` when converting `ScriptBlock` to `delegate` (#10619)
- Don't write DNS resolution errors on `Test-Connection -Quiet` (#12204) (Thanks @vexx32!)
- Use dedicated threads to read the redirected output and error streams from the child process for out-of-proc jobs (#11713)
- Fix an operator preference order issue in binder code (#12075) (Thanks @DamirAinullin!)
- Fix `NullReferenceException` when binding common parameters of type `ActionPreference` (#12124)
- Fix default formatting for deserialized `MatchInfo` (#11728) (Thanks @iSazonov!)
- Use asynchronous streams in `Invoke-RestMethod` (#11095) (Thanks @iSazonov!)
- Address UTF-8 Detection In `Get-Content -Tail` (#11899) (Thanks @NoMoreFood!)
- Handle the `IOException` in `Get-FileHash` (#11944) (Thanks @iSazonov!)
- Change `PowerShell Core` to `PowerShell` in a resource string (#11928) (Thanks @alexandair!)
- Bring back `MainWindowTitle` in `PSHostProcessInfo` (#11885) (Thanks @iSazonov!)
- Miscellaneous minor updates to Windows Compatibility (#11980)
- Fix `ConciseView` to split `PositionMessage` using `[Environment]::NewLine` (#12010)
- Remove network hop restriction for interactive sessions (#11920)
- Fix `NullReferenceException` in `SuspendStoppingPipeline()` and `RestoreStoppingPipeline()` (#11870) (Thanks @iSazonov!)
- Generate GUID for `FormatViewDefinition` `InstanceId` if not provided (#11896)
- Fix `ConciseView` where error message is wider than window width and doesn't have whitespace (#11880)
- Allow cross-platform `CAPI-compatible` remote key exchange (#11185) (Thanks @silijon!)
- Fix error message (#11862) (Thanks @NextTurn!)
- Fix `ConciseView` to handle case where there isn't a console to obtain the width (#11784)
- Update `CmsCommands` to use Store vs certificate provider (#11643) (Thanks @mikeTWC1984!)
- Enable `pwsh` to work on Windows systems where `mpr.dll` and STA is not available (#11748)
- Refactor and implement `Restart-Computer` for `Un*x` and macOS (#11319)
- Add an implementation of `Stop-Computer` for Linux and macOS (#11151)
- Fix `help` function to check if `less` is available before using (#11737)
- Update `PSPath` in `certificate_format_ps1.xml` (#11603) (Thanks @xtqqczze!)
- Change regular expression to match relation-types without quotes in Link header (#11711) (Thanks @Marusyk!)
- Fix error message during symbolic link deletion (#11331)
- Add custom `Selected.*` type to `PSCustomObject` in `Select-Object` only once (#11548) (Thanks @iSazonov!)
- Add `-AsUTC` to the `Get-Date` cmdlet (#11611)
- Fix grouping behavior with Boolean values in `Format-Hex` (#11587) (Thanks @vexx32!)
- Make `Test-Connection` always use the default synchronization context for sending ping requests (#11517)
- Correct startup error messages (#11473) (Thanks @iSazonov!)
- Ignore headers with null values in web cmdlets (#11424) (Thanks @iSazonov!)
- Re-add check for `Invoke-Command` job dispose. (#11388)
- Revert "Update formatter to not write newlines if content is empty (#11193)" (#11342) (Thanks @iSazonov!)
- Allow `CompleteInput` to return results from `ArgumentCompleter` when `AST` or Script has matching function definition (#10574) (Thanks @M1kep!)
- Update formatter to not write new lines if content is empty (#11193)

<!-- TODO: add more general contributor thank you listing -->
