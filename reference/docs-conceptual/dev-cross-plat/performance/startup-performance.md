---
description: How to identify and troubleshoot PowerShell startup issues, including performance problems and crashes.
ms.date: 12/01/2025
title: Troubleshoot PowerShell startup issues
---
# Troubleshoot PowerShell startup issues

Sometimes, PowerShell can have problems before it's even ready to use. Startup issues can be
difficult to troubleshoot, especially when you want to use PowerShell to help. There are three main
phases of startup:

1. Process creation
1. PowerShell SessionState initialization
1. Profile processing

The most common problems include:

- Long startup time or slow performance
- Errors
- Crashes

## The steps of the startup sequence

It's helpful to understand the steps PowerShell goes through during startup. This way, you can
narrow down where the issue is happening.

### Step 1: Process creation

The process creation has a few steps:

1. Create a Host window

   On Windows, the Host can be Windows Terminal, the Windows Console Host, the ISE, Visual Studio
   Code, or any other hosting application. Problems that occur here are usually unrelated to
   PowerShell, but also extremely rare.

1. Start the process host process

   Problems that occur here are usually caused by a corrupted executable or an issue in the
   operating system.

1. Prepare .NET

   PowerShell is .NET-based and that needs to fully load. Depending on which PowerShell version you
   are trying to start, you either get the full, Windows-integrated .NET Framework with Windows
   PowerShell 5.1 or the newer .NET included in PowerShell 7.

   During first-time startup of PowerShell, PowerShell and .NET run optimization tasks. This
   optimization task is only run once, during the first startup after installation, upgrade, or if
   the cache is empty. Startup will take longer during this first-time optimization. Failure during
   optimization can create a corrupted cache. A corrupted PowerShell cache can cause issues with
   command discovery and module loading.

### Step 2: PowerShell SessionState initialization

Loading the PowerShell binaries and initializing the engine involves processing the PowerShell
configuration and some cached data.

1. Process configuration files: `powershell.config.json` and PSSession configuration files used by
   JEA and other remoting scenarios. These files may contain settings that can affect the language
   mode, available commands and modules, and some policy settings.
1. Check Group Policies and Windows Security policies. Windows Group Policies can override settings
   in the `powershell.config.json`. Security Policies can enable features like WDAC (Windows
   Defender Application Control), which can also constrain the language mode available.
1. Load the default modules (Microsoft.PowerShell.Core and PSReadLine) and any modules and
   assemblies defined in the PSSession configuration.

For more information about PowerShell security features, see the following articles:

- [PowerShell security features][01]
- [about_Language_Modes][03]

### Step 3: Profile processing

Finally, PowerShell runs the available profile files. Profile scripts are run in the
following order:

1. All Hosts All Users
1. Current Host All Users
1. All Hosts Current User
1. Current Host Current User

> [!NOTE]
> Profile scripts aren't run for remote sessions.

For more information about profiles, see [about_Profiles][04].

## Narrow the scope of the issue

It's helpful to remove variables and narrow down the specific scope of where the issue happens. The
easiest variable to eliminate is the profile. The profile often contains custom code, especially in
the user-specific profile scripts.

Try running PowerShell with the profile disabled:

```powershell
# PS 5.1:
powershell -NoProfile

# PS 7.*:
pwsh -NoProfile
```

Next you should see if the problem is version-specific. Try running your profile in both Windows
PowerShell 5.1 and PowerShell 7. Windows PowerShell and PowerShell 7 store the profile in different
locations. Your profile may not be the same for both versions. Compare the files to understand the
differences. You can try installing your PowerShell profile in Windows PowerShell 5.1. However, be
aware that some PowerShell 7 commands and modules aren't compatible with Windows PowerShell 5.1.

You can test your PowerShell 7 profile in Windows PowerShell 5.1 without overwriting your existing
profile.

1. Start Windows PowerShell 5.1 with the profile disabled.
1. Manually dot-source your PowerShell 7 profile file into the Windows PowerShell 5.1 session.

   ```powershell
   . $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
   ```

1. Observe whether the issue occurs.

If the issue persists, then you know problem is an environmental issue outside of the profile.

Try running the profile on a different device. If the profile works correctly on another device,
then you know the issue is specific to your original device.

## Troubleshoot common environmental problems

### Crashes during startup

If the PowerShell console crashes during startup, especially early and with no feedback, you could
have a corrupted process cache. This is a rare condition that you can resolve by clearing the
cache. There are two cache locations that can be cleared:

- User Cache: `$env:LOCALAPPDATA\Microsoft\Windows\Caches`
- System Cache: `$env:windir\System32\Config\SystemProfile\AppData\Local\Microsoft\Windows\Caches`

Delete the contents of the user cache folder first, then try starting PowerShell again. If the
problem persists, delete the contents of the system cache and try again.

You may also need to delete the PowerShell analysis cache. You can find the cache files in the
following locations:

- Windows PowerShell:
  `$env:windir\System32\Config\SystemProfile\AppData\Local\Microsoft\Windows\PowerShell`
- PowerShell 7: `$env:LOCALAPPDATA\Microsoft\PowerShell`

Delete only the following file patterns:

- `ModuleAnalysisCache-*`
- `StartupProfileData-*`

The cached data is recreated the next time you start PowerShell.

If the problem persists in Windows PowerShell 5.1, you may need to repair the .NET Framework
installation. For more information, see [Repair the .NET Framework][02].

## Troubleshoot common profile problems

This section describes some common problems that can occur during PowerShell startup, and how to
troubleshoot them.

### Profile takes too long to run

First you must define what's _"too long."_ PowerShell is only doing what the scripts tell it to do.
Check all profile paths. There may be multiple profile scripts being run. Review the code to
understand it's trying to do.

- Determine where the delay occurs

  If there are profile scripts for the **AllUsers** scope, you might not be able to edit those
  files. Work with your system administrator to review those files. For the **CurrentUse** scope
  profile scripts, edit those files to add timing messages to help you find where the delay occurs.
  For example, you can add the following line at various points in your profile script.

  ```powershell
  Write-Host "$(Get-Date -Format 'HH:mm:ss.fff') | Profile: Step X"
  ```

- Reduce dependencies

  Reduce the number of modules that need to be loaded to execute your profile. Run `Get-Module`
  after profile runs to see the modules that were loaded during startup. By default, PowerShell
  loads the Microsoft.PowerShell.Core and PSReadLine modules. Any additional modules were loaded
  by your profile scripts.

  Modules can be loaded explicitly by using `Import-Module` or implicitly by using commands defined
  in those modules. Consider whether you need a command or a module loaded during startup.

- Avoid installing modules in a redirected folder

  In many situations on Windows, your `Documents` folder can be redirected to a network file share
  or to OneDrive. Network file access can be slow, especially if the network is congested or the
  server is under heavy load. Depending on how OneDrive is configured, it can also introduce delays
  or cause errors during profile exectution.

  You have a few options to mitigate this problem:

  - Don't redirect your `Documents` folder, but that might not be desired
  - Configure your `Modules` folder in OneDrive to _always_ be kept on disk. This prevents errors
    and delayed load times.
  - Install modules in the **AllUsers** scope, which is outside of the user profile folder.

- Measure the actual performance

  If you don't know how long your profile takes to run, you can't determine whether it's too long.
  The `Measure-Command` cmdlet can show how long a command or script block takes to run.

  Steve Lee, the PowerShell Dev Manager, has a blog post that describes how to measure the
  performance of your profile. It includes instructions for establishing a baseline for performance,
  how to get detailed timing information, and ways to optimize your profile.

  See [Optimizing your $Profile][05].

### PowerShell 7 starts slowing in an isolated network

In this scenario, your Windows computer in on a network that is not connected to the internet. For
interactive PowerShell sessions, PowerShell loads the PSReadLine module automatically. PSReadLine is
a signed module. PowerShell must verify the digital signature of the module. This verification can
cause delays in a disconnected environment. To test this theory, start PowerShell 7 in
_non-interactive_ mode:

```powershell
pwsh.exe -noninteractive
```

If PowerShell starts quickly in non-interactive mode, then the problem is likely caused by
Certificate Revocation List (CRL) checks. As part of the process of verifying a digital signature,
The .NET runtime checks the CRL to ensure that the signing certificate is still valid. In a
disconnected environment, you computer can't access the CRL on internet. The default timeout for CRL
checks is 15 seconds. This means that every time PowerShell loads a signed module, it can take up to
15 seconds to timeout.

There are three possible workarounds for this problem:

- Firewall or proxy exemption

  Allowing direct internet access for CRL checking prevents the problem. In an environment where you
  can control access to the internet access, you can configure your firewall or proxy to allow
  access to the CRL Urls. This is the easiest solution with the least impact. The firewall logs
  should show the Url that PowerShell attempted to reach.

- Reduce CRL Timeout

  Reducing the CRL lookup timeout is possible, but doing so risks other lookups to fail, that can't
  complete in the time specified. For details about how to change the timeout, see [Manage Network
  Retrieval and Path Validation][04].

- Remove CRL checking

  The CRL checking settings are managed by Group Policy. For more information, see [Manage Trusted
  Publishers][03].

  > [!WARNING]
  > It's possible to disable the CRL check however, it's not recommended. Disabling CRL checking
  > prevents you from actually revoking compromised certificates.

### ERROR: Cannot dot-source this command because it was defined in a different language mode

PowerShell works with application control systems, such as AppLocker and Windows Defender
Application Control (WDAC), by automatically running in **ConstrainedLanguage** mode.
ConstrainedLanguage mode restricts some features that are potentially dangerous. However, there are
times when you need **FullLanguage** mode to use certain commands or features. Scripts can run in
**FullLanguage** mode when they're trusted by the policy. Trust can be indicated through file
signing or other policy mechanisms configured in AppLocker or WDAC.

When you start a PowerShell session that's managed under application control, you get the following
error:

```
Cannot dot-source this command because it was defined in a different language mode. To invoke this
command without importing its contents, omit the '.' operator.
```

Under application control, PowerShell is running in **ConstrainedLanguage** mode. This error occurs
when and your profile script is _exempted_ or is _signed_ to run in **FullLanguage** mode. When
PowerShell is running in **ConstrainedLanguage** mode, it can't dot-source code trusted to run in
**FullLanguage** mode.

To resolve the problem, you must remove the exemption or signature from the profile script. If you
need code that must run in **FullLanguage** mode during your profile, move it into another script
file that's exempted or signed. Call (don't dot-source) that script file from within your profile.

For more information on this issue, see
[PowerShell Constrained Language mode and the Dot-Source Operator][06].

## Further reading

- [about_Language_Modes][03]
- [Measure-Command][07]

<!-- link references -->
[01]: ../../security/security-features.md
[02]: /dotnet/framework/install/repair
[03]: /powershell/module/microsoft.powershell.core/about/about_language_modes
[04]: /powershell/module/microsoft.powershell.core/about/about_profiles
[05]: https://devblogs.microsoft.com/powershell/optimizing-your-profile/
[06]: https://devblogs.microsoft.com/powershell/powershell-constrained-language-mode-and-the-dot-source-operator/
[07]: xref:Microsoft.PowerShell.Utility.Measure-Command
