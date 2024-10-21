---
description: This article explains the features of Windows using Application Control for Business that can be used to secure your PowerShell environment.
ms.date: 09/19/2024
title: Use Application Control for Business to secure PowerShell
---
# Use Application Control for Business to secure PowerShell

Windows 10 includes two technologies, [Application Control for Business][04] and [AppLocker][01] that you can use to control applications. They allow you to create a lockdown experience to help secure your PowerShell environment.

**AppLocker** builds on the application control features of Software Restriction Policies. AppLocker
allows you to create rules to allow or deny apps for specific users or groups. You identify the apps
based on unique properties of the files.

**App Control for Business**, introduced with Windows 10, allows you to control which drivers and applications are allowed to run on Windows.

## Lockdown policy detection

PowerShell detects both AppLocker and App Control for Business system wide policies. AppLocker doesn't have way to query the policy enforcement status. To detect if a system wide application control policy is being enforced by AppLocker, PowerShell creates two temporary files and tests if they can be executed. The filenames use the following name format:

- `$env:TEMP/__PSAppLockerTest__<random-8dot3-name>.ps1`
- `$env:TEMP/__PSAppLockerTest__<random-8dot3-name>.psm1`

Application Control for Business is the preferred application control system for Windows. It provides APIs that allow you to discover the policy configuration. App Control is designed as a security feature under the servicing criteria defined by the Microsoft Security Response Center (MSRC).

For more information about AppLocker and Application Control for Business, see [Application Controls for Windows][04] and [App Control for Business and AppLocker feature availability][02].

> [!NOTE]
> When [choosing between App Control for Business or AppLocker][03], we recommend that you implement application control
> using App Control for Business rather than AppLocker. Microsoft is continually improving App Control for Business and Microsoft management
> platforms are extending their support for App control for Business. Although AppLocker may continue to receive
> security fixes, it won't receive feature enhancements.

## Application Control for Business policy enforcement

When PowerShell runs under an App Control for Business policy, its behavior changes based on the defined security policy. Under an App Control for Business policy, PowerShell runs trusted scripts and modules allowed by the policy in `FullLanguage` mode. All other scripts and script blocks are untrusted and run in `ConstrainedLanguage` mode. PowerShell throws errors when the untrusted scripts attempt to perform actions that aren't allowed in `ConstrainedLanguage` mode. It can be difficult to know why a script failed to run correctly in `ConstrainedLanguage` mode.

## App Control for Business policy auditing

PowerShell 7.4 added a new feature to support App Control for Business policies in **Audit** mode. In audit mode, PowerShell runs the untrusted scripts in `ConstrainedLanguage` mode without errors, but logs messages to the event log instead. The log messages describe what restrictions would apply if the
policy were in **Enforce** mode.

## History of changes

Windows PowerShell 5.1 was the first version of PowerShell to support App Control for Business. The security features of App Control for Business and AppLocker improve with each new release of PowerShell. The following sections describe how this support changed in each version of PowerShell. The changes are cumulative, so the features described in the later versions include those from earlier versions.

### Changes in PowerShell 7.4

On Windows, when PowerShell runs under an Application Control for Business policy, its
behavior changes based on the defined security policy. Under an App Control for Business policy, PowerShell runs trusted scripts and modules allowed by the policy in `FullLanguage` mode. All other scripts and script blocks are untrusted and run in `ConstrainedLanguage` mode. PowerShell throws errors when the untrusted scripts attempt to perform disallowed actions. It's difficult to know why a script fails to run correctly in `ConstrainedLanguage` mode.

PowerShell 7.4 now supports App Control for Business policies in **Audit** mode. In audit mode, PowerShell runs the untrusted scripts in `ConstrainedLanguage` mode but logs messages to the event log instead of throwing errors. The log messages describe what restrictions would apply if the policy were in **Enforce** mode.

### Changes in PowerShell 7.3

- PowerShell 7.3 now supports the ability to block or allow PowerShell script files via the App Control for Business API.

### Changes in PowerShell 7.2

- There was a corner-case scenario in AppLocker where you only have **Deny** rules and constrained
  mode isn't used to enforce the policy that allows you to bypass the execution policy. Beginning in
  PowerShell 7.2, a change was made to ensure AppLocker rules take precedence over a
  `Set-ExecutionPolicy -ExecutionPolicy Bypass` command.

- PowerShell 7.2 now disallows the use of the `Add-Type` cmdlet in a `NoLanguage` mode PowerShell
  session on a locked down machine.

- PowerShell 7.2 now disallows scripts from using COM objects in AppLocker system lockdown
  conditions. Cmdlets that use COM or DCOM internally aren't affected.

## Further reading

- For more information about how Application Control for Business works and what restrictions it enforces, see
  [How Application Control for Business works with PowerShell][06].
- For more information about securing PowerShell with App Control for Business, see [How to use Application Control for Business][05].

<!-- link references -->
[01]: /windows/security/threat-protection/windows-defender-application-control/applocker/what-is-applocker
[02]: /windows/security/threat-protection/windows-defender-application-control/feature-availability
[03]: /windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview#choose-when-to-use-wdac-or-applocker
[04]: /windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control
[05]: how-to-use-wdac.md
[06]: how-wdac-works.md
