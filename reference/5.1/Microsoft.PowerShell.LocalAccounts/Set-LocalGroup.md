---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822522
schema: 2.0.0
title: Set-LocalGroup
---

# Set-LocalGroup

## SYNOPSIS
Changes a local security group.

## SYNTAX

### InputObject
```
Set-LocalGroup -Description <String> [-InputObject] <LocalGroup> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default
```
Set-LocalGroup -Description <String> [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SecurityIdentifier
```
Set-LocalGroup -Description <String> [-SID] <SecurityIdentifier> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-LocalGroup** cmdlet changes a local security group.

## EXAMPLES

### Example 1: Change a group description
```
PS C:\> Set-LocalGroup -Name "SecurityGroup04" -Description "This is a sample description."
```

This command changes the description of a local group.

## PARAMETERS

### -Description
Specifies a comment for the group.
The maximum length is 48 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the security group that this cmdlet changes.
To obtain a security group, use the Get-LocalGroup cmdlet.

```yaml
Type: LocalGroup
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the name of the security group that this cmdlet changes.

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SID
Specifies the security ID (SID) of the security group that this cmdlet changes.

```yaml
Type: SecurityIdentifier
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
You can pipe a security group, a string, or a SID to this cmdlet.

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

[Get-LocalGroup](Get-LocalGroup.md)

[New-LocalGroup](New-LocalGroup.md)

[Remove-LocalGroup](Remove-LocalGroup.md)

[Rename-LocalGroup](Rename-LocalGroup.md)