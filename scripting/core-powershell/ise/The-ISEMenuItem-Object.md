---
title:  The ISEMenuItem Object
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  a16660bd-0aee-46fd-ac17-3f022165d089
---

# The ISEMenuItem Object
  An **ISEMenuItem** object is an instance of the Microsoft.PowerShell.Host.ISE.ISEMenuItem class. All menu objects on the **Add\-ons** menu are instances of the **Microsoft.PowerShell.Host.ISE.ISEMenuItem** class.

## Properties

###  <a name="DisplayName"></a> DisplayName
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the display name of the menu item.

```
# Get the display name of the Add-ons menu item
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Clear()
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Process",{get-process},"Alt+P")
$psISE.CurrentPowerShellTab.AddOnsMenu.DisplayName

```

###  <a name="Action"></a> Action
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the block of script. It invokes the action when you click the menu item.

```
# Get the action associated with the first submenu item.
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Clear()
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Process",{get-process},"Alt+P")
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus[0].Action

# Invoke the script associated with the first submenu item 
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus[0].Action.Invoke()
```

###  <a name="Shortcut"></a> Shortcut
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the Windows input keyboard shortcut for the menu item.

```
# Get the shortcut for the first submenu item.
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Clear()
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Process",{get-process},"Alt+P")
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus[0].Shortcut
```

###  <a name="Submenus"></a> Submenus
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read\-only property that gets the [list of submenus](The-ISEMenuItemCollection-Object.md) of the menu item.

```
# List the submenus of the Add-ons menu
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Clear()
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Process",{get-process},"Alt+P")
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus
```

## Scripting example
 To better understand the use of the Add\-ons menu and its scriptable properties, read through the following scripting example.

```

# This is a scripting example that shows the use of the Add-ons menu.
# Clear the Add-ons menu if any entries currently exist
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Clear()

# Add an Add-ons menu item with an shortcut and fast access key.
# Note the use of “_”  as opposed to the “&” for mapping to the fast access key letter for the menu item.
$menuAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Process",{get-process},"Alt+P") 
# Add a nested menu – a parent and a child submenu item. 
$parentAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("Parent",$null,$null) 
$parentAdded.SubMenus.Add("_Dir",{dir},"Alt+D")

```

## See Also
 [The ISEMenuItemCollection Object](The-ISEMenuItemCollection-Object.md) 
 [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
 [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md) 
 [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)

  
