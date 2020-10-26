---
ms.date: 07/17/2020
ms.topic: reference
title: DSC for Linux nxSshAuthorizedKeys Resource
description: DSC for Linux nxSshAuthorizedKeys Resource
---
# DSC for Linux nxSshAuthorizedKeys Resource

The **nxAuthorizedKeys** resource in PowerShell Desired State Configuration (DSC) provides a
mechanism to manage authorized ssh keys for a specified user.

## Syntax

```Syntax
nxAuthorizedKeys <string> #ResourceName
{
    KeyComment = <string>
    [ Username = <string> ]
    [ Key = <string> ]
    [ DependsOn = <string[]> ]
    [ Ensure = <string> { Absent | Present }  ]
}
```

## Properties

|Property |Description |
|---|---|
|KeyComment |A unique comment for the key. This is used to uniquely identify keys. |
|Username |The username to manage ssh authorized keys for. If not defined, the default user is **root**. |
|Key |The contents of the key. This is required if **Ensure** is set to **Present**.|

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Specifies whether the key is defined. Set this property to **Absent** to ensure the key does not exist in the user's authorized keys file. Set it to **Present** to ensure the key is defined in the user's authorized key file. |

## Example

The following example defines a public ssh authorized key for the user "monuser".

```powershell
Import-DSCResource -Module nx

Node $node
{
    nxSshAuthorizedKeys myKey
    {
        KeyComment = "myKey"
        Ensure = "Present"
        Key = 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA0b+0xSd07QXRifm3FXj7Pn/DblA6QI5VAkDm6OivFzj3U6qGD1VJ6AAxWPCyMl/qhtpRtxZJDu/TxD8AyZNgc8aN2CljN1hOMbBRvH2q5QPf/nCnnJRaGsrxIqZjyZdYo9ZEEzjZUuMDM5HI1LA9B99k/K6PK2Bc1NLivpu7nbtVG2tLOQs+GefsnHuetsRMwo/+c3LtwYm9M0XfkGjYVCLO4CoFuSQpvX6AB3TedUy6NZ0iuxC0kRGg1rIQTwSRcw+McLhslF0drs33fw6tYdzlLBnnzimShMuiDWiT37WqCRovRGYrGCaEFGTG2e0CN8Co8nryXkyWc6NSDNpMzw== rsa-key-20150401'
        UserName = "monuser"
    }
}
```
