---
description: PowerShell has several features designed to improve the security of your scripting environment.
ms.date: 11/10/2021
title: PowerShell security features
---
# PowerShell security features

PowerShell has several features designed to improve the security of your scripting environment.

## Execution policy

PowerShell's execution policy is a safety feature that controls the conditions under which
PowerShell loads configuration files and runs scripts. This feature helps prevent the execution of
malicious scripts. You can use a Group Policy setting to set execution policies for computers and
users. Execution policies only apply to the Windows platform.

For more information see [about_Execution_Policies][exe-policy].

## Module and script block logging

Module Logging allows you to enable logging for selected PowerShell modules. This setting is
effective in all sessions on the computer. Pipeline execution events for the specified modules
are recorded in the Windows PowerShell log in Event Viewer.

Script Block Logging enables logging for the processing of commands, script blocks,
functions, and scripts - whether invoked interactively, or through automation. This information is
logged to the **Microsoft-Windows-PowerShell/Operational** event log.

For more information, see the following articles:

- [about_Group_Policy_Settings][logging]
- [about_Logging_Windows][log-win]
- [about_Logging_Non-Windows][log-unix]

## Constrained language mode

**ConstrainedLanguage** mode protects your system by limiting the cmdlets and .NET types that can be
used in a PowerShell session. For a full description, see [about_Language_Modes][lang-modes].

## Application Control

Windows 10 includes two technologies, [Windows Defender Application Control (WDAC)][WDAC] and
[AppLocker][applocker] that can be used for application control. They allow you to create a lockdown
experience to meet your organization's specific scenarios and requirements.

> [!NOTE]
> When it comes to [choosing between WDAC or AppLocker][choosing] it is generally recommended that
> customers implement application control using WDAC rather than AppLocker. WDAC is undergoing
> continual improvements and will be getting added support from Microsoft management platforms.
> Although AppLocker will continue to receive security fixes, it will not undergo new feature
> improvements.

**WDAC** was introduced with Windows 10 and allows organizations to control which drivers and
applications are allowed to run on their Windows 10 devices. WDAC is designed as a security feature
under the servicing criteria defined by the Microsoft Security Response Center (MSRC).

**AppLocker** builds on the application control features of Software Restriction Policies.
AppLocker contains new capabilities and extensions that enable you to create rules to allow or deny
apps from running based on unique identities of files and to specify which users or groups can run
those apps.

For more information about AppLocker and Windows Defender Application Control (WDAC), see
[Application Controls for Windows][WDAC] and
[WDAC and AppLocker feature availability][availability].

### Security Servicing Criteria

PowerShell follows the [Microsoft Security Servicing Criteria for Windows][mssec].
The table below outlines the features that meet the servicing criteria and those that do not.

|                  Feature                   |       Type       |
| ------------------------------------------ | ---------------- |
| System Lockdown - with WDAC                | Security Feature |
| Constrained language mode - with WDAC      | Security Feature |
| System Lockdown - with AppLocker           | Defense in Depth |
| Constrained language mode - with AppLocker | Defense in Depth |
| Execution Policy                           | Defense in Depth |

### Changes in PowerShell 7.2

- There was a corner-case scenario in AppLocker where you only have **Deny** rules and constrained
  mode is not used to enforce the policy that allows you to bypass the execution policy. Beginning
  in PowerShell 7.2, a change was made to ensure AppLocker rules take precedence over a
  `Set-ExecutionPolicy -ExecutionPolicy Bypass` command.

- PowerShell 7.2 now disallows the use of te `Add-Type` cmdlet in a **NoLanguage** mode PowerShell
  session on a locked down machine.

- PowerShell 7.2 now disallows scripts from using COM objects in AppLocker system lock down
  conditions. Cmdlet that use COM or DCOM internally are not affected.

## Software Bill of Materials (SBOM)

Beginning with PowerShell 7.2, all install packages contain a Software Bill of Materials (SBOM). The
SBOM is found at `$PSHOME/_manifest/spdx_2.2/manifest.spdx.json`. The creation and publishing of the
SBOM is the first step to modernize Federal Government cybersecurity and enhance software supply
chain security.

The PowerShell team is also producing SBOMs for modules that they own but ship separately from
PowerShell. For modules, the SBOM is installed in the module's folder under
`_manifest/spdx_2.2/manifest.spdx.json`.

For more information about this initiative, see the blog post
[Generating Software Bills of Materials (SBOMs) with SPDX at Microsoft][sbomblog].

<!-- link references -->
[applocker]: /windows/security/threat-protection/windows-defender-application-control/applocker/what-is-applocker
[availability]: /windows/security/threat-protection/windows-defender-application-control/feature-availability
[choosing]: /windows/security/threat-protection/windows-defender-application-control/wdac-and-applocker-overview#choose-when-to-use-wdac-or-applocker
[exe-policy]: /powershell/module/microsoft.powershell.core/about/about_execution_policies
[lang-modes]: /powershell/module/microsoft.powershell.core/about/about_language_modes
[log-unix]: /powershell/module/microsoft.powershell.core/about/about_logging_non-windows
[log-win]: /powershell/module/microsoft.powershell.core/about/about_logging_windows
[logging]: /powershell/module/microsoft.powershell.core/about/about_group_policy_settings#turn-on-module-logging
[mssec]: https://www.microsoft.com/msrc/windows-security-servicing-criteria
[WDAC]: /windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control
[sbomblog]: https://devblogs.microsoft.com/engineering-at-microsoft/generating-software-bills-of-materials-sboms-with-spdx-at-microsoft/
