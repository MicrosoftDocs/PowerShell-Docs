---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Group Resource
---

# DSC Group Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The Group resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage local groups on the target node.

## Syntax

```
Group [string] #ResourceName
{
    GroupName          = [string]
    [ Credential       = [PSCredential] ]
    [ Description      = [string[]] ]
    [ Ensure           = [string] { Absent | Present }  ]
    [ Members          = [string[]] ]
    [ MembersToExclude = [string[]] ]
    [ MembersToInclude = [string[]] ]
    [ DependsOn        = [string[]] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| GroupName| The name of the group for which you want to ensure a specific state.|
| Credential| The credentials required to access remote resources. **Note**: This account must have the appropriate Active Directory permissions to add all non-local accounts to the group; otherwise, an error occurs when the configuration is executed on the target node.
| Description| The description of the group.|
| Ensure| Indicates if the group exists. Set this property to "Absent" to ensure that the group does not exist. Setting it to "Present" (the default value) ensures that the group exists.|
| Members| Use this property to replace the current group membership with the specified members. The value of this property is an array of strings of the form *Domain*\\*UserName*. If you set this property in a configuration, do not use either the **MembersToExclude** or **MembersToInclude** property. Doing so generates an error.|
| MembersToExclude| Use this property to remove members from the existing membership of the group. The value of this property is an array of strings of the form *Domain*\\*UserName*. If you set this property in a configuration, do not use the **Members** property. Doing so generates an error.|
| MembersToInclude| Use this property to add members to the existing membership of the group. The value of this property is an array of strings of the form *Domain*\\*UserName*. If you set this property in a configuration, do not use the **Members** property. Doing so will generate an error.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"``.|

## Example 1

The following example shows how to ensure that a group called "TestGroup" is absent.

```powershell
Group GroupExample
{
    # This removes TestGroup, if present
    # To create a new group, set Ensure to "Present“
    Ensure = "Absent"
    GroupName = "TestGroup"
}
```

## Example 2

The following example shows how to add an Active Directory User to the local administrators group as part of a Multi-Machine Lab build where you are already using a PSCredential for the Local Administrator account.
As this is also used for the Domain Admin Account (after Domain promotion), we then need to convert this existing PSCredential to a Domain Friendly credential.
Then we can add a Domain User to the Local Administrators Group on the Member server.

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

The following example shows how to ensure a local group, TigerTeamAdmins, on the server TigerTeamSource.Contoso.Com does not contain a particular domain account, Contoso\JerryG.

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