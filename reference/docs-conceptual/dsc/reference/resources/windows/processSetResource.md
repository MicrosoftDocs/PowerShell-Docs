---
ms.date: 07/16/2020
ms.topic: reference
title: DSC ProcessSet Resource
description: DSC ProcessSet Resource
---
# DSC ProcessSet Resource

> Applies To: Windows PowerShell 5.x

The **ProcessSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to configure processes on a target node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
ProcessSet [string] #ResourceName
{
    Path = [string]
    [ Credential = [PSCredential] ]
    [ StandardOutputPath = [string] ]
    [ StandardErrorPath = [string] ]
    [ StandardInputPath = [string] ]
    [ WorkingDirectory = [string] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Path |The path to the process executable. If these are the names of the executable files (not fully qualified paths), the DSC resource will search the environment `$env:Path` variable to find the files. If the values of this property are fully qualified paths, DSC will not use the `$env:Path` environment variable to find the files, and will throw an error if any of the paths do not exist. Relative paths are not allowed. |
|Credential |Indicates the credentials for starting the process. |
|StandardErrorPath |The path to which the processes write standard error. Any existing file there will be overwritten. |
|StandardInputPath |The stream from which the process receives standard input. |
|StandardOutputPath |The path of the file to which the processes write standard output. Any existing file there will be overwritten. |
|WorkingDirectory |The location used as the current working directory for the processes. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Specifies whether the processes exists. Set this property to **Present** to ensure that the process exists. Otherwise, set it to **Absent**. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).
