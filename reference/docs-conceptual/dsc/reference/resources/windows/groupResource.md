---
ms.date: 07/16/2020
ms.topic: reference
title: DSC Group Resource
description: DSC Group Resource
---
# DSC Group Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **Group** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism
to manage local groups on the target node.

[!INCLUDE [Updated DSC Resources](../../../../../includes/dsc-resources.md)]

## Syntax

```Syntax
Group [string] #ResourceName
{
    GroupName = [string]
    [ Credential = [PSCredential] ]
    [ Description = [string[]] ]
    [ Members = [string[]] ]
    [ MembersToExclude = [string[]] ]
    [ MembersToInclude = [string[]] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|GroupName |The name of the group for which you want to ensure a specific state. |
|Credential |The credentials required to access remote resources. This account must have the appropriate Active Directory permissions to add all non-local accounts to the group; otherwise, an error occurs when the configuration is executed on the target node.
|Description |The description of the group. |
|Members |Use this property to replace the current group membership with the specified members. The value of this property is an array of strings of the form `Domain\UserName`. If you set this property in a configuration, do not use either the **MembersToExclude** or **MembersToInclude** property. Doing so generates an error. |
|MembersToExclude |Use this property to remove members from the existing membership of the group. The value of this property is an array of strings of the form `Domain\UserName`. If you set this property in a configuration, do not use the **Members** property. Doing so generates an error. |
|MembersToInclude |Use this property to add members to the existing membership of the group. The value of this property is an array of strings of the form `Domain\UserName`. If you set this property in a configuration, do not use the **Members** property. Doing so will generate an error. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates if the group exists. Set this property to **Absent** to ensure that the group does not exist. Setting it to **Present** ensures that the group exists. The default value is **Present**. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

## Example 1: Ensure group is not present

The following example shows how to ensure that a group called "TestGroup" is absent.

```powershell
Group GroupExample
{
    # This removes TestGroup, if present
    # To create a new group, set Ensure to "Present"
    Ensure = "Absent"
    GroupName = "TestGroup"
}
```

## Example 2: Add domain user to local group

The following example shows how to add an Active Directory User to the local administrators group as
part of a Multi-Machine Lab build where you are already using a PSCredential for the Local
Administrator account. As this is also used for the Domain Admin Account (after Domain promotion),
we then need to convert this existing PSCredential to a Domain Friendly credential. Then we can add
a Domain User to the Local Administrators Group on the Member server.

```powershell
@{
    AllNodes = @(
        @{
            NodeName = '*';
            DomainName = 'SubTest.contoso.com';
         }
        @{
            NodeName = 'Box2';
            AdminAccount = 'Admin-Dave_Alexanderson'
        }
    )
}

$domain = $node.DomainName.split('.')[0]
$DCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ("$domain\$($credential.Username)", $Credential.Password)

Group AddADUserToLocalAdminGroup {
    GroupName='Administrators'
    Ensure= 'Present'
    MembersToInclude= "$domain\$($Node.AdminAccount)"
    Credential = $dCredential
    PsDscRunAsCredential = $DCredential
}
```

## Example 3

The following example shows how to ensure a local group, TigerTeamAdmins, on the server
TigerTeamSource.Contoso.Com does not contain a particular domain account, Contoso\JerryG.

```powershell
Configuration SecureTigerTeamSource {
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node TigerTeamSource.Contoso.Com {
        Group TigerTeamAdmins {
            GroupName        = 'TigerTeamAdmins'
            Ensure           = 'Present'
            MembersToExclude = "Contoso\JerryG"
        }
    }
}
```
