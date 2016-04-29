---
title: Windows PowerShell System Requirements
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6d1d3c75-3be4-4fc9-8805-ca9b2c454d42
---
# Windows PowerShell System Requirements
This topic lists the system requirements for [!INCLUDE[psversion3](../Token/psversion3_md.md)] and [!INCLUDE[psversion4](../Token/psversion4_md.md)], and for special features, such as [!INCLUDE[mshgraphicalhost](../Token/mshgraphicalhost_md.md)], CIM commands, and workflows.

[!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)] and [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] include all required programs. This topic is designed for users of earlier releases of Windows.

## Operating System Requirements
[!INCLUDE[psversion4](../Token/psversion4_md.md)] runs on the following versions of Windows.

-   [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], installed by default

-   [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], installed by default

-   [!INCLUDE[win7_client_firstref](../Token/win7_client_firstref_md.md)] with Service Pack 1, install [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881) to run [!INCLUDE[psversion4](../Token/psversion4_md.md)]

-   [!INCLUDE[win7_server_firstref](../Token/win7_server_firstref_md.md)] with Service Pack 1, install [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881) to run [!INCLUDE[psversion4](../Token/psversion4_md.md)]

[!INCLUDE[psversion3](../Token/psversion3_md.md)] runs on the following versions of Windows.

-   [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], installed by default

-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], installed by default

-   [!INCLUDE[win7_client_firstref](../Token/win7_client_firstref_md.md)] with Service Pack 1, install [Windows Management Framework 3.0](http://www.microsoft.com/download/details.aspx?id=34595) to run [!INCLUDE[psversion3](../Token/psversion3_md.md)]

-   [!INCLUDE[win7_server_firstref](../Token/win7_server_firstref_md.md)] with Service Pack 1, install [Windows Management Framework 3.0](http://www.microsoft.com/download/details.aspx?id=34595) to run [!INCLUDE[psversion3](../Token/psversion3_md.md)]

-   [!INCLUDE[lserver](../Token/lserver_md.md)] with Service Pack 2, install [Windows Management Framework 3.0](http://www.microsoft.com/download/details.aspx?id=34595) to run [!INCLUDE[psversion3](../Token/psversion3_md.md)]

## Microsoft .NET Framework Requirements
[!INCLUDE[psversion4](../Token/psversion4_md.md)] requires the full installation of Microsoft .NET Framework 4.5. [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] include Microsoft .NET Framework 4.5 by default.

[!INCLUDE[psversion3](../Token/psversion3_md.md)] requires the full installation of Microsoft .NET Framework 4. [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] include Microsoft .NET Framework 4.5 by default, which fulfills this requirement.

To install Microsoft .NET Framework 4.5 (dotNetFx45\_Full\_setup.exe), see [Microsoft .NET Framework 4.5](http://go.microsoft.com/fwlink/?LinkID=242919) on the Microsoft Download Center.

To install the full installation of Microsoft .NET Framework 4 (dotNetFx40\_Full\_setup.exe), see [Microsoft .NET Framework 4 (Web Installer)](http://go.microsoft.com/fwlink/?LinkID=212931) on the Microsoft Download Center.

## WS\-Management 3.0
[!INCLUDE[psversion3](../Token/psversion3_md.md)] and [!INCLUDE[psversion4](../Token/psversion4_md.md)] require WS\-Management 3.0, which supports the WinRM service and WSMan protocol. This program is included in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Management Framework 4.0, and [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)].

## Windows Management Instrumentation 3.0
[!INCLUDE[psversion3](../Token/psversion3_md.md)] and [!INCLUDE[psversion4](../Token/psversion4_md.md)] require Windows Management Instrumentation 3.0 (WMI). This program is included in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Management Framework 4.0, and [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)]. If this program is not installed on the computer, features that require WMI, such as CIM commands, do not run.

## Common Language Runtime 4.0
[!INCLUDE[psversion3](../Token/psversion3_md.md)] and [!INCLUDE[psversion4](../Token/psversion4_md.md)] are compiled against Common Language Runtime (CLR) 4.0.

## Graphical User Interface Requirements
[!INCLUDE[wps_2](../Token/wps_2_md.md)] is a console\-based application that does not require a graphical user interface. As such, is it well suited to computers that do not have screens or monitors, or a user interface, such as the Server Core installation options of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].

However, some items, such as the following, require a graphical user interface. For details, see the help topic for each item.

-   [!INCLUDE[mshgraphicalhost](../Token/mshgraphicalhost_md.md)]

-   Cmdlets

    1.  [Out-GridView](https://technet.microsoft.com/en-us/library/70915a86-d753-464e-8349-cba02316154c)

    2.  [Show-Command](https://technet.microsoft.com/en-us/library/65bba50b-91a8-49d5-80a2-a30fc684ba41)

    3.  [Show-ControlPanelItem](https://technet.microsoft.com/en-us/library/0685d42c-37cc-498f-acf6-0ecfeb0cb162)

    4.  [Show-EventLog](https://technet.microsoft.com/en-us/library/a3b0f5ad-0438-42c7-915b-d1b4793a431c)

-   Parameters

    1.  **ShowWindow** parameter of the [Get-Help](https://technet.microsoft.com/en-us/library/1f46eeb4-49d7-4bec-bb29-395d9b42f54a) cmdlet.

    2.  **ShowSecurityDescriptorUi** parameter of the [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/e9152ae2-bd6d-4056-9bc7-dc1893aa29ea) and [Set-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/b21fbad3-1759-4260-b206-dcb8431cd6ea) cmdlets.

## Windows PowerShell Engine Requirements
[!INCLUDE[psversion4](../Token/psversion4_md.md)] is designed to be backwards compatible with [!INCLUDE[psversion3](../Token/psversion3_md.md)] and [!INCLUDE[psversion2](../Token/psversion2_md.md)]. Cmdlets, providers, snap\-ins, modules, and scripts written for [!INCLUDE[psversion2](../Token/psversion2_md.md)] and [!INCLUDE[psversion3](../Token/psversion3_md.md)] run unchanged in [!INCLUDE[psversion4](../Token/psversion4_md.md)].

However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, [!INCLUDE[wps_2](../Token/wps_2_md.md)] host programs that were written for [!INCLUDE[psversion2](../Token/psversion2_md.md)] and compiled with Common Language Runtime (CLR) 2.0 cannot run without modification in [!INCLUDE[psversion3](../Token/psversion3_md.md)], which is compiled with CLR 4.0.

The [!INCLUDE[psversion2](../Token/psversion2_md.md)] engine requires Microsoft .NET Framework 2.0.50727 at a minimum. This requirement is fulfilled by Microsoft .NET Framework 3.5 Service Pack 1. This requirement is not fulfilled by Microsoft .NET Framework 4 and later releases of Microsoft .NET Framework.

For information about adding or installing the [!INCLUDE[psversion2](../Token/psversion2_md.md)] engine, and adding or installing the required versions of the Microsoft .NET Framework, see [Installing the Windows PowerShell 2.0 Engine](../Topic/Installing-the-Windows-PowerShell-2.0-Engine.md). For information about starting the [!INCLUDE[psversion2](../Token/psversion2_md.md)] engine, see [Starting the Windows PowerShell 2.0 Engine](../Topic/Starting-the-Windows-PowerShell-2.0-Engine.md).

## Windows Preinstallation Environment
[!INCLUDE[psversion2](../Token/psversion2_md.md)], [!INCLUDE[psversion3](../Token/psversion3_md.md)], and [!INCLUDE[psversion4](../Token/psversion4_md.md)] run in the Windows Preinstallation Environment (Windows PE). However, the following cmdlets are not supported.

-   [Background Intelligent Transfer Service (BITS) Cmdlets](http://go.microsoft.com/fwlink/?LinkId=257514)

-   [Get-EventLog](https://technet.microsoft.com/en-us/library/b4985b11-82bf-487d-928d-becd96fc0419)

-   [Get-WinEvent[PSITPro5_Diagnostic]](https://technet.microsoft.com/en-us/library/5fe94870-ed6b-4ce2-9500-93846cc65c95)

-   [Save-Help](https://technet.microsoft.com/en-us/library/aed94f90-b73f-4e25-a25d-7c18d9f161fa)

-   [Update-Help](https://technet.microsoft.com/en-us/library/93e1d870-ace6-432b-8778-8920291d7545)

Also, the **WinRm** service is not present on Windows PE.

## See Also
[Getting Started with Windows PowerShell](../Topic/Getting-Started-with-Windows-PowerShell.md)
[Installing Windows PowerShell](../Topic/Installing-Windows-PowerShell.md)
[Starting Windows PowerShell [ps]](https://technet.microsoft.com/en-us/library/8ec8c2d7-8e7c-4722-a3d2-498fe5739a8e)

