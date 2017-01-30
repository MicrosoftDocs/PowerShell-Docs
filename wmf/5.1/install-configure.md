---
title: Install and configure WMF 5.1 
ms.date:  2017-01-18 
keywords:  PowerShell, DSC, WMF 
description:  
ms.topic:  article 
contributor:  keithb 
manager:  carmonm 
ms.prod:  powershell 
ms.technology: WMF
---

# Install and Configure WMF 5.1 #


## Download and install the WMF 5.1 package

Download the WMF 5.1 package for the operating system and architecture you wish to install it on:

| Operating System	     | Prerequisites       | Package Links             |
|------------------------|---------------------|---------------------------|
| Windows Server 2012 R2 | | [Win8.1AndW2K12R2-KB3191564-x64.msu](https://go.microsoft.com/fwlink/?linkid=839516)|
| Windows Server 2012	 | | [W2K12-KB3191565-x64.msu](https://go.microsoft.com/fwlink/?linkid=839513)|
| Windows Server 2008 R2 | [.NET Framework 4.5.2](https://www.microsoft.com/en-ca/download/details.aspx?id=42642) | [Win7AndW2K8R2-KB3191566-x64.ZIP](https://go.microsoft.com/fwlink/?linkid=839523) | 
| Windows 8.1            |  | **x64:** [Win8.1AndW2K12R2-KB3191564-x64.msu](https://go.microsoft.com/fwlink/?linkid=839516) </br> **x86:** [Win8.1-KB3191564-x86.msu](https://go.microsoft.com/fwlink/?linkid=839521) |
| Windows 7 SP1          | [.NET Framework 4.5.2](https://www.microsoft.com/en-ca/download/details.aspx?id=42642) | **x64:** [Win7AndW2K8R2-KB3191566-x64.ZIP](https://go.microsoft.com/fwlink/?linkid=839523) </br> **x86:** [Win7-KB3191566-x86.ZIP](https://go.microsoft.com/fwlink/?linkid=839522)



## Install WMF 5.1 for Windows Server 2008 R2 and Windows 7

> **Note:** Installation instructions for Windows Server 2008 R2 and Windows 7 have changed, and differ from 
the instructions for the other packages. Installation instructions for Windows Server 2012 R2, Windows Server 2012, 
and Windows 8.1 are below.

**Installing WMF 5.1 on Windows Server 2008 R2 and Windows 7**

1. Navigate to the folder into which you downloaded the ZIP file. 

2. Right-click on the ZIP file, and select "Extract All...". The Zip contains 2 files: an MSU and the Install-WMF5.1.PS1 script file. 
Once you have unpacked the ZIP file, you can copy the contents to any machine running Windows 7 or Windows Server 2008 R2.  

3. After extracting the ZIP file contents, open PowerShell as administrator, then navigate to the folder containing the  
contents of the ZIP file. 

4. Run the Install-Wmf5.1.ps1 script in that folder, and follow the instructions. This script will check the prerequisites 
on the local machine, and install WMF 5.1 if the prerequisites have been met. The prerequisites are listed below. 

Install-WMF5.1.ps1 takes the following parameters to ease automating the installation on Windows Server 2008 R2 and Windows 7:

- AcceptEula: When this parameter is included, the EULA is automatically accepted and will not be displayed.
- AllowRestart: This parameter can only be used if AcceptEula is specified. If this parameter is included, and a restart is required after installing WMF 5.1, the restart will happen without prompting immediately after the installation is completed. 

**WMF 5.1 Prerequisites for Windows Server 2008 R2 SP1 and Windows 7 SP1**

Installation of WMF 5.1 on either Windows Server 2008 R2 SP1 or Windows 7 SP1, requires the following:
- Latest service pack must be installed.
- WMF 3.0 **must not** be installed. Installing WMF 5.1 over WMF 3.0 will result in the loss of the PSModulePath, 
which can cause other applications to fail. Before installing WMF 5.1, you must either un-install WMF 3.0, or save 
the PSModulePath and then restore it manually after WMF 5.1 installation is complete. 
- WMF 5.1 requires [.NET Framework 4.5](https://www.microsoft.com/en-ca/download/details.aspx?id=30653) 
You can install Microsoft .NET Framework 4.5 by following the instructions at the download location.

**WinRM Dependency** 

Windows PowerShell Desired State Configuration (DSC) depends on WinRM. 
WinRM is not enabled by default on Windows Server 2008 R2 and Windows 7. 
Run `Set-WSManQuickConfig`, in a Windows PowerShell elevated session, to enable WinRM.


## Install WMF 5.1 for Windows Server 2012 R2, Windows Server 2012, and Windows 8.1
**Install from Windows Explorer (or File Explorer in Windows Server 2012 R2 or Windows 8.1)**

1. Navigate to the folder into which you downloaded the MSU file.

2. Double-click the MSU to run it.

**Installing from the Command Prompt**

1. After downloading the correct package for your computer's architecture, open a Command Prompt window with elevated user rights (Run as Administrator). On the Server Core installation options of Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2 SP1, Command Prompt opens with elevated user rights by default.

2. Change directories to the folder into which you have downloaded or copied the WMF 5.1 installation package.

3. Run one of the following commands:
	- On computers that are running Windows Server 2012 R2 or Windows 8.1 x64, run `Win8.1AndW2K12R2-KB3191564-x64.msu /quiet`.
	- On computers that are running Windows Server 2012, run `W2K12-KB3191565-x64.msu /quiet`.
	- On computers that are running Windows 8.1 x86, run `Win8.1-KB3191564-x86.msu /quiet`.
	
