---
ms.date: 07/16/2020
ms.topic: reference
title: DSC WindowsFeature Resource
description: DSC WindowsFeature Resource
---
# DSC WindowsFeature Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **WindowsFeature** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to ensure that roles and features are added or removed on a target node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
WindowsFeature [string] #ResourceName
{
    Name = [string]
    [ Credential = [PSCredential] ]
    [ IncludeAllSubFeature = [bool] ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the name of the role or feature that you want to ensure is added or removed. This is the same as the **Name** property from the [Get-WindowsFeature](/powershell/module/servermanager/Get-WindowsFeature) cmdlet, and not the display name of the role or feature. |
|Credential |Indicates the credentials to use to add or remove the role or feature. |
|IncludeAllSubFeature |Set this property to `$true` to ensure the state of all required subfeatures with the state of the feature you specify with the **Name** property. |
|LogPath |Indicates the path to a log file where you want the resource provider to log the operation. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates if the role or feature is added. To ensure that the role or feature is added, set this property to **Present**. To ensure that the role or feature is removed, set the property to **Absent**. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

```powershell
WindowsFeature RoleExample
{
    Ensure = "Present"
    # Alternatively, to ensure the role is uninstalled, set Ensure to "Absent"
    Name = "Web-Server" # Use the Name property from Get-WindowsFeature
}
```
