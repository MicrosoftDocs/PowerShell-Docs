---
ms.date:  08/25/2017
title:  The ObjectModelRoot Object
description: The $psISE object, which is the principal root object in PowerShell ISE is an instance of the Microsoft.PowerShell.Host.ISE.ObjectModelRoot class. This topic describes the properties of the ObjectModelRoot object.
---

# The ObjectModelRoot Object

The `$psISE` object, which is the principal root object in Windows PowerShell&reg; Integrated Scripting
Environment (ISE) is an instance of the Microsoft.PowerShell.Host.ISE.ObjectModelRoot class. This
topic describes the properties of the **ObjectModelRoot** object.

## Properties

### CurrentFile

> Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the file, which is associated with this host object that currently
has the focus.

### CurrentPowerShellTab

> Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the PowerShell tab that has the focus.

### CurrentVisibleHorizontalTool

> Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the currently visible
Windows PowerShell ISE add-on tool that is located in
the horizontal tool pane at the bottom of the editor.

### CurrentVisibleVerticalTool

> Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the currently visible Windows PowerShell ISE add-on tool that is
located in the vertical tool pane on the right side of the editor.

### Options

> Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the various options that can change settings in Windows PowerShell
ISE.

### PowerShellTabs

> Supported in Windows PowerShell ISE 2.0 and later.

The read-only property that gets the collection of the PowerShell tabs, which are open in Windows
PowerShell ISE. By default, this object contains one PowerShell tab. However, you can add more
PowerShell tabs to this object by using scripts or by using the menus in Windows PowerShell ISE.

## See Also

- [Purpose of the Windows PowerShell ISE Scripting Object Model](Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
