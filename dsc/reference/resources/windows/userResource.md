---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC User Resource
---
# DSC User Resource

Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **User** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to manage local user accounts on the target node.

## Syntax

```
User [string] #ResourceName
{
    UserName = [string]
    [ Description = [string] ]
    [ Disabled = [bool] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ FullName = [string] ]
    [ Password = [PSCredential] ]
    [ PasswordChangeNotAllowed = [bool] ]
    [ PasswordChangeRequired = [bool] ]
    [ PasswordNeverExpires = [bool] ]
    [ DependsOn = [string[]] ]
}
```

## Properties

|  Property  |  Description   |
|---|---|
| UserName| Indicates the account name for which you want to ensure a specific state.|
| Description| Indicates the description you want to use for the user account.|
| Disabled| Indicates if the account is enabled. Set this property to `$true` to ensure that this account is disabled, and set it to `$false` to ensure that it is enabled.|
| Ensure| Indicates if the account exists. Set this property to "Present" to ensure that the account exists, and set it to "Absent" to ensure that the account does not exist.|
| FullName| Represents a string with the full name you want to use for the user account.|
| Password| Indicates the password you want to use for this account. |
| PasswordChangeNotAllowed| Indicates if the user can change the password. Set this property to `$true` to ensure that the user cannot change the password, and set it to `$false` to allow the user to change the password. The default value is `$false`.|
| PasswordChangeRequired| Indicates if the user must change the password at the next sign in. Set this property to `$true` if the user must change the password. The default value is `$true`.|
| PasswordNeverExpires| Indicates if the password will expire. To ensure that the password for this account will never expire, set this property to `$true`, and set it to `$false` if the password will expire. The default value is `$false`.|
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.|

## Example

```powershell
User UserExample
{
    Ensure = "Present"  # To ensure the user account does not exist, set Ensure to "Absent"
    UserName = "SomeName"
    Password = $passwordCred # This needs to be a credential object
    DependsOn = "[Group]GroupExample" # Configures GroupExample first
}
```