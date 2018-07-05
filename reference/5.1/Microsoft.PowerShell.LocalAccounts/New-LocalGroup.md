---
external help file: Microsoft.Powershell.LocalAccounts.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.LocalAccounts
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=822515
schema: 2.0.0
title: New-LocalGroup
---

# New-LocalGroup

## SYNOPSIS
Creates a local security group.

## SYNTAX

```
New-LocalGroup [-Description <String>] [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **New-LocalGroup** cmdlet creates a local security group in the Security Account Manager.

## EXAMPLES

### Example 1: Create a security group
```
PS C:\> New-LocalGroup -Name "SecurityGroup04"
```

This command creates a group named SecurityGroup04.

## PARAMETERS

### -Description
Specifies a comment for the group.
The maximum length is 48 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies a name for the group.
The maximum length is 256 characters.

```yaml
Type: String
Parameter Sets: (All)
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

### System.String
You can pipe a string to this cmdlet.

## OUTPUTS

### System.Management.Automation.SecurityAccountsManager.LocalGroup
This cmdlet returns a security group.

## NOTES
* The **PrincipalSource** property is a property on **LocalUser**, **LocalGroup**, and **LocalPrincipal** objects that describes the source of the object. The possible sources are as follows:

- Local
- Active Directory
- Azure Active Directory group
- Microsoft Account

**PrincipalSource** is supported only by Windows 10, Windows Server 2016, and later versions of the Windows operating system. For earlier versions, the property is blank.

## RELATED LINKS

[Get-LocalGroup](Get-LocalGroup.md)

[Remove-LocalGroup](Remove-LocalGroup.md)

[Rename-LocalGroup](Rename-LocalGroup.md)

[Set-LocalGroup](Set-LocalGroup.md)