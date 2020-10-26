---
ms.date: 07/17/2020
ms.topic: reference
title: DSC for Linux nxService Resource
description: DSC for Linux nxService Resource
---
# DSC for Linux nxService Resource

The **nxService** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to
manage services on a Linux node.

## Syntax

```Syntax
nxService <string> #ResourceName
{
    Name = <string>
    [ Controller = <string> { init | upstart | systemd } ]
    [ Enabled = <bool> ]
    [ State = <string> { Running | Stopped } ]
    [ DependsOn = <string[]> ]
}
```

## Properties

|Property |Description |
|---|---|
|Name |The name of the service/daemon to configure. |
|Controller |The type of service controller to use when configuring the service. |
|Enabled |Indicates whether the service starts on boot. |
|State |Indicates whether the service is running. Set this property to **Stopped** to ensure that the service is not running. Set it to **Running** to ensure that the service is running. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |

## Additional Information

The **nxService** resource will not create a service definition or script for the service if it does
not exist. You can use the PowerShell Desired State Configuration **nxFile** Resource resource to
manage the existence or contents of the service definition file or script.

## Example

The following example shows configuration of the 'httpd' service (for Apache HTTP Server),
registered with the **SystemD** service controller.

```powershell
Import-DSCResource -Module nx

Node $node
{
    #Apache Service
    nxService ApacheService {
        Name = 'httpd'
        State = 'running'
        Enabled = $true
        Controller = 'systemd'
    }
}
```
