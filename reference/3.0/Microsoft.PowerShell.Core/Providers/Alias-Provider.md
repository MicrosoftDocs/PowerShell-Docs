---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Alias Provider
---


# *Alias* provider


## Provider name

 Alias  


## Drives

 `Alias:`  


## Short description

 Provides access to the Windows PowerShell aliases and the values that they represent.  


## Detailed description

 The Windows PowerShell **Alias** provider lets you get, add, change, clear, and delete aliases in Windows PowerShell.  

 An alias is an alternate name for a cmdlet, function, or executable file. Windows PowerShell includes a set of built-in aliases. And, you can add your own aliases to the current session and to your Windows PowerShell profile.  

 The **Alias** provider is a flat namespace that contains only the alias objects. The aliases have no child items.  

 Each alias is an instance of the [System.Management.Automation.AliasInfo](https://msdn.microsoft.com/library/system.management.automation.aliasinfo) class.  

 The **Alias** provider exposes its data store in the `Alias:` drive. To work with aliases, you can change your location to the `Alias:` drive by using the following command:  

```powershell
Set-Location Alias:
```

 Or, you can work from any other Windows PowerShell drive. To reference an alias from another location, use the `Alias:` drive name in the path.  

 Windows PowerShell includes a set of cmdlets that are designed to view and to change aliases:  

- [Export-Alias](../../Microsoft.PowerShell.Utility/Export-Alias.md)  
- [Get-Alias](../../Microsoft.PowerShell.Utility/Get-Alias.md)  
- [Import-Alias](../../Microsoft.PowerShell.Utility/Import-Alias.md)  
- [New-Alias](../../Microsoft.PowerShell.Utility/New-Alias.md)  
- [Set-Alias](../../Microsoft.PowerShell.Utility/Set-Alias.md)  

 When you use these cmdlets, you do not need to specify the `Alias:` drive in the name.  

 The **Alias** provider supports all the cmdlets that have the *Item* noun except for the [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md) cmdlet. And, it supports the [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) and [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md) cmdlets. The **Alias** provider does not support the cmdlets that have the *ItemProperty* noun. And, the **Alias** provider does not support the `-Filter` parameter in any cmdlet.  

 All changes to the aliases affect the current session only. To save the changes, add the changes to the Windows PowerShell profile. Or, use the [Export-Alias](../../Microsoft.PowerShell.Utility/Export-Alias.md) and [Import-Alias](../../Microsoft.PowerShell.Utility/Import-Alias.md) cmdlets.  


## Capabilities

 ShouldProcess  


## Examples


### Getting to the `Alias:` drive


#### Example 1

 This command changes the current location to the `Alias:` drive. You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type `set-location c:`.  

```powershell
Set-Location Alias:
```


### Getting aliases


#### Example 1

 This command gets a list of all the aliases in the current session. You can use this command in any Windows PowerShell drive.  

```powershell
Get-Item -Path Alias:
```


#### Example 2

 This command gets the `ls` alias. Because it includes the path, you can use it in any Windows PowerShell drive.  

```powershell
Get-Item -Path Alias:ls
```

 If you are in the `Alias:` drive, you can omit the drive name from the path.  


#### Example 3

 This command gets a list of the aliases that are associated with the [Get-ChildItem](../../Microsoft.PowerShell.Management/Get-ChildItem.md) cmdlet. It uses the `Definition` property, which stores the cmdlet name.  

```powershell
Get-Item -Path Alias:* | Where-Object {$_.Definition -eq "Get-ChildItem"}
```

 When the aliased item is an executable file, the `Definition` contains the fully qualified path of the file.  


#### Example 4

 This command gets the list of all the aliases when the current location is the `Alias:` drive. It uses a wildcard character `*` to indicate all the contents of the current location.  

```powershell
Get-Item -Path *
```

 In the `Alias:` drive, a dot `.`, which represents the current location, and a wildcard character `*`, which represents all items in the current location, have the same effect. For example, `Get-Item -Path .` or `Get-Item \*` produce the same result.  


### Creating a new alias


#### Example 1

 This command creates the `serv` alias for the [Get-Service](../../Microsoft.PowerShell.Management/Get-Service.md) cmdlet. Because the current location is in the `Alias:` drive, the value of the `-Path` parameter is a dot `.`. The dot represents the current location.  

 This command also uses the `-Options` dynamic parameter to set the **AllScope** and **Constant** options on the alias. The `-Options` parameter is available in the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet only when you are in the `Alias:` drive.  

```powershell
New-Item -Path . -Name serv -Value Get-Service -Options "AllScope,Constant"
```

 If you are in the `Alias:` drive, you can omit the drive name from the path.  


#### Example 2

 You can create an alias for any item that invokes a command. This command creates the `np` alias for `Notepad.exe`.  

```powershell
New-Item -Path Alias:np -Value c:\windows\notepad.exe
```


#### Example 3

 You can create an alias for any function. You can use this feature to create an alias that includes both a cmdlet and its parameters.  

 The first command creates the `CD32` function, which changes the current directory to the `System32` directory. The second command creates the `go` alias for the `CD32` function. The semi-colon `;` is the command separator.  

 When the command is complete, you can use either `CD32` or `go` to invoke the function.  

```powershell
function CD32 {Set-Location -Path c:\windows\system32}; Set-Item -Path Alias:go -Value CD32
```


### Displaying the properties and methods of aliases


#### Example 1

 This command uses the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet to get all aliases. The pipeline operator `|` sends the results to the [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) cmdlet, which displays the methods and properties of the object.  

```powershell
Get-Item -Path Alias:* | Get-Member
```

 When you pipe a collection of objects to [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md), such as the collection of aliases in the `Alias:` drive, [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) evaluates each object in the collection separately. Then, [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) returns information about each object type that it finds. If all the objects are of the same type, it returns information about the single object type. In this case, all the aliases are [AliasInfo](https://msdn.microsoft.com/library/system.management.automation.aliasinfo) objects.  
To get information about the collection of [AliasInfo](https://msdn.microsoft.com/library/system.management.automation.aliasinfo) objects, use the `-InputObject` parameter of [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md). For example, use the following command:  

```powershell
Get-Member -InputObject (Get-Item Alias:*)
```

When you use `-InputObject`, [Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md) evaluates the collection, not the objects in the collection.  


#### Example 2

 This command lists the values of the properties of the `dir` alias. It uses the [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet to get an object that represents the `dir` alias. The pipeline operator `|` sends the results to the [Format-List](../../Microsoft.PowerShell.Utility/Format-List.md) command. The [Format-List](../../Microsoft.PowerShell.Utility/Format-List.md) command uses the `-Property` parameter with a wildcard character `*` to format and display the values of all the `dir` alias properties.  

```powershell
Get-Item Alias:dir | Format-List -Property *
```


### Changing the properties of an alias


#### Example 1

 You can use the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet with the `-Options` dynamic parameter to change the value of the `-Options` property of an alias.  

 This command sets the **AllScope** and **ReadOnly** options for the `dir` alias. The command uses the `-Options` dynamic parameter of the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet. The `-Options` parameter is available in [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) only when you use it with the **Alias** or **Function** provider.  

```powershell
Set-Item -Path Alias:dir -Options "AllScope,ReadOnly"
```


#### Example 2

 This command uses the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet to change the `gp` alias so that it represents the [Get-Process](../../Microsoft.PowerShell.Management/Get-Process.md) cmdlet instead of the [Get-ItemProperty](../../Microsoft.PowerShell.Management/Get-ItemProperty.md) cmdlet. The `-Force` parameter is required because the value of the **Options** property of the `gp` alias is set to `ReadOnly`. Because the command is submitted from within the `Alias:` drive, the drive is not specified in the path.  

```powershell
Set-Item -Path gp -Value Get-Process -Force
```

 The change affects the four properties that define the association between the alias and the command. To view the effect of the change, type the following command:  
```powershell
Get-Item -Path gp | Format-List -Property *
```


#### Example 3

 This command uses the [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md) cmdlet to change the `popd` alias to `pop`.  

```powershell
Rename-Item -Path Alias:popd -NewName pop
```


### Copying an alias


#### Example 1

 This command copies the `pushd` alias so that a new `push` alias is created for the [Push-Location](../../Microsoft.PowerShell.Management/Push-Location.md) cmdlet.  

```powershell
Copy-Item -Path Alias:pushd -Destination Alias:push
```

 When the new alias is created, its **Description** property has a null value. And, its **Option** property has a value of `None`.  
If the command is issued from within the `Alias:` drive, you can omit the drive name from the value of the `-Path` parameter.  


### Deleting an alias


#### Example 1

 This command deletes the `serv` alias from the current session. You can use this command in any Windows PowerShell drive.  

```powershell
Remove-Item -Path Alias:serv
```

 If you are in the `Alias:` drive, you can omit the drive name from the path.  


#### Example 2

 This command deletes aliases that begin with "s". It does not delete read-only aliases.  

```powershell
Clear-Item -Path Alias:s*
```


#### Example 3

 This command deletes all aliases from the current session, except those with a value of `Constant` for their **Options** property. Without the `-Force` parameter, the command does not delete aliases whose **Options** property has a value of `ReadOnly`.  

```powershell
Remove-Item Alias:* -Force
```


## Dynamic parameters

 Dynamic parameters are cmdlet parameters that are added by a Windows PowerShell provider and are available only when the cmdlet is being used in the provider-enabled drive.  


### `Options` <[System.Management.Automation.ScopedItemOptions](https://msdn.microsoft.com/library/system.management.automation.scopeditemoptions)>

 Determines the value of the **Options** property of an alias.  

|Value|Description|  
|-----------|-----------------|  
|`None`|No options. This value is the default.|  
|`Constant`|The alias cannot be deleted and its properties cannot be changed. `Constant` is available only when you create an alias. You cannot change the option of an existing alias to `Constant`.|  
|`Private`|The alias is visible only in the current scope, not in the child scopes.|  
|`ReadOnly`|The properties of the alias cannot be changed except by using the `-Force` parameter. You can use [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md) to delete the alias.|  
|`AllScope`|The alias is copied to any new scopes that are created.|  


#### Cmdlets supported:


-   [New-Item](../../Microsoft.PowerShell.Management/New-Item.md)  

-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  


## See also

 [about_Aliases](../About/about_Aliases.md)   
 [about_Providers](../About/about_Providers.md)

