---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Restore DscConfiguration
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821462
external help file:   Restore-DSCConfiguration.cdxml-help.xml
---


# Restore-DscConfiguration

## SYNOPSIS
Reapplies the previous configuration for the node.

## SYNTAX

```
Restore-DscConfiguration [-CimSession <CimSession[]>] [-ThrottleLimit <Int32>] [-AsJob] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Restore-DscConfiguration** cmdlet reapplies the previous configuration for the node, if a previous configuration exists.
Specify computers by using Common Information Model (CIM) sessions.
If you do not specify a target computer, the cmdlet restores the configuration of the local computer.
If there is no previous configuration for a particular node, this cmdlet returns an error message.

This cmdlet does not support the **Confirm** parameter.

## EXAMPLES

### Example 1: Restore the configuration for the local computer
```
PS C:\> Restore-DscConfiguration
```

This command restores the configuration for the local computer.

### Example 2: Restore configuration for a specified computer
```
PS C:\> $Session = New-CimSession -ComputerName "Server01" -Credential ACCOUNTS\PattiFuller
PS C:\> Restore-DscConfiguration -CimSession $Session
```

This example restores configuration on a computer specified by a CIM session.
The example creates a CIM session for a computer named Server01 for use with the cmdlet.
Alternatively, create an array of CIM sessions to apply the cmdlet to multiple specified computers.

The first command creates a CIM session by using the **New-CimSession** cmdlet, and then stores the **CimSession** object in the $Session variable.
The command prompts you for a password.
For more information, type `Get-Help New-CimSession`.

The second command restores the configuration for the computers identified by the **CimSession** objects stored in the $Session variable, in this case, the computer named Server01.

## PARAMETERS

### -AsJob
{{Fill AsJob Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimSession
@{Text=}

```yaml
Type: CimSession[]
Parameter Sets: (All)
Aliases: Session

Required: False
Position: Named
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

### -ThrottleLimit
@{Text=}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
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

## OUTPUTS

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](http://go.microsoft.com/fwlink/?LinkID=311940)

[Get-DscConfiguration](Get-DscConfiguration.md)

[Get-DscConfigurationStatus](Get-DscConfigurationStatus.md)

[Start-DscConfiguration](Start-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)

