---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Specifying cross-node dependencies
description: DSC provides special resources that are used in configurations to specify dependencies on configurations on other nodes.
---

# Specifying cross-node dependencies

> Applies To: Windows PowerShell 5.0

DSC provides special resources, **WaitForAll**, **WaitForAny**, and **WaitForSome** that can be used
in configurations to specify dependencies on configurations on other nodes. The behavior of these
resources is as follows:

- **WaitForAll**: Succeeds if the specified resource is in the desired state on all target nodes
  defined in the **NodeName** property.
- **WaitForAny**: Succeeds if the specified resource is in the desired state on at least one of the
  target nodes defined in the **NodeName** property.
- **WaitForSome**: Specifies a **NodeCount** property in addition to a **NodeName** property. The
  resource succeeds if the resource is in the desired state on a minimum number of nodes (specified
  by **NodeCount**) defined by the **NodeName** property.

## Syntax

The **WaitForAll** and **WaitForAny** resources share the same syntax. Replace `<ResourceType>` in
the example below with either **WaitForAny** or **WaitForAll**. Like the **DependsOn** keyword, you
will need to format the name as `[ResourceType]ResourceName`. If the resource belongs to a separate
[Configuration](configurations.md), include the **ConfigurationName** in the formatted string
`[ResourceType]ResourceName::[ConfigurationName]::[ConfigurationName]`. The **NodeName** is the
computer, or Node, on which the current resource should wait.

```
<ResourceType> [string] #ResourceName
{
    ResourceName = [string]
    NodeName = [string]
    [ DependsOn = [string[]] ]
    [ PsDscRunAsCredential = [PSCredential]]
    [ RetryCount = [Uint32] ]
    [ RetryIntervalSec = [Uint64] ]
    [ ThrottleLimit = [Uint32]]
}
```

The **WaitForSome** resource has a similar syntax to the example above, but adds the **NodeCount**
key. The **NodeCount** indicates how many Nodes the current resource should wait on.

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

All **WaitForXXXX** share the following syntax keys.

|       Property       |                                                                           Description                                                                           |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RetryIntervalSec     | The number of seconds before retrying. Minimum is 1.                                                                                                            |
| RetryCount           | The maximum number of times to retry.                                                                                                                           |
| ThrottleLimit        | Number of machines to connect simultaneously. Default is `New-CimSession` default.                                                                              |
| DependsOn            | Indicates that the configuration of another resource must run before this resource is configured. For more information, see [DependsOn](resource-depends-on.md) |
| PsDscRunAsCredential | See [Using DSC with User Credentials](./runAsUser.md)                                                                                                           |

## Using WaitForXXXX resources

Each **WaitForXXXX** resource waits for the specified resources to complete on the specified Node.
Other resources in the same Configuration can then *depend on* the **WaitForXXXX** resource using
the **DependsOn** key.

For example, in the following configuration, the target node is waiting for the **xADDomain**
resource to finish on the **MyDC** node with maximum number of 30 retries, at 15-second intervals,
before the target node can join the domain.

By default the **WaitForXXX** resources try one time and then fail. Although it is not required, you
will typically want to specify a **RetryCount** and **RetryIntervalSec**.

```powershell
Configuration JoinDomain
{
    Import-DscResource -Module xComputerManagement, xActiveDirectory

    Node myDC
    {
        WindowsFeature InstallAD
        {
            Ensure = 'Present'
            Name = 'AD-Domain-Services'
        }

        xADDomain NewDomain
        {
            DomainName = 'Contoso.com'
            DomainAdministratorCredential = (Get-Credential)
            SafemodeAdministratorPassword = (Get-Credential)
            DatabasePath = "C:\Windows\NTDS"
            LogPath = "C:\Windows\NTDS"
            SysvolPath = "C:\Windows\Sysvol"
        }
    }

    Node myDomainJoinedServer
    {
        WaitForAll DC
        {
            ResourceName      = '[xADDomain]NewDomain'
            NodeName          = 'MyDC'
            RetryIntervalSec  = 15
            RetryCount        = 30
        }

        xComputer JoinDomain
        {
            Name             = 'myPC'
            DomainName       = 'Contoso.com'
            Credential       = (Get-Credential)
            DependsOn        ='[WaitForAll]DC'
        }
    }
}
```

When you compile the Configuration, two ".mof" files are generated. Apply both ".mof" files to the
target Nodes using the
[Start-DSCConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration)
cmdlet

> [!NOTE]
> **WaitForXXX** resources use Windows Remote Management to check the state of other Nodes. For more
> information about port and security requirements for WinRM, see
> [PowerShell Remoting Security Considerations](/powershell/scripting/learn/remoting/winrmsecurity).

## See Also

- [DSC Configurations](configurations.md)
- [Use Resource Dependencies](resource-depends-on.md)
- [DSC Resources](../resources/resources.md)
- [Configuring The Local Configuration Manager](../managing-nodes/metaConfig.md)
