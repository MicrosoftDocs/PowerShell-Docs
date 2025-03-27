---
description: An ISEMenuItemCollection object is a collection of ISEMenuItem objects.
ms.date: 03/27/2025
title: The ISEMenuItemCollection Object
---

# The ISEMenuItemCollection Object

An **ISEMenuItemCollection** object is a collection of **ISEMenuItem** objects. It's an instance of
the **Microsoft.PowerShell.Host.ISE.ISEMenuItemCollection** class. An example is the
`$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus` object that's used to customize the **Add-On**
menu in Windows PowerShell&reg; Integrated Scripting Environment (ISE).

## Method

### `Add(DisplayName, Action, Shortcut )`

Supported in Windows PowerShell ISE 2.0 and later.

Adds a menu item to the collection.

- **DisplayName** - String - The display name of the menu to be added.
- **Action** - System.Management.Automation.ScriptBlock - The object that specifies the action
  that's associated with this menu item.
- **Shortcut** - System.Windows.Input.KeyGesture - The keyboard shortcut for the action.
- **Returns** - The **ISEMenuItem** object that was just added.

```powershell
# Create an Add-ons menu with a fast access key and a shortcut.
# Note the use of "_"  as opposed to the "&" for mapping to the fast access key
# letter for the menu item.
$menuAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('_Process',
    {Get-Process}, 'Alt+P')
```

### `Clear()`

Supported in Windows PowerShell ISE 2.0 and later.

Removes all submenus from the menu item.

```powershell
# Remove all custom submenu items from the AddOns menu
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Clear()
```

## See Also

- [The ISEMenuItem Object][03]
- [Purpose of the Windows PowerShell ISE Scripting Object Model][01]
- [The ISE Object Model Hierarchy][02]

<!-- link references -->
[01]: Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md
[02]: The-ISE-Object-Model-Hierarchy.md
[03]: The-ISEMenuItem-Object.md
