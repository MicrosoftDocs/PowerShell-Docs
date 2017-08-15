---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Environment Provider
online version:  https://go.microsoft.com/fwlink/?linkid=834944
---


# *Environment* provider


## Provider name

 Environment  


## Drives

 `Env:`  


## Short description

 Provides access to the Windows environment variables.  


## Detailed description

 The Windows PowerShell **Environment** provider lets you get, add, change, clear, and delete Windows environment variables in Windows PowerShell.  

 The **Environment** provider is a flat namespace that contains only objects that represent the environment variables. The variables have no child items.  

 Each environment variable is an instance of the [System.Collections.DictionaryEntry](https://msdn.microsoft.com/library/system.collections.dictionaryentry) class. The name of the variable is the dictionary key. The value of the environment variable is the dictionary value.  

 The **Environment** provider exposes its data store in the `Env:` drive. To work with environment variables, change your location to the `Env:` drive (`set-location Env:`), or work from another Windows PowerShell drive. To reference an environment variable from another location, use the `Env:` drive name in the path.  

 The **Environment** provider supports all the cmdlets that contain the *Item* noun except for [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md). And, it supports the [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) and [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md) cmdlets. However, it does not support the cmdlets that contain the *ItemProperty* noun, and it does not support the `-Filter` parameter in any cmdlet.  

 Environment variables must conform to the usual naming standards. Additionally, the name cannot include the equal sign (`=`).  

 Changes to the environment variables affect the current session only. To save the changes, add the changes to the Windows PowerShell profile, or use [Export-Console](there-should-be-an-external-link) to save the current session.  


## Capabilities

 ShouldProcess  


## Examples


### Getting to the `Env:` drive


#### Example 1

 This command changes the current location to the `Env:` drive:  

```powershell
Set-Location Env:
```

 You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type:  
```powershell
Set-Location c:
```


### Getting environment variables


#### Example 1

 This command lists all the environment variables in the current session:  

```powershell
Get-ChildItem -Path Env:
```

 You can use this command from any Windows PowerShell drive.  


#### Example 2

 This command gets the `WINDIR` environment Variable:  

```powershell
Get-ChildItem -Path Env:windir
```


#### Example 3

 This command gets a list of all the environment variables in the current session and then sorts them by name:  

```powershell
Get-ChildItem  | Sort-Object -Property name
```

 By default, the environment variables appear in the order that Windows PowerShell discovers them. This command is submitted in the `Env:` drive.  
When you run this command from another drive, add the `-Path` parameter with a value of `Env:`.  


### Creating a new environment variable


#### Example 1

 This command creates the `USERMODE` environment variable with a value of "Non-Admin":  

```powershell
New-Item -Path . -Name USERMODE -Value Non-Admin
```

 Because the current location is in the `Env:` drive, the value of the `-Path` parameter is a dot (`.`). The dot represents the current location.  
If you are not in the `Env:` drive, the value of the `-Path` parameter would be `Env:`.  


### Displaying the properties and methods of environment variables


#### Example 1

 This command uses the [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet to get all the environment variables:  

```powershell
Get-ChildItem -Path Env: | Get-Member
```

 The pipeline operator (`|`) sends the results to [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md), which displays the methods and properties of the object.  
When you pipe a collection of objects to [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md), such as the collection of environment variables in the `Env:` drive, [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) evaluates each object in the collection separately. [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) then returns information about each object type that it finds. If all the objects are of the same type, it returns information about the single object type. In this case, all the environment variables are [DictionaryEntry](https://msdn.microsoft.com/library/system.collections.dictionaryentry) objects.  
To get information about the collection of [DictionaryEntry](https://msdn.microsoft.com/library/system.collections.dictionaryentry) objects, use the `-InputObject` parameter of [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md). For example, type:  

```powershell
Get-Member -InputObject (Get-ChildItem Env:)
```

When you use the `-InputObject` parameter, [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) evaluates the collection, not the objects in the collection.  


#### Example 2

 This command lists the values of the properties of the `WINDIR` environment Variable:  

```powershell
Get-Item Env:windir | Format-List -Property *
```

 It uses the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet to get an object that represents the `WINDIR` environment variable. The pipeline operator (`|`) sends the results to the [Format-List](../../Microsoft.PowerShell.Utility/Format-List.md) command. It uses the `-Property` parameter with a wildcard character (`*`) to format and display the values of all the properties of the `WINDIR` environment variable.  


### Changing the properties of an environment variable


#### Example 1

 This command uses the [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md) cmdlet to change the name of the `USERMODE` environment variable that you created to `USERROLE`:  

```powershell
Rename-Item -Path Env:USERMODE -NewName USERROLE
```

 This change affects the **Name**, **Key**, and **PSPath** properties of the [DictionaryEntry](https://msdn.microsoft.com/library/system.collections.dictionaryentry) object.  
Do not change the name of an environment variable that the system uses. Although these changes affect only the current session, they might cause the system or a program to operate incorrectly.  


#### Example 2

 This command uses the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet to change the value of the `USERROLE` environment variable to "Administrator":  

```powershell
Set-Item -Path Env:USERROLE -Value Administrator
```


### Copying an environment variable


#### Example 1

 This command copies the value of the `USERROLE` environment variable to the `USERROLE2` environment Variable:  

```powershell
Copy-Item -Path Env:USERROLE -Destination Env:USERROLE2
```


### Deleting an environment variable


#### Example 1

 This command deletes the `USERROLE2` environment variable from the current session:  

```powershell
Remove-Item -Path Env:USERROLE2
```

 You can use this command in any Windows PowerShell drive. If you are in the `Env:` drive, you can omit the drive name from the path.  


#### Example 2

 This command deletes the `USERROLE` environment variable.  

```powershell
Clear-Item -Path Env:USERROLE
```


## See also

 [about_Providers](../About/about_Providers.md)

