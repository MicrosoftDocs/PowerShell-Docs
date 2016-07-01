---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Windows_RT
ms.technology:  powershell
ms.assetid:  91f84ecd-4223-4912-a15c-2733feadb30d
---

# about_Windows_RT
## TOPIC  
 about\_Windows\_RT  
  
## SHORT DESCRIPTION  
 Explains limitations of [!INCLUDE[wps_1]()] 4.0 on Windows RT 8.1.  
  
## LONG DESCRIPTION  
 The Windows RT 8.1 operating system is installed on computers and devices \(such as Microsoft Surface 2, on which it is the operating system that ships with the computer\) that use Advanced RISC Machine \(ARM\) processors.  
  
 [!INCLUDE[wps_2]()] 4.0 is included in Windows RT 8.1. All cmdlets, providers, and modules, and most scripts designed for [!INCLUDE[wps_2]()] 2.0 and later releases run on Windows RT 8.1 without changes.  
  
 Because Windows RT 8.1 does not include all Windows features, some [!INCLUDE[wps_2]()] features work differently or do not work on Windows RT\-based devices. The following list explains the differences.  
  
 [!INCLUDE[wps_2]()] ISE is not included in and cannot run on Windows RT 8.1. [!INCLUDE[wps_2]()] ISE requires Windows Presentation Foundation, which is not included in Windows RT 8.1.  
  
 [!INCLUDE[wps_2]()] remoting and the WinRM service are disabled by default. To enable remoting, run the Enable\-PSRemoting cmdlet. Also, run the Set\-Service cmdlet to set the startup type of the WinRM service to Automatic, or Automatic \(Delayed Start\).  
  
 While remoting is disabled, you can use [!INCLUDE[wps_2]()] remoting to run commands on other computers, but other computers cannot run commands on the Windows RT device. Also, implicit remoting—that is, remoting that is built in to a cmdlet or script, and not explicitly requested with added parameters—does not work in [!INCLUDE[wps_2]()] running on Windows RT 8.1.  
  
 Domain\-joined computing and Kerberos authentication are not supported on Windows RT 8.1. You cannot use [!INCLUDE[wps_2]()] to add or manage these features.  
  
 Microsoft .NET Framework classes that are not supported on Windows RT 8.1 are also not supported by [!INCLUDE[wps_2]()] on Windows RT 8.1.  
  
 Transactions are not enabled on Windows RT 8.1. Transaction cmdlets, such as Start\-Transaction, and transaction parameters, such as UseTransaction, do not work properly.  
  
 All [!INCLUDE[wps_2]()] sessions on Windows RT 8.1 devices use the ConstrainedLanguage language mode. ConstrainedLanguage language mode is a companion to User Mode Code Integrity \(UMCI\). It permits all Windows cmdlets and [!INCLUDE[wps_2]()] language elements, but restricts types to ensure that users cannot use [!INCLUDE[wps_2]()] to circumvent or violate the UMCI protections.  
  
 For more information about ConstrainedLanguage language mode, see about\_Language\_Modes.  
  
## KEYWORDS  
 about\_ARM  
  
 about\_PowerShell\_on\_ARM  
  
 about\_PowerShell\_on\_Surface  
  
 about\_Windows\_RT\_8.1  
  
 about\_WindowsRT  
  
## SEE ALSO  
 about\_Language\_Modes  
  
 about\_Remote  
  
 about\_Windows\_PowerShell\_ISE  
  
 about\_Workflows  
  
 [!INCLUDE[wps_2]()] System Requirements: \(http:\/\/technet.microsoft.com\/library\/hh857337.aspx\)

