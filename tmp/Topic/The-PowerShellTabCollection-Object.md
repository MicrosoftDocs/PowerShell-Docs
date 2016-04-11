---
title: The PowerShellTabCollection Object
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 81f4bf4a-83bf-415e-8378-1703792fbb58
---
# The PowerShellTabCollection Object
  The **PowerShellTab** collection object is a collection of **PowerShellTab** objects. Each **PowerShellTab** object functions as a separate runtime environment. It is an instance of Microsoft.PowerShell.Host.ISE.PowerShellTabs class. An example is the **$psISE.PowerShellTabs** object.

## Methods

### Add\(\)
 [!INCLUDE[support_ise_2up](../Token/support_ise_2up_md.md)]

 Adds a new PowerShell tab to the collection. It returns the newly added tab.

```
$NewTab=$psISE.PowerShellTabs.Add()
$newTab.DisplayName="Brand New Tab"
```

### Remove\(Microsoft.PowerShell.Host.ISE.PowerShellTab psTab\)
 [!INCLUDE[support_ise_2up](../Token/support_ise_2up_md.md)]

 Removes the tab that is specified by the **psTab** parameter.

 **psTab**
 The PowerShell tab to remove.

```

$newTab = $psISE.PowerShellTabs.Add()
Change the DisplayName of the new PowerShell tab. 
$newTab.DisplayName="This tab will go away in 5 seconds" 
sleep 5 
$psISE.PowerShellTabs.Remove($newTab)
```

### SetSelectedPowerShellTab\(Microsoft.PowerShell.Host.ISE.PowerShellTab psTab\)
 [!INCLUDE[support_ise_2up](../Token/support_ise_2up_md.md)]

 Selects the PowerShell tab that is specified by the **psTab** parameter to make it the currently active PowerShell tab.

 **psTab**
 The PowerShell tab to select.

```
# Save the current tab in a variable and rename it
$OldTab = $psISE.CurrentPowerShellTab
$psISE.CurrentPowerShellTab.DisplayName="Old Tab"
# Create a new tab and give it a new display name
$newTab = $psISE.PowerShellTabs.Add()
$newTab.DisplayName="Brand New Tab" 
# Switch back to the original tab
$psISE.PowerShellTabs.SelectedPowerShellTab=$oldtab
```

## See Also
 [The PowerShellTab Object](../Topic/The-PowerShellTab-Object.md) 
 [The Windows PowerShell ISE Scripting Object Model](../Topic/The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
 [Windows PowerShell ISE Object Model Reference](../Topic/Windows-PowerShell-ISE-Object-Model-Reference.md) 
 [The ISE Object Model Hierarchy](../Topic/The-ISE-Object-Model-Hierarchy.md)

  