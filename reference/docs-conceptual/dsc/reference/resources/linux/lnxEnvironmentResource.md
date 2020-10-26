---
ms.date: 07/17/2020
ms.topic: reference
title: DSC for Linux nxEnvironment Resource
description: DSC for Linux nxEnvironment Resource
---
# DSC for Linux nxEnvironment Resource

The **nxEnvironment** resource in PowerShell Desired State Configuration (DSC) provides a mechanism
to manage system environment variables on a Linux node.

## Syntax

```Syntax
nxEnvironment <string> #ResourceName
{
    Name = <string>
    [ Value = <string>
    [ Path = <bool> }
    [ DependsOn = <string[]> ]
    [ Ensure = <string> { Absent | Present }  ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the name of the environment variable for which you want to ensure a specific state. |
|Value |The value to assign to the environment variable. |
|Path |Defines the environment variable that is being configured. Set this property to `$true` if the variable is the **Path** variable; otherwise, set it to `$false`. The default is `$false`. If the variable being configured is the **Path** variable, the value provided through the **Value** property will be appended to the existing value. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Determines whether to check if the variable exists. Set this property to **Present** to ensure the variable exists. Set it to **Absent** to ensure the variable does not exist. The default value is **Present**. |

## Additional Information

- If **Path** is absent or set to `$false`, environment variables are managed in `/etc/environment`.
  Your programs or scripts may require configuration to source the `/etc/environment` file to access
  the managed environment variables.
- If **Path** is set to `$true`, the environment variable is managed in the file
  `/etc/profile.d/DSCenvironment.sh`. This file will be created if it does not exist. If **Ensure**
  is set to **Absent** and **Path** is set to `$true`, an existing environment variable will only be
  removed from `/etc/profile.d/DSCenvironment.sh` and not from other files.

## Example

The following example shows how to use the **nxEnvironment** resource to ensure that
**TestEnvironmentVariable** is present and has the value "Test-Value". If
**TestEnvironmentVariable** is not present, it will be created.

```powershell
Import-DSCResource -Module nx

nxEnvironment EnvironmentExample
{
    Ensure = "Present"
    Name = "TestEnvironmentVariable"
    Value = "TestValue"
}
```
