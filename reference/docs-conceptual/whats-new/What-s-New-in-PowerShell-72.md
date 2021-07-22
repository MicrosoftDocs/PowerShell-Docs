---
title: What's New in PowerShell 7.2
description: New features and changes released in PowerShell 7.2
ms.date: 05/25/2021
---

# What's New in PowerShell 7.2

On November {X}, 2021 we [announced][] the general availability of PowerShell 7.2. The
long-term-servicing (LTS) release is built on .NET 6.0.

PowerShell 7.2 includes the following features, updates, and breaking changes.

- PowerShellGet 3.0 and CompatPowerShellGet
- PSReadLine 2.2 with just-in-time help and command predictions
- Improved DSC support in PowerShell 7
  - Removed PSDesiredStateConfiguration - must install from the PowerShell Gallery
- Microsoft Update support {TBD}
- New universal installer packages for most Linux distributions
- 3 new experimental features
  - Improved native command support
  - Improved ANSI color support
- {X} experimental features promoted to mainstream?
- Several breaking changes to improve usability

For a complete list of changes, see the [CHANGELOG][] in the GitHub repository.

## PowerShellGet 3.0 and CompatPowerShellGet

PowerShellGet 3.0 is a complete rewrite of the older PowerShellGet and PackageManagement modules.
This release removes the dependency on the PackageManagement, which we are no longer supporting.
This simplifies the code base making it more maintainable, easier to debug, and easier to extend.
Built around NuGet 3.0, PowerShellGet 3.0 supports NuGet v2 and v3 endpoints for PSRepositories.

CompatPowerShellGet is a compatibility module that allows use of PowerShellGet 2.x (and below)
cmdlet syntax with PowerShellGet 3.0 functionality.

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

- [Windows][]
  - [Microsoft Store package][]
- [macOS][]
- [Linux][]

Additionally, PowerShell 7.2 supports ARM32 and ARM64 flavors of Debian, Ubuntu, and ARM64 Alpine
Linux.

While not officially supported, the community has also provided packages for [Arch][] and Kali
Linux.

> [!NOTE]
> Debian 10+, CentOS 8+, Ubuntu 20.04, Alpine and Arm currently do not support WinRM remoting. For
> details on setting up SSH-based remoting, see [PowerShell Remoting over SSH][].

For up-to-date information about supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle][].

### New universal install packages for Linux distributions

Previously, we created separate installer packages for each supported version of CentOS, RHEL,
Debian, and Ubuntu. The universal installer package combines eight different packages into one,
making installation on Linux less complicated. The universal package installs the necessary
dependencies for the target distribution and creates the platform-specific changes to make
PowerShell work.

### Microsoft Update support for Windows

- Microsoft Update support - See the announcement on the
  [PowerShell Blog](https://devblogs.microsoft.com/powershell/preview-updating-powershell-7-2-with-microsoft-update/).
  - `ADD_MU=1` (default) will opt-in to updating through Microsoft update or WSUS
  - `ADD_MU=0` will opt-out of updating through Microsoft update or WSUS
  - `ENABLE_MU=1` (default) will opt-in to using Microsoft Update the Automatic Updates or Windows
    Update
  - `ENABLE_MU=0` will opt-out of using Microsoft Update the Automatic Updates or Windows Update

## Experimental Features

For more information about the Experimental Features, see [Using Experimental Features][].

The following experimental features are now mainstream features in this release:

{TO DO - mainstream features}

The following experimental features were added in this release:

- [PSAnsiRendering][] - enables changes how the PowerShell engine outputs text and add the
  `$PSStyle` automatic variable to control ANSI rendering of string output.
- [PSAnsiProgress][] - adds the `$PSStyle.Progress`
  member and allows you to control progress view bar rendering.
- [PSNativeCommandArgumentPassing][] - When this experimental feature is enabled PowerShell uses the
  **ArgumentList** property of the **StartProcessInfo** object rather than our current mechanism of
  reconstructing a string when invoking a native executable. This feature adds a new automatic
  variable `$PSNativeCommandArgumentPassing` that allows you to select the behavior at runtime.

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

## Known issues

- Some filesystem cmdlets do not work correctly with long paths, such as Remove-Item, Rename-Item
  and Set-Location. For details see: #15466
- PSReadLine 2.2.0-beta1 and 2.2.0-beta2 do not work with this preview of PowerShell due to breaking
  changes in the prediction interface. The upcoming PSReadLine 2.2.0-beta3 release will resolve
  this. Use PSReadLine 2.1.0 as the temporary workaround.

<!-- reference links -->

[Using Experimental Features]: ../learn/experimental-features.md
[PSAnsiRendering]: ../learn/experimental-features.md#psansirendering
[PSAnsiProgress]: ../learn/experimental-features.md#psansiprogress
[PSNativeCommandArgumentPassing]: ../learn/experimental-features.md#psnativecommandargumentpassing
[announced]: https://devblogs.microsoft.com/powershell/announcing-powershell-7-2/
[CHANGELOG]: https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/7.2.md
[Arch]: https://aur.archlinux.org/packages/powershell/
[Linux]: /powershell/scripting/install/installing-powershell-core-on-linux
[macOS]: /powershell/scripting/install/installing-powershell-core-on-macos
[Windows]: /powershell/scripting/install/installing-powershell-core-on-windows
[Microsoft Store package]: https://www.microsoft.com/store/apps/9MZ1SNWT0N5D
[PowerShell Remoting over SSH]: /powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core
[PowerShell Support Lifecycle]: /powershell/scripting/powershell-support-lifecycle
