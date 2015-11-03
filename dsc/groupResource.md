# DSC Group Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The Group resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage local groups on the target node.

##Syntax##
```
Group [string] #ResourceName
{
    GroupName = [string]
    [ Credential = [PSCredential] ]
    [ Description = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ Members = [string[]] ]
    [ MembersToExclude = [string[]] ]
    [ MembersToInclude = [string[]] ]
    [ DependsOn = [string[]] ]
}
```

## Properties

|  Property  |  Description   | 
|---|---| 
| GroupName| Indicates the name of the group for which you want to ensure a specific state.| 
| Credential| Indicates the credentials required to access remote resources. **Note**: This account must have the appropriate Active Directory permissions to add all non-local accounts to the group; otherwise, an error will occur.
| Description| Indicates the description of the group.| 
| Ensure| Indicates if the group exists. Set this property to "Absent" to ensure that the group does not exist. Setting it to "Present" (the default value) ensures that the group exists.| 
| Members| Indicates that you want to ensure these members form the group.| 
| MembersToExclude| Indicates the users who you want ensure are not members of this group.| 
| MembersToInclude| Indicates the users who you want to ensure are members of the group.| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"``.| 

## Example

The following example shows how to ensure that a group called TestGroup is absent. 

```powershell
Group GroupExample
{
    # This will remove TestGroup, if present
    # To create a new group, set Ensure to "Present“
    Ensure = "Absent"
    GroupName = "TestGroup"
}
```
