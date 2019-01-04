---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Registry Resource
---
# DSC Registry Resource

_Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0_

The **Registry** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to manage registry keys and values on a target node.

## Syntax

```
Registry [string] #ResourceName
{
    Key = [string]
    ValueName = [string]
    [ Ensure = [string] { Present | Absent }  ]
    [ Force =  [bool]   ]
    [ Hex = [bool] ]
    [ DependsOn = [string[]] ]
    [ ValueData = [string[]] ]
    [ ValueType = [string] { Binary | Dword | ExpandString | MultiString | Qword | String }  ]
}
```

## Properties

| Property | Description |
| --- | --- |
| Key| Indicates the path of the registry key for which you want to ensure a specific state. This path must include the hive.|
| ValueName| Indicates the name of the registry value. To add or remove a registry key, specify this property as an empty string without specifying ValueType or ValueData. To modify or remove the default value of a registry key, specify this property as an empty string while also specifying ValueType or ValueData.|
| Ensure| Indicates if the key and value exist. To ensure that they do, set this property to "Present". To ensure that they do not exist, set the property to "Absent". The default value is "Present".|
| Force| If the specified registry key is present, **Force** overwrites it with the new value. If deleting a registry key with subkeys, this needs to be **$true** |
| Hex| Indicates if data will be expressed in hexadecimal format. If specified, the DWORD/QWORD value data is presented in hexadecimal format. Not valid for other types. The default value is **$false**.|
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| ValueData| The data for the registry value.|
| ValueType| Indicates the type of the value. The supported types are: String (REG_SZ), Binary (REG-BINARY), Dword 32-bit (REG_DWORD), Qword 64-bit (REG_QWORD), Multi-string (REG_MULTI_SZ), Expandable string (REG_EXPAND_SZ) |

## Example

This example ensures that a key named "ExampleKey" is present in the **HKEY\_LOCAL\_MACHINE** hive.

```powershell
Configuration RegistryTest
{
    Registry RegistryExample
    {
        Ensure      = "Present"  # You can also set Ensure to "Absent"
        Key         = "HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey"
        ValueName   = "TestValue"
        ValueData   = "TestData"
    }
}
```

> [!NOTE]
> Changing a registry setting in the `HKEY\CURRENT\USER` hive requires that the configuration runs
> with user credentials, rather than as the system. You can use the **PsDscRunAsCredential**
> property to specify user credentials for the configuration. For an example, see
> [Running DSC with user credentials](../../../configurations/runAsUser.md).
