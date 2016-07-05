---
external help file: PSITPro5_Utility.xml
online version: 
schema: 2.0.0
---

# Enable-RunspaceDebug
## SYNOPSIS
Enables debugging on runspaces where any breakpoint is preserved until a debugger is attached.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Enable-RunspaceDebug [[-RunspaceName] <String[]>] [-BreakAll]
```

### UNNAMED_PARAMETER_SET_2
```
Enable-RunspaceDebug [[-ProcessName] <String>] [[-AppDomainName] <String[]>]
```

### UNNAMED_PARAMETER_SET_3
```
Enable-RunspaceDebug [-Runspace] <Runspace[]> [-BreakAll]
```

### UNNAMED_PARAMETER_SET_4
```
Enable-RunspaceDebug [-RunspaceId] <Int32[]> [-BreakAll]
```

### UNNAMED_PARAMETER_SET_5
```
Enable-RunspaceDebug [-RunspaceInstanceId] <Guid[]>
```

## DESCRIPTION
The Enable-RunspaceDebug cmdlet enables debugging on runspaces where any breakpoint is preserved until a debugger is attached.

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
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessName
@{Text=}

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
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
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByValue,ByPropertyName)
Accept wildcard characters: False
```

### -RunspaceId
@{Text=}

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_4
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
Parameter Sets: UNNAMED_PARAMETER_SET_5
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
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Disable-RunspaceDebug](32f7c2a1-c239-40cf-968b-389cf27e7f96)

[Get-RunspaceDebug](943a2a54-0255-4397-a7fa-cbcdbef1d857)

