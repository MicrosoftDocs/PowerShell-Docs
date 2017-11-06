---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Function Provider
---


# *Function* provider


## Provider name

 Function  


## Drives

 `Function:`  


## Short description

 Provides access to the functions defined in Windows PowerShell.  


## Detailed description

 The Windows PowerShell **Function** provider lets you get, add, change, clear, and delete the functions and filters in Windows PowerShell.  

 A function is a named block of code that performs an action. When you type the function name, the code in the function runs. A filter is a named block of code that establishes conditions for an action. You can type the name of the filter in place of the condition, such as in a [Where-Object](../Where-Object.md) command.  

 In the `Function:` drive, functions are preceded by the label "Function" and filters are preceded by the label "Filter", but they operate properly when used in the correct context regardless of the label.  

 The **Function** provider is a flat namespace that contains only the function and filter objects. Neither functions nor filters have child items.  

 Each function is an instance of the [System.Management.Automation.FunctionInfo](https://msdn.microsoft.com/library/system.management.automation.functioninfo) class. Each filter is an instance of the [System.Management.Automation.FilterInfo](https://msdn.microsoft.com/library/system.management.automation.filterinfo) class.  

 The examples in this section show how to manage functions, but the same methods can be used with filters.  

 The **Function** provider exposes its data store in the `Function:` drive. To work with functions, you can change your location to the `Function:` drive (`set-location Function:`). Or, you can work from another Windows PowerShell drive. To reference a function from another location, use the drive name (`Function:`) in the path.  

 The **Function** provider supports all of the cmdlets whose names contain the *Item* noun (the `*-Item` cmdlets), except for [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md). And, it supports the [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) and [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md) cmdlets. However, it does not support the cmdlets whose names contain the *ItemProperty* noun (the `*-ItemProperty` cmdlets), and it does not support the `-Filter` parameter in any cmdlet.  

 All changes to the functions affect the current console only. To save the changes, add the function to the Windows PowerShell profile, or use [Export-Console](../Export-Console.md) to save the current console.  


## Capabilities

 ShouldProcess  


## Examples


### Getting to the `Function:` drive


#### Example 1

 Changes the current location to the `Function:` drive. You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type `set-location c:`.  

```powershell
Set-Location Function:
```


### Getting functions


#### Example 1

 This command gets the list of all the functions in the current session. You can use this command from any Windows PowerShell drive.  

```powershell
Get-ChildItem -Path Function:
```


#### Example 2

 This command gets the `man` function from the `Function:` drive. It uses the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet to get the function. The pipeline operator (`|`) sends the result to [Format-Table](../../Microsoft.PowerShell.Utility/Format-Table.md).  

 The `-Wrap` parameter directs text that does not fit on the line onto the next line. The `-Autosize` parameter resizes the table columns to accommodate the text.  

```powershell
Get-Item -Path man | Format-Table -Wrap -Autosize
```

 If you are in a different drive, add the drive name (`Function:`) to the path.  


#### Example 3

 These commands both get the function named `c:`. The first command can be used in any drive. The second command is used in the `Function:` drive.  

 Because the name ends in a colon, which is the syntax for a drive, you must qualify the path with the drive name. Within the `Function:` drive, you can use either format. In the second command, the dot (`.`) represents the current location.  

```
c:\PS> Get-Item -Path Function:c:
PS Function> Get-Item -Path .\c:  
```


### Creating a function


#### Example 1

 This command uses the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create a function called `HKLM:`. The expression in braces is the script block that is represented by the function name.  

```powershell
New-Item -Path Function:HKLM: -Value {Set-Location HKLM:}
```

 You can also create a function by typing it at the Windows PowerShell command line. For example, tpe `Function:HKLM: {set-location HKLM:}`. If you are in the `Function:` drive, you can omit the drive name.  
Because you cannot specify the "Filter" label in [New-Item](../../Microsoft.PowerShell.Management/New-Item.md), filters are labeled as functions, but they operate properly with any label. To create a filter with the "Filter" label, type the filter at the command line. For example, type `filter:Running {$_.Status -eq "Running"}`.  


#### Example 2

 This command uses the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create a function called `Csrss`. It uses the `-Options` dynamic parameter to specify a value of `ReadOnly` for the **Options** property of the function.  

```powershell
New-Item -Path Function: -Name csrss -Options readonly -Value {Get-Process csrss}
```

 This command works from any location. If you are in the `Function:` drive, you can use a dot (`.`) to specify the path. The dot represents the current location.  


### Deleting a function


#### Example 1

 This command deletes the `HKLM:` function from the current session.  

```powershell
Remove-Item Function:HKLM:
```


#### Example 2

 This command deletes all the functions from the current session except for the functions whose **Options** property has a value of `Constant`. Without the `-Force` parameter, the command does not delete functions whose **Options** property has a value of `ReadOnly`.  

```powershell
Remove-Item Function:* -Force
```

 When you delete all the functions, the command prompt changes because the prompt function, which defines the content of the command prompt, is deleted.  


### Displaying the properties and methods of functions


#### Example 1

 This command uses the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet to get all the functions. The pipeline operator sends the results to the [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) cmdlet, which displays the methods and the properties of the object.  

```powershell
Get-Item -Path Function:* | Get-Member
```

 When you pipe a collection of objects (such as the collection of functions in the `Function:` drive) to [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md), [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) evaluates each object in the collection separately and returns information about each object type that it finds. If all of the objects are of the same type, it returns information about the single object type. In this case, all of the functions are [FunctionInfo](https://msdn.microsoft.com/library/system.management.automation.functioninfo) objects.  
To get information about the collection of [FunctionInfo](https://msdn.microsoft.com/library/system.management.automation.functioninfo) objects, use the `-InputObject` parameter of [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md). For example, type `Get-Member -InputObject (Get-Item Function:*)`. When you use the `-InputObject` parameter, [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) evaluates the collection, not the objects in the collection.  


#### Example 2

 This command lists the values of the properties of the `prompt` function. It uses the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet to get an object that represents the `prompt` function. The pipeline operator (`|`) sends the results to the [Format-List](../../Microsoft.PowerShell.Utility/Format-List.md) command. The [Format-List](../../Microsoft.PowerShell.Utility/Format-List.md) command uses the `-Property` parameter with a wildcard character (`*`) to format and to display the values of all of the properties of the `prompt` function.  

```powershell
Get-Item Function:prompt | Format-List -Property *
```


### Changing the properties of a function


#### Example 1

 You can use the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet with the `-Options` dynamic parameter to change the value of the **Options** property of a function.  

 This command sets the `AllScope` and `ReadOnly` options for the `prompt` function. This command uses the `-Options` dynamic parameter of the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet. The `-Options` parameter is available in [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) only when you use it with the **Alias** or **Function** provider.  

```powershell
Set-Item -Path Function:prompt -Options "AllScope,ReadOnly"
```


#### Example 2

 This command uses the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet to change the `prompt` function so that it displays the time before the path.  

```powershell
Set-Item -Path Function:prompt -Value {'PS '+ $(Get-Date -Format t) + " " + $(Get-Location) + '> '}
```

 The change affects both the **Definition** and **ScriptBlock** properties of the [FunctionInfo](https://msdn.microsoft.com/library/system.management.automation.functioninfo) object. To see the effect of the change, type `Get-Item -Path Function:prompt | Format-List -Property *`.  


#### Example 3

 This command uses the [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md) cmdlet to change the name of the `help` function to `gh`.  

```powershell
Rename-Item -Path Function:help -NewName gh
```


### Copying a function


#### Example 1

 This command copies the `prompt` function to `oldPrompt`, effectively creating a new name for the script block that is associated with the prompt function. You can use this to save the original prompt function if you plan to change it.  

 The **Options** property of the new function has a value of `None`. To change the value of the **Options** property, use [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md).  

```powershell
Copy-Item -Path Function:prompt -Destination Function:oldPrompt
```


## Dynamic parameters

 Dynamic parameters are cmdlet parameters that are added by a Windows PowerShell provider and are available only when the cmdlet is being used in the provider-enabled drive.  


### `Options` <[System.Management.Automation.ScopedItemOptions](https://msdn.microsoft.com/library/system.management.automation.scopeditemoptions)>

 Determines the value of the **Options** property of a function.  

|Value|Description|  
|-----------|-----------------|  
|`None`|No options. `None` is the default.|  
|`Constant`|The function cannot be deleted, and its properties cannot be changed. `Constant` is available only when you are creating a function. You cannot change the option of an existing function to `Constant`.|  
|`Private`|The function is visible only in the current scope (not in child scopes).|  
|`ReadOnly`|The properties of the function cannot be changed except by using the `-Force` parameter. You can use [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md) to delete the function.|  
|`AllScope`|The function is copied to any new scopes that are created.|  


#### Cmdlets supported:


-   [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)  

-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  


## See also

 [about_Functions](../About/about_Functions.md)   
 [about_Providers](../About/about_Providers.md)

