---
ms.date: 07/16/2020
ms.topic: reference
title: DSC WindowsFeatureSet Resource
description: DSC WindowsFeatureSet Resource
---
# DSC WindowsFeatureSet Resource

> Applies To: Windows PowerShell 5.x

The **WindowsFeatureSet** resource in Windows PowerShell Desired State Configuration (DSC) provides
a mechanism to ensure that roles and features are added or removed on a target node. This resource
is a [composite resource](../../../resources/authoringResourceComposite.md) that calls the [WindowsFeature resource](windowsfeatureResource.md)
for each feature specified in the **Name** property.

Use this resource when you want to configure a number of Windows Features to the same state.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
WindowsFeatureSet [string] #ResourceName
{
    Name = [string[]]
    [ Source = [string] ]
    [ IncludeAllSubFeature = [Boolean] ]
    [ Credential = [PSCredential] ]
    [ LogPath = [string] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
|Name |The names of the roles or features that you want to ensure are added or removed. This is the same as the **Name** property of the [Get-WindowsFeature](/powershell/module/servermanager/get-windowsfeature) cmdlet, and not the display name of the roles or features. |
|Source |Indicates the location of the source file to use for installation, if necessary. |
|IncludeAllSubFeature |Set this property to `$true` to include all required subfeatures with of the features you specify with the **Name** property. |
|Credential |The credentials to use to add or remove the roles or features. |
|LogPath |The path to a log file where you want the resource provider to log the operation. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates whether the roles or features are added. To ensure that the roles or features are added, set this property to **Present**. To ensure that the roles or features are removed, set the property to **Absent**. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

The following configuration ensures that the **Web-Server** (IIS) and **SMTP Server** features, and
all subfeatures of each, are installed.

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
