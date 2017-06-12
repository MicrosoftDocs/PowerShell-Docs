---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821765
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Enable-RunspaceDebug
---

# Enable-RunspaceDebug

## SYNOPSIS
Enables debugging on runspaces where any breakpoint is preserved until a debugger is attached.

## SYNTAX

### RunspaceNameParameterSet (Default)
```
Enable-RunspaceDebug [-BreakAll] [[-RunspaceName] <String[]>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [<CommonParameters>]
```

### RunspaceParameterSet
```
Enable-RunspaceDebug [-BreakAll] [-Runspace] <Runspace[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [<CommonParameters>]
```

### RunspaceIdParameterSet
```
Enable-RunspaceDebug [-BreakAll] [-RunspaceId] <Int32[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [<CommonParameters>]
```

### RunspaceInstanceIdParameterSet
```
Enable-RunspaceDebug [-RunspaceInstanceId] <Guid[]> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [<CommonParameters>]
```

### ProcessNameParameterSet
```
Enable-RunspaceDebug [[-ProcessName] <String>] [[-AppDomainName] <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Enable-RunspaceDebug** cmdlet enables debugging on runspaces where any breakpoint is preserved until a debugger is attached.

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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BreakAll
@{Text=}

```yaml
Type: SwitchParameter
Parameter Sets: RunspaceNameParameterSet, RunspaceParameterSet, RunspaceIdParameterSet
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
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
Position: 1
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
Position: 1
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
Position: 1
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
Position: 1
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
Position: 1
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

[Disable-RunspaceDebug](Disable-RunspaceDebug.md)

[Get-RunspaceDebug](Get-RunspaceDebug.md)

