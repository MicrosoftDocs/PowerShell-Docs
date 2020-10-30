---
ms.date: 09/20/2019
ms.topic: reference
title: DSC Service Resource
description: DSC Service Resource
---
# DSC Service Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Service** resource in Windows PowerShell Desired State Configuration (DSC) provides a
mechanism to manage services on the target node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Service [string] #ResourceName
{
    Name = [string]
    [ BuiltInAccount = [string] { LocalService | LocalSystem | NetworkService }  ]
    [ Credential = [PSCredential] ]
    [ StartupType = [string] { Automatic | Disabled | Manual }  ]
    [ State = [string] { Ignore | Running | Stopped }  ]
    [ Dependencies = [string[]] ]
    [ Description = [string] ]
    [ DisplayName = [string] ]
    [ Path = [string] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present } ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |Indicates the service name. Note that sometimes this is different from the display name. You can get a list of the services and their current state with the `Get-Service` cmdlet. |
|BuiltInAccount |Indicates the sign-in account to use for the service. The values that are allowed for this property are: **LocalService**, **LocalSystem**, and **NetworkService**. |
|Credential |Indicates credentials for the account that the service will run under. This property and the **BuiltinAccount** property cannot be used together. |
|StartupType |Indicates the startup type for the service. The values that are allowed for this property are: **Automatic**, **Disabled**, and **Manual**. |
|State |Indicates the state you want to ensure for the service. The values are: **Running** or **Stopped**. |
|Dependencies | An array of the names of the dependencies the service should have. |
|Description |Indicates the description of the target service. |
|DisplayName |Indicates the display name of the target service. |
|Path |Indicates the path to the binary file for a new service. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates whether the target service exists on the system. Set this property to **Absent** to ensure that the target service does not exist. Setting it to **Present** ensures that target service exists. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

```powershell
configuration ServiceTest
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node localhost
    {

        Service ServiceExample
        {
            Name        = "TermService"
            StartupType = "Manual"
            State       = "Running"
        }
    }
}
```
