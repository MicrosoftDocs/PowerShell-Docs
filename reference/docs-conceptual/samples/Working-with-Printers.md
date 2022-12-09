---
description: This articles shows how to manage printers in Windows using WMI objects and COM interfaces.
ms.date: 12/08/2022
title: Working with printers
---
# Working with printers in Windows

> This sample only applies to Windows platforms.

You can use PowerShell to manage printers using WMI and the **WScript.Network** COM object from WSH.

## Listing printer connections

The simplest way to list the printers installed on a computer is to use the WMI **Win32_Printer**
class:

```powershell
Get-CimInstance -Class Win32_Printer
```

You can also list the printers using the **WScript.Network** COM object that's typically used in WSH
scripts:

```powershell
(New-Object -ComObject WScript.Network).EnumPrinterConnections()
```

Because this command returns a simple string collection of port names and printer device names
without any distinguishing labels, it isn't easy to interpret.

## Adding a network printer

To add a new network printer, use **WScript.Network**:

```powershell
(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection("\\Printserver01\Xerox5")
```

## Setting a default printer

To use WMI to set the default printer, find the printer in the **Win32_Printer** collection and then
invoke the **SetDefaultPrinter** method:

```powershell
$printer = Get-CimInstance -Class Win32_Printer -Filter "Name='HP LaserJet 5Si'"
Invoke-CimMethod -InputObject $printer -MethodName SetDefaultPrinter
```

**WScript.Network** is a little simpler to use, because it has a **SetDefaultPrinter** method that
takes only the printer name as an argument:

```powershell
(New-Object -ComObject WScript.Network).SetDefaultPrinter('HP LaserJet 5Si')
```

## Removing a printer connection

To remove a printer connection, use the **WScript.Network RemovePrinterConnection** method:

```powershell
(New-Object -ComObject WScript.Network).RemovePrinterConnection("\\Printserver01\Xerox5")
```
