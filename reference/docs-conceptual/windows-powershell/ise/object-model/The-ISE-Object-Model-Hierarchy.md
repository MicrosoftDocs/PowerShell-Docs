---
description: This article shows the hierarchy of objects that are part of Windows PowerShell ISE.
ms.date: 03/27/2025
title: The ISE Object Model Hierarchy
---

# The ISE Object Model Hierarchy

This article shows the hierarchy of objects that are part of Windows PowerShell Integrated Scripting
Environment (ISE). Windows PowerShell ISE is included in Windows PowerShell 3.0, 4.0, and 5.1. Click
an object to take you to the reference documentation for the class that defines the object.

## $psISE Object

The `$psISE` object is the [root object][06] of the Windows PowerShell
ISE object hierarchy. Located at the top level, it makes the following objects available for
scripting:

## [$psISE.CurrentFile][04]

The `$psISE.CurrentFile` object is an instance of the [ISEFile][04] class.

## [$psISE.CurrentPowerShellTab][07]

The `$psISE.CurrentPowerShellTab` object is an instance of the [PowerShellTab][07] class.

## $psISE.CurrentVisibleHorizontalTool

The `$psISE.CurrentVisibleHorizontalTool` object is an instance of the [ISEAddOnTool][03] class. It
represents the installed add-on tool that's currently docked to the top edge of the Windows
PowerShell ISE window.

## $psISE.CurrentVisibleVerticalTool

The `$psISE.CurrentVisibleHorizontalTool` object is an instance of the [ISEAddOnTool][03] class. It
represents the installed add-on tool that's currently docked to the right-hand edge of the Windows
PowerShell ISE window.

## [$psISE.Options][05]

The `$psISE.Options` object is an instance of the [ISEOptions][05] class. The ISEOptions object
represents various settings for Windows PowerShell ISE. It's an instance of the
Microsoft.PowerShell.Host.ISE.ISEOptions class.

## [$psISE.PowerShellTabs][08]

The `$psISE.PowerShellTabs` object is an instance of the [PowerShellTabCollection][08] class. It's a
collection of all the currently open PowerShell tabs that represent the available Windows PowerShell
run environments on the local computer or on connected remote computers. Each member in the
collection is an instance of the [PowerShellTab][07] class.

## See Also

- [Purpose of the Windows PowerShell ISE Scripting Object Model][01]
- [The ISE Object Model Hierarchy][02]

<!-- link references -->
[01]: Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md
[02]: The-ISE-Object-Model-Hierarchy.md
[03]: The-ISEAddOnTool-Object.md
[04]: The-ISEFile-Object.md
[05]: The-ISEOptions-Object.md
[06]: The-ObjectModelRoot-Object.md
[07]: The-PowerShellTab-Object.md
[08]: The-PowerShellTabCollection-Object.md
