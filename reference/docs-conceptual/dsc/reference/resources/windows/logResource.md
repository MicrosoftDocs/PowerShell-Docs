---
ms.date: 07/16/2020
ms.topic: reference
title: DSC Log Resource
description: DSC Log Resource
---
# DSC Log Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Log** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to
write messages to the Microsoft-Windows-Desired State Configuration/Analytic event log.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Log [string] #ResourceName
{
    Message = [string]
    [ DependsOn = [string[]] ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

> [!NOTE]
> By default only the Operational logs for DSC are enabled. Before the Analytic log will be
> available or visible, it must be enabled. For more information, see [Where are DSC Event Logs?](../../../troubleshooting/troubleshooting.md#where-are-dsc-event-logs).

## Properties

| Property |                                                   Description                                                    |
| -------- | ---------------------------------------------------------------------------------------------------------------- |
| Message  | Indicates the message you want to write to the Microsoft-Windows-Desired State Configuration/Analytic event log. |

## Common properties

|       Property       |                                                                                                                                                          Description                                                                                                                                                           |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| DependsOn            | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
| PsDscRunAsCredential | Sets the credential for running the entire resource as.                                                                                                                                                                                                                                                                        |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

The following example shows how to include a message in the Microsoft-Windows-Desired State
Configuration/Analytic event log.

> [!NOTE]
> If you run [Test-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/test-dscconfiguration)
> with this resource configured, it will always return **$false**.

```powershell
Configuration logResourceTest
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        Log LogExample
        {
            Message = 'This message will appear in the Microsoft-Windows-Desired State Configuration/Analytic event log.'
        }
    }
}
```
