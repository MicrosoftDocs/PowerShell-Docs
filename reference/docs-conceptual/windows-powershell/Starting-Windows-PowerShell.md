---
ms.date:  12/05/2019
keywords:  powershell,cmdlet
title:  Starting Windows PowerShell
description: This article explains the ways of starting various versions of PowerShell.
---

# Starting Windows PowerShell

Windows PowerShell is a scripting engine `.DLL` that's embedded into multiple hosts. The most common
hosts you'll start are the interactive command-line `powershell.exe` and the Interactive Scripting
Environment `powershell_ise.exe`.

To start Windows PowerShell&reg; on Windows Server&reg; 2012 R2, Windows&reg; 8.1, Windows Server
2012, and Windows 8, see
[Common Management Tasks and Navigation in Windows](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831491(v=ws.11)).

## PowerShell Core has renamed binary

PowerShell Core, referred to as PowerShell, is version 6 and higher that's open source and uses .NET
Core. Supported versions are available on Windows, macOS, and Linux.

Beginning in PowerShell 6, the PowerShell binary was renamed `pwsh.exe` for Windows and `pwsh` for
macOS and Linux. You can start PowerShell preview versions using `pwsh-preview`. For more
information, see
[What's New in PowerShell Core 6.0](/powershell/scripting/whats-new/what-s-new-in-powershell-core-60#renamed-powershellexe-to-pwshexe)
and [About pwsh](/powershell/module/microsoft.powershell.core/about/about_pwsh).

To find cmdlet reference and installation documentation for PowerShell 7, use the following links:

| Document | Link |
| ----- | ----- |
| Cmdlet reference | [PowerShell Module Browser](/powershell/module/) |
| Windows installation | [Installing PowerShell Core on Windows](/powershell/scripting/install/installing-powershell-core-on-windows) |
| macOS installation | [Installing PowerShell Core on macOS](/powershell/scripting/install/installing-powershell-core-on-macos) |
| Linux installation | [Installing PowerShell Core on Linux](/powershell/scripting/install/installing-powershell-core-on-linux) |

To view content for other PowerShell versions, see [How to use the PowerShell documentation](../how-to-use-docs.md).

## How to Start Windows PowerShell on Earlier Versions of Windows

This section explains how to start Windows PowerShell and Windows PowerShell Integrated Scripting
Environment (ISE) on Windows&reg; 7, Windows Server&reg; 2008 R2, and Windows Server&reg; 2008. It
also explains how to enable the optional feature for Windows PowerShell ISE in Windows PowerShell
2.0 on Windows Server&reg; 2008 R2 and Windows Server&reg; 2008.

Use any of the following methods to start the installed version of Windows PowerShell 3.0, or
Windows PowerShell 4.0, where applicable.

#### From the Start Menu

- Click **Start**, type **PowerShell**, and then click **Windows PowerShell**.
- From the **Start** menu, click **Start**, click **All Programs**, click **Accessories**, click the
  **Windows PowerShell** folder, and then click **Windows PowerShell**.

#### At the Command Prompt

In **cmd.exe**, Windows PowerShell, or Windows PowerShell ISE, to start Windows PowerShell, type:

```
PowerShell
```

You can also use the parameters of the `powershell.exe` program to customize the session. For more
information, see
[PowerShell.exe Command-Line Help](/powershell/module/Microsoft.PowerShell.Core/About/about_PowerShell_exe).

#### With Administrative privileges (Run as administrator)

Click **Start**, type **PowerShell**, right-click **Windows PowerShell**, and then click **Run as
administrator**.

## How to Start Windows PowerShell ISE on Earlier Releases of Windows

Use any of the following methods to start Windows PowerShell ISE.

#### From the Start Menu

- Click **Start**, type **ISE**, and then click **Windows PowerShell ISE**.
- From the **Start** menu, click **Start**, click **All Programs**, click **Accessories**, click the
  **Windows PowerShell** folder, and then click **Windows PowerShell ISE**.

#### At the Command Prompt

In `cmd.exe`, Windows PowerShell, or Windows PowerShell ISE, to start Windows PowerShell, type:

```
PowerShell_ISE
```

or

```
ISE
```

#### With Administrative privileges (Run as administrator)

Click **Start**, type **ISE**, right-click **Windows PowerShell ISE**, and then click **Run as
administrator**.

## How to Enable Windows PowerShell ISE on Earlier Releases of Windows

In Windows PowerShell 4.0 and Windows PowerShell 3.0, Windows PowerShell ISE is enabled by default
on all versions of Windows. If it isn't already enabled, Windows Management Framework 4.0 or Windows
Management Framework 3.0 enables it.

In Windows PowerShell 2.0, Windows PowerShell ISE is enabled by default on Windows 7. However, on
Windows Server 2008 R2 and Windows Server 2008, it's an optional feature.

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

However, you might occasionally need to run **Windows PowerShell (x86)**, such as when you're using
a module that requires the 32-bit version or when you're connecting remotely to a 32-bit computer.

To start a 32-bit version of Windows PowerShell, use any of the following procedures.

#### In Windows Server&reg; 2012 R2

- On the **Start** screen, type **Windows PowerShell (x86)**. Click the **Windows PowerShell x86**
  tile.
- In **Server Manager**, from the **Tools** menu, select **Windows PowerShell (x86)**.
- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell
  x86** and then click **Windows PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows Server&reg; 2012

- On the **Start** screen, type **PowerShell** and then click **Windows PowerShell (x86)**.
- In **Server Manager**, from the **Tools** menu, select **Windows PowerShell (x86)**.
- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell**
  and then click **Windows PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows&reg; 8.1

- On the **Start** screen, type **Windows PowerShell (x86)**. Click the **Windows PowerShell x86**
  tile.
- If you're running
  [Remote Server Administration Tools](https://go.microsoft.com/fwlink/?LinkID=304145) for Windows
  8.1, you can also open Windows PowerShell x86 from the **Server ManagerTools** menu. Select
  **Windows PowerShell (x86)**.
- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell
  x86** and then click **Windows PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows&reg; 8

- On the **Start** screen, move the cursor to the upper right corner, click **Settings**, click
  **Tiles**, and then move the **Show Administrative Tools** slider to **Yes**. Then, type
  **PowerShell** and click **Windows PowerShell (x86)**.
- If you're running
  [Remote Server Administration Tools](https://www.microsoft.com/download/details.aspx?id=28972) for
  Windows 8, you can also open Windows PowerShell x86 from the **Server ManagerTools** menu. Select
  **Windows PowerShell (x86)**.
- On the **Start** screen or the desktop, type **PowerShell (x86)** and then click **Windows
  PowerShell (x86)**.
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`
