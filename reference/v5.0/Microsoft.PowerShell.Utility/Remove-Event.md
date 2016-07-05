---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294003
schema: 2.0.0
---

# Remove-Event
## SYNOPSIS
Deletes events from the event queue.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Remove-Event [-SourceIdentifier] <String> [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Remove-Event [-EventIdentifier] <Int32> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Remove-Event cmdlet deletes events from the event queue in the current session.

This cmdlet deletes only the events currently in the queue.
To cancel event registrations or unsubscribe, use the Unregister-Event cmdlet.

## EXAMPLES

### Example 1: Remove an event by source identifier
```
PS C:\>Remove-Event -SourceIdentifier "ProcessStarted"
```

This command deletes events with a source identifier of Process Started from the event queue.

### Example 2: Remove an event by event identifier
```
PS C:\>Remove-Event -EventIdentifier 30
```

This command deletes the event with an event ID of 30 from the event queue.

### Example 3: Remove all events
```
PS C:\>Get-Event | Remove-Event
```

This command deletes all events from the event queue.

## PARAMETERS

### -EventIdentifier
Deletes only the event with the specified event identifier.
An EventIdentifier or SourceIdentifier parameter is required in every command.

```yaml
Type: Int32
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SourceIdentifier
Deletes only the events with the specified source identifier.
Wildcards are not permitted.
An EventIdentifier or SourceIdentifier parameter is required in every command.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
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

### System.Management.Automation.PSEventArgs
You can pipe events from Get-Event to Remove-Event.

## OUTPUTS

### None
The cmdlet does not generate any output.

## NOTES
* Events, event subscriptions, and the event queue exist only in the current session. If you close the current session, the event queue is discarded and the event subscription is canceled.

*

## RELATED LINKS

[Get-Event](4ac85bbe-2abd-4e86-a313-edae6a08e435)

[New-Event](d5f16c15-8a98-4221-8f96-0867578f5430)

[Register-EngineEvent](f5c43ecf-b8ef-44d2-b586-0480121c397c)

[Register-ObjectEvent](896cbb3f-f415-481e-985b-1999e95c7407)

[Register-WmiEvent](bc569c33-ee85-4a13-82c1-7d5f117f23f4)

[Remove-Event](7f3788ee-44af-407f-8f7b-9f1b4a262c71)

[Unregister-Event](313e8361-8646-4b0d-b72f-f76987c49591)

[Wait-Event](bd2e7d77-2642-4628-b937-0a7d52033399)

