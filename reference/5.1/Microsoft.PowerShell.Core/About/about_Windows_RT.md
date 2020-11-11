---
description:  Explains limitations of  Windows PowerShell 4.0 on Windows RT 8.1. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_windows_rt?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Windows_RT
---

# About Windows RT

## SHORT DESCRIPTION

Explains limitations of  Windows PowerShell 4.0 on Windows RT 8.1.

## LONG DESCRIPTION

The Windows RT 8.1 operating system is installed on computers and devices
(such as Microsoft Surface 2, on which it is the operating system that ships
with the computer) that use Advanced RISC Machine (ARM) processors.

Windows PowerShell 4.0 is included in Windows RT 8.1. All cmdlets, providers,
and modules, and most scripts designed for Windows PowerShell 2.0 and later
releases run on Windows RT 8.1 without changes.

Because Windows RT 8.1 does not include all Windows features, some Windows
PowerShell features work differently or do not work on Windows RT-based
devices. The following list explains the differences.

- Windows PowerShell ISE is not included in and cannot run on Windows RT 8.1.
  Windows PowerShell ISE requires Windows Presentation Foundation, which is not
  included in Windows RT 8.1.

- Windows PowerShell remoting and the WinRM service are disabled by default.
  To enable remoting, run the Enable-PSRemoting cmdlet. Also, run the
  Set-Service cmdlet to set the startup type of the WinRM service to Automatic,
  or Automatic (Delayed Start).

  While remoting is disabled, you can use Windows PowerShell remoting to run
  commands on other computers, but other computers cannot run commands on the
  Windows RT device. Also, implicit remoting - that is, remoting that is built
  in to a cmdlet or script, and not explicitly requested with added parameters
  - does not work in Windows PowerShell running on Windows RT 8.1.

- Domain-joined computing and Kerberos authentication are not supported on
  Windows RT 8.1. You cannot use Windows PowerShell to add or manage these
  features.

- Microsoft .NET Framework classes that are not supported on Windows RT 8.1
  are also not supported by Windows PowerShell on Windows RT 8.1.

- Transactions are not enabled on Windows RT 8.1. Transaction cmdlets, such
  as Start-Transaction, and transaction parameters, such as UseTransaction, do
  not work properly.

- All Windows PowerShell sessions on Windows RT 8.1 devices use the
  ConstrainedLanguage language mode. ConstrainedLanguage language mode is a
  companion to User Mode Code Integrity (UMCI). It permits all Windows cmdlets
  and Windows PowerShell language elements, but restricts types to ensure that
  users cannot use Windows PowerShell to circumvent or violate the UMCI
  protections.

For more information about ConstrainedLanguage language mode, see
[about_Language_Modes](about_Language_Modes.md).

## SEE ALSO

[about_Language_Modes](about_Language_Modes.md)

[about_Remote](about_Remote.md)

[about_Windows_PowerShell_ISE](about_Windows_PowerShell_ISE.md)
