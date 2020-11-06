---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/remove-event?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-Event
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

The `Remove-Event` cmdlet deletes events from the event queue in the current session.

This cmdlet deletes only the events currently in the queue. To cancel event registrations or
unsubscribe, use the `Unregister-Event` cmdlet.

## EXAMPLES

### Example 1: Remove an event by source identifier

```
PS C:\> Remove-Event -SourceIdentifier "ProcessStarted"
```

This command deletes events with a source identifier of Process Started from the event queue.

### Example 2: Remove an event by event identifier

```
PS C:\> Remove-Event -EventIdentifier 30
```

This command deletes the event with an event ID of 30 from the event queue.

### Example 3: Remove all events

```
PS C:\> Get-Event | Remove-Event
```

This command deletes all events from the event queue.

## PARAMETERS

### -EventIdentifier

Specifies the event identifier for which the cmdlet deletes. An **EventIdentifier** or
**SourceIdentifier** parameter is required in every command.

```yaml
Type: System.Int32
Parameter Sets: ByIdentifier
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SourceIdentifier

Specifies the source identifier for which this cmdlet deletes events from. Wildcards are not
permitted. An **EventIdentifier** or **SourceIdentifier** parameter is required in every command.

```yaml
Type: System.String
Parameter Sets: BySource
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSEventArgs

You can pipe events from `Get-Event` to `Remove-Event`.

## OUTPUTS

### None

The cmdlet does not generate any output.

## NOTES

Events, event subscriptions, and the event queue exist only in the current session. If you close the
current session, the event queue is discarded and the event subscription is canceled.

## RELATED LINKS

[Get-Event](Get-Event.md)

[New-Event](New-Event.md)

[Register-EngineEvent](Register-EngineEvent.md)

[Register-ObjectEvent](Register-ObjectEvent.md)

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)
