---
ms.date: 09/20/2019
keywords: dsc,powershell,configuration,setup
title: DSC WindowsOptionalFeatureSet Resource
---
# DSC WindowsOptionalFeatureSet Resource

> Applies To: Windows PowerShell 5.x

The **WindowsOptionalFeatureSet** resource in Windows PowerShell Desired State Configuration (DSC)
provides a mechanism to ensure that optional features are enabled on a target node. This resource is
a [composite resource](../../../resources/authoringResourceComposite.md) that calls the [WindowsOptionalFeature resource](windowsOptionalFeatureResource.md)
for each feature specified in the **Name** property.

Use this resource when you want to configure a number of Windows optional features to the same state.

## Syntax

```MOF
WindowsOptionalFeatureSet [string] #ResourceName
{
    Name = [string[]]
    [ Source = [string] ]
    [ RemoveFilesOnDisable = [bool] ]
    [ LogPath = [string] ]
    [ NoWindowsUpdateCheck = [bool] ]
    [ LogLevel = [string] { ErrorsOnly | ErrorsAndWarning | ErrorsAndWarningAndInformation }  ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Enable | Disable }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the name of the features that you want to ensure are enabled or disabled. |
|Source |Not implemented. |
|NoWindowsUpdateCheck |Specifies whether DISM contacts Windows Update (WU) when searching for the source files to enable features. If _$true_, DISM does not contact WU. |
|RemoveFilesOnDisable |Set to _$true_ to remove all files associated with the features when **Ensure** is set to _Absent_. |
|LogLevel |The maximum output level shown in the logs. The accepted values are: _ErrorsOnly_, _ErrorsAndWarning_, and _ErrorsAndWarningAndInformation_. |
|LogPath |The path to a log file where you want the resource provider to log the operation. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Specifies whether the features are enabled. To ensure that the features are enabled, set this property to _Enable_. To ensure that the features are disabled, set the property to _Disable_. The default value is _Enable_. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).