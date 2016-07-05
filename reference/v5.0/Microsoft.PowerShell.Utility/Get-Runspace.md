---
external help file: PSITPro5_Utility.xml
online version: 
schema: 2.0.0
---

# Get-Runspace
## SYNOPSIS
Gets active runspaces within a Windows PowerShellhost process.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-Runspace [[-Name] <String[]>]
```

### UNNAMED_PARAMETER_SET_2
```
Get-Runspace [-Id] <Int32[]>
```

### UNNAMED_PARAMETER_SET_3
```
Get-Runspace [-InstanceId] <Guid[]>
```

## DESCRIPTION
The Get-Runspace cmdlet gets active runspaces in a Windows PowerShell host process.

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
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceId
@{Text=}

```yaml
Type: Guid[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
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

[Debug-Runspace](108d65fa-016c-4f80-af83-f2aa7ec000c3)

[New-Runspace](a62aaa44-222c-4e4a-b1e0-e6038e43a6eb)

[Remove-Runspace](9705ada0-e39c-4b61-a633-e37c70d89c57)

