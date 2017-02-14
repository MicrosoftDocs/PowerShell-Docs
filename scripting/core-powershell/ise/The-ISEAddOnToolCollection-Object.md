---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  The ISEAddOnToolCollection Object
ms.technology:  powershell
ms.assetid:    634eab89-0845-4016-974b-361b09bb8f7b
---


# The ISEAddOnToolCollection Object
  The **ISEAddOnToolCollection** object is a collection of **ISEAddOnTool** objects. An example is the **$psISE.CurrentPowerShellTab.VerticalAddOnTools** object.

## Methods

### Add\( Name, ControlType, \[IsVisible\] \)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Adds a new add-on tool to the collection. It returns the newly added add-on tool. Before you run this command, you must install the add-on tool on the local computer and load the assembly.

 **Name** - String
 Specifies the display name of the add-on tool that is added to Windows PowerShell ISE.

 **ControlType** -Type
 Specifies the control that is added.

 **\[IsVisible\]** - optional Boolean
 If set to **$true**, the add-on tool is immediately visible in the associated tool pane.

```PowerShell
# Load a DLL with an add-on and then add it to the ISE
[reflection.assembly]::LoadFile("c:\test\ISESimpleSolution\ISESimpleSolution.dll")
$psISE.CurrentPowerShellTab.VerticalAddOnTools.Add("Solutions", [ISESimpleSolution.Solution], $true)
```

### Remove\( Item \)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Removes the specified add-on tool from the collection.

 **Item** - Microsoft.PowerShell.Host.ISE.ISEAddOnTool
 Specifies the object to be removed from Windows PowerShell ISE.

```PowerShell
# Load a DLL with an add-on and then add it to the ISE
[reflection.assembly]::LoadFile("c:\test\ISESimpleSolution\ISESimpleSolution.dll")
$psISE.CurrentPowerShellTab.VerticalAddOnTools.Add("Solutions", [ISESimpleSolution.Solution], $true)
```

### SetSelectedPowerShellTab\( psTab \)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Selects the PowerShell tab that the **psTab** parameter specifies.

 **psTab** - Microsoft.PowerShell.Host.ISE.PowerShellTab
 The PowerShell tab to select.

```PowerShell
      $newTab = $psISE.PowerShellTabs.Add()
# Change the DisplayName of the new PowerShell tab. 
$newTab.DisplayName="Brand New Tab"
```

### Remove\( psTab \)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Removes the PowerShell tab that the **psTab** parameter specifies.

 **psTab** - Microsoft.PowerShell.Host.ISE.PowerShellTab
 The PowerShell tab to remove.

```PowerShell
$newTab = $psISE.PowerShellTabs.Add()
Change the DisplayName of the new PowerShell tab. 
$newTab.DisplayName="This tab will go away in 5 seconds" 
sleep 5 
$psISE.PowerShellTabs.Remove($newTab)
```

## See Also
- [The PowerShellTab Object](The-PowerShellTab-Object.md) 
- [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
- [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md) 
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)

  
