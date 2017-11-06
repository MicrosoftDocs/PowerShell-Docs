---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  The ISE Object Model Hierarchy
---

# The ISE Object Model Hierarchy
This topic shows the hierarchy of objects that are part of 
Windows PowerShell Integrated Scripting Environment (ISE). 
Windows PowerShell ISE is included in Windows PowerShell 3.0 
and in Windows PowerShell 4.0. 
Click an object to take you to the reference documentation 
for the class that defines the object.

## $psISE Object

The **$psISE** object is the [root object](The-ObjectModelRoot-Object.md)
of the Windows PowerShell ISE object hierarchy.
Located at the top level, it makes the following objects available for scripting:

## [$psISE.CurrentFile](The-ISEFile-Object.md)

The **$psISE.CurrentFile** object is an instance of the
[ISEFile](The-ISEFile-Object.md) class.

## [$psISE.CurrentPowerShellTab](The-PowerShellTab-Object.md)

The **$psISE.CurrentPowerShellTab** object is an instance of the
[PowerShellTab](The-PowerShellTab-Object.md) class.

## $psISE.CurrentVisibleHorizontalTool

The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the
[ISEAddOnTool](The-ISEAddOnTool-Object.md) class.
It represents the installed add-on tool that is currently docked to the top
edge of the Windows PowerShell ISE window.

## $psISE.CurrentVisibleVerticalTool

The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the
[ISEAddOnTool](The-ISEAddOnTool-Object.md) class.
It represents the installed add-on tool that is currently docked to the 
right-hand edge of the Windows PowerShell ISE window.

## [$psISE.Options](The-ISEOptions-Object.md)

The **$psISE.Options** object is an instance of the
[ISEOptions](The-ISEOptions-Object.md) class.
The ISEOptions object represents various settings for Windows PowerShell
ISE.
It is an instance of the Microsoft.PowerShell.Host.ISE.ISEOptions class.

## [$psISE.PowerShellTabs](The-PowerShellTabCollection-Object.md)

The **$psISE.PowerShellTabs** object is an instance of the
[PowerShellTabCollection](The-PowerShellTabCollection-Object.md) class.
It is a collection of all the currently open PowerShell tabs that represent
the available Windows PowerShell run environments on the local computer 
or on connected remote computers. 
Each member in the collection is an instance of the
[PowerShellTab](The-PowerShellTab-Object.md) class.

## See Also
- [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md)
