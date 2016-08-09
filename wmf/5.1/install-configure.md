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

## Install .Net 4.6
You must install the .NET Framework 4.6 to use WMF 5.1. 
This is required to enable the new catalog-signing features, which impacts several areas of module and script loading in WMF 5.1. 

The [.NET Framework 4.6 is available as KB 3045560](https://support.microsoft.com/en-us/kb/3045560). 
Install instructions are available at the download location.

> **Note:** It is a known issue that .NET 4.6 requirement is not detected by the WMF 5.1 Preview installer, so you will be able to install WMF 5.1 Preview before installing .NET 4.6. 
Our testing has shown that you can install .NET 4.6 after installing the WMF 5.1 Preview. 
The final version of WMF 5.1 will correctly check this prerequisite requirement before installing. 

## Download and install the WMF 5.1 Preview

Download the WMF 5.1 package for the operating system and architecture you wish to install it on:

| Operating System	     | Prerequisites | Package Links             |
|------------------------|---------------|---------------------------|
| Windows Server 2012 R2 | [.NET Framework 4.6](https://support.microsoft.com/en-us/kb/3045560) | [Win8.1AndW2K12R2-KB3156422-x64.msu](http://go.microsoft.com/fwlink/?LinkID=823586)|
| Windows Server 2012	 | [.NET Framework 4.6](https://support.microsoft.com/en-us/kb/3045560) | [W2K12-KB3156423-x64.msu](http://go.microsoft.com/fwlink/?LinkID=823587)|
| Windows Server 2008 R2 | [.NET Framework 4.6](https://support.microsoft.com/en-us/kb/3045560) </br> [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) </br> Security update for [SHA-2 Code Signing](https://technet.microsoft.com/en-us/library/security/3033929) | [Win7AndW2K8R2-KB3156424-x64.msu](http://go.microsoft.com/fwlink/?LinkID=823588) |
| Windows 8.1            | [.NET Framework 4.6](https://support.microsoft.com/en-us/kb/3045560) | **x64:** [Win8.1AndW2K12R2-KB3156422-x64.msu](http://go.microsoft.com/fwlink/?LinkID=823586) </br> **x86:** [Win8.1-KB3156422-x86.msu](http://go.microsoft.com/fwlink/?LinkID=823589) |
| Windows 7 SP1          | [.NET Framework 4.6](https://support.microsoft.com/en-us/kb/3045560) </br> [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) </br> Security update for [SHA-2 Code Signing](https://technet.microsoft.com/en-us/library/security/3033929) | **x64:** [Win7AndW2K8R2-KB3156424-x64.msu](http://go.microsoft.com/fwlink/?LinkID=823588) </br> **x86:** [Win7-KB3156424-x86.msu](http://go.microsoft.com/fwlink/?LinkID=823590) |


## Install WMF 5.1 from Windows Explorer (or File Explorer in Windows Server 2012 R2 or Windows 8.1)

1. Navigate to the folder into which you downloaded the MSU file.

2. Double-click the MSU to run it.

## Install WMF 5.1 from the Command Prompt##

1. After downloading the correct package for your computer's architecture, open a Command Prompt window with elevated user rights (Run as Administrator). On the Server Core installation options of Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 SP1, Command Prompt opens with elevated user rights by default.

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
- WMF 5.1 requires [Microsoft .NET Framework 4.6](https://support.microsoft.com/en-us/kb/3045560). 
You can install Microsoft .NET Framework 4.6 by following the instructions at the download location.
- Security update for [SHA-2 Code Signing](https://technet.microsoft.com/en-us/library/security/3033929). This is needed to use new PowerShell cmdlets for Windows catalog files. 

> **WinRM Dependency** - Windows PowerShell Desired State Configuration (DSC) depends on WinRM. WinRM is not enabled by default on Windows Server 2008 R2 and Windows 7. Run `Set-WSManQuickConfig`, in a Windows PowerShell elevated session, to enable WinRM.

