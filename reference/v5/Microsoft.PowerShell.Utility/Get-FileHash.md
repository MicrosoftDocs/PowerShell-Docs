---
external help file: Microsoft.PowerShell.Utility-help.xml
online version: http://go.microsoft.com/fwlink/?LinkId=517145
schema: 2.0.0
---

# Get-FileHash
## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### Path (Default)
```
Get-FileHash [-Path] <String[]> [-Algorithm <String>]
```

### LiteralPath
```
Get-FileHash -LiteralPath <String[]> [-Algorithm <String>]
```

### Stream
```
Get-FileHash -InputStream <Stream> [-Algorithm <String>]
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

### -Algorithm
{{Fill Algorithm Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: SHA1, SHA256, SHA384, SHA512, MACTripleDES, MD5, RIPEMD160

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputStream
{{Fill InputStream Description}}

```yaml
Type: Stream
Parameter Sets: Stream
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
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
Accept pipeline input: True (ByPropertyName)
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

### System.String[]


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[http://go.microsoft.com/fwlink/?LinkId=517145](http://go.microsoft.com/fwlink/?LinkId=517145)

