---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC WaitForSome Resource
---

# DSC WaitForSome Resource

> Applies To: Windows PowerShell 5.0 and later

The **WaitForSome** Desired State Configuration (DSC) resource can be used within a node block in a [DSC configuration](../../../configurations/configurations.md)
to specify dependencies on configurations on other nodes.

This resource succeeds if the resource specified by the **ResourceName** property is in the desired state on a minimum number of nodes
(specified by **NodeCount**) defined by the **NodeName** property.

> [!NOTE]
> **WaitForSome** resource uses Windows Remote Management to check the state of other Nodes.
> For more information about port and security requirements for WinRM, see
> [PowerShell Remoting Security Considerations](/powershell/scripting/learn/remoting/winrmsecurity?view=powershell-6).

## Syntax

```
WaitForSome [String] #ResourceName
{
    NodeCount = [UInt32]
    NodeName = [string[]]
    ResourceName = [string]
    [DependsOn = [string[]]]
    [PsDscRunAsCredential = [PSCredential]]
    [RetryCount = [UInt32]]
    [RetryIntervalSec = [UInt64]]
    [ThrottleLimit = [UInt32]]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| NodeCount| The minimum number of nodes that must be in the desired state for this resource to succeed.|
| NodeName| The target nodes of the resource to depend on.|
| ResourceName| The resource name to depend on. If this resource belongs to a different configuration, format the name as "[__ResourceType__]__ResourceName__::[__ConfigurationName__]::[__ConfigurationName__]"|
| RetryIntervalSec| The number of seconds before retrying. Minimum is 1.|
| RetryCount| The maximum number of times to retry.|
| ThrottleLimit| Number of machines to connect simultaneously. Default is new-cimsession default.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|
| PsDscRunAsCredential | See [Using DSC with User Credentials](https://docs.microsoft.com/powershell/dsc/runasuser) |

## Example

For an example of how to use this resource, see [Specifying cross-node dependencies](../../../configurations/crossNodeDependencies.md)
