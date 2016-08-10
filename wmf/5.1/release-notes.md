---
title:   WMF 5.1 Release Notes (Preview)
ms.date:  2016-07-27
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  jkeithb
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# Windows Management Framework (WMF) 5.1 Preview Release Notes #

WMF 5.1 Preview includes the PowerShell, WMI, WinRM, and Software Inventory and Licensing (SIL) components that are being released with Windows Server 2016. 
WMF 5.1 can be installed on Windows 7, Windows 8.1, Windows Server 2008 R2, 2012, and 2012 R2, and provides a number of improvements over WMF 5.0 RTM including:

- New cmdlets: local users and groups; Get-ComputerInfo
- PowerShellGet improvements include enforcing signed modules, and installing JEA modules
- PackageManagement added support for Containers, CBS Setup, EXE-based setup, CAB packages
- Debugging improvements for DSC and PowerShell classes
- Security enhancements including enforcement of catalog-signed modules coming from the Pull Server and when using PowerShellGet cmdlets
- Responses to a number of user requests and issues

**Important notes:**

- **WMF 5.1 Preview requires the .NET Framework 4.6**. Installation will succeed, but key features will fail if .NET 4.6 is not installed. Instructions are available in the [Install and Configure WMF 5.1 (Preview)](https://msdn.microsoft.com/en-us/powershell/wmf/5.1/install-configure) topic. 
- **WMF 5.1 Preview is not supported for production** deployments at this time. It is intended to provide early information about what is in the release, and to give you the opportunity to provide feedback to the PowerShell team.
- WMF 5.1 Preview may be installed directly over WMF 5.0.
- It is a known issue that WMF 4.0 is currently required in order to install WMF 5.1 Preview on Windows 7 and Windows Server 2008. This requirement is expected to be removed before the final release.
- Installing future versions of WMF 5.1, including the RTM version, will require uninstalling the WMF 5.1 Preview.

