---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Starting Windows PowerShell on Earlier Versions of Windows
ms.assetid:  57125436-3d1e-4e7f-b5c4-8f0ecb49d642
---

# Starting Windows PowerShell on Earlier Versions of Windows
This section explains how to start Windows PowerShell and Windows PowerShell Integrated Scripting Environment (ISE) on Windows® 7, Windows Server® 2008 R2, and Windows Server® 2008. It also explains how to enable the optional feature for Windows PowerShell ISE in Windows PowerShell 2.0 on Windows Server® 2008 R2 and Windows Server® 2008.

To install Windows PowerShell 4.0 on supported systems, download and install [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881). For more information, see [Installing Windows PowerShell](Installing-Windows-PowerShell.md).

To install Windows PowerShell 3.0 on supported systems, download and install [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/?LinkID=240290). For more information, see [Installing Windows PowerShell](Installing-Windows-PowerShell.md).

## How to Start Windows PowerShell on Earlier Versions of Windows
Use any of the following methods to start the installed version of Windows PowerShell 3.0, or Windows PowerShell 4.0, where applicable.

#### From the Start Menu

- Click **Start**, type **PowerShell**, and then click **Windows PowerShell**.

- From the **Start** menu, click **Start**, click **All Programs**, click **Accessories**, click the **Windows PowerShell** folder, and then click **Windows PowerShell**.

#### At the Command Prompt

- In Cmd.exe, Windows PowerShell, or Windows PowerShell ISE, to start Windows PowerShell, type:

    ```
    PowerShell
    ```

    You can also use the parameters of the PowerShell.exe program to customize the session. For more information, see [PowerShell.exe Command-Line Help](../core-powershell/console/PowerShell.exe-Command-Line-Help.md).

#### With Administrative privileges ("Run as administrator")

1. Click **Start**, type **PowerShell**, right-click **Windows PowerShell**, and then click **Run as administrator**.

## How to Start Windows PowerShell ISE on Earlier Releases of Windows
Use any of the following methods to start Windows PowerShell ISE.

#### From the Start Menu

- Click **Start**, type **ISE**, and then click **Windows PowerShell ISE**.

- From the **Start** menu, click **Start**, click **All Programs**, click **Accessories**, click the **Windows PowerShell** folder, and then click **Windows PowerShell ISE**.

#### At the Command Prompt

- In Cmd.exe, Windows PowerShell, or Windows PowerShell ISE, to start Windows PowerShell, type:

    ```
    PowerShell_ISE
    ```

    or

    ```
    ISE
    ```

#### With Administrative privileges ("Run as administrator")

1. Click **Start**, type **ISE**, right-click **Windows PowerShell ISE**, and then click **Run as administrator**.

## How to Enable Windows PowerShell ISE on Earlier Releases of Windows
In Windows PowerShell 4.0 and Windows PowerShell 3.0, Windows PowerShell ISE is enabled by default on all versions of Windows. If it is not already enabled, Windows Management Framework 4.0 or Windows Management Framework 3.0 enables it.

In Windows PowerShell 2.0, Windows PowerShell ISE is enabled by default on Windows 7. However, on Windows Server 2008 R2 and Windows Server 2008, it is an optional feature.

To enable Windows PowerShell ISE in Windows PowerShell 2.0 on Windows Server 2008 R2 or Windows Server 2008, use the following procedure.

#### To enable Windows PowerShell Integrated Scripting Environment (ISE)

1. Start Server Manager.

2. Click **Features** and then click **Add Features**.

3. In Select Features, click Windows PowerShell Integrated Scripting Environment (ISE).

