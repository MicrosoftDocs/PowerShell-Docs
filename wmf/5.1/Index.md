---
ms.date:  08/12/2017
ms.topic: conceptual
keywords:  wmf,powershell,setup
title:  WMF 5.1 Release Notes
---

# Windows Management Framework (WMF) 5.1

WMF provides users with the ability to update existing Windows systems to the versions of PowerShell, WMI, WinRM, and Software Inventory Logging (SIL) components that were released with Windows Server 2016.

WMF 5.1 can be installed on Windows 7, Windows 8.1, Windows Server 2008 R2, 2012, and 2012 R2, and provides a number of improvements over WMF 5.0 RTM including:

- New cmdlets: local users and groups; Get-ComputerInfo
- PowerShellGet improvements include enforcing signed modules, and installing JEA modules
- PackageManagement added support for Containers, CBS Setup, EXE-based setup, CAB packages
- Debugging improvements for DSC and PowerShell classes
- Security enhancements including enforcement of catalog-signed modules coming from the Pull Server and when using PowerShellGet cmdlets
- Responses to a number of user requests and issues

To learn about what is new in this release, browse the topics listed under [New Scenarios and Features](https://docs.microsoft.com/powershell/wmf/5.1/scenarios-features).

The [Install and Configure](https://docs.microsoft.com/powershell/wmf/5.1/install-configure) topic lists the requirements and provides installation instructions for WMF.

The [Compatibility](https://docs.microsoft.com/powershell/wmf/5.1/compatibility) topic lists which versions of WMF may be installed on which Windows releases.

[Product Compatibility](https://docs.microsoft.com/powershell/wmf/5.1/productincompat) lists the Microsoft applications that have not approved WMF 5.1 for use at this time.

Details for the components of WMF will be found in MSDN documentation:

- [PowerShell 5.1](https://docs.microsoft.com/powershell/)
- [WMI](https://msdn.microsoft.com/library/jj152383(v=vs.85).aspx)
- [WinRM](https://msdn.microsoft.com/library/aa384426(v=vs.85).aspx)
- [Software Inventory Logging](https://technet.microsoft.com/library/dn383584(v=ws.11).aspx)
