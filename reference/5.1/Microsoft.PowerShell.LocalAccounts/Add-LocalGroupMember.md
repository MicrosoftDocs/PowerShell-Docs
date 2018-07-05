---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822507
schema: 2.0.0
title: Add-LocalGroupMember
---

# Add-LocalGroupMember

## SYNOPSIS
Adds members to a local group.

## SYNTAX

### Group
```
Add-LocalGroupMember [-Group] <LocalGroup> [-Member] <LocalPrincipal[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Default
```
Add-LocalGroupMember [-Member] <LocalPrincipal[]> [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SecurityIdentifier
```
Add-LocalGroupMember [-Member] <LocalPrincipal[]> [-SID] <SecurityIdentifier> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Add-LocalGroupMember** cmdlet adds users or groups to a local security group.
All the rights and permissions that are assigned to a group are assigned to all members of that group.

Members of the Administrators group on a local computer have Full Control permissions on that computer.
Limit the number of users in the Administrators group.

If the computer is joined to a domain, you can add user accounts, computer accounts, and group accounts from that domain and from trusted domains to a local group.

## EXAMPLES

### Example 1: Add members to the Administrators group
```
PS C:\> Add-LocalGroupMember -Group "Administrators" -Member "Admin02", "MicrosoftAccount\username@Outlook.com", "AzureAD\DavidChew@contoso.com", "CONTOSO\Domain Admins"
```

This command adds several members to the local Administrators group.
The new members include a local user account, a Microsoft account, an Azure Active Directory account, and a domain group.
This example uses a placeholder value for the user name of an account at Outlook.com.

## PARAMETERS

### -Group
Specifies the security group to which this cmdlet adds members.

```yaml
Type: LocalGroup
Parameter Sets: Group
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Member
Specifies an array of users or groups that this cmdlet adds to a security group.
You can specify users or groups by name, security ID (SID), or **LocalPrincipal** objects.

```yaml
Type: LocalPrincipal[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the name of the security group to which this cmdlet adds members.

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SID
Specifies the security ID of the security group to which this cmdlet adds members.

```yaml
Type: SecurityIdentifier
Parameter Sets: SecurityIdentifier
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SecurityAccountsManager.LocalGroup, System.String, System.Security.Principal.SecurityIdentifier
You can pipe a local principal, a string, or a SID to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* The **PrincipalSource** property is a property on **LocalUser**, **LocalGroup**, and **LocalPrincipal** objects that describes the source of the object. The possible sources are as follows:

- Local
- Active Directory
- Azure Active Directory group
- Microsoft Account

**PrincipalSource** is supported only by Windows 10, Windows Server 2016, and later versions of the Windows operating system. For earlier versions, the property is blank.

## RELATED LINKS

[Get-LocalGroupMember](Get-LocalGroupMember.md)

[New-LocalGroup](New-LocalGroup.md)

[Remove-LocalGroupMember](Remove-LocalGroupMember.md)