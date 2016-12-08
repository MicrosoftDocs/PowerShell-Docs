---
title:   Windows Management Framework (WMF)
ms.date:  2016-12-07
keywords:  PowerShell, WMF
description:  
ms.topic:  article
author:  keithb
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# Windows Management Framework

Windows Management Framework (WMF) is the delivery mechanism that provides a consistent management interface across the various flavors of Windows and Windows Server.
With the installation of WMF, customers get a seamless way to interoperate between mixes of OSes in their environment.
WMF makes the updates to management functionality, in a given release of Windows and Windows Server, available for installation on lower versions (typically, 2 lower versions) of Windows and Windows Server.

WMF installation adds and/or updates the following features:

- Windows PowerShell
- Windows PowerShell Desired State Configuration (DSC)
- Windows PowerShell Integrated Script Environment (ISE)
- Windows Remote Management (WinRM)
- Windows Management Instrumentation (WMI)
- Windows PowerShell Web Services (Management OData IIS Extension)
- Software Inventory Logging (SIL)
- Server Manager CIM Provider

## WMF Release Notes

To learn about various enhancements in PowerShell and other components of a given WMF, please refer to the links below to review the release notes:

- [WMF 5.1 (Preview)](5.1/release-notes.md)
- [WMF 5.0](5.0/releasenotes.md)

## WMF Availability Across Windows Operating Systems

| Operating System Version | [WMF 5.1](https://aka.ms/wmf51download) | [WMF 5.0](https://aka.ms/wmf5download) | [WMF 4.0](https://aka.ms/wmf4download) |  [WMF 3.0](https://aka.ms/wmf3download) | [WMF 2.0](https://aka.ms/wmf2download) |
| ------------------------ | ----------- | ----------- | ----------- | ------------ |  ------------- |
| Windows Server 2016 | Ships in-box |  |  |  |  |
| Windows 10 | Ships in-box | Ships in-box  | | | |  
| Windows Server 2012 R2| Yes | Yes | Ships in-box |  |  |
| Windows 8.1 | Yes | Yes |  Ships in-box |  |  |
| Windows Server 2012 | Yes | Yes | Yes |  Ships in-box | |
| Windows 8 |  |  |  | Ships in-box | |
| Windows Server 2008 R2 SP1 | Yes | Yes | Yes |  Yes| Ships in-box |
| Windows 7 SP1  | Yes | Yes | Yes | Yes | Ships in-box |
| Windows Server 2008 SP2 | | | | Yes | Yes |
| Windows Vista | | | | | Yes |
| Windows Server 2003| | | |  | Yes |
| Windows XP | | | |  | Yes |

**"Ships in-box"**: 
The features of the `specified WMF` were shipped in the indicated version of  Windows and Windows Server.
Hence, the `specified WMF` doesn't need to be installed on the indicated operating system versions.
