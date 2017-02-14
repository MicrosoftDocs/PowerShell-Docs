---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Get Runspace
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821801
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Get-Runspace

## SYNOPSIS
Gets active runspaces within a Windows PowerShell host process.

## SYNTAX

### NameParameterSet (Default)
```
Get-Runspace [[-Name] <String[]>] [<CommonParameters>]
```

### IdParameterSet
```
Get-Runspace [-Id] <Int32[]> [<CommonParameters>]
```

### InstanceIdParameterSet
```
Get-Runspace [-InstanceId] <Guid[]> [<CommonParameters>]
```

## DESCRIPTION
The **Get-Runspace** cmdlet gets active runspaces in a Windows PowerShell host process.

## EXAMPLES

### 1:
```

```

### 2:
```

```

## PARAMETERS

### -Id
@{Text=}

```yaml
Type: Int32[]
Parameter Sets: IdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
@{Text=}

```yaml
Type: Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
@{Text=}

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Debug-Runspace](Debug-Runspace.md)

[New-Runspace]()

[Remove-Runspace]()

