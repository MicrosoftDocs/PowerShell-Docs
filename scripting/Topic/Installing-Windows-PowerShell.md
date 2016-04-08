---
title: Installing Windows PowerShell
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6fbb0409-5a54-48ec-95e6-7f8b7d8c4969
---
# Installing Windows PowerShell
[!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] include [!INCLUDE[psversion3](../Token/psversion3_md.md)] and all of its prerequisites. The system also includes the [!INCLUDE[psversion2](../Token/psversion2_md.md)] engine for backward compatibility with host programs that cannot use [!INCLUDE[psversion3](../Token/psversion3_md.md)].

This topic explains how to install [!INCLUDE[psversion3](../Token/psversion3_md.md)] on earlier systems and install and enable the required features.

This topic includes the following sections:

-   [Installing Windows PowerShell on Windows 8 and Windows Server 2012](../Topic/Installing-Windows-PowerShell.md#BKMK_InstallingOnWindows8andWindowsServer2012)

-   [Installing Windows PowerShell on Windows 7 and Windows Server 2008 R2](../Topic/Installing-Windows-PowerShell.md#BKMK_InstallingOnWindows7andWindowsServer2008R2)

-   [Installing Windows PowerShell on Windows Server 2008](../Topic/Installing-Windows-PowerShell.md#BKMK_InstallingOnWindowsServer2008LH)

-   [Installing Windows PowerShell on Server Core](../Topic/Installing-Windows-PowerShell.md#BKMK_InstallingOnServerCore)

-   [Deploying Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/639d0eff-98a3-4124-b52c-26921ebd98b0)

-   [Installing the Windows PowerShell 2.0 Engine](../Topic/Installing-the-Windows-PowerShell-2.0-Engine.md)

## <a name="BKMK_InstallingOnWindows8andWindowsServer2012"></a>Installing Windows PowerShell on Windows 8 and Windows Server 2012
[!INCLUDE[psversion3](../Token/psversion3_md.md)] arrives installed, configured, and ready to use. [!INCLUDE[mshgraphicalhost](../Token/mshgraphicalhost_md.md)] is installed and enabled. For information about starting [!INCLUDE[mshshort](../Token/mshshort_md.md)], see [Starting Windows PowerShell on Windows 8](https://technet.microsoft.com/en-us/library/d7be1668-8617-4890-ad90-dd9765fbd2c3) and [Starting Windows PowerShell on Windows Server 2012](https://technet.microsoft.com/en-us/library/4fc0110a-cc0c-42a4-bbb5-3cc89a0fc968).

## <a name="BKMK_InstallingOnWindows7andWindowsServer2008R2"></a>Installing Windows PowerShell on Windows 7 and Windows Server 2008 R2
These instructions explain how to install [!INCLUDE[psversion3](../Token/psversion3_md.md)] on computers running [!INCLUDE[win7_client_secondref](../Token/win7_client_secondref_md.md)] with Service Pack 1 and [!INCLUDE[win7_server_secondref](../Token/win7_server_secondref_md.md)] with Service Pack 1. There are separate installation instructions below for computers running with the Server Core installation option of [!INCLUDE[win7_server_secondref](../Token/win7_server_secondref_md.md)].

#### Getting ready to install

-   Before installing [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)], uninstall any previous versions of Windows Management Framework 3.0.

#### To install [!INCLUDE[psversion3](../Token/psversion3_md.md)]

1.  Install the full installation of Microsoft .NET Framework 4 (dotNetFx40\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=212547](http://go.microsoft.com/fwlink/?LinkID=212547).

    Or, install Microsoft .NET Framework 4.5 (dotNetFx45\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=242919](http://go.microsoft.com/fwlink/?LinkID=242919).

2.  Install [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)] from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=240290](http://go.microsoft.com/fwlink/?LinkID=240290).

For information about starting [!INCLUDE[psversion3](../Token/psversion3_md.md)], see [Starting Windows PowerShell on Earlier Versions of Windows](../Topic/Starting-Windows-PowerShell-on-Earlier-Versions-of-Windows.md).

## <a name="BKMK_InstallingOnServerCore"></a>Installing Windows PowerShell on Server Core
These instructions explain how to install [!INCLUDE[psversion3](../Token/psversion3_md.md)] on computers running the Server Core installation option of [!INCLUDE[win7_server_secondref](../Token/win7_server_secondref_md.md)] with Service Pack 1.

The first steps in the procedure use Deployment Image Servicing and Management (DISM) commands to install Microsoft [!INCLUDE[dnprdnlong](../Token/dnprdnlong_md.md)] for Server Core and [!INCLUDE[psversion2](../Token/psversion2_md.md)]. These programs are prerequisites for [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)], which is installed in a subsequent step.

#### Getting ready to install

-   Before installing [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)], uninstall any previous versions of Windows Management Framework 3.0.

#### To install [!INCLUDE[psversion3](../Token/psversion3_md.md)]

1.  Start Cmd.exe

2.  Run the following DISM commands. These commands install [!INCLUDE[dnprdnlong](../Token/dnprdnlong_md.md)] and [!INCLUDE[psversion2](../Token/psversion2_md.md)].

    ```
    dism /online /enable-feature:NetFx2-ServerCore
    dism /online /enable-feature:MicrosoftWindowsPowerShell
    dism /online /enable-feature:NetFx2-ServerCore-WOW64
    ```

3.  Install Microsoft [!INCLUDE[netfx40_short](../Token/netfx40_short_md.md)] full installation for Server Core from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=248450](http://go.microsoft.com/fwlink/?LinkID=248450).

4.  Install [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)] from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=240290](http://go.microsoft.com/fwlink/?LinkID=240290).

## <a name="BKMK_InstallingOnWindowsServer2008LH"></a>Installing Windows PowerShell on Windows Server 2008
These instructions explain how to install [!INCLUDE[psversion3](../Token/psversion3_md.md)] on computers running [!INCLUDE[lserver](../Token/lserver_md.md)] with Service Pack 2.

On [!INCLUDE[lserver](../Token/lserver_md.md)] systems, Windows Management Framework ([!INCLUDE[psversion2](../Token/psversion2_md.md)], KB 968930) is a prerequisite for [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)]. The "Extended Protection for Authentication" feature protects the computer from authentication forwarding attacks and allows you to use the **UseSSL** parameter when creating remote sessions. To install [!INCLUDE[psversion3](../Token/psversion3_md.md)] and the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, use the following procedure.

#### Getting ready to install

-   Before installing [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)], uninstall any previous versions of Windows Management Framework 3.0.

#### To install [!INCLUDE[psversion3](../Token/psversion3_md.md)]

1.  Install Microsoft .NET Framework 3.5 with Service Pack 1 from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=242910](http://go.microsoft.com/fwlink/?LinkID=242910).

2.  Install Windows Management Framework ([!INCLUDE[psversion2](../Token/psversion2_md.md)], KB 968930) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkId=243035](http://go.microsoft.com/fwlink/?LinkId=243035).

3.  Install the full installation of Microsoft .NET Framework 4 (dotNetFx40\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=212547](http://go.microsoft.com/fwlink/?LinkID=212547).

    Or, install Microsoft .NET Framework 4.5 (dotNetFx45\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=242919](http://go.microsoft.com/fwlink/?LinkID=242919).

4.  Install "Extended Protection for Authentication" (KB 968389) from [http://go.microsoft.com/fwlink/?LinkID=186398](http://go.microsoft.com/fwlink/?LinkID=186398).

5.  Install [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)] from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=240290](http://go.microsoft.com/fwlink/?LinkID=240290).

## See Also
[Windows PowerShell System Requirements](../Topic/Windows-PowerShell-System-Requirements.md)
[Starting Windows PowerShell [ps]](https://technet.microsoft.com/en-us/library/8ec8c2d7-8e7c-4722-a3d2-498fe5739a8e)

