---
ms.date:  2017-06-09
schema:  2.0
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821801
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Get-Runspace
---

# Get-Runspace

## SYNOPSIS
Gets active runspaces within a Windows PowerShellhost process.

## SYNTAX

### NameParameterSet (Default)
```
Get-Runspace [[-Name] <String[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [<CommonParameters>]
```

### IdParameterSet
```
Get-Runspace [-Id] <Int32[]> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [<CommonParameters>]
```

### InstanceIdParameterSet
```
Get-Runspace [-InstanceId] <Guid[]> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [<CommonParameters>]
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
Position: 1
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

### -InstanceId
@{Text=}

```yaml
Type: Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases: 

Required: True
Position: 1
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

[Debug-Runspace](Debug-Runspace.md)

