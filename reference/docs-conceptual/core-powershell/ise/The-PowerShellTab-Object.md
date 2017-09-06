---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  The PowerShellTab Object
ms.assetid:  a9b58556-951b-4f48-b3ae-b351b7564360
---

# The PowerShellTab Object
  The **PowerShellTab** object represents a Windows PowerShell runtime environment.

## Methods

### Invoke\( Script \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Runs the given script in the PowerShell tab.

> [!NOTE]
> This method only works on other PowerShell tabs, not the PowerShell tab from which it is run. It does not return any object or value. If the code modifies any variable, then those changes persist on the tab against which the command was invoked.

 **Script** - System.Management.Automation.ScriptBlock or String
 The script block to run.

```
# Manually create a second PowerShell tab before running this script.
# Return to the first PowerShell tab and type the following command
$psise.PowerShellTabs[1].Invoke({dir})
```

### InvokeSynchronous\( Script, \[useNewScope\], millisecondsTimeout \)
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 Runs the given script in the PowerShell tab.

> [!NOTE]
> This method only works on other PowerShell tabs, not the PowerShell tab from which it is run. The script block is run and any value that is returned from the script is returned to the run environment from which you invoked the command. If the command takes longer to run than the **millesecondsTimeout** value specifies, then the command fails with an exception: "The operation has timed out."

 **Script** - System.Management.Automation.ScriptBlock or String
 The script block to run.

 **\[useNewScope\]** -  Optional Boolean that defaults to **$true**
 If set to **$true**, then a new scope is created within which to run the command. It does not modify the runtime environment of the PowerShell tab that is specified by the command.

 **\[millisecondsTimeout\]** -  Optional integer that defaults to **500**.
 If the command does not finish within the specified time, then the command generates a **TimeoutException** with the message "The operation has timed out."

```
# create a new PowerShell tab and then switch back to the first
$PSise.PowerShellTabs.Add()
$psISE.PowerShellTabs.SetSelectedPowerShellTab($psISE.PowerShellTabs[0]) 

# Invoke a simple command on the other tab, in its own scope
$psISE.PowerShellTabs[1].InvokeSynchronous('$x=1',$false)
# You can switch to the other tab and type 'œ$x' to see that the value is saved there.

# This example sets a value in the other tab (in a different scope) 
# and returns it through the pipeline to this tab to store in $a
$a=$psISE.PowerShellTabs[1].InvokeSynchronous('$z=3;$z') 
$a

# This example runs a command that takes longer than the allowed timeout value
# and measures how long it runs so that you can see the impact
measure-command {$psISE.PowerShellTabs[1].InvokeSynchronous("sleep 10",$false,5000)}

```

## Properties

### AddOnsMenu
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the Add-ons menu for the PowerShell tab.

```
# Clear the Add-ons menu if one exists.
$psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Clear()
# Create an AddOns menu with an accessor.
# Note the use of "_"  as opposed to the "&" for mapping to the fast key letter for the menu item.
$menuAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Process",{get-process},"Alt+P") 
# Add a nested menu. 
$parentAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("Parent",$null,$null) 
$parentAdded.SubMenus.Add("_Dir",{dir},"Alt+D")
# Show the Add-ons menu on the current PowerShell tab.
$psISE.CurrentPowerShellTab.AddOnsMenu
```

### CanInvoke
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only Boolean property that returns a **$true** value if a script can be invoked with the [Invoke( Script )](#invoke-script-) method.

```
# CanInvoke will be false if the PowerShell
# tab is running a script that takes a while, and you
# check its properties from another PowerShell tab. It is
# always false if checked on the current PowerShell tab. 
# Manually create a second PowerShell tab before running this script.
# Return to the first tab and type
$secondTab = $psise.PowerShellTabs[1] 
$secondTab.CanInvoke 
$secondTab.Invoke({sleep 20})
$secondTab.CanInvoke

```

### Consolepane
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.  In Windows PowerShell ISE 2.0 this was named **CommandPane**.

 The read-only property that gets the Console pane [editor](../ise/The-ISEEditor-Object.md) object.

```
# Gets the Console Pane editor.
$psISE.CurrentPowerShellTab.ConsolePane

```

### DisplayName
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-write property that gets or sets the text that is displayed on the PowerShell tab. By default, tabs are named "PowerShell #", where the # represents a number.

```
$newTab = $psise.PowerShellTabs.Add()
# Change the DisplayName of the new PowerShell tab. 
$newTab.DisplayName="Brand New Tab"
```

### ExpandedScript
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-write Boolean property that determines whether the Script pane is expanded or hidden.

```
# Toggle the expanded script property to see its effect.
$PSise.CurrentPowerShellTab.ExpandedScript=!$PSise.CurrentPowerShellTab.ExpandedScript

```

### Files
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the [collection of script files](../ise/The-ISEFileCollection-Object.md) that are open in the PowerShell tab.

```
$newFile = $psISE.CurrentPowerShellTab.Files.Add()
$newFile.Editor.Text = "a`r`nb" 
# Gets the line count
$newFile.Editor.LineCount
```

### Output
  This feature is present in Windows PowerShell ISE 2.0, but was removed or renamed in later versions of the ISE.  In later versions of Windows PowerShell ISE, you can use the **ConsolePane** object for the same purposes.

 The read-only property that gets the Output pane of the current [editor](../ise/The-ISEEditor-Object.md).

```
# Clears the text in the Output pane.
$psise.CurrentPowerShellTab.output.clear()
```

### Prompt
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the current prompt text. Note: the **Prompt** function can be overridden by the user'™s profile. If the result is other than a simple string, then this property returns nothing.

```
# Gets the current prompt text.
$psISE.CurrentPowerShellTab.Prompt
```

### ShowCommands
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 The read-write property that indicates if the Commands pane is currently displayed.

```
# Gets the current status of the Commands pane and stores it in the $a variable
$a = $psISE.CurrentPowerShellTab.ShowCommands
# if $a is $false, then turn the Commands pane on by changing the value to $True
if (!$a) {$psISE.CurrentPowerShellTab.ShowCommands=$True}
```

### StatusText
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the **PowerShellTab** status text.

```
# Gets the current status text,
$psISE.CurrentPowerShellTab.StatusText
```

### HorizontalAddOnToolsPaneOpened
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 The read-only property that indicates whether the horizontal Add-Ons tool pane is currently open.

```
# Gets the current state of the horizontal Add-ons tool pane. 
$psISE.CurrentPowerShellTab.HorizontalAddOnToolsPaneOpened
```

### VerticalAddOnToolsPaneOpened
  Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions. 

 The read-only property that indicates whether the vertical Add-Ons tool pane is currently open.

```
# Turns on the Commands pane
$psISE.CurrentPowerShellTab.ShowCommands=$True
# Gets the current state of the vertical Add-ons tool pane. 
$psISE.CurrentPowerShellTab.HorizontalAddOnToolsPaneOpened
```

## See Also
- [The PowerShellTabCollection Object](The-PowerShellTabCollection-Object.md) 
- [The Windows PowerShell ISE Scripting Object Model](../ise/The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
- [Windows PowerShell ISE Object Model Reference](../ise/Windows-PowerShell-ISE-Object-Model-Reference.md) 
- [The ISE Object Model Hierarchy](../ise/The-ISE-Object-Model-Hierarchy.md)

  
