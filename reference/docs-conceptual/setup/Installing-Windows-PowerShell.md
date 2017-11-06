---
ms.date:  2017-08-09
keywords:  powershell,cmdlet,download,install,setup,windows 10, windows 8.1, windows 8.0,windows 7
title:  Installing Windows PowerShell
---

# Installing Windows PowerShell

PowerShell comes installed by default in every Windows,
starting with Windows 7 SP1 and Windows Server 2008 R2 SP1.

Linux, macOS, and Windows users that would like to install **PowerShell 6** (beta),
in their machines, need to:

1. Get PowerShell for the specific OS and version, from [GitHub](https://github.com/powershell/powershell#get-powershell)
1. Follow the installation instructions
  - [Linux](https://github.com/PowerShell/PowerShell/blob/master/docs/installation/linux.md)
  - [macOS](https://github.com/PowerShell/PowerShell/blob/master/docs/installation/linux.md#macos-1012)
  - [Windows](https://github.com/PowerShell/PowerShell/blob/master/docs/installation/windows.md#msi)

PowerShell 6 is also available for Docker;
see [Docker installation](https://github.com/PowerShell/PowerShell/tree/master/docker) instructions.

## Finding PowerShell in Windows 10, 8.1, 8.0, and 7

Sometimes locating PowerShell console or ISE (Integrated Scripting
Environment) in Windows can be difficult,
as it's location moves from one version of Windows to the next.

The following tables should help you find PowerShell in your Windows version.
All versions listed here are the original version, as released,
with no updates.

### For Console

Version | Location
-- | --
Windows 10 | Click left lower corner Windows icon, start typing PowerShell
Windows 8.1, 8.0 | On the start screen, start typing PowerShell.<br/>If on desktop, click left lower corner Windows icon, start typing PowerShell
Windows 7 SP1 | Click left lower corner Windows icon, on the search box start typing PowerShell

### For ISE

Version | Location
-- | --
Windows 10 | Click left lower corner Windows icon, start typing ISE
Windows 8.1, 8.0 | On the start screen, type **PowerShell ISE**.<br/>If on desktop, click left lower corner Windows icon, type **PowerShell ISE**
Windows 7 SP1 | Click left lower corner Windows icon, on the search box start typing PowerShell

## Finding PowerShell in Windows Server versions

Starting with Windows Server 2008 R2, 
Windows operating system can be installed 
without the graphical user interface (GUI).
Editions of Windows Server without GUI are named **Core** editions, 
and editions with the GUI are named **Desktop**.

### Windows Server Core editions

In all Core editions,
when you log to the server you get a Windows command prompt window.

Type `powershell` and press **ENTER** to start PowerShell
inside the command prompt session. 
Type `exit` to terminate the PowerShell session and return to command prompt.

### Windows Server Desktop editions

In all desktop editions,
click the left lower corner Windows icon, start typing PowerShell.
You get both console and ISE options.

The only exception to the above rule is the ISE 
in Windows Server 2008 R2 SP1;
in this case, click the left lower corner Windows icon, 
type PowerShell ISE.

## How to check the version of PowerShell

To find which version of PowerShell you have installed,
start a PowerShell console (or the ISE) and type `$PSVersionTable`
and press **ENTER**.

## Upgrading existing Windows PowerShell

The installation package for PowerShell comes inside a WMF installer.
The version of the WMF installer matches the version of PowerShell;
there's no stand alone installer for Windows PowerShell.

If you need to update your existing version of PowerShell,
in Windows, use the following table to locate the installer for the version
of PowerShell you want to update to.

Windows | PS 3.0 | PS 4.0 | PS 5.0 | PS 5.1 |
--|--|--|--|--|
Windows 10 (see Note1)<br/>Windows Server 2016 | - | - | - | installed
Windows 8.1<br/>Windows Server 2012 R2 | - | installed | [WMF 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) | [WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616)
Windows 8<br/>Windows Server 2012 | installed | [WMF 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=40855) | [WMF 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) | [WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616)
Windows 7 SP1<br/>Windows Server 2008 R2 SP1 | [WMF 3.0](https://www.microsoft.com/en-us/download/details.aspx?id=34595) | [WMF 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=40855) | [WMF 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=50395) | [WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616)

> **Note 1**:
  >>
  >> On the initial release of Windows 10, with automatic updates enabled, PowerShell gets updated from version 5.0 to 5.1.
  >>
  >> If the original version of Windows 10 is not updated through Windows Updates, the version of PowerShell is 5.0.

## Need Azure PowerShell

If you're looking for **Azure PowerShell**,
you could start with [Overview of Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure).

Otherwise, what you might need is
[Install and configure Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps)

## See Also

- [Windows PowerShell System Requirements](Windows-PowerShell-System-Requirements.md)
- [Starting Windows PowerShell](Starting-Windows-PowerShell.md)
