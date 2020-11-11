---
ms.date: 07/16/2020
ms.topic: reference
title: DSC WaitForAny Resource
description: DSC WaitForAny Resource
---
# DSC WaitForAny Resource

> Applies To: Windows PowerShell 5.1

The **WaitForAny** Desired State Configuration (DSC) resource can be used within a node block in a [DSC configuration](../../../configurations/configurations.md)
to specify dependencies on configurations on other nodes.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

This resource succeeds if the resource specified by the **ResourceName** property is in the desired
state on any target nodes defined in the **NodeName** property.

> [!NOTE]
> **WaitForAny** resource uses Windows Remote Management to check the state of other Nodes. For more
> information about port and security requirements for WinRM, see
> [PowerShell Remoting Security Considerations](/powershell/scripting/learn/remoting/winrmsecurity).

## Syntax

```Syntax
WaitForAny [string] #ResourceName
{
    ResourceName = [string]
    NodeName = [string[]]
    [ RetryIntervalSec = [Uint64] ]
    [ RetryCount = [Uint32] ]
    [ ThrottleLimit = [Uint32]]
    [ DependsOn = [string[]] ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|ResourceName |The resource name to depend on. If this resource belongs to a different configuration, format the name as `[ResourceType]ResourceName::[ConfigurationName]::[ConfigurationName]`. |
|NodeName |The target nodes of the resource to depend on. |
|RetryIntervalSec |The number of seconds before retrying. Minimum is 1. |
|RetryCount |The maximum number of times to retry. |
|ThrottleLimit |Number of machines to connect simultaneously. Default is `New-CimSession` default. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example

For an example of how to use this resource, see [Specifying cross-node dependencies](../../../configurations/crossNodeDependencies.md)
