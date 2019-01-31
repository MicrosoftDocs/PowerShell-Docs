---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Environment Resource
---

# DSC Environment Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The __Environment__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage system environment variables.

## Syntax
``` mof
Environment [string] #ResourceName
{
    Name = [string]
    [ Ensure = [string] { Absent | Present }  ]
    [ Path = [bool] ]
    [ DependsOn = [string[]] ]
    [ Value = [string] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| Indicates the name of the environment variable for which you want to ensure a specific state.|
| Ensure| Indicates if a variable exists. Set this property to __Present__ to create the environment variable if it does not exist or to ensure that its value matches what is provided through the __Value__ property if the variable already exists. Set it to __Absent__ to delete the variable if it exists.|
| Path| Defines the environment variable that is being configured. Set this property to __$true__ if the variable is the __Path__ variable; otherwise, set it to __$false__. The default is __$false__. If the variable being configured is the __Path__ variable, the value provided through the __Value__ property will be appended to the existing value.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| Value| The value to assign to the environment variable.|

## Example

The following example ensures that __TestEnvironmentVariable__ is present and it has the value __TestValue__. If it is not present, it creates it.

```powershell
Environment EnvironmentExample
{
    Ensure = "Present"  # You can also set Ensure to "Absent"
    Name = "TestEnvironmentVariable"
    Value = "TestValue"
}
```