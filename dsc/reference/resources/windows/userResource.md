---
ms.date: 09/20/2019
keywords: dsc,powershell,configuration,setup
title: DSC User Resource
---
# DSC User Resource

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.x

The **User** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism
to manage local user accounts on the target node.

## Syntax

```MOF
User [string] #ResourceName
{
    UserName = [string]
    [ Description = [string] ]
    [ Disabled = [bool] ]
    [ FullName = [string] ]
    [ Password = [PSCredential] ]
    [ PasswordChangeNotAllowed = [bool] ]
    [ PasswordChangeRequired = [bool] ]
    [ PasswordNeverExpires = [bool] ]
    [ DependsOn = [string[]] ]
    [ Ensure = [string] { Absent | Present }  ]
    [ PsDscRunAsCredential = [PSCredential] ]
}
```

## Properties

|Property |Description |
|---|---|
|UserName |Indicates the account name for which you want to ensure a specific state. |
|Description |Indicates the description you want to use for the user account. |
|Disabled |Indicates if the account is enabled. Set this property to _$true_ to ensure that this account is disabled, and set it to _$false_ to ensure that it is enabled. |
|FullName |Represents a string with the full name you want to use for the user account. |
|Password |Indicates the password you want to use for this account. |
|PasswordChangeNotAllowed |Indicates if the user can change the password. Set this property to _$true_ to ensure that the user cannot change the password, and set it to _$false_ to allow the user to change the password. The default value is _$false_. |
|PasswordChangeRequired |Indicates if the user must change the password at the next sign in. Set this property to _$true_ if the user must change the password. The default value is _$true_. |
|PasswordNeverExpires |Indicates if the password will expire. To ensure that the password for this account will never expire, set this property to _$true_. Set it to _$false_ if the password will expire. The default value is _$false_. |

## Common properties

|Property |Description |
|---|---|
|DependsOn |Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is ResourceName and its type is ResourceType, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. |
|Ensure |Indicates if the account exists. Set this property to _Present_ to ensure that the account exists, and set it to _Absent_ to ensure that the account does not exist. The default value is _Present_. |
|PsDscRunAsCredential |Sets the credential for running the entire resource as. |

> [!NOTE]
> The **PsDscRunAsCredential** common property was added in WMF 5.0 to allow running any DSC
> resource in the context of other credentials. For more information, see [Use Credentials with DSC Resources](../../../configurations/runasuser.md).

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