---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294018
schema: 2.0.0
---

# Start-Sleep
## SYNOPSIS
Suspends the activity in a script or session for the specified period of time.

## SYNTAX

### Seconds (Default)
```
Start-Sleep [-Seconds] <Int32> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### Milliseconds
```
Start-Sleep -Milliseconds <Int32> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
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

This command makes all the commands in the session sleep for one-half of a second (500 milliseconds).

## PARAMETERS

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Milliseconds
Specifies how long the resource sleeps in milliseconds.
The parameter can be abbreviated as "-m".

```yaml
Type: Int32
Parameter Sets: Milliseconds
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Seconds
Specifies how long the resource sleeps in seconds.
You can omit the parameter name ("Seconds"), or you can abbreviate it as "-s".

```yaml
Type: Int32
Parameter Sets: Seconds
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

