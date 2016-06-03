---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Start-Sleep
## SYNOPSIS
Suspends the activity in a script or session for the specified period of time.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Start-Sleep [-Seconds] <Int32>
```

### UNNAMED_PARAMETER_SET_2
```
Start-Sleep -Milliseconds <Int32>
```

## DESCRIPTION
The Start-Sleep cmdlet suspends the activity in a script or session for the specified period of time.
You can use it for many tasks, such as waiting for an operation to complete or pausing before repeating an operation.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Start-Sleep -s 15
```

This command makes all commands in the session sleep for 15 seconds.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>Start-Sleep -m 500
```

This command makes all the commands in the session sleep for one-half of a second \(500 milliseconds\).

## PARAMETERS

### -Milliseconds
Specifies how long the resource sleeps in milliseconds.
The parameter can be abbreviated as "-m".

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: true (ByPropertyName)
Accept wildcard characters: False
```

### -Seconds
Specifies how long the resource sleeps in seconds.
You can omit the parameter name \("Seconds"\), or you can abbreviate it as "-s".

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### System.Int32
You can pipe the number of seconds to Start-Sleep.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
You can also refer to Start-Sleep by its built-in alias, "sleep".
For more information, see about_Aliases.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113407)


