---
description: WMF is a prerequisite for Windows PowerShell. This articles shows the history of WMF versions and provides information about how to find and install WMF.
ms.date: 08/26/2023
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

- [WMF 5.1][08]
- [WMF 5.0][07]

## WMF availability across Windows operating systems

|         OS Version         |     End of Support     |   WMF 5.1    | WMF 5.0<br>_Out of support_ | WMF 4.0<br>_Out of support_ | WMF 3.0<br>_Out of support_ | WMF 2.0<br>_Out of support_ |
| -------------------------- | ---------------------- | ------------ | --------------------------- | --------------------------- | --------------------------- | --------------------------- |
| Windows Server 2022        | [2031-10-14][04]       | Ships in-box |                             |                             |                             |                             |
| Windows Server 2019        | [2029-01-09][04]       | Ships in-box |                             |                             |                             |                             |
| Windows Server 2016        | [2027-01-11][04]       | Ships in-box |                             |                             |                             |                             |
| Windows 11                 | [2025-10-14][03]       | Ships in-box |                             |                             |                             |                             |
| Windows 10                 | [2025-10-14][03]       | Ships in-box | Ships in-box                |                             |                             |                             |
| Windows Server 2012 R2     | [2023-10-10][02]       | [Yes][05]    | Yes                         | Ships in-box                |                             |                             |
| Windows 8.1                | [_Out of support_][02] | [Yes][05]    | Yes                         | Ships in-box                |                             |                             |
| Windows Server 2012        | [2023-10-10][02]       | [Yes][05]    | Yes                         | Yes                         | Ships in-box                |                             |
| Windows 8                  | [_Out of support_][01] |              |                             |                             | Ships in-box                |                             |
| Windows Server 2008 R2 SP1 | [_Out of support_][01] | [Yes][05]    | Yes                         | Yes                         | Yes                         | Ships in-box                |
| Windows 7 SP1              | [_Out of support_][01] | [Yes][05]    | Yes                         | Yes                         | Yes                         | Ships in-box                |
| Windows Server 2008 SP2    | [_Out of support_][01] |              |                             |                             | Yes                         | Yes                         |
| Windows Vista              | [_Out of support_][01] |              |                             |                             |                             | Yes                         |
| Windows Server 2003        | [_Out of support_][01] |              |                             |                             |                             | Yes                         |
| Windows XP                 | [_Out of support_][01] |              |                             |                             | Yes                         | Yes                         |

- **Ships in-box**: The features of the specified version of WMF were shipped in the indicated
  version of Windows client or Windows Server.
- **Out of support**: These products are no longer supported by Microsoft. You must upgrade to a
  supported version. For more information, see the [Microsoft Lifecycle Policy][06] page.

> [!NOTE]
> The installer for WMF 4.0 is no longer available or supported.

<!-- link refs -->
[01]: /lifecycle/products/?products=windows
[02]: /windows/release-health/status-windows-8.1-and-windows-server-2012-r2
[03]: /windows/release-health/supported-versions-windows-client
[04]: /windows/release-health/windows-server-release-info
[05]: https://aka.ms/wmf51download
[06]: https://support.microsoft.com/lifecycle
[07]: whats-new/release-notes.md#wmf-50-changes
[08]: whats-new/release-notes.md#wmf-51-changes
