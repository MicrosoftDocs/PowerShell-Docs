---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/unregister-event?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Unregister-Event
---

# Unregister-Event

## SYNOPSIS
Cancels an event subscription.

## SYNTAX

### BySource (Default)

```
Unregister-Event [-SourceIdentifier] <String> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ById

```
Unregister-Event [-SubscriptionId] <Int32> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Unregister-Event` cmdlet cancels an event subscription that was created by using the
`Register-EngineEvent`, `Register-ObjectEvent`, or `Register-WmiEvent` cmdlet.

When an event subscription is canceled, the event subscriber is deleted from the session and the
subscribed events are no longer added to the event queue. When you cancel a subscription to an event
created by using the `New-Event` cmdlet, the new event is also deleted from the session.

`Unregister-Event` does not delete events from the event queue. To delete events, use the
`Remove-Event` cmdlet.

## EXAMPLES

### Example 1: Cancel an event subscription by source identifier

```
PS C:\> Unregister-Event -SourceIdentifier "ProcessStarted"
```

This command cancels the event subscription that has a source identifier of ProcessStarted.

To find the source identifier of an event, use the `Get-Event` cmdlet. To find the source identifier
of an event subscription, use the `Get-EventSubscriber` cmdlet.

### Example 2: Cancel an event subscription by subscription identifier

```
PS C:\> Unregister-Event -SubscriptionId 2
```

This command cancels the event subscription that has a subscription identifier of 2.

To find the subscription identifier of an event subscription, use the `Get-EventSubscriber` cmdlet.

### Example 3: Cancel all event subscriptions

```
PS C:\> Get-EventSubscriber -Force | Unregister-Event -Force
```

This command cancels all event subscriptions in the session.

The command uses the `Get-EventSubscriber` cmdlet to get all event subscriber objects in the
session, including the subscribers that are hidden by using the **SupportEvent** parameter of the
event registration cmdlets.

It uses a pipeline operator (`|`) to send the subscriber objects to `Unregister-Event`, which
deletes them from the session. To complete the task, the **Force** parameter is also required on
`Unregister-Event`.

## PARAMETERS

### -Force

Cancels all event subscriptions, including subscriptions that were hidden by using the
**SupportEvent** parameter of `Register-ObjectEvent`, `Register-WmiEvent`, and
`Register-EngineEvent`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceIdentifier

Specifies a source identifier that this cmdlet cancels event subscriptions.

A **SourceIdentifier** or **SubscriptionId** parameter must be included in every command.

```yaml
Type: System.String
Parameter Sets: BySource
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionId

Specifies a source identifier ID that this cmdlet cancels event subscriptions.

A **SourceIdentifier** or **SubscriptionId** parameter must be included in every command.

```yaml
Type: System.Int32
Parameter Sets: ById
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Management.Automation.PSEventSubscriber

You can pipe the output from `Get-EventSubscriber` to `Unregister-Event`.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

No event sources available on the Linux or macOS platforms.

Events, event subscriptions, and the event queue exist only in the current session. If you close the
current session, the event queue is discarded and the event subscription is canceled.

`Unregister-Event` cannot delete events created by using the `New-Event` cmdlet unless you have
subscribed to the event by using the `Register-EngineEvent` cmdlet. To delete a custom event from
the session, you must remove it programmatically or close the session.

## RELATED LINKS

[Get-Event](Get-Event.md)

[Get-EventSubscriber](Get-EventSubscriber.md)

[New-Event](New-Event.md)

[Register-EngineEvent](Register-EngineEvent.md)

[Register-ObjectEvent](Register-ObjectEvent.md)

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)
