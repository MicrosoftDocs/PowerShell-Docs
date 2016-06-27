---
title: Function Provider
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7dfc92f4-9a88-4399-978d-6d5d224b3e76
---
# Function Provider
## PROVIDER NAME  
 Function  
  
## DRIVES  
 Function:  
  
## SHORT DESCRIPTION  
 Provides access to the functions defined in Windows PowerShell.  
  
## DETAILED DESCRIPTION  
 The Windows PowerShell Function provider lets you get, add, change, clear, and delete the functions and filters in Windows PowerShell.  
  
 A function is a named block of code that performs an action. When you type the function name, the code in the function runs. A filter is a named block of code that establishes conditions for an action. You can type the name of the filter in place of the condition, such as in a [Where\-Object](assetId:///f4c69467-d5ce-4da2-87d5-d2ae74be8acb) command.  
  
 In the Function: drive, functions are preceded by the label "Function" and filters are preceded by the label "Filter", but they operate properly when used in the correct context regardless of the label.  
  
 The Function provider is a flat namespace that contains only the function and filter objects. Neither functions nor filters have child items.  
  
 Each function is an instance of the System.Management.Automation.FunctionInfo class. Each filter is an instance of the System.Management.Automation.FilterInfo class.  
  
 The examples in this section show how to manage functions, but the same methods can be used with filters.  
  
 The Function provider exposes its data store in the Function: drive. To work with functions, you can change your location to the Function: drive \("set\-location function:"\). Or, you can work from another Windows PowerShell drive. To reference a function from another location, use the drive name \(Function:\) in the path.  
  
 The Function provider supports all of the cmdlets whose names contain the Item noun \(the Item cmdlets\), except for [Invoke\-Item](assetId:///38a9887b-ce1a-4bde-be4e-98012efae204). And, it supports the [Get\-Content](assetId:///86d8b4af-af2c-4a27-9519-2c9fd420be3d) and [Set\-Content](assetId:///6fff9b86-86df-4440-b7b7-8124b22088fc) cmdlets. However, it does not support the cmdlets whose names contain the ItemProperty noun \(the ItemProperty cmdlets\), and it does not support the Filter parameter in any cmdlet.  
  
 All changes to the functions affect the current console only. To save the changes, add the function to the Windows PowerShell profile, or use [Export\-Console](assetId:///0858eece-ddcb-4525-89d1-4732c5f54c48) to save the current console.  
  
## CAPABILITIES  
 ShouldProcess  
  
## EXAMPLES  
  
### Getting to the Function: Drive  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 Changes the current location to the Function: drive. You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type "set\-location c:".  
  
```  
set-location function:  
  
```  
  
### Getting Functions  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets the list of all the functions in the current session. You can use this command from any Windows PowerShell drive.  
  
```  
get-childitem -path function:  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets the "man" function from the Function: drive. It uses the Get\-Item cmdlet to get the function. The pipeline operator \(&#124;\) sends the result to Format\-Table.  
  
 The Wrap parameter directs text that does not fit on the line onto the next line. The Autosize parameter resizes the table columns to accommodate the text.  
  
```  
get-item -path man | format-table -wrap -autosize  
  
```  
  
 If you are in a different drive, add the drive name \(Function:\) to the path.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 These commands both get the function named "c:". The first command can be used in any drive. The second command is used in the Function: drive.  
  
 Because the name ends in a colon, which is the syntax for a drive, you must qualify the path with the drive name. Within the Function: drive, you can use either format. In the second command, the dot \(.\) represents the current location.  
  
```  
c:\PS> get-item -path function:c:  
  
PS Function> get-item -path .\c:  
  
```  
  
### Creating a Function  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the New\-Item cmdlet to create a function called "HKLM:". The expression in braces is the script block that is represented by the function name.  
  
```  
new-item -path function:hklm: -value {set-location hklm:}  
  
```  
  
 You can also create a function by typing it at the Windows PowerShell command line. For example, tpe "function:hklm: {set\-location hklm:}". If you are in the Function: drive, you can omit the drive name.  
Because you cannot specify the "Filter" label in New\-Item, filters are labeled as functions, but they operate properly with any label. To create a filter with the "Filter" label, type the filter at the command line. For example, type "filter:Running {$\_.Status \-eq "Running"}".  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the New\-Item cmdlet to create a function called Csrss. It uses the Options dynamic parameter to specify a value of ReadOnly for the Options property of the function.  
  
```  
new-item -path function: -name csrss -options readonly -value {get-process csrss}  
  
```  
  
 This command works from any location. If you are in the Function: drive, you can use a dot \(.\) to specify the path. The dot represents the current location.  
  
### Deleting a Function  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes the "hklm:" function from the current session.  
  
```  
remove-item function:hklm:  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes all the functions from the current session except for the functions whose Options property has a value of Constant. Without the Force parameter, the command does not delete functions whose Options property has a value of ReadOnly.  
  
```  
remove-item function:* -force  
  
```  
  
 When you delete all the functions, the command prompt changes because the prompt function, which defines the content of the command prompt, is deleted.  
  
### Displaying the Properties and Methods of Functions  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Get\-Item cmdlet to get all the functions. The pipeline operator sends the results to the Get\-Member cmdlet, which displays the methods and the properties of the object.  
  
```  
get-item -path function:* | get-member  
  
```  
  
 When you pipe a collection of objects \(such as the collection of functions in the Function: drive\) to Get\-Member, Get\-Member evaluates each object in the collection separately and returns information about each object type that it finds. If all of the objects are of the same type, it returns information about the single object type. In this case, all of the functions are FunctionInfo objects.  
To get information about the collection of FunctionInfo objects, use the InputObject parameter of Get\-Member. For example, type "get\-member \-InputObject \(get\-item function:\*\)". When you use the InputObject parameter, Get\-Member evaluates the collection, not the objects in the collection.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command lists the values of the properties of the "prompt" function. It uses the Get\-Item cmdlet to get an object that represents the "prompt" function. The pipeline operator \(&#124;\) sends the results to the Format\-List command. The Format\-List command uses the Property parameter with a wildcard character \(\*\) to format and to display the values of all of the properties of the "prompt" function.  
  
```  
get-item function:prompt | format-list -property *  
  
```  
  
### Changing the Properties of a Function  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 You can use the Set\-Item cmdlet with the Options dynamic parameter to change the value of the Options property of a function.  
  
 This command sets the AllScope and ReadOnly options for the "prompt" function. This command uses the Options dynamic parameter of the Set\-Item cmdlet. The Options parameter is available in Set\-Item only when you use it with the Alias or Function provider.  
  
```  
set-item -path function:prompt -options "AllScope,ReadOnly"  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Set\-Item cmdlet to change the "prompt" function so that it displays the time before the path.  
  
```  
set-item -path function:prompt -value {'PS '+ $(Get-Date -format t) + " " + $(Get-Location) + '> '}  
  
```  
  
 The change affects both the Definition and ScriptBlock properties of the FunctionInfo object. To see the effect of the change, type "get\-item \-path function:prompt &#124; format\-list \-property \*".  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Rename\-Item cmdlet to change the name of the "help" function to "gh".  
  
```  
rename-item -path function:help -newname gh  
  
```  
  
### Copying a Function  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command copies the "prompt" function to "oldPrompt", effectively creating a new name for the script block that is associated with the prompt function. You can use this to save the original prompt function if you plan to change it.  
  
 The Options property of the new function has a value of None. To change the value of the Options property, use Set\-Item.  
  
```  
copy-item -path function:prompt -destination function:oldPrompt  
  
```  
  
## DYNAMIC PARAMETERS  
 Dynamic parameters are cmdlet parameters that are added by a Windows PowerShell provider and are available only when the cmdlet is being used in the provider\-enabled drive.  
  
### Options \<System.Management.Automation.ScopedItemOptions\>  
 Determines the value of the Options property of a function.  
  
|Value|Description|  
|-----------|-----------------|  
|None|No options. "None" is the default.|  
|Constant|The function cannot be deleted, and its properties cannot be changed. Constant is available only when you are creating a function. You cannot change the option of an existing function to Constant.|  
|Private|The function is visible only in the current scope \(not in child scopes\).|  
|ReadOnly|The properties of the function cannot be changed except by using the Force parameter. You can use [Remove\-Item](assetId:///f98b4219-60df-408b-bdc8-994f920fc7bd) to delete the function.|  
|AllScope|The function is copied to any new scopes that are created.|  
  
#### Cmdlets supported:  
  
-   [New\-Item](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106)  
  
-   [Set\-Item](assetId:///2ae0f9bc-105b-4363-8410-7f94a3c12fa3)  
  
## See Also  
 [about\_Functions](assetId:///61d40692-5300-4de9-a9b5-bae31815e105)   
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)