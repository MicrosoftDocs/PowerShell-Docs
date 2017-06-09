---
ms.date:  2017-06-09
keywords:  powershell,cmdlet
external help file:  PSDiagnostics-help.xml
---

# Start-Trace

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
Start-Trace [-SessionName] <String> [[-OutputFilePath] <String>] [[-ProviderFilePath] <String>] [-ETS]
 [-Format <Object>] [-MinBuffers <Int32>] [-MaxBuffers <Int32>] [-BufferSizeInKB <Int32>]
 [-MaxLogFileSizeInMB <Int32>]
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

### -BufferSizeInKB
{{Fill BufferSizeInKB Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ETS
{{Fill ETS Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format
{{Fill Format Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 
Accepted values: bin, bincirc, csv, tsv, sql

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxBuffers
{{Fill MaxBuffers Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxLogFileSizeInMB
{{Fill MaxLogFileSizeInMB Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinBuffers
{{Fill MinBuffers Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFilePath
{{Fill OutputFilePath Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderFilePath
{{Fill ProviderFilePath Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionName
{{Fill SessionName Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
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

