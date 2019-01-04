---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WindowsOptionalFeatureSet Resource
---

# DSC WindowsOptionalFeatureSet Resource

> Applies To: Windows PowerShell 5.0

The **WindowsOptionalFeatureSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to ensure that optional features are enabled on a target node.
This resource is a [composite resource](../../../resources/authoringResourceComposite.md) that calls the [WindowsOptionalFeature resource](windowsOptionalFeatureResource.md) for each feature specified in
the `Name` property.

Use this resource when you want to configure a number of Windows optional features to the same state.

## Syntax

```
WindowsOptionalFeature [string] #ResourceName
{
    Name = [string[]]
    [ Ensure = [string] { Enable | Disable }  ]
    [ Source = [string] ]
    [ RemoveFilesOnDisable = [bool] ]
    [ LogPath = [string] ]
    [ NoWindowsUpdateCheck = [bool] ]
    [ LogLevel = [string] { ErrorsOnly | ErrorsAndWarning | ErrorsAndWarningAndInformation }  ]
    [ DependsOn = [string[]] ]

}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| Indicates the name of the features that you want to ensure are enabled or disabled.|
| Ensure| Specifies whether the features are enabled. To ensure that the features are enabled, set this property to "Enable" To ensure that the features are disabled, set the property to "Disable".|
| Source| Not implemented.|
| NoWindowsUpdateCheck| Specifies whether DISM contacts Windows Update (WU) when searching for the source files to enable features. If $true, DISM does not contact WU.|
| RemoveFilesOnDisable| Set to **$true** to remove all files associated with the features when they are disabled (that is, when **Ensure** is set to "Absent").|
| LogLevel| The maximum output level shown in the logs. The accepted values are: "ErrorsOnly" (only errors are logged), "ErrorsAndWarning" (errors and warnings are logged), and "ErrorsAndWarningAndInformation" (errors, warnings, and debug information are logged).|
| LogPath| The path to a log file where you want the resource provider to log the operation.|
| DependsOn| Specifies that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
