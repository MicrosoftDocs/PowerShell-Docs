# Installation Instructions

Download the correct package for your operating system and architecture:

| Operating System	     | Architecture | Package Name              | 
|------------------------|--------------|---------------------------| 
| Windows Server 2012 R2 | x64 		| [Win8.1AndW2K12R2-KB3134758-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717507) | 
| Windows Server 2012	 | x64		| [W2K12-KB3134759-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717506) | 
| Windows Server 2008 R2 | x64		| [Win7AndW2K8R2-KB3134760-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717504) |
| Windows 8.1            | x64          | [Win8.1AndW2K12R2-KB3134758-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717507) |
| Windows 8.1            | x86          | [Win8.1-KB3134758-x86.msu](http://go.microsoft.com/fwlink/?LinkID=717963) |
| Windows 7 SP1          | x64          | [Win7AndW2K8R2-KB3134760-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717504) |
| Windows 7 SP1          | x86          | [Win7-KB3134760-x86.msu](http://go.microsoft.com/fwlink/?LinkID=717962) |


**To install WMF 5.0 from Windows Explorer (or File Explorer in Windows Server 2012 R2 and Windows 8.1):**

1. Navigate to the folder into which you downloaded the MSU file.

2. Double-click the MSU to run it.

**To install WMF 5.0 from Command Prompt:** 

1. After downloading the correct package for your computer's architecture, open a Command Prompt window with elevated user rights (Run as Administrator). On the Server Core installation options of Windows Server 2012 R2 or Windows Server 2012 or Windows Server 2008 R2 SP1, Command Prompt opens with elevated user rights by default.

2. Change directories to the folder into which you have downloaded or copied the WMF 5.0 installation package.

3. Run one of the following commands:
	- On computers that are running Windows Server 2012 R2 or Windows 8.1 x64, run **Win8.1AndW2K12R2-KB3134758-x64.msu /quiet**.
	- On computers that are running Windows Server 2012, run **W2K12-KB3134759-x64.msu /quiet**.
	- On computers that are running Windows Server 2008 R2 SP1 or Windows 7 SP1 x64, run **Win7AndW2K8R2-KB3134760-x64.msu /quiet**.
	- On computers that are running Windows 8.1 x86, run **Win8.1-KB3134758-x86.msu /quiet**.
	- On computers that are running Windows 7 SP1 x86, run **Win7-KB3134760-x86.msu /quiet**.

**Additional Installation Notes for Windows Server 2008 SP1 and Windows 7 SP1:**

Ensure following prerequisites have been met:
- Latest service pack is installed.
- [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) is installed

*WinRM Dependency:*
Windows PowerShell Desired State Configuration (DSC) depends on WinRM. WinRM is not enabled by default on Windows Server 2008 R2 and Windows 7. To enable WinRM, in a Windows PowerShell elevated session, run **Set-WSManQuickConfig**.


