---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Windows PowerShell System Requirements
ms.assetid:  6d1d3c75-3be4-4fc9-8805-ca9b2c454d42
---

# Windows PowerShell System Requirements
This topic lists the system requirements for Windows PowerShell 3.0, Windows PowerShell 4.0 and Windows PowerShell 5.0, and for special features, such as Windows PowerShell Integrated Scripting Environment (ISE), CIM commands, and workflows.

Windows® 8.1 and Windows Server® 2012 R2 include all required programs. This topic is designed for users of earlier releases of Windows.

## Operating System Requirements
Windows PowerShell 5.0 runs on the following versions of Windows.

- Windows Server 2016, installed by default

- Windows Server 2012 R2, install [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) to run Windows PowerShell 5.0

- Windows Server 2012, install [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) to run Windows PowerShell 5.0

- Windows Server 2008 R2 with Service Pack 1, install [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) to run Windows PowerShell 5.0

- Windows 8.1

- Windows 7 with Service Pack 1, install [Windows Management Framework 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) to run Windows PowerShell 5.0

Windows PowerShell 4.0 runs on the following versions of Windows.

- Windows 8.1, installed by default

- Windows Server 2012 R2, installed by default

- Windows® 7 with Service Pack 1, install [Windows Management Framework 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=40855) to run Windows PowerShell 4.0

- Windows Server® 2008 R2 with Service Pack 1, install [Windows Management Framework 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=40855) to run Windows PowerShell 4.0

Windows PowerShell 3.0 runs on the following versions of Windows.

- Windows 8, installed by default

- Windows Server 2012, installed by default

- Windows® 7 with Service Pack 1, install [Windows Management Framework 3.0](https://www.microsoft.com/en-us/download/details.aspx?id=34595) to run Windows PowerShell 3.0

- Windows Server® 2008 R2 with Service Pack 1, install [Windows Management Framework 3.0](https://www.microsoft.com/en-us/download/details.aspx?id=34595) to run Windows PowerShell 3.0

- Windows Server 2008 with Service Pack 2, install [Windows Management Framework 3.0](https://www.microsoft.com/en-us/download/details.aspx?id=34595) to run Windows PowerShell 3.0

## Microsoft .NET Framework Requirements
Windows PowerShell 5.0 requires the full installation of Microsoft .NET Framework 4.5. Windows 8.1 and Windows Server 2012 R2 include Microsoft .NET Framework 4.5 by default.

Windows PowerShell 4.0 requires the full installation of Microsoft .NET Framework 4.5. Windows 8.1 and Windows Server 2012 R2 include Microsoft .NET Framework 4.5 by default.

Windows PowerShell 3.0 requires the full installation of Microsoft .NET Framework 4. Windows 8 and Windows Server 2012 include Microsoft .NET Framework 4.5 by default, which fulfills this requirement.

To install Microsoft .NET Framework 4.5 (dotNetFx45_Full_setup.exe), see [Microsoft .NET Framework 4.5](http://go.microsoft.com/fwlink/?LinkID=242919) on the Microsoft Download Center.

To install the full installation of Microsoft .NET Framework 4 (dotNetFx40_Full_setup.exe), see [Microsoft .NET Framework 4 (Web Installer)](http://go.microsoft.com/fwlink/?LinkID=212931) on the Microsoft Download Center.

## Windows Management Framework 4.0
Windows PowerShell 5.0 requires Windows Management Framework 4.0 to be preinstalled on Windows Server 2008 R2 SP1 and Windows 7 SP1.

## WS-Management 3.0
Windows PowerShell 3.0 and Windows PowerShell 4.0 require WS-Management 3.0, which supports the WinRM service and WSMan protocol. This program is included in Windows 8.1, Windows Server 2012 R2, Windows 8, Windows Server 2012, Windows Management Framework 4.0, and Windows Management Framework 3.0.

## Windows Management Instrumentation 3.0
Windows PowerShell 3.0 and Windows PowerShell 4.0 require Windows Management Instrumentation 3.0 (WMI). This program is included in Windows 8.1, Windows Server 2012 R2, Windows 8, Windows Server 2012, Windows Management Framework 4.0, and Windows Management Framework 3.0. If this program is not installed on the computer, features that require WMI, such as CIM commands, do not run.

## Common Language Runtime 4.0
Windows PowerShell 3.0, Windows PowerShell 4.0, and Windows PowerShell 5.0 are compiled against Common Language Runtime (CLR) 4.0.

## Graphical User Interface Requirements
Windows PowerShell is a console-based application that does not require a graphical user interface. As such, is it well suited to computers that do not have screens or monitors, or a user interface, such as the Server Core installation options of Windows Server 2012 R2 or Windows Server 2012.

However, some items, such as the following, require a graphical user interface. For details, see the help topic for each item.

- Windows PowerShell Integrated Scripting Environment (ISE)

- Cmdlets

    1.  [Out-GridView](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-gridview)

    2.  [Show-Command](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Utility/Show-Command)

    3.  [Show-ControlPanelItem](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/Show-ControlPanelItem)

    4.  [Show-EventLog](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/Show-EventLog)

- Parameters

    1.  **ShowWindow** parameter of the [Get-Help](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/Get-Help) cmdlet.

    2.  **ShowSecurityDescriptorUI** parameter of the [Register-PSSessionConfiguration](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/Register-PSSessionConfiguration) and [Set-PSSessionConfiguration](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/Set-PSSessionConfiguration) cmdlets.

## Windows PowerShell Engine Requirements
Windows PowerShell 4.0 is designed to be backwards compatible with Windows PowerShell 3.0 and Windows PowerShell 2.0. Cmdlets, providers, snap-ins, modules, and scripts written for Windows PowerShell 2.0 and Windows PowerShell 3.0 run unchanged in Windows PowerShell 4.0.

However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, Windows PowerShell host programs that were written for Windows PowerShell 2.0 and compiled with Common Language Runtime (CLR) 2.0 cannot run without modification in Windows PowerShell 3.0, which is compiled with CLR 4.0.

The Windows PowerShell 2.0 engine requires Microsoft .NET Framework 2.0.50727 at a minimum. This requirement is fulfilled by Microsoft .NET Framework 3.5 Service Pack 1. This requirement is not fulfilled by Microsoft .NET Framework 4 and later releases of Microsoft .NET Framework.

For information about adding or installing the Windows PowerShell 2.0 engine, and adding or installing the required versions of the Microsoft .NET Framework, see [Installing the Windows PowerShell 2.0 Engine](Installing-the-Windows-PowerShell-2.0-Engine.md). For information about starting the Windows PowerShell 2.0 engine, see [Starting the Windows PowerShell 2.0 Engine](Starting-the-Windows-PowerShell-2.0-Engine.md).

## Windows Preinstallation Environment
Windows PowerShell 2.0, Windows PowerShell 3.0, and Windows PowerShell 4.0 run in the Windows Preinstallation Environment (Windows PE). However, the following cmdlets are not supported.

- [Background Intelligent Transfer Service (BITS) Cmdlets](http://go.microsoft.com/fwlink/?LinkId=257514)

- [Get-EventLog](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/Get-EventLog)

- [Get-WinEvent](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Diagnostics/Get-WinEvent)

- [Save-Help](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/Save-Help)

- [Update-Help](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/Update-Help)

Also, the **WinRM** service is not present on Windows PE.

## See Also
- [Getting Started with Windows PowerShell](../getting-started/Getting-Started-with-Windows-PowerShell.md)
- [Installing Windows PowerShell](Installing-Windows-PowerShell.md)
- [Starting Windows PowerShell](Starting-Windows-PowerShell.md)

