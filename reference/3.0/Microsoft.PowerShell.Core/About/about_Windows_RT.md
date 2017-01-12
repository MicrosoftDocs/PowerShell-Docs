---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Windows_RT
ms.technology:  powershell
---

# About Windows RT
## about_Windows_RT


## SHORT DESCRIPTION
Explains limitations of  Windows PowerShell® 4.0 on Windows RT 8.1.


## LONG DESCRIPTION
The Windows RT 8.1 operating system is installed on computers and devices (such as Microsoft Surface 2, on which it is the operating system that ships with the computer) that use Advanced RISC Machine (ARM) processors.

Windows PowerShell 4.0 is included in Windows RT 8.1. All cmdlets, providers, and modules, and most scripts designed for  Windows PowerShell 2.0 and later releases run on Windows RT 8.1 without changes.

Because Windows RT 8.1 does not include all Windows features, some  Windows PowerShell features work differently or do not work on Windows RT-based devices. The following list explains the differences.

--  Windows PowerShell ISE is not included in and cannot run on Windows RT 8.1.  Windows PowerShell ISE requires Windows Presentation Foundation, which is not included in Windows RT 8.1.

--  Windows PowerShell remoting and the WinRM service are disabled by default. To enable remoting, run the Enable-PSRemoting cmdlet. Also, run the Set-Service cmdlet to set the startup type of the WinRM service to Automatic, or Automatic (Delayed Start).

While remoting is disabled, you can use  Windows PowerShell remoting to run commands on other computers, but other computers cannot run commands on the Windows RT device. Also, implicit remoting—that is, remoting that is built in to a cmdlet or script, and not explicitly requested with added parameters—does not work in  Windows PowerShell running on Windows RT 8.1.

-- Domain-joined computing and Kerberos authentication are not supported on Windows RT 8.1. You cannot use  Windows PowerShell to add or manage these features.

-- Microsoft .NET Framework classes that are not supported on Windows RT 8.1 are also not supported by  Windows PowerShell on Windows RT 8.1.

-- Transactions are not enabled on Windows RT 8.1. Transaction cmdlets, such as Start-Transaction, and transaction parameters, such as UseTransaction, do not work properly.

-- All  Windows PowerShell sessions on Windows RT 8.1 devices use the ConstrainedLanguage language mode. ConstrainedLanguage language mode is a companion to User Mode Code Integrity (UMCI). It permits all Windows cmdlets and  Windows PowerShell language elements, but restricts types to ensure that users cannot use  Windows PowerShell to circumvent or violate the UMCI protections.

For more information about ConstrainedLanguage language mode, see about_Language_Modes.


## KEYWORDS
about_ARM

about_PowerShell_on_ARM

about_PowerShell_on_Surface

about_Windows_RT_8.1

about_WindowsRT


## SEE ALSO
about_Language_Modes

about_Remote

about_Windows_PowerShell_ISE

about_Workflows

Windows PowerShell System Requirements:

(http:\/\/technet.microsoft.com\/library\/hh857337.aspx)

