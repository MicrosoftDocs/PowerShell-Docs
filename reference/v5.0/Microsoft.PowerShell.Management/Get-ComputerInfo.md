---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/?LinkId=799466
schema: 2.0.0
---

# Get-ComputerInfo
## SYNOPSIS
Gets a consolidated object of system and operating system properties.

## SYNTAX

```
Get-ComputerInfo [[-Property] <String[]>]
```

## DESCRIPTION
The Get-ComputerInfo cmdlet gets a consolidated object of system and operating system properties.

## EXAMPLES

### Example 1: Get all computer properties
```
PS C:\>Get-ComputerInfo
```

This command gets all system and operating system properties from the computer.

### Example 2: Get all computer operating system properties
```
PS C:\>Get-ComputerInfo -Property "os*"
```

This command gets all operating system properties from the computer.

## PARAMETERS

### -Property
Specifies, as a string array, the computer properties in which this cmdlet displays.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.String[]

## OUTPUTS

### Microsoft.PowerShell.Management.ComputerInfo

## NOTES

## RELATED LINKS

