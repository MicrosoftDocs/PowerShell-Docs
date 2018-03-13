---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  DSC ServiceSet Resource
---

# DSC ServiceSet Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0


The **ServiceSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage services on the target node. This resource is a 
[composite resource](authoringResourceComposite.md) that calls the [Service resource](serviceResource.md) for each service specified in the `Name` property.

Use this resource when you want to configure a number of services to the same state.

## Syntax

```
Service [string] #ResourceName
{
    Name = [string[]]
    [ StartupType = [string] { Automatic | Disabled | Manual }  ]
    [ BuiltInAccount = [string] { LocalService | LocalSystem | NetworkService }  ]
    [ State = [string] { Running | Stopped }  ]
    [ Ensure = [string] { Absent | Present }  ]
    [ Credential = [PSCredential] ]
    [ DependsOn = [string[]] ]
    
}
```

## Properties

|  Property  |  Description   | 
|---|---| 
| Name| Indicates the service names. Note that sometimes this is different from the display names. You can get a list of the services and their current state with the [Get-Service](https://technet.microsoft.com/library/hh849804.aspx) cmdlet.|
| StartupType| Indicates the startup type for the service. The values that are allowed for this property are: **Automatic**, **Disabled**, and **Manual**|  
| BuiltInAccount| Indicates the sign-in account to use for the services. The values that are allowed for this property are: **LocalService**, **LocalSystem**, and **NetworkService**.| 
| State| Indicates the state you want to ensure for the services: **Stopped** or **Running**.| 
| Ensure| Indicates whether the services exist on the system. Set this property to **Absent** to ensure that the services do not exist. Setting it to **Present** (the default value) ensures that target services exist.|
| Credential| Indicates credentials for the account that the service resource will run under. This property and the **BuiltinAccount** property cannot be used together.| 
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is *ResourceName* and its type is *ResourceType*, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 



## Example

The following configuration starts the "Windows Audio" and "Remote Desktop Services" services.

```powershell
configuration ServiceSetTest
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node localhost
    {

        ServiceSet ServiceSetExample
        {
            Name        = @("TermService", "Audiosrv")
            StartupType = "Manual"
            State       = "Running"
        } 
    }
}
```

