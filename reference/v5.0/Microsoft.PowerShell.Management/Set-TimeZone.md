---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/?LinkId=799469
schema: 2.0.0
---

# Set-TimeZone
## SYNOPSIS
Sets the system time zone to a specified time zone.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-TimeZone [-PassThru] -Id <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Set-TimeZone [-InputObject] <TimeZoneInfo> [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Set-TimeZone [-Name] <String> [-PassThru] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Set-TimeZone cmdlet sets the system time zone to a specified time zone.

## EXAMPLES

### Example 1: Set the time zone on the computer
```
PS C:\>Set-TimeZone -Name "Pacific Standard Time"
```

This command sets the time zone on the local computer to Pacific Standard Time.

## PARAMETERS

### -Id
Specifies the ID of the time zone that this cmdlet sets.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByPropertyName)
Accept wildcard characters: False
```

### -InputObject
Specifies a TimeZoneInfo object to use as input.

```yaml
Type: TimeZoneInfo
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the name of the time zone that this cmdlet sets.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String, System.TimeZoneInfo, System.String

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-TimeZone](1ac48beb-4d86-41ae-827a-bb9f86fea3d9)

