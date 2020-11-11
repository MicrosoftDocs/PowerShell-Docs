---
ms.date: 07/16/2020
ms.topic: reference
title: DSC Environment Resource
description: DSC Environment Resource
---
# DSC Environment Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Environment** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to manage system environment variables.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Environment [string] #ResourceName
{
    Name = [string]
    [ Path = [bool] ]
    [ Value = [string] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the name of the environment variable for which you want to ensure a specific state. |
|Path |Defines the environment variable that is being configured. Set this property to `$true` if the variable is the **Path** variable; otherwise, set it to `$false`. The default is `$false`. If the variable being configured is the **Path** variable, the value provided through the **Value** property will be appended to the existing value. |
|Value |The value to assign to the environment variable. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates if a variable exists. Set this property to **Present** to create the environment variable if it does not exist or to ensure that its value matches what is provided through the **Value** property if the variable already exists. Set it to **Absent** to delete the variable if it exists. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

The following example ensures that TestEnvironmentVariable is present and it has the value
_TestValue_. If it is not present, it creates it.

```powershell
Environment EnvironmentExample
{
    Ensure = "Present"  # You can also set Ensure to "Absent"
    Name = "TestEnvironmentVariable"
    Value = "TestValue"
}
```
