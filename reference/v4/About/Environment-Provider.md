---
title: Environment Provider
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 94fcd05d-e702-4706-9b7d-ad7e5fd0ec09
---
# Environment Provider
## PROVIDER NAME  
 Environment  
  
## DRIVES  
 Env:  
  
## SHORT DESCRIPTION  
 Provides access to the Windows environment variables.  
  
## DETAILED DESCRIPTION  
 The Windows PowerShell Environment provider lets you get, add, change, clear, and delete Windows environment variables in Windows PowerShell.  
  
 The Environment provider is a flat namespace that contains only objects that represent the environment variables. The variables have no child items.  
  
 Each environment variable is an instance of the System.Collections.DictionaryEntry class. The name of the variable is the dictionary key. The value of the environment variable is the dictionary value.  
  
 The Environment provider exposes its data store in the Env: drive. To work with environment variables, change your location to the Env: drive \("set\-location env:"\), or work from another Windows PowerShell drive. To reference an environment variable from another location, use the Env: drive name in the path.  
  
 The Environment provider supports all the cmdlets that contain the Item noun except for [Invoke\-Item](assetId:///38a9887b-ce1a-4bde-be4e-98012efae204). And, it supports the [Get\-Content](assetId:///86d8b4af-af2c-4a27-9519-2c9fd420be3d) and [Set\-Content](assetId:///6fff9b86-86df-4440-b7b7-8124b22088fc) cmdlets. However, it does not support the cmdlets that contain the ItemProperty noun, and it does not support the Filter parameter in any cmdlet.  
  
 Environment variables must conform to the usual naming standards. Additionally, the name cannot include the equal sign \(\=\).  
  
 Changes to the environment variables affect the current session only. To save the changes, add the changes to the Windows PowerShell profile, or use [Export\-Console](assetId:///0858eece-ddcb-4525-89d1-4732c5f54c48) to save the current session.  
  
## CAPABILITIES  
 ShouldProcess  
  
## EXAMPLES  
  
### Getting to the Env: Drive  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command changes the current location to the Env: drive:  
  
```  
set-location env:  
  
```  
  
 You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type:  
    set\-location c:  
  
### Getting Environment Variables  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command lists all the environment variables in the current session:  
  
```  
get-childitem -path env:  
  
```  
  
 You can use this command from any Windows PowerShell drive.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets the WINDIR environment variable:  
  
```  
get-childitem -path env:windir  
  
```  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 3 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command gets a list of all the environment variables in the current session and then sorts them by name:  
  
```  
get-childitem  | sort-object -property name  
  
```  
  
 By default, the environment variables appear in the order that Windows PowerShell discovers them. This command is submitted in the Env: drive.  
When you run this command from another drive, add the Path parameter with a value of Env:.  
  
### Creating a New Environment Variable  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command creates the USERMODE environment variable with a value of Non\-Admin:  
  
```  
new-item -path . -name USERMODE -value Non-Admin  
  
```  
  
 Because the current location is in the Env: drive, the value of the Path parameter is a dot \(.\). The dot represents the current location.  
If you are not in the Env: drive, the value of the Path parameter would be Env:.  
  
### Displaying the Properties and Methods of Environment Variables  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Get\-ChildItem cmdlet to get all the environment variables:  
  
```  
get-childitem -path env: | get-member  
  
```  
  
 The pipeline operator \(&#124;\) sends the results to Get\-Member, which displays the methods and properties of the object.  
When you pipe a collection of objects to Get\-Member, such as the collection of environment variables in the Env: drive, Get\-Member evaluates each object in the collection separately. Get\-Member then returns information about each object type that it finds. If all the objects are of the same type, it returns information about the single object type. In this case, all the environment variables are DictionaryEntry objects.  
To get information about the collection of DictionaryEntry objects, use the InputObject parameter of Get\-Member. For example, type:  
    get\-member \-inputobject \(get\-childitem env:\)  
When you use the InputObject parameter, Get\-Member evaluates the collection, not the objects in the collection.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command lists the values of the properties of the WINDIR environment variable:  
  
```  
get-item env:windir | format-list -property *  
  
```  
  
 It uses the Get\-Item cmdlet to get an object that represents the WINDIR environment variable. The pipeline operator \(&#124;\) sends the results to the Format\-List command. It uses the Property parameter with a wildcard character \(\*\) to format and display the values of all the properties of the WINDIR environment variable.  
  
### Changing the Properties of an Environment Variable  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Rename\-Item cmdlet to change the name of the USERMODE environment variable that you created to USERROLE:  
  
```  
rename-item -path env:USERMODE -newname USERROLE  
  
```  
  
 This change affects the Name, Key, and PSPath properties of the DictionaryEntry object.  
Do not change the name of an environment variable that the system uses. Although these changes affect only the current session, they might cause the system or a program to operate incorrectly.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command uses the Set\-Item cmdlet to change the value of the USERROLE environment variable to Administrator:  
  
```  
set-item -path env:USERROLE -value Administrator  
  
```  
  
### Copying an Environment Variable  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command copies the value of the USERROLE environment variable to the USERROLE2 environment variable:  
  
```  
copy-item -path env:USERROLE -destination env:USERROLE2  
  
```  
  
### Deleting an environment variable  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 1 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes the USERROLE2 environment variable from the current session:  
  
```  
remove-item -path env:USERROLE2  
  
```  
  
 You can use this command in any Windows PowerShell drive. If you are in the Env: drive, you can omit the drive name from the path.  
  
#### \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- EXAMPLE 2 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
 This command deletes the USERROLE environment variable.  
  
```  
clear-item -path env:USERROLE  
  
```  
  
## See Also  
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)