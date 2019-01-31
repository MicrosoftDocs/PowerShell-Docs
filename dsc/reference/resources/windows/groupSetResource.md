---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
description:  Provides a mechanism to manage local groups on the target node.
title:  DSC GroupSet Resource
---
# DSC GroupSet Resource

> Applies To: Windows PowerShell 5.0

The **GroupSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage local groups on the target node. This resource is a
[composite resource](../../../resources/authoringResourceComposite.md) that calls the [Group resource](groupResource.md) for each group specified in the `GroupName` parameter.

Use this resource when you want to add and/or remove the same list of members to more than one group, remove more than one group, or add more than one group with the same list of members.

## Syntax

```
Group [string] #ResourceName
{
    GroupName = [string[]]
    [ Ensure = [string] { Absent | Present }  ]
    [ MembersToInclude = [string[]] ]
    [ MembersToExclude = [string[]] ]
    [ Credential = [PSCredential] ]
    [ DependsOn = [string[]] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| GroupName| The names of the groups for which you want to ensure a specific state.|
| MembersToExclude| Use this property to remove members from the existing membership of the groups. The value of this property is an array of strings of the form *Domain*\\*UserName*. If you set this property in a configuration, do not use the **Members** property. Doing so will generate an error.|
| Credential| The credentials required to access remote resources. **Note**: This account must have the appropriate Active Directory permissions to add all non-local accounts to the group; otherwise, an error will occur.
| Ensure| Indicates whether the groups exist. Set this property to "Absent" to ensure that the groups do not exist. Setting it to "Present" (the default value) ensures that the groups exist.|
| Members| Use this property to replace the current group membership with the specified members. The value of this property is an array of strings of the form *Domain*\\*UserName*. If you set this property in a configuration, do not use either the **MembersToExclude** or **MembersToInclude** property. Doing so will generate an error.|
| MembersToInclude| Use this property to add members to the existing membership of the group. The value of this property is an array of strings of the form *Domain*\\*UserName*. If you set this property in a configuration, do not use the **Members** property. Doing so will generate an error.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"``.|

## Example 1: Ensuring Groups are present

The following example shows how to ensure that two groups called "myGroup" and "myOtherGroup" are present.

```powershell
configuration GroupSetTest
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node localhost
    {
        GroupSet GroupSetTest
        {
            GroupName        = @("myGroup", "myOtherGroup")
            Ensure           = "Present"
            MembersToInclude = @("contoso\alice", "contoso\bob")
            MembersToExclude = $("contoso\john")
            Credential       = Get-Credential
        }
    }
}
$cd = @{
    AllNodes = @(
        @{
            NodeName                    = 'localhost'
            PSDscAllowPlainTextPassword = $true
            PSDscAllowDomainUser        = $true
        }
    )
}

GroupSetTest -ConfigurationData $cd
```

> [!NOTE]
> This example uses plaintext credentials for simplicity. For information about how to encrypt credentials in the configuration MOF file, see [Securing the MOF File](../../../pull-server/secureMOF.md).
