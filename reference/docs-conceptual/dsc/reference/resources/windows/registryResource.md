---
ms.date: 07/16/2020
ms.topic: reference
title: DSC Registry Resource
description: DSC Registry Resource
---
# DSC Registry Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Registry** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to manage registry keys and values on a target node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Registry [string] #ResourceName
{
    Key = [string]
    ValueName = [string]
    [ Force =  [bool]   ]
    [ Hex = [bool] ]
    [ ValueData = [string[]] ]
    [ ValueType = [string] { Binary | Dword | ExpandString | MultiString | Qword | String }  ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Present | Absent }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Key |Indicates the path of the registry key for which you want to ensure a specific state. This path must include the hive. |
|ValueName |Indicates the name of the registry value. To add or remove a registry key, specify this property as an empty string without specifying **ValueType** or **ValueData**. To modify or remove the default value of a registry key, specify this property as an empty string while also specifying **ValueType** or **ValueData**. |
|Force |If the specified registry key is present, **Force** overwrites it with the new value. If deleting a registry key with subkeys, this needs to be `$true`. |
|Hex |Indicates if data will be expressed in hexadecimal format. If specified, the DWORD/QWORD value data is presented in hexadecimal format. Not valid for other types. The default value is `$false`. |
|ValueData |The data for the registry value. |
|ValueType |Indicates the type of the value. The supported types are: **String** (REG_SZ), **Binary** (REG-BINARY), **Dword** (32-bit REG_DWORD), **Qword** (64-bit REG_QWORD), **MultiString** (REG_MULTI_SZ), **ExpandString** (REG_EXPAND_SZ). |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates if the key and value exist. To ensure that they do, set this property to **Present**. To ensure that they do not exist, set the property to **Absent**. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Examples

### Example 1: Ensure specified Value and Data under specified registry key

This example ensures that the registry value "TestValue" under a key named "ExampleKey1" is present in the `HKEY\_LOCAL\_MACHINE` hive and has the data "TestData".

```powershell
Configuration RegistryTest
{
    Registry RegistryExample
    {
        Ensure      = "Present"  # You can also set Ensure to "Absent"
        Key         = "HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey1"
        ValueName   = "TestValue"
        ValueData   = "TestData"
    }
}
```

### Example 2: Ensure specified registry key exists

This example ensures that a key named "ExampleKey2" is present in the **HKEY\_LOCAL\_MACHINE** hive.

```powershell
Configuration RegistryTest
{
    Registry RegistryExample
    {
        Ensure      = "Present"  # You can also set Ensure to "Absent"
        Key         = "HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey2"
        ValueName   = ""
    }
}
```

> [!NOTE]
> Changing a registry setting in the `HKEY_CURRENT_USER` hive requires that the configuration runs
> with user credentials, rather than as the system. You can use the **PsDscRunAsCredential**
> property to specify user credentials for the configuration. For an example, see
> [Running DSC with user credentials](../../../configurations/runAsUser.md).
