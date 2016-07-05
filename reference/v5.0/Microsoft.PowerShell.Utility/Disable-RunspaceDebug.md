---
external help file: PSITPro5_Utility.xml
online version: 
schema: 2.0.0
---

# Disable-RunspaceDebug
## SYNOPSIS
Disables debugging on one or more runspaces, and releases any pending debugger stop.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Disable-RunspaceDebug [[-RunspaceName] <String[]>]
```

### UNNAMED_PARAMETER_SET_2
```
Disable-RunspaceDebug [[-ProcessName] <String>] [[-AppDomainName] <String[]>]
```

### UNNAMED_PARAMETER_SET_3
```
Disable-RunspaceDebug [-Runspace] <Runspace[]>
```

### UNNAMED_PARAMETER_SET_4
```
Disable-RunspaceDebug [-RunspaceId] <Int32[]>
```

### UNNAMED_PARAMETER_SET_5
```
Disable-RunspaceDebug [-RunspaceInstanceId] <Guid[]>
```

## DESCRIPTION
The Disable-RunspaceDebug cmdlet disables debugging on one or more runspaces, and releases any pending debugger stop.

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

[Enable-RunspaceDebug](e4b83556-564c-4bc2-9e30-265e5a45a300)

[Get-RunspaceDebug](943a2a54-0255-4397-a7fa-cbcdbef1d857)

