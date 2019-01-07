---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WindowsOptionalFeature Resource
---

# DSC WindowsOptionalFeature Resource

> Applies To: Windows PowerShell 5.0

The **WindowsOptionalFeature** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to ensure that optional features are enabled on a target node.

## Syntax

```
WindowsOptionalFeature [string] #ResourceName
{
    Name = [string]
    [ Ensure = [string] { Enable | Disable }  ]
    [ Source = [string] ]
    [ NoWindowsUpdateCheck = [bool] ]
    [ RemoveFilesOnDisable = [bool] ]
    [ LogLevel = [string] { ErrorsOnly | ErrorsAndWarning | ErrorsAndWarningAndInformation }  ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]

}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| Indicates the name of the feature that you want to ensure is enabled or disabled.|
| Ensure| Specifies whether the feature is enabled. To ensure that the feature is enabled, set this property to "Enable" To ensure that the feature is disabled, set the property to "Disable".|
| Source| Not implemented.|
| NoWindowsUpdateCheck| Specifies whether DISM contacts Windows Update (WU) when searching for the source files to enable a feature. If $true, DISM does not contact WU.|
| RemoveFilesOnDisable| Set to **$true** to remove all files associated with the feature when it is disabled (that is, when **Ensure** is set to "Absent").|
| LogLevel| The maximum output level shown in the logs. The accepted values are: "ErrorsOnly" (only errors are logged), "ErrorsAndWarning" (errors and warnings are logged), and "ErrorsAndWarningAndInformation" (errors, warnings, and debug information are logged).|
| LogPath| The path to a log file where you want the resource provider to log the operation.|
| DependsOn| Specifies that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|