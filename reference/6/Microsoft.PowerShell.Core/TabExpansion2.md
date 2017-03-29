---
external help file: System.Management.Automation.dll-Help.xml
online version: 
schema: 2.0.0
---

# TabExpansion2

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### ScriptInputSet (Default)
```
TabExpansion2 [-inputScript] <String> [-cursorColumn] <Int32> [[-options] <Hashtable>]
```

### AstInputSet
```
TabExpansion2 [-ast] <Ast> [-tokens] <Token[]> [-positionOfCursor] <IScriptPosition> [[-options] <Hashtable>]
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

### -ast
{{Fill ast Description}}

```yaml
Type: Ast
Parameter Sets: AstInputSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cursorColumn
{{Fill cursorColumn Description}}

```yaml
Type: Int32
Parameter Sets: ScriptInputSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inputScript
{{Fill inputScript Description}}

```yaml
Type: String
Parameter Sets: ScriptInputSet
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -options
{{Fill options Description}}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -positionOfCursor
{{Fill positionOfCursor Description}}

```yaml
Type: IScriptPosition
Parameter Sets: AstInputSet
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -tokens
{{Fill tokens Description}}

```yaml
Type: Token[]
Parameter Sets: AstInputSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

