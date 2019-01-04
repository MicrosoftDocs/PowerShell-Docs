---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WindowsFeatureSet Resource
---

# DSC WindowsFeatureSet Resource

> Applies To: Windows PowerShell 5.0

The **WindowsFeatureSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to ensure that roles and features are added or removed on a target node.
This resource is a [composite resource](../../../resources/authoringResourceComposite.md) that calls the [WindowsFeature resource](windowsfeatureResource.md) for each feature specified in the `Name` property.

Use this resource when you want to configure a number of Windows Features to the same state.

## Syntax

```
WindowsFeatureSet [string] #ResourceName
{
    Name = [string[]]
    [ Ensure = [string] { Absent | Present }  ]
    [ Source = [string] ]
    [ IncludeAllSubFeature = [bool] ]
    [ Credential = [PSCredential] ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]

}
```

## Properties

|  Property  |  Description   |
|---|---|
| Name| The names of the roles or features that you want to ensure are added or removed. This is the same as the **Name** property of the [Get-WindowsFeature](https://technet.microsoft.com/en-us/library/jj205469.aspx) cmdlet, and not the display name of the roles or features.|
| Credential| The credentials to use to add or remove the roles or features.|
| Ensure| Indicates whether the roles or features are added. To ensure that the roles or features are added, set this property to "Present" To ensure that the roles or features are removed, set the property to "Absent".|
| IncludeAllSubFeature| Set this property to **$true** to include all required subfeatures with of the features you specify with the **Name** property.|
| LogPath| The path to a log file where you want the resource provider to log the operation.|
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| Source| Indicates the location of the source file to use for installation, if necessary.|

## Example

The following configuration ensures that the **Web-Server** (IIS) and **SMTP Server** features, and all subfeatures of each, are installed.

```powershell
configuration FeatureSetTest
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node localhost
    {

        WindowsFeatureSet WindowsFeatureSetExample
        {
            Name                    = @("SMTP-Server", "Web-Server")
            Ensure                  = 'Present'
            IncludeAllSubFeature    = $true
        }
    }
}
```
