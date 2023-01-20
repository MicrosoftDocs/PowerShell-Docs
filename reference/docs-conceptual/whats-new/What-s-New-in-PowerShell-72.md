---
title: What's New in PowerShell 7.2
description: New features and changes released in PowerShell 7.2
ms.date: 01/20/2023
---

# What's New in PowerShell 7.2

PowerShell 7.2 is the next Long Term Servicing (LTS) release is built on .NET 6.0.

PowerShell 7.2 includes the following features, updates, and breaking changes.

- New universal installer packages for most supported Linux distributions
- Microsoft Update support on Windows
- 2 new experimental features
  - Improved native command argument passing support
  - ANSI FileInfo color support
- Improved Tab Completions
- PSReadLine 2.1 with Predictive IntelliSense
- 7 experimental features promoted to mainstream and 1 removed
- Separating DSC from PowerShell 7 to enable future improvements
- Several breaking changes to improve usability

For a complete list of changes, see the [Change Log][11] in the GitHub repository.

## Installation updates

Check the installation instructions for your preferred operating system:

- [Windows][09]
- [macOS][08]
- [Linux][07]

Additionally, PowerShell 7.2 supports ARM64 versions of Windows and macOS and ARM32 and ARM64
versions of Debian and Ubuntu.

For up-to-date information about supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle][10].

### New universal install packages for Linux distributions

Previously, we created separate installer packages for each supported version of CentOS, RHEL,
Debian, and Ubuntu. The universal installer package combines eight different packages into one,
making installation on Linux simpler. The universal package installs the necessary dependencies for
the target distribution and creates the platform-specific changes to make PowerShell work.

### Microsoft Update support for Windows

PowerShell 7.2 add support for Microsoft Update. When you enable this feature, you'll get the latest
PowerShell 7 updates in your traditional Windows Update (WU) management flow, whether that's with
Windows Update for Business, WSUS, SCCM, or the interactive WU dialog in Settings.

The PowerShell 7.2 MSI package includes following command-line options:

- `USE_MU` - This property has two possible values:
  - `1` (default) - Opts into updating through Microsoft Update or WSUS
  - `0` -  don't opt into updating through Microsoft Update or WSUS
- `ENABLE_MU`
  - `1` (default) - Opts into using Microsoft Update the Automatic Updates or Windows Update
  - `0` - don't opt into using Microsoft Update the Automatic Updates or Windows Update

## Experimental Features

The following experimental features are now mainstream features in this release:

- `Microsoft.PowerShell.Utility.PSImportPSDataFileSkipLimitCheck` - see
  [Import-PowerShellDataFile][06]
- `Microsoft.PowerShell.Utility.PSManageBreakpointsInRunspace`
- `PSAnsiRendering` - see [about_ANSI_Terminals][05]
- `PSAnsiProgress` - see [about_ANSI_Terminals][05]
- `PSCultureInvariantReplaceOperator`
- `PSNotApplyErrorActionToStderr`
- `PSUnixFileStat`

The following experimental feature was added in this release:

- [PSNativeCommandArgumentPassing][04] - When this experimental feature is enabled PowerShell uses
  the **ArgumentList** property of the **StartProcessInfo** object rather than our current mechanism
  of reconstructing a string when invoking a native executable. This feature adds a new automatic
  variable `$PSNativeCommandArgumentPassing` that allows you to select the behavior at runtime.

- [PSAnsiRenderingFileInfo][02] - Allow ANSI color customization of file information.
- [PSLoadAssemblyFromNativeCode][03] - Exposes an API to allow assembly loading from native code.

For more information about the Experimental Features, see [Using Experimental Features][01].

## Improved Tab Completions

PowerShell 7.2 includes several improvements to Tab Completion. These changes include bugfixes and
improve usability.

- Fix tab completion for unlocalized about* topics (#15265) (Thanks @MartinGC94)
- Fix splatting being treated as positional parameter in completions (#14623) (Thanks @MartinGC94)
- Add completions for comment-based help keywords (#15337) (Thanks @MartinGC94)
- Add completion for Requires statements (#14596) (Thanks @MartinGC94)
- Added tab completion for View parameter of Format-* cmdlets (#14513) (Thanks @iSazonov)

## PSReadLine 2.1 Predictive IntelliSense

PSReadLine 2.1 introduced `CommandPrediction` APIs that establish a framework for providing
predictions for command-line completion. The API enables users to discover, edit, and execute full
commands based on matching predictions from the user's history.

Predictive IntelliSense is disabled by default. To enable predictions, run the following command:

```powershell
Set-PSReadLineOption -PredictionSource History
```

## Separating DSC from PowerShell 7 to enable future improvements

The PSDesiredStateConfiguration module was removed from the PowerShell 7.2 package and is now
published to the PowerShell Gallery. This allows the PSDesiredStateConfiguration module to be
developed independently of PowerShell and users can mix and match versions of PowerShell and
PSDesiredStateConfiguration for their environment. To install PSDesiredStateConfiguration 2.0.5 from
the PowerShell Gallery:

```powershell
Install-Module -Name PSDesiredStateConfiguration -Repository PSGallery -MaximumVersion 2.99
```

> [!IMPORTANT]
> Be sure to include the parameter MaximumVersion or you could install version 3 (or higher) of
> PSDesireStateConfiguration that contains significant differences.

## Engine updates

- Add `LoadAssemblyFromNativeMemory` function to load assemblies in memory from a native PowerShell
  host by awakecoding · Pull Request #14652

## Breaking Changes and Improvements

- The PSDesiredStateConfiguration was removed from the PowerShell 7.2 package
- Make PowerShell Linux deb and RPM packages universal (#15109)
- Experimental feature `PSNativeCommandArgumentPassing`: Use ArgumentList for native executable
  invocation (#14692)
- Ensure `-PipelineVariable` is set for all output from script cmdlets (#12766)
- Emit warning if `ConvertTo-Json` exceeds -Depth value (#13692)
- Remove alias D of -Directory switch CL-General #15171
- Improve detection of mutable value types (#12495)
- Restrict `New-Object` in **NoLanguage** mode under lock down (#14140)
- Enforce AppLocker Deny configuration before Execution Policy Bypass configuration (#15035)
- Change `FileSystemInfo.Target` from a **CodeProperty** to an **AliasProperty** that points to
  `FileSystemInfo.LinkTarget` (#16165)

<!-- end of content -->
<!-- link references -->
[01]: ../learn/experimental-features.md
[02]: ../learn/experimental-features.md#psansirenderingfileinfo
[03]: ../learn/experimental-features.md#psloadassemblyfromnativecode
[04]: ../learn/experimental-features.md#psnativecommandargumentpassing
[05]: /powershell/module/microsoft.powershell.core/about/about_ansi_terminals
[06]: /powershell/module/microsoft.powershell.utility/import-powershelldatafile
[07]: /powershell/scripting/install/installing-powershell-core-on-linux
[08]: /powershell/scripting/install/installing-powershell-core-on-macos
[09]: /powershell/scripting/install/installing-powershell-core-on-windows
[10]: /powershell/scripting/powershell-support-lifecycle
[11]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/7.2.md
