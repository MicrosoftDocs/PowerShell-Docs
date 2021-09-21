---
title: What's New in PowerShell 7.2
description: New features and changes released in PowerShell 7.2
ms.date: 08/17/2021
---

# What's New in PowerShell 7.2

On November {X}, 2021 we [announced][announced] the general availability of PowerShell 7.2. The
long-term-servicing (LTS) release is built on .NET 6.0.

PowerShell 7.2 includes the following features, updates, and breaking changes.

- PSReadLine 2.2 with just-in-time help and command predictions
- Improved DSC support in PowerShell 7
  - Removed PSDesiredStateConfiguration - must install from the PowerShell Gallery
- Microsoft Update support {TBD}
- New universal installer packages for most Linux distributions
- 3 new experimental features
  - Improved native command support
  - Improved ANSI color support
- 7 experimental features promoted to mainstream and 1 removed
- Several breaking changes to improve usability

For a complete list of changes, see the [CHANGELOG][CHANGELOG] in the GitHub repository.

## Improved DSC support in PowerShell 7

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

We are continuing on this journey to make DSC a cross-platform technology during 7.2 timeframe:

- Separate out the DSC parts in the PowerShell engine and moved them as a subsystem into the
  PSDesiredStateConfiguration module
- Removing the dependency on MOF. Initially, only support DSC Resources written as PowerShell
  classes. This includes tooling to convert existing script based DSC Resources to be wrapped as
  PowerShell classes.

Additional work that we are considering, but may not make it as part of the initial release:

- Change generated DSC configuration files from MOF to using JSON
- Enabling integration of DSC with existing agents (no LCM support)
- Open sourcing the PSDesiredStateConfiguration module

## Installation updates

Check the installation instructions for your preferred operating system:

- [Windows][Windows]
- [macOS][macOS]
- [Linux][Linux]

Additionally, PowerShell 7.2 supports ARM32 and ARM64 builds of Debian, Ubuntu, and ARM64 Alpine
Linux and an ARM64 build for macOS .

For up-to-date information about supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle][lifecycle].

### New universal install packages for Linux distributions

Previously, we created separate installer packages for each supported version of CentOS, RHEL,
Debian, and Ubuntu. The universal installer package combines eight different packages into one,
making installation on Linux less complicated. The universal package installs the necessary
dependencies for the target distribution and creates the platform-specific changes to make
PowerShell work.

### Microsoft Update support for Windows

PowerShell 7.2 add support for Microsoft Update. When you enable this feature, you'll get the latest
PowerShell 7 updates in your traditional Windows Update (WU) management flow, whether that's with
Windows Update for Business, WSUS, SCCM, or the interactive WU dialog in Settings.

The PowerShell 7.2 MSI package includes following command-line options:

- `USE_MU` - This property has two possible values:
  - `1` (default) - Opts into updating through Microsoft Update or WSUS
  - `0` -  Do not opt into updating through Microsoft Update or WSUS
- `ENABLE_MU`
  - `1` (default) - Opts into using Microsoft Update the Automatic Updates or Windows Update
  - `0` - Do not opt into using Microsoft Update the Automatic Updates or Windows Update

## Experimental Features

The following experimental features are now mainstream features in this release:

- `Microsoft.PowerShell.Utility.PSImportPSDataFileSkipLimitCheck`
- `Microsoft.PowerShell.Utility.PSManageBreakpointsInRunspace`
- `PSAnsiRendering` - see [about_ANSI_Terminals][ansi]
- `PSAnsiProgress` - see [about_ANSI_Terminals][ansi]
- `PSCultureInvariantReplaceOperator`
- `PSNotApplyErrorActionToStderr`
- `PSUnixFileStat`

The following experimental features were added in this release:

- [PSNativeCommandArgumentPassing][native] - When this experimental feature is enabled PowerShell
  uses the **ArgumentList** property of the **StartProcessInfo** object rather than our current
  mechanism of reconstructing a string when invoking a native executable. This feature adds a new
  automatic variable `$PSNativeCommandArgumentPassing` that allows you to select the behavior at
  runtime.

For more information about the Experimental Features, see [Using Experimental Features][exp].

## Improved Tab Completions

PowerShell 7.2 includes several improvements to Tab Completion. These changes include bug fixes and
improve usability.

- Fix tab completion for unlocalized about* topics (#15265) (Thanks @MartinGC94)
- Fix splatting being treated as positional parameter in completions (#14623) (Thanks @MartinGC94)
- Add completions for comment-based help keywords (#15337) (Thanks @MartinGC94)
- Add completion for Requires statements (#14596) (Thanks @MartinGC94)
- Added tab completion for View parameter of Format-* cmdlets (#14513) (Thanks @iSazonov)

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

<!-- reference links -->

[announced]: https://devblogs.microsoft.com/powershell/announcing-powershell-7-2/
[ansi]: /powershell/module/microsoft.powershell.core/about/about_ansi_terminals
[Arch]: https://aur.archlinux.org/packages/powershell/
[CHANGELOG]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/7.2.md
[exp]: ../learn/experimental-features.md
[lifecycle]: /powershell/scripting/powershell-support-lifecycle
[Linux]: /powershell/scripting/install/installing-powershell-core-on-linux
[macOS]: /powershell/scripting/install/installing-powershell-core-on-macos
[native]: ../learn/experimental-features.md#psnativecommandargumentpassing
[ssh]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
[Windows]: /powershell/scripting/install/installing-powershell-core-on-windows
