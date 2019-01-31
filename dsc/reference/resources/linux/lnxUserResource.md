---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC for Linux nxUser Resource
---

# DSC for Linux nxUser Resource

The **nxUser** resource in PowerShell Desired State Configuration (DSC) provides a mechanism to manage local users on a Linux node.

## Syntax

```
nxUser <string> #ResourceName
{
    UserName = <string>
    [ Ensure = <string> { Absent | Present }  ]
    [ FullName = <string> ]
    [ Description = <string> ]
    [ Password = <string> ]
    [ Disabled = <bool> ]
    [ PasswordChangeRequired = <bool> ]
    [ HomeDirectory = <string> ]
    [ GroupID = <string> ]
    [ DependsOn = <string[]> ]

}
```

## Properties

|  Property |  Indicates the account name for which you want to ensure a specific state. |
|---|---|
| UserName| Specifies the location where you want to ensure the state for a file or directory.|
| Ensure| Specifies whether the account exists. Set this property to "Present" to ensure that the account exists, and set it to "Absent" to ensure that the account does not exist.|
| FullName| A string that contains the full name to use for the user account.|
| Description| The description for the user account.|
| Password| The hash of the users password in the appropriate form for the Linux computer. Typically, this is a salted SHA-256, or SHA-512 hash. On Debian and Ubuntu Linux, this value can be generated with the mkpasswd command. For other Linux distros, the crypt method of Python’s Crypt library can be used to generate the hash.|
| Disabled| Indicates whether the account is enabled. Set this property to **$true** to ensure that this account is disabled, and set it to **$false** to ensure that it is enabled.|
| PasswordChangeRequired| Indicates whether the user can change the password. Set this property to **$true** to ensure that the user cannot change the password, and set it to **$false** to allow the user to change the password. The default value is **$false**. This property is only evaluated if the user account did not exist previously and is being created.|
| HomeDirectory| The home directory for the user.|
| GroupID| The primary group ID for the user.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is "ResourceName" and its type is "ResourceType", the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|

## Example

The following example ensures that the user "monuser" exists and is a member of the group "DBusers".

```
Import-DSCResource -Module nx

Node $node {
nxUser UserExample{
   UserName = "monuser"
   Description = "Monitoring user"
   Password  =    '$6$fZAne/Qc$MZejMrOxDK0ogv9SLiBP5J5qZFBvXLnDu8HY1Oy7ycX.Y3C7mGPUfeQy3A82ev3zIabhDQnj2ayeuGn02CqE/0'
   Ensure = "Present"
   HomeDirectory = "/home/monuser"
}

nxGroup GroupExample{
   GroupName = "DBusers"
   Ensure = "Present"
   MembersToInclude = "monuser"
   DependsOn = "[nxUser]UserExample"
}
}
```