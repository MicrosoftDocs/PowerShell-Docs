---
title: Install and configure WMF 5.1 (Preview)
ms.date:  2016-05-16
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
contributor:  kriscv
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# Install and Configure WMF 5.1 (Preview) #

> Note: This content is placeholder. Download links will be added when WMF 5.1 Preview will be released.

Download the WMF 5.1 package for the operating system and architecture you wish to install it on:

| Operating System	     | Architecture | Package Name              |
|------------------------|--------------|---------------------------|
| Windows Server 2012 R2 | x64 		    | Win8.1AndW2K12R2-KB3156422-x64.msu|
| Windows Server 2012	 | x64		    | W2K12-KB3156423-x64.msu|
| Windows Server 2008 R2 | x64		    | Win7AndW2K8R2-KB3156424-x64.msu |
| Windows 8.1            | x64          | Win8.1AndW2K12R2-KB3156422-x64.msu |
| Windows 8.1            | x86          | Win8.1-KB3156422-x86.msu |
| Windows 7 SP1          | x64          | Win7AndW2K8R2-KB3156424-x64.msu |
| Windows 7 SP1          | x86          | Win7-KB3156424-x86.msu |


## Install WMF 5.1 from Windows Explorer (or File Explorer in Windows Server 2012 R2 or Windows 8.1)

1. Navigate to the folder into which you downloaded the MSU file.

2. Double-click the MSU to run it.

## Install WMF 5.1 from the command prompt##

1. After downloading the correct package for your computer's architecture, open a Command Prompt window with elevated user rights (Run as Administrator). On the Server Core installation options of Windows Server 2012 R2 or Windows Server 2012 or Windows Server 2008 R2 SP1, Command Prompt opens with elevated user rights by default.

2. Change directories to the folder into which you have downloaded or copied the WMF 5.1 installation package.

3. Run one of the following commands:
	- On computers that are running Windows Server 2012 R2 or Windows 8.1 x64, run `Win8.1AndW2K12R2-KB3156422-x64.msu /quiet`.
	- On computers that are running Windows Server 2012, run `W2K12-KB3156423-x64.msu /quiet`.
	- On computers that are running Windows Server 2008 R2 SP1 or Windows 7 SP1 x64, run `Win7AndW2K8R2-KB3156424-x64.msu /quiet`.
	- On computers that are running Windows 8.1 x86, run `Win8.1-KB3156422-x86.msu /quiet`.
	- On computers that are running Windows 7 SP1 x86, run `Win7-KB3156424-x86.msu /quiet`.

## Additional Installation Notes for Windows Server 2008 SP1 and Windows 7 SP1##
Installation of WMF 5.1 on either Windows Server 2008 SP1 or Windows 7 SP1, require the installation of:
- Latest service pack.
- [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855)
- WMF 5.1 requires Microsoft .NET Framework 4.6. You can install Microsoft .NET Framework 4.6 by following the instructions at [Installing the .NET Framework](https://msdn.microsoft.com/en-us/library/5a4x27ek(v=vs.110).aspx).
- Security update for [SHA-2 Code Signing](https://technet.microsoft.com/en-us/library/security/3033929). This is needed to use new PowerShell cmdlets for windows catalog files. 

> **WinRM Dependency** - Windows PowerShell Desired State Configuration (DSC) depends on WinRM. WinRM is not enabled by default on Windows Server 2008 R2 and Windows 7. To enable WinRM, in a Windows PowerShell elevated session, run `Set-WSManQuickConfig`.

