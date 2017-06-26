---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Registry Provider
online version:  http://go.microsoft.com/fwlink/?LinkId=821468
---


# *Registry* provider


## Provider name

 **Registry**  


## Drives

 `HKLM:`, `HKCU:`  


## Short description

 Provides access to the registry keys, entries, and values in Windows PowerShell.  


## Detailed description

 The Windows PowerShell **Registry** provider lets you get, add, change, clear, and delete registry keys, entries, and values in Windows PowerShell.  

 Registry keys are represented as instances of the [Microsoft.Win32.RegistryKey](https://msdn.microsoft.com/library/microsoft.win32.registrykey) class. Registry entries are represented as instances of the [PSCustomObject](https://msdn.microsoft.com/library/system.management.automation.pscustomobject) class.  

 The **Registry** provider lets you access a hierarchical namespace that consists of registry keys and subkeys. Registry entries and values are not components of that hierarchy. Instead, they are properties of each of the keys.  

 The **Registry** provider supports all the cmdlets that contain the *Item* noun (the `*-Item` cmdlets), such as [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md), [Copy-Item](../../Microsoft.PowerShell.Management/Copy-Item.md), and [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md), except for the [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md) cmdlet. Use the `*-Item` cmdlets when you work with registry keys and subkeys.  

 The **Registry** provider also supports the cmdlets that contain the *ItemProperty* noun (the `*-ItemProperty` cmdlets). Use the `*-ItemProperty` cmdlets when you work with registry entries. You cannot use the cmdlets that contain the *Content* noun (the `*-Content` cmdlets) with the **Registry** provider.  

 Each registry key is protected by a security descriptor. You can use [Get-Acl](../../Microsoft.PowerShell.Security/Get-Acl.md) to view the security descriptor of a key.  


## Capabilities

 **ShouldProcess**, **UseTransactions**  


## Examples


### Navigating the registry


#### Example 1

 This command sets the current location to the `HKEY_LOCAL_MACHINE\Software` registry key:  

```powershell
Set-Location HKLM:\software
```


#### Example 2

 This command gets an object that represents the current location:  

```powershell
Get-Location
```


### Managing registry keys


#### Example 1

 This command gets each immediate subkeys of the `HKEY_LOCAL_MACHINE\Software` registry key:  

```powershell
Get-ChildItem -Path HKLM:\software
```


#### Example 2

 This command creates the `TestNew` subkey under the `HKCU:\Environment` subkey:  

```powershell
New-Item -Path hkcu:\Environment\TestNew
```


#### Example 3

 This command deletes the `TestNew` subkey of the `HKEY_CURRENT_USER\Environment` key:  

```powershell
Remove-Item -Path hkcu:\Environment\TestNew
```


#### Example 4

 This command copies the `TestNew` key to the `TestCopy` subkey:  

```powershell
Copy-Item -Path  hkcu:\Environment\TestNew  hkcu:\Environment\TestNew\TestCopy
```


#### Example 5

 This command gets all the subkeys of the `HKEY_LOCAL_MACHINE\Software` registry key:  

```powershell
Get-ChildItem -Path HKLM:\Software -Recurse
```


#### Example 6

 This command moves the `HKEY_CURRENT_USER\Environment\testnewcopy` registry key, its subkeys and their registry entries to the `HKEY_CURRENT_USER\Environment\testnew` key:  

```powershell
Move-Item -Path hkcu:\environment\testnewcopy -Destination hkcu:\environment\testnew
```


#### Example 7

 This command renames the `HKEY_CURRENT_USER\Environment\testnew` registry key to `HKEY_CURRENT_USER\Environment\test`:  

```powershell
Rename-Item -Path hkcu:\environment\testnew\ -NewName test
```


#### Example 8

 This command gets the security descriptor of the specified registry key:  

```powershell
Get-Acl -Path hkcu:\environment\testnew | Format-List -Property *
```


### Managing registry entries


#### Example 1

 This command gets the registry entries in the `HKEY_CURRENT_USER\Environment` registry key:  

```powershell
Get-ItemProperty -Path hkcu:\Environment
```

 This command gets the **Default** registry entry only when it contains data.  


#### Example 2

 This command gets the **Temp** registry entry in the `HKEY_CURRENT_USER\Environment` key:  

```powershell
Get-ItemProperty -Path hkcu:\Environment -Name Temp
```


#### Example 3

 This command creates a **PSTest** registry entry in the `HKEY_CURRENT_USER\Environment` key and sets its value to 1:  

```powershell
New-ItemProperty -Path hkcu:\environment -Name PSTest -Value 1 -PropertyType dword
```


#### Example 4

 This command changes the value of the **PSTest** registry entry  in the `HKEY_CURRENT_USER\Environment` key to "Start" and changes its data type to REG_SZ (string):  

```powershell
Set-ItemProperty -Path hkcu:\environment -Name PSTest -Value Start -Type string
```


#### Example 5

 This command renames the **PSTest** registry entry in the `HKEY_CURRENT_USER\Environment` key to **PSTestNew**:  

```powershell
Rename-ItemProperty -Path hkcu:\environment -Name PSTest -NewName PSTestNew
```


#### Example 6

 This command copies the **PSTestNew** registry entry from the `HKEY_CURRENT_USER\Environment` key to the `HKEY_CURRENT_USER\Environment\testnewcopy` key:  

```powershell
Copy-ItemProperty -Path hkcu:\environment -Destination hkcu:\environment\testnewcopy -Name pstestnew
```


#### Example 7

 The command moves the **pstestnew** registry entry from the `HKEY_CURRENT_USER\environment\testnewcopy` key to the `HKEY_CURRENT_USER\environment\testnew` key:  

```powershell
Move-ItemProperty -Path hkcu:\environment\testnewcopy -Destination hkcu:\environment\testnew -Name pstestnew
```


#### Example 8

 This command clears the value of the **pstestnew** registry entry in the `HKEY_CURRENT_USER\Environment\testnew` key:  

```powershell
Clear-ItemProperty -Path hkcu:\environment\testnew -Name pstestnew
```

 You can use the [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md) cmdlet to clear the value of the default registry entry for a subkey. For example, the following command clears the value of the default entry of the `HKEY_CURRENT_USER\Environment\testnew` registry key:  

```powershell
Clear-Item -Path hkcu:\environment\testnew  
```


#### Example 9

 This command deletes the pstestnew registry entry from the `HKEY_CURRENT_USER\Environment\testnew` registry key:  

```powershell
Remove-ItemProperty -Path hkcu:\environment\testnew -Name pstestnew
```


#### Example 10

 This command changes the value of the default registry entry in the `HKEY_CURRENT_USER\Environment\testnew` key to "default value":  

```powershell
Set-ItemProperty -Path hkcu:\environment\testnew -Name "(default)" -Value "default value"
```

 You can also change the default value of a registry key by using the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet. For example, the following command updates the default value of the testnew key:  

```powershell
Set-Item -Path hkcu:\environment\testnew -Value "another default value"  
```


## Dynamic parameters

 Dynamic parameters are cmdlet parameters that are added by a Windows PowerShell provider and are available only when the cmdlet is being used in the provider-enabled drive.  


### `Type` <[Microsoft.Win32.RegistryValueKind](https://msdn.microsoft.com/library/microsoft.win32.registryvaluekind)>

 Establishes or changes the data type of a registry value. The default is `String` (REG_SZ).  

 This parameter works as designed on the [Set-ItemProperty](../../Microsoft.PowerShell.Management/Set-ItemProperty.md) cmdlet. It is also available on the [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md) cmdlet in the registry drives, but it has no effect.  

|Value|Description|  
|-----------|-----------------|  
 |  `String` | Specifies a null-terminated string. Equivalent to REG_SZ. |   
 |  `ExpandString` | Specifies a null-terminated string that contains unexpanded references to environment variables that are expanded when the value is retrieved. Equivalent to REG_EXPAND_SZ. |   
 |  `Binary` | Specifies binary data in any form. Equivalent to REG_BINARY. |   
 |  `DWord` | Specifies a 32-bit binary number. Equivalent to REG_DWORD. |   
 |  `MultiString` | Specifies an array of null-terminated strings terminated by two null characters. Equivalent to REG_MULTI_SZ. |   
 |  `QWord` | Specifies a 64-bit binary number. Equivalent to REG_QWORD. |   
 |  `Unknown` | Indicates an unsupported registry data type, such as REG_RESOURCE_LIST. |   


#### Cmdlets supported:


-   [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)  

-   [Set-ItemProperty](../../Microsoft.PowerShell.Management/Set-ItemProperty.md)  


## See also

 [about_Providers](../About/about_Providers.md)

