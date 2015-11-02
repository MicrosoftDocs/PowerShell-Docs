# DSC Registry Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **Registry** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage registry keys and values on a target node.

## Syntax

```
Registry [string] #ResourceName
{
    Key = [string]
    ValueName = [string]
    [ Ensure = [string] { Absent | Present }  ]
    [ Force =  [bool]   ]
    [ Hex = [bool] ]
    [ DependsOn = [string[]] ]
    [ ValueData = [string[]] ]
    [ ValueType = [string] { Binary | Dword | ExpandString | MultiString | Qword | String }  ]
}
```

## Properties
|  Property  |  Description   | 
|---|---| 
| Key| Indicates the path of the registry key for which you want to ensure a specific state. This path must include the hive.| 
| ValueName| Indicates the name of the registry value.| 
| Ensure| Indicates if the key and value exist. To ensure that they do, set this property to "Present". To ensure that they do not exist, set the property to "Absent". The default value is "Present".| 
| Force| If the specified registry key is present, __Force__ overwrites it with the new value.| 
| Hex| Indicates if data will be expressed in hexadecimal format. If specified, the DWORD/QWORD value data is presented in hexadecimal format. Not valid for other types. The default value is __$false__.| 
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 
| ValueData| The data for the registry value.| 
| ValueType| Indicates the type of the value. The supported types are: 
<ul><li>String (REG_SZ)</li>


<li>Binary (REG-BINARY)</li>


<li>Dword 32-bit (REG_DWORD)</li>


<li>Qword 64-bit (REG_QWORD)</li>


<li>Multi-string (REG_MULTI_SZ)</li>


<li>Expandable string (REG_EXPAND_SZ)</li></ul>

## Example
```powershell
Registry RegistryExample
{
    Ensure = "Present"  # You can also set Ensure to "Absent"
    Key = "HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey"
    ValueName = "TestValue"
    ValueData = "TestData"
}
```

