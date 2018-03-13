---
ms.date:  2017-06-12
author:  JKeithB
ms.topic:  reference
keywords:  wmf,powershell,setup
---

# System Requirements

- Install the latest Windows updates before installing WMF 5.0 RTM.
- You can install WMF 5.0 RTM only on the following operating systems:

    | Operating System	     | Editions         | Prerequisites        |  Package Links |
    |------------------------|--------------|------------------|----------------------| --------------|
    | Windows Server 2012 R2 |  |  | [Win8.1AndW2K12R2-KB3134758-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717507) |
    | Windows Server 2012	 |  |  | [W2K12-KB3134759-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717506) |
    | Windows Server 2008 R2 SP1 | All, except IA64 | [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) and [.NET Framework 4.5 or above](https://msdn.microsoft.com/library/5a4x27ek.aspx) are installed| [Win7AndW2K8R2-KB3134760-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717504)|
    | Windows 8.1 | Pro, Enterprise | | **x64:**  [Win8.1AndW2K12R2-KB3134758-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717507) </br> **x86:**  [Win8.1-KB3134758-x86.msu](http://go.microsoft.com/fwlink/?LinkID=717963)|
    | Windows 7 SP1 | All | [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) and [.NET Framework 4.5 or above](https://msdn.microsoft.com/library/5a4x27ek.aspx) are installed | **x64:**  [Win7AndW2K8R2-KB3134760-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717504)  </br> **x86:**  [Win7-KB3134760-x86.msu](http://go.microsoft.com/fwlink/?LinkID=717962)|

# Installation Instructions

### To install WMF 5.0 from Windows Explorer (or File Explorer):

1. Navigate to the folder into which you downloaded the MSU file.

2. Double-click the MSU to run it.

### To install WMF 5.0 from Command Prompt:

1. After downloading the correct package for your computer's architecture, open a Command Prompt window with elevated user rights (Run as Administrator). On the Server Core installation options of Windows Server 2012 R2 or Windows Server 2012 or Windows Server 2008 R2 SP1, Command Prompt opens with elevated user rights by default.

2. Change directories to the folder into which you have downloaded or copied the WMF 5.0 installation package.

3. Run one of the following commands:
	- On computers that are running Windows Server 2012 R2 or Windows 8.1 x64, run **Win8.1AndW2K12R2-KB3134758-x64.msu /quiet**.
	- On computers that are running Windows Server 2012, run **W2K12-KB3134759-x64.msu /quiet**.
	- On computers that are running Windows Server 2008 R2 SP1 or Windows 7 SP1 x64, run **Win7AndW2K8R2-KB3134760-x64.msu /quiet**.
	- On computers that are running Windows 8.1 x86, run **Win8.1-KB3134758-x86.msu /quiet**.
	- On computers that are running Windows 7 SP1 x86, run **Win7-KB3134760-x86.msu /quiet**.

### Additional Installation Notes for Windows Server 2008 R2 SP1 and Windows 7 SP1:

Ensure following prerequisites have been met:
- Latest service pack is installed.
- [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) is installed.
- [.NET Framework 4.5 or above](https://msdn.microsoft.com/library/5a4x27ek.aspx) is installed.

**WMF 4.0 Dependency**

Windows Server 2008 R2 SP1 and Windows 7 SP1 systems have built-in PowerShell 2.0, WinRM, and WMI. WMF 3.0 and WMF 4.0 packages, which updates these built-in components, were released after the release of Windows Server 2008 R2 SP1 and Windows 7 SP1. Installing/Uninstalling WMF 3.0 and WMF 4.0 packages uncovered some issues in the following upgrade path:

- Built-in --> WMF 4.0
- Built-in --> WMF 3.0 --> WMF4.0. 

We fixed all these issues in WMF 4.0 packages. Hence, there is a prerequisite of WMF 4.0 for installing WMF 5.0 on Windows Server 2008 R2 SP1 and Windows 7 SP1. Below are the specific issues you might encounter if you do not install WMF 4.0 before upgrading to WMF 5.0:

- Forwarded Events log is unavailable and EventCollector log is not displayed in Event Viewer after you uninstall WMF 3.0 or WMF 5.0 (without the prerequisite WMF 4.0 installed) in Windows 7 SP1 and in Windows Server 2008 R2 SP1 ([KB2809215](https://support.microsoft.com/en-us/kb/2809215)).
- Customization to *PSModulePath* environment variable gets reset to default value when you upgrade directly from built-in PowerShell 2.0 to WMF 5.0 ([KB2872035](https://support.microsoft.com/en-us/kb/2872035)) or from WMF 3.0 to WMF 5.0. ([KB2872047](https://support.microsoft.com/en-us/kb/2872047)) in Windows 7 SP1 and in Windows Server 2008 R2 SP1.

**WinRM Dependency**

Windows PowerShell Desired State Configuration (DSC) depends on WinRM. WinRM is not enabled by default on Windows Server 2008 R2 SP1 and Windows 7 SP1. To enable WinRM, in a Windows PowerShell elevated session, run **Set-WSManQuickConfig**.

# Uninstallation Instructions

### Using Command Prompt

1.	Open **Command Prompt.**

2.	Run the [Windows Update Standalone Launcher](https://support.microsoft.com/en-us/kb/934307) as shown below:

On Windows Server 2012 R2 and Windows 8.1:
```powershell
wusa /uninstall /kb:3134758
```
On Windows Server 2012:
```powershell
wusa /uninstall /kb:3134759
```
On Windows Server 2008 R2 SP1 and Windows 7 SP1:
```powershell
wusa /uninstall /kb:3134760
```

### Using Control Panel

1.	Open **Control Panel.**

2.	Open **Programs**, then open **Uninstall a program.**

3.	Click **View installed updates.**

4.	Select **Windows Management Framework 5.0** from the list of installed updates. This corresponds to *KB3134758*, *KB3134759*, or *KB3134760*. Click **Uninstall.**

