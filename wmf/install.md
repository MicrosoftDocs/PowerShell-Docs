# Installation Instructions

Download the correct package for your operating system and architecture.

| Operating System	     | Architecture | Package Name              | 
|------------------------|--------------|---------------------------| 
| Windows Server 2012 R2 | x64 			| [W2K12R2-KB3094174-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717507) | 
| Windows Server 2012	 | x64			| [W2K12-KB3094175-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717506) | 
| Windows Server 2008 R2 | x64			| [W2K8R2-KB3094176-x64.msu](http://go.microsoft.com/fwlink/?LinkId=717504)  | 


## Installation on Windows Server 2012 R2 and Windows Server 2012

Ensure following prerequisites have been met:

- **Windows Server 2012 R2**, or **Windows Server 2012**
- **Windows PowerShell 2.0** (if applicable)
	- Windows PowerShell 2.0 is disabled by default on Windows Server 2012 R2 Server Core. It can be enabled by running the following two commands:
```powershell
dism /online /enable-feature:MicrosoftWindowsPowerShellV2
dism /online /enable-feature:MicrosoftWindowsPowerShellV2-WOW64
```

**Installation:**

- **Double-click** the appropriate MSU file to start installation, or run the MSU file directly from ** Command Prompt **.

## Installation on Windows Server 2008 R2 SP1

Ensure following prerequisites have been met:

- Latest service pack is installed.
- [WMF 4.0](http://www.microsoft.com/en-us/download/details.aspx?id=40855) is installed

**Installation:**

- **Double-click** the appropriate MSU file to start installation, or run the MSU file directly from ** Command Prompt **.

** WinRM Dependency:**

Windows PowerShell Desired State Configuration (DSC) depends on WinRM. WinRM is not enabled by default on Windows Server 2008 R2. To enable WinRM, in a Windows PowerShell elevated session, run **Set-WSManQuickConfig**.
