---
ms.date:  06/12/2018
keywords:  wmf,powershell,setup
title:  Windows Management Framework (WMF)
---

# Windows Management Framework

Windows Management Framework (WMF) provides a consistent management interface for Windows. WMF
provides a seamless way to manage various versions of Windows client and Windows Server. WMF
installer packages contain updates to management functionality and are available for older versions
of Windows.

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

To learn about various enhancements in PowerShell and other components of a given WMF, please refer
to the links below to review the release notes:

- [WMF 5.1](5.1/release-notes.md)
- [WMF 5.0](5.0/releasenotes.md)
- [WMF 4.0](https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows%20Management%20Framework%204%200%20Release%20Notes.docx)
- [WMF 3.0](https://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/WMF%203%20Release%20Notes.docx)

## WMF Availability Across Windows Operating Systems

|Operating System Version  |[WMF 5.1][] |[WMF 5.0][] |[WMF 4.0][] |[WMF 3.0][]  |[WMF 2.0][] |
|--------------------------|------------|------------|------------|-------------|------------|
|Windows Server 2016       |Ships in-box|            |            |             |            |
|Windows 10                |Ships in-box|Ships in-box|            |             |            |
|Windows Server 2012 R2    |Yes         |Yes         |Ships in-box|             |            |
|Windows 8.1               |Yes         |Yes         |Ships in-box|             |            |
|Windows Server 2012       |Yes         |Yes         |Yes         |Ships in-box |            |
|Windows 8                 |            |            |            |Ships in-box |            |
|Windows Server 2008 R2 SP1|Yes         |Yes         |Yes         |Yes          |Ships in-box|
|Windows 7 SP1             |Yes         |Yes         |Yes         |Yes          |Ships in-box|
|Windows Server 2008 SP2   |            |            |            |Yes          |Yes         |
|Windows Vista             |            |            |            |             |Yes         |
|Windows Server 2003       |            |            |            |             |Yes         |
|Windows XP                |            |            |            |Yes          |            |

**Ships in-box**: The features of the specified version of WMF were shipped in the indicated version of
Windows client or Windows Server.

[WMF 5.1]: https://aka.ms/wmf51download
[WMF 5.0]: https://aka.ms/wmf5download
[WMF 4.0]: https://aka.ms/wmf4download
[WMF 3.0]: https://aka.ms/wmf3download
[WMF 2.0]: https://aka.ms/wmf2download
