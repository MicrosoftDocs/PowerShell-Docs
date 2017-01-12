---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Working with Printers
ms.technology:  powershell
ms.assetid:    4f29ead3-f83b-4706-ac3e-f2154ff38dc5
---


# Working with Printers
You can use Windows PowerShell to manage printers by using WMI and the WScript.Network COM object from WSH. We will use a mix of both tools to demonstrate specific tasks.

### Listing Printer Connections
The simplest way to list the printers installed on a computer is to use the WMI **Win32_Printer** class:

```
Get-WmiObject -Class Win32_Printer -ComputerName
```

You can also list the printers by using the **WScript.Network** COM object that is typically used in WSH scripts:

```
(New-Object -ComObject WScript.Network).EnumPrinterConnections()
```

Because this command returns a simple string collection of port names and printer device names without any distinguishing labels, it is not easy to interpret.

### Adding a Network Printer
To add a new network printer, use **WScript.Network**:

```
(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection("\\Printserver01\Xerox5")
```

### Setting a Default Printer
To use WMI to set the default printer, find the printer in the **Win32_Printer** collection and then invoke the **SetDefaultPrinter** method:

```
(Get-WmiObject -ComputerName . -Class Win32_Printer -Filter "Name='HP LaserJet 5Si'").SetDefaultPrinter()
```

**WScript.Network** is a little simpler to use, because it has a **SetDefaultPrinter** method that takes only the printer name as an argument:

```
(New-Object -ComObject WScript.Network).SetDefaultPrinter('HP LaserJet 5Si')
```

### Removing a Printer Connection
To remove a printer connection, use the **WScript.Network RemovePrinterConnection** method:

```
(New-Object -ComObject WScript.Network).RemovePrinterConnection("\\Printserver01\Xerox5")
```

