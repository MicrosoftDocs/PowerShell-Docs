---
external help file: System.Management.Automation.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289600
schema: 2.0.0
---

# Out-Default
## SYNOPSIS
Sends the output to the default formatter and to the default output cmdlet.

## SYNTAX

```
Out-Default [-Transcript] [-InputObject <PSObject>]
```

## DESCRIPTION
The Out-Default cmdlet sends output to the default formatter and the default output cmdlet.
This cmdlet has no effect on the formatting or output of Windows PowerShell commands.
It is a placeholder that lets you write your own Out-Default function or cmdlet.

## EXAMPLES

### 1:
```

```

## PARAMETERS

### -InputObject
Accepts input to the cmdlet.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Transcript
@{Text=}

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Format-Custom]()

[Format-List]()

[Format-Table]()

[Format-Wide]()

[about_Format.ps1.xml]()

