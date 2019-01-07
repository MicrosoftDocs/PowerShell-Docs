---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WindowsFeature Resource
---

# DSC WindowsFeature Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **WindowsFeature** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to ensure that roles and features are added or removed on a target node.

## Syntax

```
WindowsFeature [string] #ResourceName
{
    Name = [string]
    [ Credential = [PSCredential] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ IncludeAllSubFeature = [bool] ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]
    [ Source = [string] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| Indicates the name of the role or feature that you want to ensure is added or removed. This is the same as the __Name__ property from the [Get-WindowsFeature](/powershell/module/servermanager/Get-WindowsFeature) cmdlet, and not the display name of the role or feature.|
| Credential| Indicates the credentials to use to add or remove the role or feature.|
| Ensure| Indicates if the role or feature is added. To ensure that the role or feature is added, set this property to "Present" To ensure that the role or feature is removed, set the property to "Absent".|
| IncludeAllSubFeature| Set this property to __$true__ to ensure the state of all required subfeatures with the state of the feature you specify with the __Name__ property.|
| LogPath| Indicates the path to a log file where you want the resource provider to log the operation.|
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| Source| Indicates the location of the source file to use for installation, if necessary.|

## Example
```powershell
WindowsFeature RoleExample
{
    Ensure = "Present"
    # Alternatively, to ensure the role is uninstalled, set Ensure to "Absent"
    Name = "Web-Server" # Use the Name property from Get-WindowsFeature
}
```