---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/?LinkId=799468
schema: 2.0.0
---

# Get-TimeZone
## SYNOPSIS
Gets the current time zone or a list of available time zones.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-TimeZone -Id <String[]>
```

### UNNAMED_PARAMETER_SET_2
```
Get-TimeZone [-ListAvailable]
```

### UNNAMED_PARAMETER_SET_3
```
Get-TimeZone [[-Name] <String[]>]
```

## DESCRIPTION
The Get-TimeZone cmdlet gets the current time zone or a list of available time zones.

## EXAMPLES

### Example 1: Get the current time zone
```
PS C:\>Get-TimeZone
Pacific Standard Time
```

This command gets the current time zone.

### Example 2: Get time zones that match a specified string
```
PS C:\>Get-TimeZone -Name "*pac*"
Pacific Standard Time (Mexico) 

(UTC-08:00) Pacific Time (US &amp; Canada) 

Pacific Standard Time

SA Pacific Standard Time

Pacific SA Standard Time

West Pacific Standard Time

Central Pacific Standard Time
```

This command gets all time zones that match the specified wildcard.

### Example 3: Get all available time zones
```
PS C:\>Get-TimeZone -ListAvailable
```

This command gets all available time zones.

## PARAMETERS

### -Id
Specifies, as a string array, the ID or IDs of the time zones that this cmdlet gets.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ListAvailable
Indicates that this cmdlet gets all available time zones.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies, as a string array, the name or names of the time zones that this cmdlet gets.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True(ByValue)
Accept wildcard characters: True
```

## INPUTS

### System.String[]

## OUTPUTS

### System.TimeZoneInfo[]

## NOTES

## RELATED LINKS

[Set-TimeZone](904d8606-0d11-48b7-852e-fb708bf95e6b)

