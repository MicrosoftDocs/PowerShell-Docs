---
description: This article explains how to install Windows PowerShell on various versions of Windows.
ms.date: 10/25/2022
title: Installing Windows PowerShell
---
# Installing Windows PowerShell

Windows PowerShell comes installed by default in every Windows, starting with Windows 7 SP1 and
Windows Server 2008 R2 SP1.

If you are interested in PowerShell 7 and later, you need to install PowerShell instead of Windows
PowerShell. For more information, see
[Installing PowerShell on Windows][01].

## Finding PowerShell in Windows 11, 10, 8.1, 8.0, and 7

Sometimes locating PowerShell console or the Integrated Scripting Environment (ISE) in Windows can
be difficult, as its location moves from one version of Windows to the next.

The following tables should help you find PowerShell in your Windows version. All versions listed
here are the original version, as released, with no updates.

### For Console

- For Windows 10 and 11 - Click Windows icon (lower left corner for Windows 10, lower center for
  Windows 11), start typing PowerShell.
- For Windows 8.1 - On the start screen, start typing PowerShell. If on desktop, click left lower
  corner Windows icon, start typing PowerShell.

### For ISE

- For Windows 10 and 11 - Click Windows icon (lower left corner for Windows 10, lower center for
  Windows 11), start typing ISE.
- For Windows 8.1 - On the start screen, type **PowerShell ISE**. If on desktop, click left lower
  corner Windows icon, type **PowerShell ISE**.

## Finding PowerShell in Windows Server versions

Starting with Windows Server 2008 R2, Windows operating system can be installed without the
graphical user interface (GUI). Editions of Windows Server without GUI are named **Core** editions,
and editions with the GUI are named **Desktop**.

### Windows Server Core editions

In all Core editions, when you log to the server you get a Windows command prompt window.

Type `powershell` and press <kbd>ENTER</kbd> to start PowerShell inside the command prompt session.
Type `exit` to close the PowerShell session and return to command prompt.

### Windows Server Desktop editions

In all desktop editions, click the left lower corner Windows icon, start typing PowerShell. You get
both console and ISE options.

The only exception to the above rule is the ISE in Windows Server 2008 R2 SP1. In this case, click
the left lower corner Windows icon, type PowerShell ISE.

## How to check the version of PowerShell

To find which version of PowerShell you have installed, start a PowerShell console (or the ISE) and
type `$PSVersionTable` and press <kbd>ENTER</kbd>. Look for the `PSVersion` value.

## Upgrading existing Windows PowerShell

The installation package for PowerShell comes inside a WMF installer. The version of the WMF
installer matches the version of PowerShell. There's no stand alone installer for Windows
PowerShell.

If you need to update your existing version of PowerShell, in Windows, use the following table to
locate the installer for the version of PowerShell you want to update to.

|                    Windows                     |    PS 3.0     |    PS 4.0     |    PS 5.0     |    PS 5.1     |
| ---------------------------------------------- | :-----------: | :-----------: | :-----------: | :-----------: |
| Windows 11 <br/>Windows Server 2022            |       -       |       -       |       -       |   installed   |
| Windows 10 (see Note1)<br/>Windows Server 2016 |       -       |       -       |       -       |   installed   |
| Windows 8.1<br/>Windows Server 2012 R2         |       -       |   installed   | not supported | [WMF 5.1][08] |
| Windows 8<br/>Windows Server 2012              |   installed   | not supported | not supported | [WMF 5.1][08] |
| Windows 7 SP1<br/>Windows Server 2008 R2 SP1   | not supported | not supported | not supported | [WMF 5.1][08] |

> [!NOTE]
> On the initial release of Windows 10, with automatic updates enabled, PowerShell gets updated from
> version 5.0 to 5.1. If the original version of Windows 10 is not updated through Windows Updates,
> the version of PowerShell is 5.0.

## Need Azure PowerShell

If you're looking for **Azure PowerShell**, you could start with
[Overview of Azure PowerShell][04].

## See Also

- [Windows PowerShell System Requirements][09]
- [Starting Windows PowerShell][02]

<!-- link refs -->
[01]: ../../install/Installing-PowerShell-on-Windows.md
[02]: ../Starting-Windows-PowerShell.md
[04]: /powershell/azure/overview
[08]: https://www.microsoft.com/download/details.aspx?id=54616
[09]: Windows-PowerShell-System-Requirements.md
