---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294003
schema: 2.0.0
---

# Remove-Event
## SYNOPSIS
Deletes events from the event queue.

## SYNTAX

### BySource (Default)
```
Remove-Event [-SourceIdentifier] <String> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### ByIdentifier
```
Remove-Event [-EventIdentifier] <Int32> [-InformationAction <ActionPreference>] [-InformationVariable <String>]
 [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Remove-Event cmdlet deletes events from the event queue in the current session.

This cmdlet deletes only the events currently in the queue.
To cancel event registrations or unsubscribe, use the Unregister-Event cmdlet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>remove-event -sourceIdentifier "ProcessStarted"
```

This command deletes events with a source identifier of "Process Started" from the event queue.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>remove-event -eventIdentifier 30
```

This command deletes the event with an event ID of 30 from the event queue.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-event | remove-event
```

This command deletes all events from the event queue.

## PARAMETERS

### -EventIdentifier
Deletes only the event with the specified event identifier.
An EventIdentifier or SourceIdentifier parameter is required in every command.

```yaml
Type: Int32
Parameter Sets: ByIdentifier
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

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

### -SourceIdentifier
Deletes only the events with the specified source identifier.
Wildcards are not permitted.
An EventIdentifier or SourceIdentifier parameter is required in every command.

```yaml
Type: String
Parameter Sets: BySource
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
Aliases: cf

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
Aliases: wi

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
Events, event subscriptions, and the event queue exist only in the current session.
If you close the current session, the event queue is discarded and the event subscription is canceled.

## RELATED LINKS

[Get-Event]()

[New-Event]()

[Register-EngineEvent]()

[Register-ObjectEvent]()

[Register-WmiEvent]()

[Remove-Event]()

[Unregister-Event]()

[Wait-Event]()

