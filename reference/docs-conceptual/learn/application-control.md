---
description: PowerShell has several features designed to improve the security of your scripting environment.
ms.date: 05/23/2023
title: Using Windows Defender Application Control
---
# Using Windows Defender Application Control

Windows 10 includes two technologies, [Windows Defender Application Control (WDAC)][04] and
[AppLocker][01] that can be used for application control. They allow you to create a lockdown
experience to meet your organization's specific scenarios and requirements.

> [!NOTE]
> When it comes to [choosing between WDAC or AppLocker][03] it's generally recommended that
> customers implement application control using WDAC rather than AppLocker. WDAC is undergoing
> continual improvements and will be getting added support from Microsoft management platforms.
> Although AppLocker will continue to receive security fixes, it will not receive feature
> enhancements.

**WDAC** was introduced with Windows 10 and allows organizations to control which drivers and
applications are allowed to run on their Windows 10 devices. WDAC is designed as a security feature
under the servicing criteria defined by the Microsoft Security Response Center (MSRC).

**AppLocker** builds on the application control features of Software Restriction Policies. AppLocker
contains new capabilities and extensions that enable you to create rules to allow or deny apps from
running based on unique identities of files and to specify which users or groups can run those apps.

For more information about AppLocker and Windows Defender Application Control (WDAC), see
[Application Controls for Windows][04] and [WDAC and AppLocker feature availability][02].

## WDAC policy enforcement

On Windows, when PowerShell runs under a Windows Defender Application Control (WDAC) policy, it
changes its behavior to based on the defined security policy. Under a WDAC policy, PowerShell runs
trusted scripts and modules allowed by the policy in Full Language mode. All other scripts and
script blocks are untrusted and run in Constrained Language mode. PowerShell throws errors when the
untrusted scripts attempt to perform disallowed actions. It's difficult to know why a script fails
to run correctly Constrained Language mode.

## WDAC policy auditing

PowerShell 7.4-preview.4 added a new experimental feature, `PSConstrainedAuditLogging`. When you
enable this feature, PowerShell supports WDAC policies is in **Audit** mode. In audit mode,
PowerShell runs the untrusted scripts in Constrained Language mode without error, but logs messages
to the event log instead of throwing errors. The log messages describe what restrictions would apply
if the policy was in **Enforce** mode.

<!-- link references -->
[01]: /windows/security/threat-protection/windows-defender-application-control/applocker/what-is-applocker
[02]: /windows/security/threat-protection/windows-defender-application-control/feature-availability
[03]: /windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview#choose-when-to-use-wdac-or-applocker
[04]: /windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control
