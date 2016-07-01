---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Remove Event
ms.technology:  powershell
external help file:  PSITPro4_Utility.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=294003
schema:  2.0.0
---


# Remove-Event
## SYNOPSIS
Deletes events from the event queue.
## SYNTAX

### BySource (Default)
```
Remove-Event [-SourceIdentifier] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByIdentifier
```
Remove-Event [-EventIdentifier] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
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

[Get-Event](Get-Event.md)

[New-Event](New-Event.md)

[Register-EngineEvent](Register-EngineEvent.md)

[Register-ObjectEvent](Register-ObjectEvent.md)

[Register-WmiEvent](../Microsoft.Powershell.Management/Register-WmiEvent.md)

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)

