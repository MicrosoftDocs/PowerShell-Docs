---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/28/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.localaccounts/remove-localgroup?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-LocalGroup
---

# Remove-LocalGroup

## SYNOPSIS
Deletes local security groups.

## SYNTAX

### InputObject

```
Remove-LocalGroup [-InputObject] <LocalGroup[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default

```
Remove-LocalGroup [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SecurityIdentifier

```
Remove-LocalGroup [-SID] <SecurityIdentifier[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-LocalGroup` cmdlet deletes local security groups. This cmdlet deletes only a local
group. It does not delete the user accounts, computer accounts, or group accounts that belong to
that group. You cannot recover a deleted group.

If you delete a group and then create another group that has the same group name, you must set new
permissions for the new group. The new group does not inherit the permissions that were assigned to
the group.

> [!NOTE]
> The Microsoft.PowerShell.LocalAccounts module is not available in 32-bit PowerShell on a 64-bit
> system.

## EXAMPLES

### Example 1: Delete a security group

```powershell
Remove-LocalGroup -Name "SecurityGroup04"
```

This command deletes the group named SecurityGroup04.

## PARAMETERS

### -InputObject

Specifies an array of security groups that this cmdlet deletes. To obtain groups, use the
`Get-LocalGroup` cmdlet.

```yaml
Type: Microsoft.PowerShell.Commands.LocalGroup[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name

Specifies an array of names of the security groups that this cmdlet deletes.

```yaml
Type: System.String[]
Parameter Sets: Default
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SID

Specifies an array of security IDs (SIDs) of security groups that this cmdlet deletes.

```yaml
Type: System.Security.Principal.SecurityIdentifier[]
Parameter Sets: SecurityIdentifier
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SecurityAccountsManager.LocalGroup

You can pipe a security group to this cmdlet.

### System.String

You can pipe a string to this cmdlet.

### System.Security.Principal.SecurityIdentifier

You can pipe a SID to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

Windows PowerShell includes the following aliases for `Remove-LocalGroup`:

- `rlg`

This cmdlet cannot delete the following default groups:

- Administrators
- Backup Operators
- Cryptographic Operators
- Distributed COM Users
- Event Log Readers
- Guests
- Hyper-V Administrators
- IIS_IUSRS
- Network Configuration Operators
- Performance Log Users
- Performance Monitor Users
- Power Users
- Remote Desktop Users
- Remote Management Users
- Replicator
- Users
- WinRMRemoteWMIUsers__

The **PrincipalSource** property is a property on **LocalUser**, **LocalGroup**, and
**LocalPrincipal** objects that describes the source of the object. The possible sources are as
follows:

- Local
- Active Directory
- Microsoft Entra group
- Microsoft Account

**PrincipalSource** is supported only by Windows 10, Windows Server 2016, and later versions of the
Windows operating system. For earlier versions, the property is blank.

## RELATED LINKS

[Get-LocalGroup](Get-LocalGroup.md)

[New-LocalGroup](New-LocalGroup.md)

[Rename-LocalGroup](Rename-LocalGroup.md)

[Set-LocalGroup](Set-LocalGroup.md)
