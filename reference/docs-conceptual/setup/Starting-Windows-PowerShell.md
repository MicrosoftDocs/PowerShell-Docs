---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Starting Windows PowerShell
ms.assetid:  59b649a2-c90c-4cf4-bf95-a740c59148e7
---

# Starting Windows PowerShell
PowerShell is a scripting engine dll which is embedded into multiple hosts.  The most common host you will start are the interactive command line PowerShell.exe and the Interactive Scripting Environment PowerShell_ISE.exe.

To start Windows PowerShell® on Windows Server® 2012 R2, Windows® 8.1, Windows Server 2012, and Windows 8, see [Common Management Tasks and Navigation](https://technet.microsoft.com/library/hh831491.aspx).

## How to Start Windows PowerShell on Earlier Versions of Windows

This section explains how to start Windows PowerShell and Windows PowerShell Integrated Scripting
Environment (ISE) on Windows® 7, Windows Server® 2008 R2, and Windows Server® 2008. It also
explains how to enable the optional feature for Windows PowerShell ISE in Windows PowerShell 2.0 on
Windows Server® 2008 R2 and Windows Server® 2008.

Use any of the following methods to start the installed version of Windows PowerShell 3.0, or
Windows PowerShell 4.0, where applicable.

#### From the Start Menu

- Click **Start**, type **PowerShell**, and then click **Windows PowerShell**.
- From the **Start** menu, click **Start**, click **All Programs**, click **Accessories**, click
  the **Windows PowerShell** folder, and then click **Windows PowerShell**.

#### At the Command Prompt

In Cmd.exe, Windows PowerShell, or Windows PowerShell ISE, to start Windows PowerShell, type:

```
PowerShell
```

You can also use the parameters of the PowerShell.exe program to customize the session. For more
information, see [PowerShell.exe Command-Line Help](../core-powershell/console/PowerShell.exe-Command-Line-Help.md).

#### With Administrative privileges ("Run as administrator")

Click **Start**, type **PowerShell**, right-click **Windows PowerShell**, and then click **Run as
administrator**.

## How to Start Windows PowerShell ISE on Earlier Releases of Windows

Use any of the following methods to start Windows PowerShell ISE.

#### From the Start Menu

- Click **Start**, type **ISE**, and then click **Windows PowerShell ISE**.
- From the **Start** menu, click **Start**, click **All Programs**, click **Accessories**, click
  the **Windows PowerShell** folder, and then click **Windows PowerShell ISE**.

#### At the Command Prompt

In Cmd.exe, Windows PowerShell, or Windows PowerShell ISE, to start Windows PowerShell, type:

```
PowerShell_ISE
```

or

```
ISE
```

#### With Administrative privileges ("Run as administrator")

Click **Start**, type **ISE**, right-click **Windows PowerShell ISE**, and then click **Run as
administrator**.

## How to Enable Windows PowerShell ISE on Earlier Releases of Windows

In Windows PowerShell 4.0 and Windows PowerShell 3.0, Windows PowerShell ISE is enabled by default
on all versions of Windows. If it is not already enabled, Windows Management Framework 4.0 or
Windows Management Framework 3.0 enables it.

In Windows PowerShell 2.0, Windows PowerShell ISE is enabled by default on Windows 7. However, on
Windows Server 2008 R2 and Windows Server 2008, it is an optional feature.

To enable Windows PowerShell ISE in Windows PowerShell 2.0 on Windows Server 2008 R2 or Windows
Server 2008, use the following procedure.

#### To enable Windows PowerShell Integrated Scripting Environment (ISE)

1. Start Server Manager.
2. Click **Features** and then click **Add Features**.
3. In Select Features, click Windows PowerShell Integrated Scripting Environment (ISE).

## Starting the 32-Bit Version of Windows PowerShell

When you install Windows PowerShell on a 64-bit computer, **Windows PowerShell (x86)**, a 32-bit
version of Windows PowerShell is installed in addition to the 64-bit version. When you run Windows
PowerShell, the 64-bit version runs by default.

However, you might occasionally need to run **Windows PowerShell (x86)**, such as when you are
using a module that requires the 32-bit version or when you are connecting remotely to a 32-bit
computer.

To start a 32-bit version of Windows PowerShell, use any of the following procedures.

#### In Windows Server® 2012 R2

- On the **Start** screen, type **Windows PowerShell (x86)**. Click the **Windows PowerShell x86**
  tile.
- In **Server Manager**, from the **Tools** menu, select **Windows PowerShell (x86)**.
- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell
  x86** and then click **Windows PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows Server® 2012

- On the **Start** screen, type **PowerShell** and then click **Windows PowerShell (x86)**.
- In **Server Manager**, from the **Tools** menu, select **Windows PowerShell (x86)**.
- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell**
  and then click **Windows PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows® 8.1

- On the **Start** screen, type **Windows PowerShell (x86)**. Click the **Windows PowerShell x86**
  tile.
- If you are running
  [Remote Server Administration Tools](https://go.microsoft.com/fwlink/?LinkID=304145) for
  Windows 8.1, you can also open Windows PowerShell x86 from the **Server ManagerTools** menu.
  Select **Windows PowerShell (x86)**.
- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell
  x86** and then click **Windows PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows® 8

- On the **Start** screen, move the cursor to the upper right corner, click **Settings**, click
  **Tiles**, and then move the **Show Administrative Tools** slider to Yes. Then, type **PowerShell**
  and click **Windows PowerShell (x86)**.
- If you are running
  [Remote Server Administration Tools](https://www.microsoft.com/download/details.aspx?id=28972) for
  Windows 8, you can also open Windows PowerShell x86 from the **Server ManagerTools** menu. Select
  **Windows PowerShell (x86)**.
- On the **Start** screen or the desktop, type **PowerShell (x86)** and then click **Windows
  PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`