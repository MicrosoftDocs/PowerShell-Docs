---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/28/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.localaccounts/remove-localuser?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-LocalUser
---

# Remove-LocalUser

## SYNOPSIS
Deletes local user accounts.

## SYNTAX

### InputObject

```
Remove-LocalUser [-InputObject] <LocalUser[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default

```
Remove-LocalUser [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SecurityIdentifier

```
Remove-LocalUser [-SID] <SecurityIdentifier[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-LocalUser` cmdlet deletes local user accounts.

## EXAMPLES

### Example 1: Delete a user account

```powershell
Remove-LocalUser -Name "AdminContoso02"
```

This command deletes the user account named AdminContoso02.

> [!NOTE]
> The Microsoft.PowerShell.LocalAccounts module is not available in 32-bit PowerShell on a 64-bit
> system.

## PARAMETERS

### -InputObject

Specifies an array of user accounts that this cmdlet deletes. To obtain a user account, use the
`Get-LocalUser` cmdlet.

```yaml
Type: Microsoft.PowerShell.Commands.LocalUser[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name

Specifies an array of names of the user accounts that this cmdlet deletes.

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

Specifies an array of security IDs (SIDs) of user accounts that this cmdlet deletes.

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

### System.Management.Automation.SecurityAccountsManager.LocalUser

You can pipe a local user to this cmdlet.

### System.String

You can pipe a string to this cmdlet.

### System.Security.Principal.SecurityIdentifier

You can pipe a SID to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

Windows PowerShell includes the following aliases for `Remove-LocalUser`:

- `rlu`

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

[Disable-LocalUser](Disable-LocalUser.md)

[Enable-LocalUser](Enable-LocalUser.md)

[Get-LocalUser](Get-LocalUser.md)

[New-LocalUser](New-LocalUser.md)

[Rename-LocalUser](Rename-LocalUser.md)

[Set-LocalUser](Set-LocalUser.md)
