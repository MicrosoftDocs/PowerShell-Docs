---
ms.date: 08/28/2020
ms.topic: reference
title: DSC WindowsOptionalFeature Resource
description: DSC WindowsOptionalFeature Resource
---
# DSC WindowsOptionalFeature Resource

> Applies To: Windows PowerShell 5.x

The **WindowsOptionalFeature** resource in Windows PowerShell Desired State Configuration (DSC)
provides a mechanism to ensure that optional features are enabled on a target node.

> [!NOTE]
> **WindowsOptionalFeature** only works on Windows client machines like Windows 10.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
WindowsOptionalFeature [string] #ResourceName
{
    Name = [string]
    [ NoWindowsUpdateCheck = [bool] ]
    [ RemoveFilesOnDisable = [bool] ]
    [ LogLevel = [string] { ErrorsOnly | ErrorsAndWarning | ErrorsAndWarningAndInformation }  ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Enable | Disable }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the name of the feature that you want to ensure is enabled or disabled. |
|NoWindowsUpdateCheck |Specifies whether DISM contacts Windows Update (WU) when searching for the source files to enable a feature. If `$true`, DISM does not contact WU. |
|RemoveFilesOnDisable |Set to `$true` to remove all files associated with the feature when **Ensure** is set to **Absent**. |
|LogLevel |The maximum output level shown in the logs. The accepted values are: **ErrorsOnly**, **ErrorsAndWarning**, and **ErrorsAndWarningAndInformation**. |
|LogPath |The path to a log file where you want the resource provider to log the operation. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Specifies whether the feature is enabled. To ensure that the feature is enabled, set this property to _Enable_. To ensure that the feature is disabled, set the property to _Disable_. The default value is _Enable_. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).
