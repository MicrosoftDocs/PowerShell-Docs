---
description: This article explains the features of Windows using Windows Defender Application Control (WDAC) that can be used to secure your PowerShell environment.
ms.date: 09/19/2024
title: Use Windows Defender Application Control to secure PowerShell
---
# Use Windows Defender Application Control to secure PowerShell

Windows 10 includes two technologies, [Windows Defender Application Control (WDAC)][04] and
[AppLocker][01] that you can use to control applications. They allow you to create a lockdown
experience to help secure your PowerShell environment.

**AppLocker** builds on the application control features of Software Restriction Policies. AppLocker
allows you to create rules to allow or deny apps for specific users or groups. You identify the apps
based on unique properties of the files.

**WDAC**, introduced with Windows 10, allows you to control which drivers and applications are
allowed to run on Windows.

PowerShell detects both AppLocker and WDAC system wide policies. AppLocker is deprecated. WDAC is
the preferred application control system for Windows. WDAC is designed as a security feature under
the servicing criteria defined by the Microsoft Security Response Center (MSRC).

For more information about AppLocker and WDAC, see [Application Controls for Windows][04] and
[WDAC and AppLocker feature availability][02].

> [!NOTE]
> When [choosing between WDAC or AppLocker][03], we recommend that you implement application control
> using WDAC rather than AppLocker. Microsoft is continually improving WDAC and Microsoft management
> platforms are extending their support for WDAC. Although AppLocker may continue to receive
> security fixes, it won't receive feature enhancements.

## WDAC policy enforcement

When PowerShell runs under a WDAC policy, its behavior changes based on the defined security policy.
Under a WDAC policy, PowerShell runs trusted scripts and modules allowed by the policy in
`FullLanguage` mode. All other scripts and script blocks are untrusted and run in
`ConstrainedLanguage` mode. PowerShell throws errors when the untrusted scripts attempt to perform
actions that aren't allowed in `ConstrainedLanguage` mode. It can be difficult to know why a script
failed to run correctly in `ConstrainedLanguage` mode.

## WDAC policy auditing

PowerShell 7.4 added a new feature to support WDAC policies in **Audit** mode. In audit mode,
PowerShell runs the untrusted scripts in `ConstrainedLanguage` mode without errors, but logs
messages to the event log instead. The log messages describe what restrictions would apply if the
policy were in **Enforce** mode.

## History of changes

Windows PowerShell 5.1 was the first version of PowerShell to support WDAC. The security features of
WDAC and AppLocker improve with each new release of PowerShell. The following sections describe how
this support changed in each version of PowerShell. The changes are cumulative, so the features
described in the later versions include those from earlier versions.

### Changes in PowerShell 7.4

On Windows, when PowerShell runs under a Windows Defender Application Control (WDAC) policy, its
behavior changes based on the defined security policy. Under a WDAC policy, PowerShell runs trusted
scripts and modules allowed by the policy in `FullLanguage` mode. All other scripts and script
blocks are untrusted and run in `ConstrainedLanguage` mode. PowerShell throws errors when the
untrusted scripts attempt to perform disallowed actions. It's difficult to know why a script fails
to run correctly in `ConstrainedLanguage` mode.

PowerShell 7.4 now supports WDAC policies in **Audit** mode. In audit mode, PowerShell runs the
untrusted scripts in `ConstrainedLanguage` mode but logs messages to the event log instead of
throwing errors. The log messages describe what restrictions would apply if the policy were in
**Enforce** mode.

### Changes in PowerShell 7.3

- PowerShell 7.3 now supports the ability to block or allow PowerShell script files via the WDAC
  API.

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

- For more information about how WDAC works and what restrictions it enforces, see
  [How WDAC works with PowerShell][06].
- For more information about securing PowerShell with WDAC, see [How to use WDAC][05].

<!-- link references -->
[01]: /windows/security/threat-protection/windows-defender-application-control/applocker/what-is-applocker
[02]: /windows/security/threat-protection/windows-defender-application-control/feature-availability
[03]: /windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview#choose-when-to-use-wdac-or-applocker
[04]: /windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control
[05]: how-to-use-wdac.md
[06]: how-wdac-works.md
