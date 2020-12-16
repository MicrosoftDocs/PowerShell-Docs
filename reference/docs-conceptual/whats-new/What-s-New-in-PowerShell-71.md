---
title: What's New in PowerShell 7.1
description: New features and changes released in PowerShell 7.1
ms.date: 12/15/2020
---

# What's New in PowerShell 7.1

On November 11, 2020 we
[announced](https://devblogs.microsoft.com/powershell/announcing-powershell-7-1/) the general
availability of PowerShell 7.1. Building on the foundation established in PowerShell 7.0, our
efforts focused on community issues and include a number of improvements and fixes. We are committed
to ensuring that PowerShell remains a stable and performant platform.

PowerShell 7.1 includes the following features, updates, and breaking changes.

- PSReadLine 2.1.0, which includes Predictive IntelliSense
- PowerShell 7.1 has been published to the Microsoft Store
- Installer packages updated for new OS versions with support for ARM64
- 4 new experimental features and 2 experimental features promoted to mainstream
- Several breaking changes to improve usability

For a complete list of changes, see the
[CHANGELOG](https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG/7.1.md) in the GitHub
repository.

## PSReadLine 2.1.0

PowerShell 7.1 also include PSReadLine 2.1.0. This version includes Predictive IntelliSense. For
more information about the Predictive IntelliSense feature, see the
[announcement](https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/)
in the PowerShell blog.

## Microsoft Store installer package

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

## Other installers

For more up-to-date information about supported operating systems and support lifecycle, see the
[PowerShell Support Lifecycle](/powershell/scripting/powershell-support-lifecycle).

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

## Experimental Features

For more information about the Experimental Features, see [Using Experimental Features](../learn/experimental-features.md).

The following experimental features are now mainstream features in this release:

- [PSNullConditionalOperators](../learn/experimental-features.md#psnullconditionaloperators)
- [PSUnixFileStat](../learn/experimental-features.md#psunixfilestat)

The following experimental features were added in this release:

- [Microsoft.PowerShell.Utility.PSManageBreakpointsInRunspace](../learn/experimental-features.md#microsoftpowershellutilitypsmanagebreakpointsinrunspace)
  - PowerShell 7.1 extends this experimental feature to add the **Runspace** parameter to all
  `*-PSBreakpoint` cmdlets. The **Runspace** parameter specifies a **Runspace** object to interact
  with breakpoints in the specified runspace.

- [PSNativePSPathResolution](../learn/experimental-features.md#psnativepspathresolution) - This
  feature allows you to pass PowerShell provider paths to native commands that don't support
  PowerShell path syntax.

- [PSCultureInvariantReplaceOperator](../learn/experimental-features.md#pscultureinvariantreplaceoperator) -
  When the left-hand operand in a `-replace` operator statement is not a string, that operand is
  converted to a string. With the feature enabled, the conversion does not use Culture settings for
  string conversion.

- [PSSubsystemPluginModel](../learn/experimental-features.md#pssubsystempluginmodel) lays the
  groundwork to support future Predictive IntelliSense plug-ins.

## Breaking Changes and Improvements

- Fix `$?` to not be `$false` when native command writes to `stderr`
  ([#13395](https://github.com/PowerShell/PowerShell/pull/13395))

  It is common for native commands to write to `stderr` without intending to indicate a failure.
  With this change `$?` is set to `$false` only when the native command also has a non-zero exit
  code. This change is unrelated to the experimental feature `PSNotApplyErrorActionToStderr`.

- Make `$ErrorActionPreference` not affect `stderr` output of native commands
  ([#13361](https://github.com/PowerShell/PowerShell/pull/13361))

  It is common for native commands to write to `stderr` without intending to indicate a failure.
  With this change, `stderr` output is still captured in **ErrorRecord** objects, but the runtime no
  longer applies `$ErrorActionPreference` if the **ErrorRecord** comes from a native command.

- Rename `-FromUnixTime` to `-UnixTimeSeconds` on `Get-Date` to allow Unix time input
  ([#13084](https://github.com/PowerShell/PowerShell/pull/13084)) (Thanks @aetos382!)

  The `-FromUnixTime` parameter was added during 7.1-preview.2. The parameter was renamed to better
  match the data type. This parameter takes an integer value that represents in seconds since
  January 1, 1970, 0:00:00.

  This example converts a Unix time (represented by the number of seconds since 1970-01-01 0:00:00) to DateTime.

  ```powershell
  Get-Date -UnixTimeSeconds 1577836800

  Wednesday, January 01, 2020 12:00:00 AM
  ```

- Allow explicitly specified named parameter to supersede the same one from hashtable splatting (#13162)

  With this change, the named parameters from splatting are moved to the end of the parameter list
  so that they are bound after all explicitly specified named parameters are bound. Parameter
  binding for simple functions doesn't throw an error when a specified named parameter cannot be
  found. Unknown named parameters are bound to the `$args` parameter of the simple function. Moving
  splatting to the end of the argument list changes the order the parameters appears in `$args`.

  For example:

  ```powershell
  function SimpleTest {
      param(
          $Name,
          $Path
      )
      "Name: $Name; Path: $Path; Args: $args"
  }
  ```

  In the previous behavior, **MyPath** is not bound to `-Path` because it's the third argument in
  the argument list. ## So it ends up being stuffed into '$args' along with `Blah = "World"`

  ```powershell
  PS> $hash = @{ Name = "Hello"; Blah = "World" }
  PS> SimpleTest @hash "MyPath"
  Name: Hello; Path: ; Args: -Blah: World MyPath
  ```

  With this change, the arguments from `@hash` are moved to the end of the argument list. **MyPath**
  becomes the first argument in the list, so it is bound to `-Path`.

  ```powershell
  PS> SimpleTest @hash "MyPath"
  Name: Hello; Path: MyPath; Args: -Blah: World
  ```

- Make the switch parameter `-Qualifier` not positional for `Split-Path`
  ([#12960](https://github.com/PowerShell/PowerShell/pull/12960)) (Thanks @yecril71pl!)

- Resolve the working directory as literal path for `Start-Process` when it's not specified
  ([#11946](https://github.com/PowerShell/PowerShell/pull/11946)) (Thanks @NoMoreFood!)

- Make `-OutFile` parameter in web cmdlets to work like `-LiteralPath`
  ([#11701](https://github.com/PowerShell/PowerShell/pull/11701)) (Thanks @iSazonov!)

- Fix string parameter binding for `BigInteger` numeric literals
  ([#11634](https://github.com/PowerShell/PowerShell/pull/11634)) (Thanks @vexx32!)

- On Windows, `Start-Process` creates a process environment with all the environment variables from
  current session, using `-UseNewEnvironment` creates a new default process environment
  ([#10830](https://github.com/PowerShell/PowerShell/pull/10830)) (Thanks @iSazonov!)

- Do not wrap return result in `PSObject` when converting a `ScriptBlock` to a delegate
  ([#10619](https://github.com/PowerShell/PowerShell/pull/10619))

  When a `ScriptBlock` is converted to a delegate type to be used in C# context, wrapping the result
  in a `PSObject` brings unneeded troubles:

  - When the value is converted to the delegate return type, the `PSObject` essentially gets
    unwrapped. So the `PSObject` is unneeded.
  - When the delegate return type is `object`, it gets wrapped in a `PSObject` making it hard to
    work with in C# code.

  After this change, the returned object is the underlying object.
