---
title:  Installing Windows PowerShell
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  6fbb0409-5a54-48ec-95e6-7f8b7d8c4969
---

# Installing Windows PowerShell
Windows® 8 and Windows Server® 2012 include Windows PowerShell 3.0 and all of its prerequisites. The system also includes the Windows PowerShell 2.0 engine for backward compatibility with host programs that cannot use Windows PowerShell 3.0.

This topic explains how to install Windows PowerShell 3.0 on earlier systems and install and enable the required features.

This topic includes the following sections:

-   [Installing Windows PowerShell on Windows 8 and Windows Server 2012](Installing-Windows-PowerShell.md#BKMK_InstallingOnWindows8andWindowsServer2012)

-   [Installing Windows PowerShell on Windows 7 and Windows Server 2008 R2](Installing-Windows-PowerShell.md#BKMK_InstallingOnWindows7andWindowsServer2008R2)

-   [Installing Windows PowerShell on Windows Server 2008](Installing-Windows-PowerShell.md#BKMK_InstallingOnWindowsServer2008LH)

-   [Installing Windows PowerShell on Server Core](Installing-Windows-PowerShell.md#BKMK_InstallingOnServerCore)

-   [Deploying Windows PowerShell Web Access](https://technet.microsoft.com/en-us/library/639d0eff-98a3-4124-b52c-26921ebd98b0)

-   [Installing the Windows PowerShell 2.0 Engine](Installing-the-Windows-PowerShell-2.0-Engine.md)

## <a name="BKMK_InstallingOnWindows8andWindowsServer2012"></a>Installing Windows PowerShell on Windows 8 and Windows Server 2012
Windows PowerShell 3.0 arrives installed, configured, and ready to use. Windows PowerShell Integrated Scripting Environment (ISE) is installed and enabled. For information about starting Windows PowerShell, see [Starting Windows PowerShell on Windows 8](https://technet.microsoft.com/en-us/library/d7be1668-8617-4890-ad90-dd9765fbd2c3) and [Starting Windows PowerShell on Windows Server 2012](https://technet.microsoft.com/library/hh831491.aspx#BKMK_powershell).

## <a name="BKMK_InstallingOnWindows7andWindowsServer2008R2"></a>Installing Windows PowerShell on Windows 7 and Windows Server 2008 R2
These instructions explain how to install Windows PowerShell 3.0 on computers running Windows 7 with Service Pack 1 and Windows Server 2008 R2 with Service Pack 1. There are separate installation instructions below for computers running with the Server Core installation option of Windows Server 2008 R2.

#### Getting ready to install

-   Before installing Windows Management Framework 3.0, uninstall any previous versions of Windows Management Framework 3.0.

#### To install Windows PowerShell 3.0

1.  Install the full installation of Microsoft .NET Framework 4 (dotNetFx40\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=212547](http://go.microsoft.com/fwlink/?LinkID=212547).

    Or, install Microsoft .NET Framework 4.5 (dotNetFx45\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=242919](http://go.microsoft.com/fwlink/?LinkID=242919).

2.  Install Windows Management Framework 3.0 from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=240290](http://go.microsoft.com/fwlink/?LinkID=240290).

For information about starting Windows PowerShell 3.0, see [Starting Windows PowerShell on Earlier Versions of Windows](Starting-Windows-PowerShell-on-Earlier-Versions-of-Windows.md).

## <a name="BKMK_InstallingOnServerCore"></a>Installing Windows PowerShell on Server Core
These instructions explain how to install Windows PowerShell 3.0 on computers running the Server Core installation option of Windows Server 2008 R2 with Service Pack 1.

The first steps in the procedure use Deployment Image Servicing and Management (DISM) commands to install Microsoft .NET Framework 2.0 for Server Core and Windows PowerShell 2.0. These programs are prerequisites for Windows Management Framework 3.0, which is installed in a subsequent step.

#### Getting ready to install

-   Before installing Windows Management Framework 3.0, uninstall any previous versions of Windows Management Framework 3.0.

#### To install Windows PowerShell 3.0

1.  Start Cmd.exe

2.  Run the following DISM commands. These commands install .NET Framework 2.0 and Windows PowerShell 2.0.

    ```
    dism /online /enable-feature:NetFx2-ServerCore
    dism /online /enable-feature:MicrosoftWindowsPowerShell
    dism /online /enable-feature:NetFx2-ServerCore-WOW64
    ```

3.  Install Microsoft .NET Framework 4.0 full installation for Server Core from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=248450](http://go.microsoft.com/fwlink/?LinkID=248450).

4.  Install Windows Management Framework 3.0 from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=240290](http://go.microsoft.com/fwlink/?LinkID=240290).

## <a name="BKMK_InstallingOnWindowsServer2008LH"></a>Installing Windows PowerShell on Windows Server 2008
These instructions explain how to install Windows PowerShell 3.0 on computers running Windows Server 2008 with Service Pack 2.

On Windows Server 2008 systems, Windows Management Framework (Windows PowerShell 2.0, KB 968930) is a prerequisite for Windows Management Framework 3.0. The "Extended Protection for Authentication" feature protects the computer from authentication forwarding attacks and allows you to use the **UseSSL** parameter when creating remote sessions. To install Windows PowerShell 3.0 and the Windows PowerShell 2.0 Engine, use the following procedure.

#### Getting ready to install

-   Before installing Windows Management Framework 3.0, uninstall any previous versions of Windows Management Framework 3.0.

#### To install Windows PowerShell 3.0

1.  Install Microsoft .NET Framework 3.5 with Service Pack 1 from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=242910](http://go.microsoft.com/fwlink/?LinkID=242910).

2.  Install Windows Management Framework (Windows PowerShell 2.0, KB 968930) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkId=243035](http://go.microsoft.com/fwlink/?LinkId=243035).

3.  Install the full installation of Microsoft .NET Framework 4 (dotNetFx40\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=212547](http://go.microsoft.com/fwlink/?LinkID=212547).

    Or, install Microsoft .NET Framework 4.5 (dotNetFx45\_Full\_setup.exe) from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=242919](http://go.microsoft.com/fwlink/?LinkID=242919).

4.  Install "Extended Protection for Authentication" (KB 968389) from [http://go.microsoft.com/fwlink/?LinkID=186398](http://go.microsoft.com/fwlink/?LinkID=186398).

5.  Install Windows Management Framework 3.0 from the Microsoft Download Center at [http://go.microsoft.com/fwlink/?LinkID=240290](http://go.microsoft.com/fwlink/?LinkID=240290).

## See Also
[Windows PowerShell System Requirements](Windows-PowerShell-System-Requirements.md)
[Starting Windows PowerShell [ps]](https://technet.microsoft.com/en-us/library/8ec8c2d7-8e7c-4722-a3d2-498fe5739a8e)
