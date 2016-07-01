---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289571
schema: 2.0.0
---

# Clear-History
## SYNOPSIS
Deletes entries from the command history.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Clear-History [[-Id] <Int32[]>] [[-Count] <Int32>] [-Newest] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Clear-History [[-Count] <Int32>] [-CommandLine <String[]>] [-Newest] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Clear-History cmdlet deletes commands from the command history, that is, the list of commands entered during the current session.

Without parameters, Clear-History deletes all commands from the session history, but you can use the parameters of Clear-History to delete selected commands.

## EXAMPLES

### Example 1: Delete all commands
```
PS C:\>Clear-History
```

This command deletes all commands from the session history.

### Example 2: Delete commands by using history IDs
```
PS C:\>Clear-History -Id 23, 25
```

This command deletes the commands that have history IDs 23 and 25.

### Example 3: Delete specific commands
```
PS C:\>Clear-History -Command *help*, *command
```

This command deletes commands that include "help" or end in "command".

### Example 4: Delete the newest commands
```
PS C:\>Clear-History -Count 10 -Newest
```

This command deletes the 10 newest commands from the history.

### Example 5: Delete the oldest commands
```
PS C:\>Clear-History -Id 10 -Count 3
```

This command deletes the three oldest commands, starting with the entry with ID 10.

## PARAMETERS

### -CommandLine
Specifies commands that this cmdlet deletes.
If you enter more than one string, Clear-History deletes commands that have any of the strings.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count
Specifies the number of history entries that this cmdlet clears, starting with the oldest entry in the history.

If you use the Count and Id parameters in the same command, the cmdlet clears the number of entries specified by the Count parameter, starting with the entry specified by the Id parameter.
For example, if Count is 10 and Id is 30, Clear-History clears items 21 through 30 inclusive.

If you use the Count and CommandLine parameters in the same command, Clear-History clears the number of entries specified by the Count parameter, starting with the entry specified by the CommandLine parameter.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the history IDs of commands that this cmdlet deletes.

To find the history ID of a command, use the Get-History cmdlet.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Newest
Indicates that this cmdlet deletes the newest entries in the history.
By default, Clear-History deletes the oldest entries in the history.

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

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
The session history is a list of the commands entered during the session.
You can view the history, add and delete commands, and run commands from the history.
For more information, see about_History.

Deleting a command from the history does not change the history IDs of the remaining items in the command history.

## RELATED LINKS

[Add-History](cf476753-0b6d-405d-aab5-9b4488f18390)

[Get-History](023a54f7-7e13-4699-8b0a-5f348b2a8125)

[Invoke-History](cc0f7984-a1f9-445c-99ba-be39a502fe01)

[about_History](cb632285-e50b-428e-8d7d-7583f8880b70)

