---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC for Linux nxGroup Resource
---
# DSC for Linux nxGroup Resource

The **nxGroup** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to manage local groups on a Linux node.

## Syntax

```
nxGroup <string> #ResourceName
{
    GroupName = <string>
    [ Ensure = <string> { Absent | Present } ]
    [ Members = <string[]> ]
    [ MembersToInclude = <string[]> ]
    [ MembersToExclude = <string[]> ]
    [ DependsOn = <string[]> ]
}
```

## Properties

|  Property |  Description |
|---|---|
| GroupName| Specifies the name of the group for which you want to ensure a specific state.|
| Ensure| Determines whether to check if the group exists. Set this property to "Present" to ensure the group exists. Set it to "Absent" to ensure the group does not exist. The default value is "Present".|
| Members| Specifies the members that form the group.|
| MembersToInclude| Specifies the users who you want to ensure are members of the group.|
| MembersToExclude| Specifies the users who you want to ensure are not members of the group.|
| PreferredGroupID| Sets the group id to the provided value if possible. If the group id is currently in use, the next available group id is used.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the **ID** of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = '[ResourceType]ResourceName'`.|

## Example

The following example ensures that the user 'monuser' exists and is a member of the group 'DBusers'.

```powershell
Import-DSCResource -Module nx

Node $node {
    nxUser UserExample {
       UserName = 'monuser'
       Description = 'Monitoring user'
       Password = '$6$fZAne/Qc$MZejMrOxDK0ogv9SLiBP5J5qZFBvXLnDu8HY1Oy7ycX.Y3C7mGPUfeQy3A82ev3zIabhDQnj2ayeuGn02CqE/0'
       Ensure = 'Present'
       HomeDirectory = '/home/monuser'
    }

    nxGroup GroupExample {
       GroupName = 'DBusers'
       Ensure = 'Present'
       MembersToInclude = 'monuser'
       DependsOn = '[nxUser]UserExample'
    }
}
```