---
title: Alias Provider
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dce3f872-aeff-4eb2-8b38-876cd612fc29
---
# Alias Provider
## PROVIDER NAME  
 Alias  
  
## DRIVES  
 Alias:  
  
## SHORT DESCRIPTION  
 Provides access to the Windows PowerShell aliases and the values that they represent.  
  
## DETAILED DESCRIPTION  
 The Windows PowerShell Alias provider lets you get, add, change, clear, and delete aliases in Windows PowerShell.  
  
 An alias is an alternate name for a cmdlet, function, or executable file. Windows PowerShell includes a set of built\-in aliases. And, you can add your own aliases to the current session and to your Windows PowerShell profile.  
  
 The Alias provider is a flat namespace that contains only the alias objects. The aliases have no child items.  
  
 Each alias is an instance of the System.Management.Automation.AliasInfo class.  
  
 The Alias provider exposes its data store in the Alias: drive. To work with aliases, you can change your location to the Alias: drive by using the following command:  
  
 [Set-Location](Set-Location.md) alias:  
  
 Or, you can work from any other Windows PowerShell drive. To reference an alias from another location, use the Alias: drive name in the path.  
  
 Windows PowerShell includes a set of cmdlets that are designed to view and to change aliases:  
  
 Export\-Alias  
  
 Get\-Alias  
  
 Import\-Alias  
  
 New\-Alias  
  
 Set\-Alias  
  
 When you use these cmdlets, you do not need to specify the Alias: drive in the name.  
  
 The Alias provider supports all the cmdlets that have the Item noun except for the [Invoke-Item](Invoke-Item.md) cmdlet. And, it supports the [Get-Content](Get-Content.md) and [Set-Content](Set-Content.md) cmdlets. The Alias provider does not support the cmdlets that have the ItemProperty noun. And, the Alias provider does not support the Filter parameter in any cmdlet.  
  
 All changes to the aliases affect the current session only. To save the changes, add the changes to the Windows PowerShell profile. Or, use the [Export-Alias](Export-Alias.md) and [Import-Alias](Import-Alias.md) cmdlets.  
  
## CAPABILITIES  
 ShouldProcess  
  
## EXAMPLES  
  
### Getting to the Alias: Drive  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command changes the current location to the Alias: drive. You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type "set\-location c:".  
  
```  
set-location alias:  
  
```  
  
### Getting Aliases  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets a list of all the aliases in the current session. You can use this command in any Windows PowerShell drive.  
  
```  
get-item -path alias:  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets the "ls" alias. Because it includes the path, you can use it in any Windows PowerShell drive.  
  
```  
get-item -path alias:ls  
  
```  
  
 If you are in the Alias: drive, you can omit the drive name from the path.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets a list of the aliases that are associated with the Get\-ChildItem cmdlet. It uses the Definition property, which stores the cmdlet name.  
  
```  
get-item -path alias:* | where-object {$_.Definition -eq "Get-Childitem"}  
  
```  
  
 When the aliased item is an executable file, the Definition contains the fully qualified path of the file.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 4 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets the list of all the aliases when the current location is the Alias: drive. It uses a wildcard character \(\*\) to indicate all the contents of the current location.  
  
```  
get-item -path *  
  
```  
  
 In the Alias: drive, a dot \(.\), which represents the current location, and a wildcard character \(\*\), which represents all items in the current location, have the same effect. For example, "get\-item \-path ." or "get\-item \*" produce the same result.  
  
### Creating a New Alias  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command creates the "serv" alias for the Get\-Service cmdlet. Because the current location is in the Alias: drive, the value of the Path parameter is a dot \(.\). The dot represents the current location.  
  
 This command also uses the Options dynamic parameter to set the AllScope and Constant options on the alias. The Options parameter is available in the New\-Item cmdlet only when you are in the Alias: drive.  
  
```  
new-item -path . -name serv -value Get-Service -Options "AllScope,Constant"  
  
```  
  
 If you are in the Alias: drive, you can omit the drive name from the path.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 You can create an alias for any item that invokes a command. This command creates the "np" alias for Notepad.exe.  
  
```  
new-item -path alias:np -value c:\windows\notepad.exe  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 You can create an alias for any function. You can use this feature to create an alias that includes both a cmdlet and its parameters.  
  
 The first command creates the CD32 function, which changes the current directory to the System32 directory. The second command creates the "go" alias for the CD32 function. The semi\-colon \(;\) is the command separator.  
  
 When the command is complete, you can use either "CD32" or "go" to invoke the function.  
  
```  
function CD32 {set-location -path c:\windows\system32} set-item -path alias:go -value CD32  
  
```  
  
### Displaying the Properties and Methods of Aliases  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Get\-Item cmdlet to get all aliases. The pipeline operator \(&#124;\) sends the results to the Get\-Member cmdlet, which displays the methods and properties of the object.  
  
```  
get-item -path alias:* | get-member  
  
```  
  
 When you pipe a collection of objects to Get\-Member, such as the collection of aliases in the Alias: drive, Get\-Member evaluates each object in the collection separately. Then, Get\-Member returns information about each object type that it finds. If all the objects are of the same type, it returns information about the single object type. In this case, all the aliases are AliasInfo objects.  
To get information about the collection of AliasInfo objects, use the InputObject parameter of Get\-Member. For example, use the following command:  
    Get\-Member \-InputObject \(Get\-Item alias:\*\)  
When you use InputObject, Get\-Member evaluates the collection, not the objects in the collection.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command lists the values of the properties of the "dir" alias. It uses the Get\-Item cmdlet to get an object that represents the "dir" alias. The pipeline operator \(&#124;\) sends the results to the Format\-List command. The Format\-List command uses the Property parameter with a wildcard character \(\*\) to format and display the values of all the "dir" alias properties.  
  
```  
get-item alias:dir | format-list -property *  
  
```  
  
### Changing the Properties of an Alias  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 You can use the Set\-Item cmdlet with the Options dynamic parameter to change the value of the Options property of an alias.  
  
 This command sets the AllScope and ReadOnly options for the "dir" alias. The command uses the Options dynamic parameter of the Set\-Item cmdlet. The Options parameter is available in Set\-Item only when you use it with the Alias or Function provider.  
  
```  
set-item -path alias:dir -options "AllScope,ReadOnly"  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Set\-Item cmdlet to change the "gp" alias so that it represents the Get\-Process cmdlet instead of the Get\-ItemProperty cmdlet. The Force parameter is required because the value of the Options property of the "gp" alias is set to ReadOnly. Because the command is submitted from within the Alias: drive, the drive is not specified in the path.  
  
```  
set-item -path gp -value get-process -force  
  
```  
  
 The change affects the four properties that define the association between the alias and the command. To view the effect of the change, type the following command:  
    get\-item \-path gp &#124; format\-list \-property \*  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Rename\-Item cmdlet to change the "popd" alias to "pop".  
  
```  
rename-item -path alias:popd -newname pop  
  
```  
  
### Copying an Alias  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command copies the pushd alias so that a new push alias is created for the Push\-Location cmdlet.  
  
```  
copy-item -path alias:pushd -destination alias:push  
  
```  
  
 When the new alias is created, its Description property has a null value. And, its Option property has a value of None.  
If the command is issued from within the Alias: drive, you can omit the drive name from the value of the Path parameter.  
  
### Deleting an Alias  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes the serv alias from the current session. You can use this command in any Windows PowerShell drive.  
  
```  
remove-item -path alias:serv  
  
```  
  
 If you are in the Alias: drive, you can omit the drive name from the path.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes aliases that begin with "s". It does not delete read\-only aliases.  
  
```  
clear-item -path alias:s*  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes all aliases from the current session, except those with a value of Constant for their Options property. Without the Force parameter, the command does not delete aliases whose Options property has a value of ReadOnly.  
  
```  
remove-item alias:* -force  
  
```  
  
## DYNAMIC PARAMETERS  
 Dynamic parameters are cmdlet parameters that are added by a Windows PowerShell provider and are available only when the cmdlet is being used in the provider\-enabled drive.  
  
### Options \<System.Management.Automation.ScopedItemOptions\>  
 Determines the value of the Options property of an alias.  
  
|Value|Description|  
|-----------|-----------------|  
|None|No options. This value is the default.|  
|Constant|The alias cannot be deleted and its properties cannot be changed. Constant is available only when you create an alias. You cannot change the option of an existing alias to Constant.|  
|Private|The alias is visible only in the current scope, not in the child scopes.|  
|ReadOnly|The properties of the alias cannot be changed except by using the Force parameter. You can use [Remove-Item](Remove-Item.md) to delete the alias.|  
|AllScope|The alias is copied to any new scopes that are created.|  
  
#### Cmdlets supported:  
  
-   [New-Item](New-Item.md)  
  
-   [Set-Item](Set-Item.md)  
  
## See Also  
 [about\_Aliases &#91;m2&#93;](assetId:///4b175fd4-37ef-4fe1-8e75-06205d4cea12)   
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)