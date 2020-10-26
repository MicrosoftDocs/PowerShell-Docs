---
ms.date:  06/05/2017
title:  The PowerShellTabCollection Object
description: The PowerShellTab collection object is a collection of PowerShellTab objects. Each PowerShellTab object functions as a separate runtime environment.
---
# The PowerShellTabCollection Object

The **PowerShellTab** collection object is a collection of **PowerShellTab** objects. Each
**PowerShellTab** object functions as a separate runtime environment. It is an instance of
Microsoft.PowerShell.Host.ISE.PowerShellTabs class. An example is the `$psISE.PowerShellTabs`
object.

## Methods

### Add\(\)

Supported in Windows PowerShell ISE 2.0 and later.

Adds a new PowerShell tab to the collection. It returns the newly added tab.

```powershell
$newTab = $psISE.PowerShellTabs.Add()
$newTab.DisplayName = 'Brand New Tab'
```

### Remove\(Microsoft.PowerShell.Host.ISE.PowerShellTab psTab\)

Supported in Windows PowerShell ISE 2.0 and later.

Removes the tab that is specified by the **psTab** parameter.

**psTab**
The PowerShell tab to remove.

```powershell
$newTab = $psISE.PowerShellTabs.Add()
Change the DisplayName of the new PowerShell tab.
$newTab.DisplayName = 'This tab will go away in 5 seconds'
sleep 5
$psISE.PowerShellTabs.Remove($newTab)
```

### SetSelectedPowerShellTab\(Microsoft.PowerShell.Host.ISE.PowerShellTab psTab\)

Supported in Windows PowerShell ISE 2.0 and later.

Selects the PowerShell tab that is specified by the **psTab** parameter to make it the currently
active PowerShell tab.

**psTab**
The PowerShell tab to select.

```powershell
# Save the current tab in a variable and rename it
$oldTab = $psISE.CurrentPowerShellTab
$psISE.CurrentPowerShellTab.DisplayName = 'Old Tab'
# Create a new tab and give it a new display name
$newTab = $psISE.PowerShellTabs.Add()
$newTab.DisplayName = 'Brand New Tab'
# Switch back to the original tab
$psISE.PowerShellTabs.SelectedPowerShellTab = $oldTab
```

## See Also

- [The PowerShellTab Object](The-PowerShellTab-Object.md)
- [Purpose of the Windows PowerShell ISE Scripting Object Model](Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
