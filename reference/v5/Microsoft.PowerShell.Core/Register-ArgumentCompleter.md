---
external help file: System.Management.Automation.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=528576
schema: 2.0.0
---

# Register-ArgumentCompleter
## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### NativeSet
```
Register-ArgumentCompleter -CommandName <String[]> -ScriptBlock <ScriptBlock> [-Native]
```

### PowerShellSet
```
Register-ArgumentCompleter [-CommandName <String[]>] -ParameterName <String> -ScriptBlock <ScriptBlock>
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -CommandName
{{Fill CommandName Description}}

```yaml
Type: String[]
Parameter Sets: NativeSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: PowerShellSet
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Native
{{Fill Native Description}}

```yaml
Type: SwitchParameter
Parameter Sets: NativeSet
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterName
{{Fill ParameterName Description}}

```yaml
Type: String
Parameter Sets: PowerShellSet
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
{{Fill ScriptBlock Description}}

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[http://go.microsoft.com/fwlink/?LinkId=528576](http://go.microsoft.com/fwlink/?LinkId=528576)

