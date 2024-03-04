---
description: This article explains the ways of starting various versions of PowerShell.
ms.date: 03/04/2024
title: Starting Windows PowerShell
---

# Starting Windows PowerShell

Windows PowerShell is a scripting engine that's embedded into multiple hosts. The most common hosts
you'll start are the interactive command-line `powershell.exe` and the Interactive Scripting
Environment `powershell_ise.exe`.

## PowerShell has renamed binary

PowerShell version 6 and higher uses .NET Core. Supported versions are available on Windows, macOS,
and Linux.

Beginning in PowerShell 6, the PowerShell binary was renamed `pwsh.exe` for Windows and `pwsh` for
macOS and Linux. You can start PowerShell preview versions using `pwsh-preview`. For more
information, see [About pwsh][04].

To find cmdlet reference and installation documentation for PowerShell 7, use the following links:

|       Document       |                  Link                  |
| -------------------- | -------------------------------------- |
| Cmdlet reference     | [PowerShell Module Browser][02]        |
| Windows installation | [Installing PowerShell on Windows][07] |
| macOS installation   | [Installing PowerShell on macOS][06]   |
| Linux installation   | [Installing PowerShell on Linux][05]   |

To view content for other PowerShell versions, see [How to use the PowerShell documentation][01].

### From the Start Menu

- Open the **Start** menu, type **Windows PowerShell**, select **Windows PowerShell**, then select
  **Open**.

### At the Command Prompt

In Windows Command shell, Windows PowerShell, or Windows PowerShell ISE, to start Windows
PowerShell, type: `PowerShell`.

You can also use the parameters of the `powershell.exe` program to customize the session. For more
information, see [PowerShell.exe Command-Line Help][03].

### With Administrative privileges (Run as administrator)

Open the **Start** menu, type **Windows PowerShell**, select **Windows PowerShell**, and then
select **Run as administrator**.

## How to Start Windows PowerShell ISE on Earlier Releases of Windows

Use any of the following methods to start Windows PowerShell ISE.

### From the Start Menu

- Open the **Start** menu, type **ISE**, select **Windows PowerShell ISE**, then select **Open**.

### At the Command Prompt

In Windows Command shell, Windows PowerShell, or Windows PowerShell ISE, to start Windows
PowerShell, type: `PowerShell_ISE`. In Windows PowerShell, you can use the alias `ise`.

### With Administrative privileges (Run as administrator)

Click **Start**, type **ISE**, right-click **Windows PowerShell ISE**, and then click **Run as
administrator**.

## Starting the 32-Bit Version of Windows PowerShell

When using a 64-bit computer, **Windows PowerShell (x86)**, a 32-bit version of Windows PowerShell
is installed in addition to the 64-bit version. When you run Windows PowerShell, the 64-bit version
runs by default.

However, you might occasionally need to run **Windows PowerShell (x86)**, such as when you're using
a module that requires the 32-bit version or when you're connecting remotely to a 32-bit computer.

To start a 32-bit version of Windows PowerShell, use any of the following procedures.

- Click **Start**, type **Windows PowerShell**, select **Windows PowerShell (x86)**, then select
  **Open**.

<!-- link references -->
[01]: ../how-to-use-docs.md
[02]: /powershell/module/
[03]: /powershell/module/Microsoft.PowerShell.Core/About/about_PowerShell_exe
[04]: /powershell/module/microsoft.powershell.core/about/about_pwsh
[05]: /powershell/scripting/install/installing-powershell-on-linux
[06]: /powershell/scripting/install/installing-powershell-on-macos
[07]: /powershell/scripting/install/installing-powershell-on-windows
