---
description: WMF is a prerequisite for Windows PowerShell. This articles shows the history of WMF versions and provides information about how to find and install WMF.
ms.date: 10/25/2022
title: Windows Management Framework (WMF)
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

- [WMF 5.1][09]
- [WMF 5.0][08]

## WMF availability across Windows operating systems

|         OS Version         |  End of Support  | [WMF 5.1][04] | WMF 5.0<br>_Out of support_ | WMF 4.0<br>_Out of support_ | WMF 3.0<br>_Out of support_ | WMF 2.0<br>_Out of support_ |
| -------------------------- | ---------------- | ------------- | --------------------------- | --------------------------- | --------------------------- | --------------------------- |
| Windows Server 2022        |                  | Ships in-box  |                             |                             |                             |                             |
| Windows Server 2019        |                  | Ships in-box  |                             |                             |                             |                             |
| Windows Server 2016        | Jan 12, 2027     | Ships in-box  |                             |                             |                             |                             |
| Windows 11                 |                  | Ships in-box  |                             |                             |                             |                             |
| Windows 10                 |                  | Ships in-box  | Ships in-box                |                             |                             |                             |
| Windows Server 2012 R2     | Oct 10, 2023     | Yes           | Yes                         | Ships in-box                |                             |                             |
| Windows 8.1                | Jan 10, 2023     | Yes           | Yes                         | Ships in-box                |                             |                             |
| Windows Server 2012        | Oct 10, 2023     | Yes           | Yes                         | Yes                         | Ships in-box                |                             |
| Windows 8                  | _Out of support_ |               |                             |                             | Ships in-box                |                             |
| Windows Server 2008 R2 SP1 | _Out of support_ | Yes           | Yes                         | Yes                         | Yes                         | Ships in-box                |
| Windows 7 SP1              | _Out of support_ | Yes           | Yes                         | Yes                         | Yes                         | Ships in-box                |
| Windows Server 2008 SP2    | _Out of support_ |               |                             |                             | Yes                         | Yes                         |
| Windows Vista              | _Out of support_ |               |                             |                             |                             | Yes                         |
| Windows Server 2003        | _Out of support_ |               |                             |                             |                             | Yes                         |
| Windows XP                 | _Out of support_ |               |                             |                             | Yes                         | Yes                         |

- **Ships in-box**: The features of the specified version of WMF were shipped in the indicated
  version of Windows client or Windows Server.
- **Out of support**: These products are no longer supported by Microsoft. You must upgrade to a
  supported version. For more information, see the [Microsoft Lifecycle Policy][07] page.

> [!NOTE]
> The installer for WMF 4.0 is no longer available or supported.

<!-- link refs -->
[04]: https://aka.ms/wmf51download
[07]: https://support.microsoft.com/lifecycle
[08]: whats-new/release-notes.md#wmf-50-changes
[09]: whats-new/release-notes.md#wmf-51-changes
<!--
[01]: https://aka.ms/wmf2download
[02]: https://aka.ms/wmf3download
[03]: https://aka.ms/wmf4download
[05]: https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows%20Management%20Framework%204%200%20Release%20Notes.docx
[06]: https://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/WMF%203%20Release%20Notes.docx
-->
