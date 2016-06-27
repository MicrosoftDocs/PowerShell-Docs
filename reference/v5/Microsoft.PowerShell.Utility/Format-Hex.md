---
external help file: Microsoft.PowerShell.Utility-help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=526919
schema: 2.0.0
---

# Format-Hex
## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### Path (Default)
```
Format-Hex [-Path] <String[]>
```

### LiteralPath
```
Format-Hex -LiteralPath <String[]>
```

### ByInputObject
```
Format-Hex -InputObject <Object> [-Encoding <String>]
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

### -Encoding
{{Fill Encoding Description}}

```yaml
Type: String
Parameter Sets: ByInputObject
Aliases: 
Accepted values: Ascii, UTF32, UTF7, UTF8, BigEndianUnicode, Unicode

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
{{Fill InputObject Description}}

```yaml
Type: Object
Parameter Sets: ByInputObject
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath
{{Fill LiteralPath Description}}

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{Fill Path Description}}

```yaml
Type: String[]
Parameter Sets: Path
Aliases: 

Required: True
Position: 0
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Object


## OUTPUTS

### Microsoft.PowerShell.Commands.ByteCollection


## NOTES

## RELATED LINKS

[http://go.microsoft.com/fwlink/?LinkId=526919](http://go.microsoft.com/fwlink/?LinkId=526919)

