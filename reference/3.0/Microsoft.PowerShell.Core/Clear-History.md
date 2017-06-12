---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=135199
external help file:  System.Management.Automation.dll-Help.xml
title:  Clear-History
---

# Clear-History
## SYNOPSIS
Deletes entries from the command history.
## SYNTAX

### IDParameter (Default)
```
Clear-History [[-Id] <Int32[]>] [[-Count] <Int32>] [-Newest] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CommandLineParameter
```
Clear-History [-CommandLine <String[]>] [[-Count] <Int32>] [-Newest] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Clear-History cmdlet deletes commands from the command history, that is, the list of commands entered during the current session.

Without parameters, Clear-History deletes all commands from the session history, but you can use the parameters of Clear-History to delete selected commands.
## EXAMPLES

### Example 1
```
PS C:\> clear-history
```

Deletes all commands from the session history.
### Example 2
```
PS C:\> clear-history -id 23, 25
```

Deletes the commands with history IDs 23 and 25.
### Example 3
```
PS C:\> clear-history -command *help*, *command
```

Deletes commands that include "help" or end in "command".
### Example 4
```
PS C:\> clear-history -count 10 -newest
```

Deletes the 10 newest commands from the history.
### Example 5
```
PS C:\> clear-history -id 10 -count 3
```

Deletes the three oldest commands, beginning with the entry with ID 10.
## PARAMETERS

### -CommandLine
Deletes commands with the specified text strings.
If you enter more than one string, Clear-History deletes commands with any of the strings.

```yaml
Type: String[]
Parameter Sets: CommandLineParameter
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Count
Clears the specified number of  history entries, beginning with the oldest entry in the history.

If you use the Count and Id parameters in the same command, the cmdlet clears the number of entries specified by the Count parameter, beginning with the entry specified by the Id parameter. 
For example, if Count is 10 and Id is 30, Clear-History clears items 21 through 30 inclusive.

If you use the Count and CommandLine parameters in the same command, Clear-History clears the number of entries specified by the Count parameter, beginning with the entry specified by the CommandLine parameter.

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
Deletes commands with the specified history IDs.

To find the history ID of a command, use Get-History.

```yaml
Type: Int32[]
Parameter Sets: IDParameter
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Newest
Deletes the newest entries in the history.
By default, Clear-History deletes the oldest entries in the history.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe objects to Clear-History.
## OUTPUTS

### None
This cmdlet does not generate any output.
## NOTES
* The session history is a list of the commands entered during the session. You can view the history, add and delete commands, and run commands from the history. For more information, see about_History.

  Deleting a command from the history does not change the history IDs of the remaining items in the command history.

*
## RELATED LINKS

[Add-History](Add-History.md)

[Get-History](Get-History.md)

[Invoke-History](Invoke-History.md)

[about_History](About/about_History.md)

