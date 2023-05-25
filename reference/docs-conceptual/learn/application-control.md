---
description: You can secure your PowerShell environments on Windows using Windows Defender Application Control (WDAC).
ms.date: 05/23/2023
title: Using Windows Defender Application Control
---
# Using Windows Defender Application Control

Windows 10 includes two technologies, [Windows Defender Application Control (WDAC)][04] and
[AppLocker][01] that you can use to control applications. They allow you to create a lockdown
experience to meet your organization's specific scenarios and requirements.

> [!NOTE]
> When [choosing between WDAC or AppLocker][03], it's generally recommended that customers
> implement application control using WDAC rather than AppLocker. Microsoft is continually
> improving WDAC and Microsoft management platforms are extending their support for WDAC. Although
> AppLocker may continue to receive security fixes, it won't receive feature enhancements.

**WDAC** was introduced with Windows 10 and allows organizations to control which drivers and
applications are allowed to run on their Windows 10 devices. WDAC is designed as a security feature
under the servicing criteria defined by the Microsoft Security Response Center (MSRC).

**AppLocker** builds on the application control features of Software Restriction Policies. AppLocker
contains new capabilities and extensions that enable you to create rules to allow or deny apps from
running based on unique identities of files and to specify which users or groups can run those apps.

For more information about AppLocker and WDAC, see [Application Controls for Windows][04] and
[WDAC and AppLocker feature availability][02].

## WDAC policy enforcement

When PowerShell runs under a WDAC policy, it changes its
behavior based on the defined security policy. Under a WDAC policy, PowerShell runs trusted scripts
and modules allowed by the policy in Full Language mode. All other scripts and script blocks are
untrusted and run in Constrained Language mode. PowerShell throws errors when the untrusted scripts
attempt to perform disallowed actions. It's difficult to know why a script fails to run correctly
in Constrained Language mode.

## WDAC policy auditing

PowerShell 7.4-preview.4 added a new experimental feature, `PSConstrainedAuditLogging`. When you
enable this feature, PowerShell supports WDAC policies in **Audit** mode. In audit mode, PowerShell
runs the untrusted scripts in Constrained Language mode without errors, but logs messages to the
event log instead. The log messages describe what restrictions would apply if the policy was in
**Enforce** mode.

<!-- link references -->
[01]: /windows/security/threat-protection/windows-defender-application-control/applocker/what-is-applocker
[02]: /windows/security/threat-protection/windows-defender-application-control/feature-availability
[03]: /windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview#choose-when-to-use-wdac-or-applocker
[04]: /windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control
