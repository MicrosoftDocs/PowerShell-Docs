---
description: This article lists the system requirements for Windows PowerShell 3.0, Windows PowerShell 4.0, Windows PowerShell 5.0, and Windows PowerShell 5.1.
ms.date: 10/23/2023
title: Windows PowerShell System Requirements
---

# Windows PowerShell System Requirements

This article lists the system requirements for Windows PowerShell 3.0, Windows PowerShell 4.0,
Windows PowerShell 5.0, and Windows PowerShell 5.1. And, special features, such as Windows
PowerShell Integrated Scripting Environment (ISE), Common Information Model (CIM) commands, and
workflows.

Windows 8.1 and Windows Server 2012 R2 include all required programs. This article is designed for
users of earlier releases of Windows.

## Operating system requirements

### Windows PowerShell 5.1

Windows PowerShell 5.1 runs on the following versions of Windows. To run Windows PowerShell 5.1,
install Windows Management Framework 5.1. For more information, see
[Install and Configure WMF 5.1][04].

|              Windows version               |               System requirement               |
| ------------------------------------------ | ---------------------------------------------- |
| Windows Server 2022                        | Installed by default                           |
| Windows Server 2019                        | Installed by default                           |
| Windows Server 2016                        | Installed by default                           |
| Windows Server 2012 R2                     | Install [Windows Management Framework 5.1][18] |
| Windows Server 2012                        | Install [Windows Management Framework 5.1][18] |
| Windows Server 2008 R2 with Service Pack 1 | Install [Windows Management Framework 5.1][18] |
| Windows 11                                 | Installed by default                           |
| Windows 10 version 1607 and up             | Installed by default                           |
| Windows 10 version 1507, 1511              | Install [Windows Management Framework 5.1][18] |
| Windows 8.1                                | Install [Windows Management Framework 5.1][18] |
| Windows 7 with Service Pack 1              | Install [Windows Management Framework 5.1][18] |

### Windows PowerShell 5.0

Windows Management Framework 5.1 supersedes Windows Management Framework 5.0. For more information,
see [Install and Configure WMF 5.1][04].

|              Windows version               |               System requirement               |
| ------------------------------------------ | ---------------------------------------------- |
| Windows Server 2022                        | Higher version installed by default            |
| Windows Server 2019                        | Higher version installed by default            |
| Windows Server 2016                        | Higher version installed by default            |
| Windows Server 2012 R2                     | Install [Windows Management Framework 5.1][18] |
| Windows Server 2012                        | Install [Windows Management Framework 5.1][18] |
| Windows Server 2008 R2 with Service Pack 1 | Install [Windows Management Framework 5.1][18] |
| Windows 11                                 | Higher version installed by default            |
| Windows 10 version 1607 and up             | Higher version installed by default            |
| Windows 10 version 1507, 1511              | Installed by default                           |
| Windows 8.1                                | Install [Windows Management Framework 5.1][18] |
| Windows 7 with Service Pack 1              | Install [Windows Management Framework 5.1][18] |

### Windows PowerShell 4.0

Windows PowerShell 4.0 runs on the following versions of Windows.

|              Windows version               |               System requirement               |
| ------------------------------------------ | ---------------------------------------------- |
| Windows 8.1                                | Installed by default                           |
| Windows Server 2012 R2                     | Installed by default                           |

### Windows PowerShell 3.0

Windows PowerShell 3.0 runs on the following versions of Windows.

|              Windows version               |               System requirement               |
| ------------------------------------------ | ---------------------------------------------- |
| Windows 8                                  | Installed by default                           |
| Windows Server 2012                        | Installed by default                           |

## Microsoft .NET Framework requirements

Windows PowerShell 5.1 requires the full installation of Microsoft .NET Framework 4.5 or higher.

## Windows Management Framework 4.0

Windows PowerShell 5.0 requires Windows Management Framework 4.0 to be preinstalled on Windows
Server 2008 R2 SP1 and Windows 7 SP1.

## WS-Management 3.0

Windows PowerShell 3.0 and Windows PowerShell 4.0 require WS-Management 3.0, which supports the
WinRM service and WSMan protocol. This program is included in Windows 8.1, Windows Server 2012 R2,
Windows 8, Windows Server 2012, Windows Management Framework 4.0, and Windows Management Framework
3.0.

## Windows Management Instrumentation 3.0

Windows PowerShell 3.0 and Windows PowerShell 4.0 require Windows Management Instrumentation 3.0
(WMI). This program is included in Windows 8.1, Windows Server 2012 R2, Windows 8, Windows Server
2012, Windows Management Framework 4.0, and Windows Management Framework 3.0. If this program isn't
installed on the computer, features that require WMI, such as CIM commands, don't run.

## Common Language Runtime 4.0

Windows PowerShell 3.0, Windows PowerShell 4.0, and Windows PowerShell 5.0 are compiled against
Common Language Runtime (CLR) 4.0.

## Graphical user interface requirements

Windows PowerShell is a console-based application that doesn't require a graphical user interface.
It's well suited to computers that don't have screens or monitors, or a user interface, such as the
Server Core installation options of Windows Server 2012 R2 or Windows Server 2012.

Some items require a graphical user interface. For details, see the help article for each item.

- Windows PowerShell Integrated Scripting Environment (ISE). For more information, see
  [Introducing the Windows PowerShell ISE][17].
- Cmdlets
  - [Out-GridView][15]
  - [Show-Command][16]
  - [Show-ControlPanelItem][13]
  - [Show-EventLog][14]
- Parameters
  - **ShowWindow** parameter of the [Get-Help][06] cmdlet.
  - **ShowSecurityDescriptorUI** parameter of the
    [Register-PSSessionConfiguration][07]
    and
    [Set-PSSessionConfiguration][09]
    cmdlets.

## Windows PowerShell engine requirements

Windows PowerShell 4.0 is designed to be backwards compatible with Windows PowerShell 3.0 and
Windows PowerShell 2.0. Cmdlets, providers, snap-ins, modules, and scripts written for Windows
PowerShell 2.0 and Windows PowerShell 3.0 run unchanged in Windows PowerShell 4.0.

However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, Windows
PowerShell host programs that were written for Windows PowerShell 2.0 and compiled with Common
Language Runtime (CLR) 2.0 can't run without modification in Windows PowerShell 3.0, which is
compiled with CLR 4.0.

The Windows PowerShell 2.0 engine's minimum requirement is Microsoft .NET Framework 2.0.50727. This
requirement is fulfilled by Microsoft .NET Framework 3.5 Service Pack 1. This requirement isn't
fulfilled by Microsoft .NET Framework 4 and later releases of Microsoft .NET Framework.

For information about adding or installing the Windows PowerShell 2.0 engine, and adding or
installing the required versions of the Microsoft .NET Framework, see
[Installing the Windows PowerShell 2.0 Engine][23]. For
information about starting the Windows PowerShell 2.0 engine, see
[Starting the Windows PowerShell 2.0 Engine][01].

## Windows Preinstallation Environment

Windows PowerShell 2.0, Windows PowerShell 3.0, and Windows PowerShell 4.0 run in the Windows
Preinstallation Environment (Windows PE). However, the following cmdlets aren't supported.

- Background Intelligent Transfer Service (BITS) cmdlets. For more information, see
  [BitsTransfer][05].
- [Get-EventLog][12]
- [Get-WinEvent][11]
- [Save-Help][08]
- [Update-Help][10]

The **WinRM** service isn't present on Windows PE.

For information on installing Windows PowerShell 5.1 on Windows PE, see
[Adding Windows PowerShell support to Windows PE][25].

## See also

- [Installing Windows PowerShell][24]
- [Starting Windows PowerShell][02]
- [Windows Management Framework][03]

<!-- link references -->
[01]: ../Starting-the-Windows-PowerShell-2.0-Engine.md
[02]: ../Starting-Windows-PowerShell.md
[03]: ../wmf/overview.md
[04]: ../wmf/setup/install-configure.md
[05]: /powershell/module/bitstransfer/
[06]: /powershell/module/Microsoft.PowerShell.Core/Get-Help
[07]: /powershell/module/Microsoft.PowerShell.Core/Register-PSSessionConfiguration
[08]: /powershell/module/Microsoft.PowerShell.Core/Save-Help
[09]: /powershell/module/Microsoft.PowerShell.Core/Set-PSSessionConfiguration
[10]: /powershell/module/Microsoft.PowerShell.Core/Update-Help
[11]: /powershell/module/Microsoft.PowerShell.Diagnostics/Get-WinEvent
[12]: /powershell/module/Microsoft.PowerShell.Management/Get-EventLog
[13]: /powershell/module/Microsoft.PowerShell.Management/Show-ControlPanelItem
[14]: /powershell/module/Microsoft.PowerShell.Management/Show-EventLog
[15]: /powershell/module/microsoft.powershell.utility/out-gridview
[16]: /powershell/module/Microsoft.PowerShell.Utility/Show-Command
[17]: /powershell/scripting/components/ise/introducing-the-windows-powershell-ise
[18]: https://aka.ms/wmf5download
[21]: https://www.microsoft.com/download/details.aspx?id=34595
[23]: Installing-the-Windows-PowerShell-2.0-Engine.md
[24]: Installing-Windows-PowerShell.md
[25]: /windows-hardware/manufacture/desktop/winpe-adding-powershell-support-to-windows-pe
