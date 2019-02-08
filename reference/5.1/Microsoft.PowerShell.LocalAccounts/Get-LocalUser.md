---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822514
schema: 2.0.0
title: Get-LocalUser
---

# Get-LocalUser

## SYNOPSIS
Gets local user accounts.

## SYNTAX

### Default (Default)
```
Get-LocalUser [[-Name] <String[]>] [<CommonParameters>]
```

### SecurityIdentifier
```
Get-LocalUser [[-SID] <SecurityIdentifier[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-LocalUser** cmdlet gets local user accounts.
This cmdlet gets default built-in user accounts, local user accounts that you created, and local accounts that you connected to Microsoft accounts.

## EXAMPLES

### Example 1: Get an account by using its name
```
PS C:\> Get-LocalUser -Name "AdminContoso02"
Name             Enabled Description
----             ------- -----------
AdminContoso02   True    Description of this account.
```

This command gets a user account named AdminContoso02.

### Example 2: Get an account that is connected to a Microsoft account
```
PS C:\> Get-LocalUser -Name "MicrosoftAccount\username@Outlook.com"
Name                                    Enabled  Description
----                                    -------  -----------
MicrosoftAccount\user name@outlook.com  True     Description of this account.
```

This command gets a user account that is connected to a Microsoft account.
This example uses a placeholder value for the user name of an account at Outlook.com.

### Example 3: Get an account that is connected to a Microsoft account
```
PS C:\> Get-LocalUser -SecurityIdentifier "S-1-5-2"
Name                                    Enabled  Description
----                                    -------  -----------
MicrosoftAccount\user name@contoso.com  True     Description of this account.
```

This command gets a local user account that has the specified SID.

## PARAMETERS

### -Name
Specifies an array of names of user accounts that this cmdlet gets.
You can use the wildcard character.

```yaml
Type: String[]
Parameter Sets: Default
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -SID
Specifies an array of security IDs (SIDs) of user accounts that this cmdlet gets.

```yaml
Type: SecurityIdentifier[]
Parameter Sets: SecurityIdentifier
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String, System.Security.Principal.SecurityIdentifier
You can pipe a string or SID to this cmdlet.

## OUTPUTS

### System.Management.Automation.SecurityAccountsManager.LocalUser[]
This cmdlet returns local user accounts.

## NOTES
* The **PrincipalSource** property is a property on **LocalUser**, **LocalGroup**, and **LocalPrincipal** objects that describes the source of the object. The possible sources are as follows:

- Local
- Active Directory
- Azure Active Directory group
- Microsoft Account

**PrincipalSource** is supported only by Windows 10, Windows Server 2016, and later versions of the Windows operating system. For earlier versions, the property is blank.

## RELATED LINKS

[Disable-LocalUser](Disable-LocalUser.md)

[Enable-LocalUser](Enable-LocalUser.md)

[New-LocalUser](New-LocalUser.md)

[Remove-LocalUser](Remove-LocalUser.md)

[Rename-LocalUser](Rename-LocalUser.md)

[Set-LocalUser](Set-LocalUser.md)
