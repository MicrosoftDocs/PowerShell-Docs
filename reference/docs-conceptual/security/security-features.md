---
description: PowerShell has several features designed to improve the security of your scripting environment.
ms.date: 09/19/2024
title: PowerShell security features
---
# PowerShell security features

PowerShell has several features designed to improve the security of your scripting environment.

## Execution policy

PowerShell's execution policy is a safety feature that controls the conditions under which
PowerShell loads configuration files and runs scripts. This feature helps prevent the execution of
malicious scripts. You can use a Group Policy setting to set execution policies for computers and
users. Execution policies only apply to the Windows platform.

For more information see [about_Execution_Policies][02].

## Use of the SecureString class

PowerShell has several cmdlets that support the use of the `System.Security.SecureString` class.
And, as with any .NET class, you can use **SecureString** in your own scripts. However, Microsoft
doesn't recommend using **SecureString** for new development. Microsoft recommends that you avoid
using passwords and rely on other means to authenticate, such as certificates or Windows
authentication.

PowerShell continues to support the **SecureString** class for backward compatibility. Using a
**SecureString** is still more secure than using a plain text string. By default, PowerShell doesn't
show the unprotected value of a **SecureString** object. However, **SecureString** can be easily
converted to a plain text string. For a full discussion about using **SecureString**, see the
[System.Security.SecureString class][01] documentation.

## Module and script block logging

Module Logging allows you to enable logging for selected PowerShell modules. This setting is
effective in all sessions on the computer. PowerShell records pipeline execution events for the
specified modules in the Windows PowerShell log in Event Viewer.

Script Block Logging enables logging for the processing of commands, script blocks, functions, and
scripts - whether invoked interactively, or through automation. PowerShell logs this information to
the **Microsoft-Windows-PowerShell/Operational** event log.

For more information, see the following articles:

- [about_Group_Policy_Settings][03]
- [about_Logging_Windows][06]
- [about_Logging_Non-Windows][05]

## AMSI Support

The Windows Antimalware Scan Interface (AMSI) is an API that allows applications to pass actions to
an antimalware scanner, such as Windows Defender, to scan for malicious payloads. Beginning with
PowerShell 5.1, PowerShell running on Windows 10 (and higher) passes all script blocks to AMSI.

PowerShell 7.3 extends the data that's sent to AMSI for inspection. It now includes all invocations
of .NET method members.

For more information about AMSI, see [How AMSI helps][09].

## Constrained language mode

**ConstrainedLanguage** mode protects your system by limiting the cmdlets and .NET types allowed in
a PowerShell session. For a full description, see [about_Language_Modes][04].

## Application Control

Windows 10 includes two technologies, [App Control for Business][08] and [AppLocker][07] that you
can use to control applications. PowerShell detects if a system wide application control policy is
being enforced. The policy applies certain behaviors when running script blocks, script files, or
loading module files to prevent arbitrary code execution on the system.

App Control for Business is designed as a security feature under the servicing criteria defined by
the Microsoft Security Response Center (MSRC). App Control is the preferred application control
system for Windows.

For more information about how PowerShell supports AppLocker and App Control, see
[Use App Control to secure PowerShell][10].

## Software Bill of Materials (SBOM)

Beginning with PowerShell 7.2, all install packages contain a Software Bill of Materials (SBOM). The
PowerShell team also produces SBOMs for modules that they own but ship independently from
PowerShell.

You can find SBOM files in the following locations:

- In PowerShell, find the SBOM at `$PSHOME/_manifest/spdx_2.2/manifest.spdx.json`.
- For modules, find the SBOM in the module's folder under `_manifest/spdx_2.2/manifest.spdx.json`.

The creation and publishing of the SBOM is the first step to modernize Federal Government
cybersecurity and enhance software supply chain security. For more information about this
initiative, see the blog post [Generating SBOMs with SPDX at Microsoft][11].

## Security Servicing Criteria

PowerShell follows the [Microsoft Security Servicing Criteria for Windows][12]. Only security
features meet the criteria for servicing.

Security features

- System Lockdown with App Control for Business
- Constrained language mode with App Control for Business

Defense in depth features

- System Lockdown with AppLocker
- Constrained language mode with AppLocker
- Execution Policy

<!-- link references -->
[01]: /dotnet/fundamentals/runtime-libraries/system-security-securestring
[02]: /powershell/module/microsoft.powershell.core/about/about_execution_policies
[03]: /powershell/module/microsoft.powershell.core/about/about_group_policy_settings#turn-on-module-logging
[04]: /powershell/module/microsoft.powershell.core/about/about_language_modes
[05]: /powershell/module/microsoft.powershell.core/about/about_logging_non-windows
[06]: /powershell/module/microsoft.powershell.core/about/about_logging_windows
[07]: /windows/security/application-security/application-control/app-control-for-business/applocker/what-is-applocker
[08]: /windows/security/application-security/application-control/app-control-for-business/appcontrol
[09]: /windows/win32/amsi/how-amsi-helps
[10]: app-control/application-control.md
[11]: https://devblogs.microsoft.com/engineering-at-microsoft/generating-software-bills-of-materials-sboms-with-spdx-at-microsoft/
[12]: https://www.microsoft.com/msrc/windows-security-servicing-criteria
