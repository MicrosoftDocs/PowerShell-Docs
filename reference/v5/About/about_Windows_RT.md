---
title: about_Windows_RT
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: effdf754-1a4b-45fb-9cb2-910389751e7d
---
# about_Windows_RT
## TOPIC  
 about\_Windows\_RT  
  
## SHORT DESCRIPTION  
 Explains limitations of [!INCLUDE[wps_1](../Token/wps_1_md.md)] 4.0 on Windows RT 8.1.  
  
## LONG DESCRIPTION  
 The Windows RT 8.1 operating system is installed on computers and devices \(such as Microsoft Surface 2, on which it is the operating system that ships with the computer\) that use Advanced RISC Machine \(ARM\) processors.  
  
 [!INCLUDE[wps_2](../Token/wps_2_md.md)] 4.0 is included in Windows RT 8.1. All cmdlets, providers, and modules, and most scripts designed for [!INCLUDE[wps_2](../Token/wps_2_md.md)] 2.0 and later releases run on Windows RT 8.1 without changes.  
  
 Because Windows RT 8.1 does not include all Windows features, some [!INCLUDE[wps_2](../Token/wps_2_md.md)] features work differently or do not work on Windows RT\-based devices. The following list explains the differences.  
  
 \-\- [!INCLUDE[wps_2](../Token/wps_2_md.md)] ISE is not included in and cannot run on Windows RT 8.1. [!INCLUDE[wps_2](../Token/wps_2_md.md)] ISE requires Windows Presentation Foundation, which is not included in Windows RT 8.1.  
  
 \-\- [!INCLUDE[wps_2](../Token/wps_2_md.md)] remoting and the WinRM service are disabled by default. To enable remoting, run the Enable\-PSRemoting cmdlet. Also, run the Set\-Service cmdlet to set the startup type of the WinRM service to Automatic, or Automatic \(Delayed Start\).  
  
 While remoting is disabled, you can use [!INCLUDE[wps_2](../Token/wps_2_md.md)] remoting to run commands on other computers, but other computers cannot run commands on the Windows RT device. Also, implicit remoting—that is, remoting that is built in to a cmdlet or script, and not explicitly requested with added parameters—does not work in [!INCLUDE[wps_2](../Token/wps_2_md.md)] running on Windows RT 8.1.  
  
 \-\- Domain\-joined computing and Kerberos authentication are not supported on Windows RT 8.1. You cannot use [!INCLUDE[wps_2](../Token/wps_2_md.md)] to add or manage these features.  
  
 \-\- Microsoft .NET Framework classes that are not supported on Windows RT 8.1 are also not supported by [!INCLUDE[wps_2](../Token/wps_2_md.md)] on Windows RT 8.1.  
  
 \-\- Transactions are not enabled on Windows RT 8.1. Transaction cmdlets, such as Start\-Transaction, and transaction parameters, such as UseTransaction, do not work properly.  
  
 \-\- All [!INCLUDE[wps_2](../Token/wps_2_md.md)] sessions on Windows RT 8.1 devices use the ConstrainedLanguage language mode. ConstrainedLanguage language mode is a companion to User Mode Code Integrity \(UMCI\). It permits all Windows cmdlets and [!INCLUDE[wps_2](../Token/wps_2_md.md)] language elements, but restricts types to ensure that users cannot use [!INCLUDE[wps_2](../Token/wps_2_md.md)] to circumvent or violate the UMCI protections.  
  
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
  
 [!INCLUDE[wps_2](../Token/wps_2_md.md)] System Requirements:  
  
 \(http:\/\/technet.microsoft.com\/library\/hh857337.aspx\)