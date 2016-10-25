---
author: jpjofre
description: 
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell, cmdlet
manager: carolz
ms.date: 2016-09-30
ms.prod: powershell
ms.technology: powershell
ms.topic: reference
online version: http://go.microsoft.com/fwlink/?LinkId=821763
schema: 2.0.0
title: Disable-RunspaceDebug
---

# Disable-RunspaceDebug

## SYNOPSIS
Disables debugging on one or more runspaces, and releases any pending debugger stop.

## SYNTAX

### RunspaceNameParameterSet (Default)
```
Disable-RunspaceDebug [[-RunspaceName] <String[]>] [<CommonParameters>]
```

### RunspaceParameterSet
```
Disable-RunspaceDebug [-Runspace] <Runspace[]> [<CommonParameters>]
```

### RunspaceIdParameterSet
```
Disable-RunspaceDebug [-RunspaceId] <Int32[]> [<CommonParameters>]
```

### RunspaceInstanceIdParameterSet
```
Disable-RunspaceDebug [-RunspaceInstanceId] <Guid[]> [<CommonParameters>]
```

### ProcessNameParameterSet
```
Disable-RunspaceDebug [[-ProcessName] <String>] [[-AppDomainName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Disable-RunspaceDebug** cmdlet disables debugging on one or more runspaces, and releases any pending debugger stop.

## EXAMPLES

### 1:
```

```

### 2:
```

```

## PARAMETERS

### -AppDomainName
@{Text=}

```yaml
Type: String[]
Parameter Sets: ProcessNameParameterSet
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessName
@{Text=}

```yaml
Type: String
Parameter Sets: ProcessNameParameterSet
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Runspace
@{Text=}

```yaml
Type: Runspace[]
Parameter Sets: RunspaceParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RunspaceId
@{Text=}

```yaml
Type: Int32[]
Parameter Sets: RunspaceIdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunspaceInstanceId
@{Text=}

```yaml
Type: Guid[]
Parameter Sets: RunspaceInstanceIdParameterSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunspaceName
@{Text=}

```yaml
Type: String[]
Parameter Sets: RunspaceNameParameterSet
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

[Enable-RunspaceDebug](Enable-RunspaceDebug.md)

[Get-RunspaceDebug](Get-RunspaceDebug.md)

