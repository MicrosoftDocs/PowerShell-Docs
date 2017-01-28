---
title:   WMF 5.1 Release Notes 
ms.date:  2017-01-20
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  keithb
manager:  carmonm
ms.prod:  powershell
ms.technology: WMF
---

# Windows Management Framework (WMF) 5.1 Release Notes #

WMF 5.1 includes the PowerShell, WMI, WinRM, and Software Inventory and Licensing (SIL) components that were released with Windows Server 2016.
WMF 5.1 can be installed on Windows 7, Windows 8.1, Windows Server 2008 R2, 2012, and 2012 R2, and provides a number of improvements over WMF 5.0 RTM including:

- New cmdlets: local users and groups; Get-ComputerInfo
- PowerShellGet improvements include enforcing signed modules, and installing JEA modules
- PackageManagement added support for Containers, CBS Setup, EXE-based setup, CAB packages
- Debugging improvements for DSC and PowerShell classes
- Security enhancements including enforcement of catalog-signed modules coming from the Pull Server and when using PowerShellGet cmdlets
- Responses to a number of user requests and issues

**Important notes:**

- **WMF 5.1 requires the .NET Framework 4.5.2**. Installation will succeed, but key features will fail if .NET 4.5.2 is not installed. Instructions are available in the [Install and Configure WMF 5.1 ](https://msdn.microsoft.com/en-us/powershell/wmf/5.1/install-configure) topic.
- WMF 5.1 Preview must be uninstalled before installing WMF 5.1 RTM.
- WMF 5.1 may be installed directly over WMF 5.0 or WMF 4.0.
- It is __not required__ to install WMF 4.0 prior to installing WMF 5.1 on Windows 7 and Windows Server 2008 R2. That was an issue for the WMF 5.1 Preview release, and has been resolved.  


