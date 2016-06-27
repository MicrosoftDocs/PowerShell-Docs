---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294022
schema: 2.0.0
---

# Unregister-Event
## SYNOPSIS
Cancels an event subscription.

## SYNTAX

### BySource (Default)
```
Unregister-Event [-SourceIdentifier] <String> [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### ById
```
Unregister-Event [-SubscriptionId] <Int32> [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Unregister-Event cmdlet cancels an event subscription that was created by using the Register-EngineEvent, Register-ObjectEvent, or Register-WmiEvent cmdlet.

When an event subscription is canceled, the event subscriber is deleted from the session and the subscribed events are no longer added to the event queue.
When you cancel a subscription to an event created by using the New-Event cmdlet, the new event is also deleted from the session.

Unregister-Event does not delete events from the event queue.
To delete events, use the Remove-Event cmdlet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>unregister-event -sourceIdentifier ProcessStarted
```

This command cancels the event subscription that has a source identifier of "ProcessStarted".

To find the source identifier of an event, use the Get-Event cmdlet.
To find the source identifier of an event subscription, use the Get-EventSubscriber cmdlet.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>unregister-event -subscriptionId 2
```

This command cancels the event subscription that has a subscription identifier of 2.

To find the subscription identifier of an event subscription, use the Get-EventSubscriber cmdlet.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-eventsubscriber -force | unregister-event -force
```

This command cancels all event subscriptions in the session.

The command uses the Get-EventSubscriber cmdlet to get all event subscriber objects in the session, including the subscribers that are hidden by using the SupportEvent parameter of the event registration cmdlets.

It uses a pipeline operator (|) to send the subscriber objects to Unregister-Event, which deletes them from the session.
To complete the task, the Force parameter is also required on Unregister-Event.

## PARAMETERS

### -Force
Cancels all event subscriptions, including subscriptions that were hidden by using the SupportEvent parameter of Register-ObjectEvent, Register-WmiEvent, and Register-EngineEvent.

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
Cancels event subscriptions that have the specified source identifier.

A SourceIdentifier or SubscriptionId parameter must be included in every command.

```yaml
Type: String
Parameter Sets: BySource
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionId
Cancels event subscriptions that have the specified subscription identifier.

A SourceIdentifier or SubscriptionId parameter must be included in every command.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Management.Automation.PSEventSubscriber
You can pipe the output from Get-EventSubscriber to Unregister-Event.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
Events, event subscriptions, and the event queue exist only in the current session.
If you close the current session, the event queue is discarded and the event subscription is canceled.

Unregister-Event cannot delete events created by using the New-Event cmdlet unless you have subscribed to the event by using the Register-EngineEvent cmdlet.
To delete a custom event from the session, you must remove it programmatically or close the session.

## RELATED LINKS

[Get-Event]()

[Get-EventSubscriber]()

[New-Event]()

[Register-EngineEvent]()

[Register-ObjectEvent]()

[Register-WmiEvent]()

[Remove-Event]()

[Unregister-Event]()

[Wait-Event]()

