---
title:   DSC GroupSet Resource
ms.date:  2016-05-16
keywords:  powershell, DSC, built-in, resource
description:  Provides a mechanism to manage local groups on the target node.
ms.topic:  article
author:  eslesar
manager:  dongill
ms.prod:  powershell
---

# DSC Group Resource

> Applies To: Windows Windows PowerShell 5.0

The **GroupSet** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage local groups on the target node. This resource is a 
[composite resource](authoringResourceComposite.md) that calls the [Group resource](groupResource.md) for each group specified in the `GroupName` parameter.

Use this resource when you want to add and/or remove the same list of members to more than one group.

##Syntax##
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

## Example 1

The following example shows how to ensure that a group called "TestGroup" is absent. 

```powershell
Group GroupExample
{
    # This will remove TestGroup, if present
    # To create a new group, set Ensure to "Present“
    Ensure = "Absent"
    GroupName = "TestGroup"
}
```
## Example 2
The following example shows how to add an Active Directory User to the local administrators group as part of a Multi-Machine Lab build where you are already using a PSCredential for the Local Adminstrator account. As this is also used for the Domain Admin Account (after Domain promotion) we then need to convert this existing PSCredential to a Domain Friendly credential to enable us to add a Domain User to the Local Administrators Group on the Member server.

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

Group AddADUserToLocalAdminGroup
        {
            GroupName='Administrators'   
            Ensure= 'Present'             
            MembersToInclude= "$domain\$($Node.AdminAccount)"
            Credential = $dCredential    
            PsDscRunAsCredential = $DCredential
        }
```

