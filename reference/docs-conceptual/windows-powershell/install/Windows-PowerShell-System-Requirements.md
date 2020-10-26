---
ms.date:  12/06/2019
keywords:  powershell,cmdlet
title:  Windows PowerShell System Requirements
description: This article lists the system requirements for Windows PowerShell 3.0, Windows PowerShell 4.0, Windows PowerShell 5.0, and Windows PowerShell 5.1.
---

# Windows PowerShell System Requirements

This article lists the system requirements for Windows PowerShell 3.0, Windows PowerShell 4.0,
Windows PowerShell 5.0, and Windows PowerShell 5.1. And, special features, such as Windows
PowerShell Integrated Scripting Environment (ISE), Common Information Model (CIM) commands, and
workflows.

Windows&reg; 8.1 and Windows Server&reg; 2012 R2 include all required programs. This article is designed for
users of earlier releases of Windows.

## Operating system requirements

### Windows PowerShell 5.1

Windows PowerShell 5.1 runs on the following versions of Windows. To run Windows PowerShell 5.1,
install Windows Management Framework 5.1. For more information, see
[Install and Configure WMF 5.1](../wmf/setup/install-configure.md).

|              Windows version               |                           System requirement                            |
| ------------------------------------------ | ----------------------------------------------------------------------- |
| Windows Server 2019                        | Installed by default                                                    |
| Windows Server 2016                        | Installed by default                                                    |
| Windows Server 2012 R2                     | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows Server 2012                        | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows Server 2008 R2 with Service Pack 1 | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows 10 version 1607 and up             | Installed by default                                                    |
| Windows 10 version 1507, 1511              | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows 8.1                                | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows 7 with Service Pack 1              | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |

### Windows PowerShell 5.0

Windows PowerShell 5.0 runs on the following versions of Windows. To run Windows PowerShell 5.0,
install Windows Management Framework 5.1. For more information, see
[Install and Configure WMF 5.1](../wmf/setup/install-configure.md). Windows Management Framework 5.1
supersedes Windows Management Framework 5.0.

|              Windows version               |                           System requirement                            |
| ------------------------------------------ | ----------------------------------------------------------------------- |
| Windows Server 2019                        | Higher version installed by default                                     |
| Windows Server 2016                        | Higher version installed by default                                     |
| Windows Server 2012 R2                     | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows Server 2012                        | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows Server 2008 R2 with Service Pack 1 | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows 10 version 1607 and up             | Higher version installed by default                                     |
| Windows 10 version 1507, 1511              | Installed by default                                                    |
| Windows 8.1                                | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |
| Windows 7 with Service Pack 1              | Install [Windows Management Framework 5.1](https://aka.ms/wmf5download) |

### Windows PowerShell 4.0

Windows PowerShell 4.0 runs on the following versions of Windows. To run Windows PowerShell 4.0,
install the specified version of the Windows Management Framework for your operating system.

|               Windows version               |                                             System requirement                                             |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Windows 8.1                                 | Installed by default                                                                                       |
| Windows Server 2012 R2                      | Installed by default                                                                                       |
| Windows&reg; 7 with Service Pack 1              | Install [Windows Management Framework 4.0](https://www.microsoft.com/download/details.aspx?id=40855) |
| Windows Server&reg; 2008 R2 with Service Pack 1 | Install [Windows Management Framework 4.0](https://www.microsoft.com/download/details.aspx?id=40855) |

### Windows PowerShell 3.0

Windows PowerShell 3.0 runs on the following versions of Windows. To run Windows PowerShell 3.0,
install the specified version of the Windows Management Framework for your operating system.

|               Windows version               |                                             System requirement                                             |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Windows 8                                   | Installed by default                                                                                       |
| Windows Server 2012                         | Installed by default                                                                                       |
| Windows&reg; 7 with Service Pack 1              | Install [Windows Management Framework 3.0](https://www.microsoft.com/download/details.aspx?id=34595) |
| Windows Server&reg; 2008 R2 with Service Pack 1 | Install [Windows Management Framework 3.0](https://www.microsoft.com/download/details.aspx?id=34595) |
| Windows Server 2008 with Service Pack 2     | Install [Windows Management Framework 3.0](https://www.microsoft.com/download/details.aspx?id=34595) |

## Microsoft .NET Framework requirements

The following table shows the .NET Framework requirements for Windows PowerShell.

|        Version         |                                                                                 .NET requirement                                                                                  |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Windows PowerShell 5.1 | Requires the full installation of Microsoft .NET Framework 4.5. Windows 8.1 and Windows Server 2012 R2 include Microsoft .NET Framework 4.5 by default.                           |
| Windows PowerShell 5.0 | Requires the full installation of Microsoft .NET Framework 4.5. Windows 8.1 and Windows Server 2012 R2 include Microsoft .NET Framework 4.5 by default.                           |
| Windows PowerShell 4.0 | Requires the full installation of Microsoft .NET Framework 4.5. Windows 8.1 and Windows Server 2012 R2 include Microsoft .NET Framework 4.5 by default.                           |
| Windows PowerShell 3.0 | Requires the full installation of Microsoft .NET Framework 4. Windows 8 and Windows Server 2012 include Microsoft .NET Framework 4.5 by default, which fulfills this requirement. |

Use the following links to download Microsoft .NET Framework from the Microsoft Download Center.

|                     Version                      |                                                     Link                                                     |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| .NET Framework 4.5 (`dotNetFx45_Full_setup.exe`) | [Microsoft .NET Framework 4.5](https://go.microsoft.com/fwlink/?LinkID=242919)                               |
| .NET Framework 4 (`dotNetFx40_Full_setup.exe`)   | [Microsoft .NET Framework 4 (Web Installer)](https://www.microsoft.com/download/details.aspx?id=17851) |

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
  [Introducing the Windows PowerShell ISE](/powershell/scripting/components/ise/introducing-the-windows-powershell-ise).
- Cmdlets
  - [Out-GridView](/powershell/module/microsoft.powershell.utility/out-gridview)
  - [Show-Command](/powershell/module/Microsoft.PowerShell.Utility/Show-Command)
  - [Show-ControlPanelItem](/powershell/module/Microsoft.PowerShell.Management/Show-ControlPanelItem)
  - [Show-EventLog](/powershell/module/Microsoft.PowerShell.Management/Show-EventLog)
- Parameters
  - **ShowWindow** parameter of the [Get-Help](/powershell/module/Microsoft.PowerShell.Core/Get-Help) cmdlet.
  - **ShowSecurityDescriptorUI** parameter of the
    [Register-PSSessionConfiguration](/powershell/module/Microsoft.PowerShell.Core/Register-PSSessionConfiguration)
    and
    [Set-PSSessionConfiguration](/powershell/module/Microsoft.PowerShell.Core/Set-PSSessionConfiguration)
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
[Installing the Windows PowerShell 2.0 Engine](Installing-the-Windows-PowerShell-2.0-Engine.md). For
information about starting the Windows PowerShell 2.0 engine, see
[Starting the Windows PowerShell 2.0 Engine](../Starting-the-Windows-PowerShell-2.0-Engine.md).

## Windows Preinstallation Environment

Windows PowerShell 2.0, Windows PowerShell 3.0, and Windows PowerShell 4.0 run in the Windows
Preinstallation Environment (Windows PE). However, the following cmdlets aren't supported.

- Background Intelligent Transfer Service (BITS) cmdlets. For more information, see
  [BitsTransfer](/powershell/module/bitstransfer/).
- [Get-EventLog](/powershell/module/Microsoft.PowerShell.Management/Get-EventLog)
- [Get-WinEvent](/powershell/module/Microsoft.PowerShell.Diagnostics/Get-WinEvent)
- [Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help)
- [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help)

The **WinRM** service isn't present on Windows PE.

## See also

[Installing Windows PowerShell](Installing-Windows-PowerShell.md)

[Starting Windows PowerShell](../Starting-Windows-PowerShell.md)

[Windows Management Framework](../wmf/overview.md)
