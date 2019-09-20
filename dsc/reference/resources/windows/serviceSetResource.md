---
ms.date: 09/20/2019
keywords: dsc,powershell,configuration,setup
title: DSC ServiceSet Resource
---
# DSC ServiceSet Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **ServiceSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to manage services on the target node. This resource is a [composite resource](../../../resources/authoringResourceComposite.md)
that calls the [Service resource](serviceResource.md) for each service specified in the **Name**
property.

Use this resource when you want to configure a number of services to the same state.

## Syntax

```MOF
ServiceSet [string] #ResourceName
{
    Name = [string[]]
    [ StartupType = [string] { Automatic | Disabled | Manual }  ]
    [ BuiltInAccount = [string] { LocalService | LocalSystem | NetworkService }  ]
    [ State = [string] { Running | Stopped }  ]
    [ Credential = [PSCredential] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the service names. Note that sometimes this is different from the display names. You can get a list of the services and their current state with the `Get-Service` cmdlet. |
|StartupType |Indicates the startup type for the services. The values that are allowed for this property are: _Automatic_, _Disabled_, and _Manual_. |
|BuiltInAccount |Indicates the sign-in account to use for the services. The values that are allowed for this property are: _LocalService_, _LocalSystem_, and _NetworkService_. |
|State |Indicates the state you want to ensure for the services: _Stopped_ or _Running_. |
|Credential |Indicates credentials for the account that the service resource will run under. This property and the **BuiltinAccount** property cannot be used together. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates whether the services exist on the system. Set this property to _Absent_ to ensure that the services do not exist. Setting it to _Present_ ensures that target services exist. The default value is _Present_. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

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