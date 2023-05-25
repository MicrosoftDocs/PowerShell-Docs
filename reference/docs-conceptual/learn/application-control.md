---
description: You can secure your PowerShell environments on Windows using Windows Defender Application Control (WDAC).
ms.date: 05/23/2023
title: Using Windows Defender Application Control
---
# Using Windows Defender Application Control

Windows 10 includes two technologies, [Windows Defender Application Control (WDAC)][04] and
[AppLocker][01] that you can use to control applications. They allow you to create a lockdown
experience to help secure your PowerShell environment

**AppLocker** builds on the application control features of Software Restriction Policies. AppLocker
contains capabilities and extensions that enable you to create rules to allow or deny apps from
running based on unique identities of files and to specify the users or groups that are allowed to
run those apps.

> [!NOTE]
> When [choosing between WDAC or AppLocker][03], we recommend that you implement application control
> using WDAC rather than AppLocker. Microsoft is continually improving WDAC and Microsoft management
> platforms are extending their support for WDAC. Although AppLocker may continue to receive
> security fixes, it won't receive feature enhancements.

**WDAC** was introduced with Windows 10 and allows organizations to control the drivers and
applications are allowed to run on their Windows devices. WDAC is designed as a security feature
under the servicing criteria defined by the Microsoft Security Response Center (MSRC).

For more information about AppLocker and WDAC, see [Application Controls for Windows][04] and
[WDAC and AppLocker feature availability][02].

## WDAC policy enforcement

When PowerShell runs under a WDAC policy, it changes its behavior based on the defined security
policy. Under a WDAC policy, PowerShell runs trusted scripts and modules allowed by the policy in
Full Language mode. All other scripts and script blocks are untrusted and run in Constrained
Language mode. PowerShell throws errors when the untrusted scripts attempt to perform actions that
aren't allowed in Constrained Language mode. It can be difficult to know why a script failed to run
correctly in Constrained Language mode.

## WDAC policy auditing

PowerShell 7.4-preview.4 added a new experimental feature, `PSConstrainedAuditLogging`. When you
enable this feature, PowerShell supports WDAC policies in **Audit** mode. In audit mode, PowerShell
runs the untrusted scripts in Constrained Language mode without errors, but logs messages to the
event log instead. The log messages describe what restrictions would apply if the policy was in
**Enforce** mode.

### Viewing audit events

PowerShell logs audit events to the **PowerShellCore/Analytic** event log. You must enable
the Analytic log. To enable the Analytic log in the Windows Event Viewer, right-click on the
**PowerShellCore/Analytic** log and select **Enable Log**.

Or, you can run the following command from an elevated PowerShell session.

```powershell
wevtutil.exe sl PowerShellCore/Analytic /enabled:true /quiet
```

You can view the events in the Windows Event Viewer or use the `Get-WinEvent` cmdlet to retrieve the
events.

```powershell
Get-WinEvent -LogName PowerShellCore/Analytic -Oldest |
    Where-Object Id -eq 16387 | Format-List
```

```Output
TimeCreated  : 4/19/2023 10:11:07 AM
ProviderName : PowerShellCore
Id           : 16387
Message      : WDAC Audit.

    Title: Method or Property Invocation
    Message: Method or Property 'WriteLine' on type 'System.Console' invocation will not
        be allowed in ConstrainedLanguage mode.
        At C:\scripts\Test1.ps1:3 char:1
        + [System.Console]::WriteLine("pwnd!")
        + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    FullyQualifiedId: MethodOrPropertyInvocationNotAllowed
```

The event message includes the script position where the restriction would be applied. This
information helps you understand where you need to change your script so that it runs under the WDAC
policy.

> [!IMPORTANT]
> Once you have reviewed the audit events, you should disable the Analytic log. Analytic logs grow
> quickly and consume large amounts of disk space.

### Viewing audit events in the PowerShell debugger

If you set the `$DebugPreference` variable to `Break` for an interactive PowerShell session,
PowerShell will break into the command-line script debugger at the current location in the script
where the audit event occurred. This allows you to debug your code and inspect the current state of
the script in real time.

<!-- link references -->
[01]: /windows/security/threat-protection/windows-defender-application-control/applocker/what-is-applocker
[02]: /windows/security/threat-protection/windows-defender-application-control/feature-availability
[03]: /windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview#choose-when-to-use-wdac-or-applocker
[04]: /windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control
