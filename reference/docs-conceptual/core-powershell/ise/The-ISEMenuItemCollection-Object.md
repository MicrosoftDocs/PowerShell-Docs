---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  The ISEMenuItemCollection Object
ms.assetid:  0c0f5484-3320-408e-8534-5bd1c8e48512
---
# The ISEMenuItemCollection Object

An **ISEMenuItemCollection** object is a collection of **ISEMenuItem** objects. It is an instance of the Microsoft.PowerShell.Host.ISE.ISEMenuItemCollection class. An example is the **$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus** object that is used to customize the **Add-On** menu in Windows PowerShell® Integrated Scripting Environment (ISE).

## Method

### Add\(string DisplayName, System.Management.Automation.ScriptBlock Action, System.Windows.Input.KeyGesture Shortcut \)

Supported in Windows PowerShell ISE 2.0 and later.

Adds a menu item to the collection.

**DisplayName**
The display name of the menu to be added.

**Action**
The **System.Management.Automation.ScriptBlock** object that specifies the action that is associated with this menu item.

**Shortcut**
The keyboard shortcut for the action.

**Returns**
The ISEMenuItem object that was just added.

```powershell
# Create an Add-ons menu with an fast access key and a shortcut.
# Note the use of "_"  as opposed to the "&" for mapping to the fast access key letter for the menu item.
$menuAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('_Process', {Get-Process}, 'Alt+P')
```

### Clear\(\)

Supported in Windows PowerShell ISE 2.0 and later.

Removes all submenus from the menu item.

```powershell
# Remove all custom submenu items from the AddOns menu
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Clear()
```

## See Also

- [The ISEMenuItem Object](The-ISEMenuItem-Object.md)
- [Purpose of the Windows PowerShell ISE Scripting Object Model](Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)