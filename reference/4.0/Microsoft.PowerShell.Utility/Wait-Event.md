---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Wait Event
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/p/?linkid=294026
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Wait-Event

## SYNOPSIS
Waits until a particular event is raised before continuing to run.

## SYNTAX

```
Wait-Event [[-SourceIdentifier] <String>] [-Timeout <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Wait-Event cmdlet suspends execution of a script or function until a particular event is raised.
Execution resumes when the event is detected.
To cancel the wait, press CTRL+C.

This feature provides an alternative to polling for an event.
It also allows you to determine the response to an event in two different ways: by using the Action parameter of the event subscription and by waiting for an event to return and then respond with an action.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> wait-event
```

This command waits for the next event that is raised.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> wait-event -sourceIdentifier "ProcessStarted"
```

This command waits for the next event that is raised and that has a source identifier of "ProcessStarted".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> $timer.Interval = 2000
PS C:\> $timer.Autoreset = $false
PS C:\> $timer.Enabled = $true; Wait-Event Timer.Elapsed

# After 2 seconds

EventIdentifier  : 12
Sender           : System.Timers.Timer
SourceEventArgs  : System.Timers.ElapsedEventArgs
SourceArgs       : {System.Timers.Timer, System.Timers.ElapsedEventArgs}
SourceIdentifier : Timer.Elapsed
TimeGenerated    : 6/10/2008 3:24:18 PM
MessageData      :
ForwardEvent     : False
```

This command uses the Wait-Event cmdlet to wait for a timer event on a timer that is set for 2000 milliseconds.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\> wait-event -sourceIdentifier "ProcessStarted" -timeout 90
```

This command waits up to 90 seconds for the next event that is raised and that has a source identifier of "ProcessStarted".
If the specified time expires, the wait ends.

## PARAMETERS

### -SourceIdentifier
Waits only for events with the specified source identifier.
By default, Wait-Events waits for any event.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: All events
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Timeout
Determines the maximum time, in seconds, that Wait-Event waits for the event to occur.
The default, -1, waits indefinitely.
The timing starts when you submit the Wait-Event command.

If the specified time is exceeded, the wait ends and the command prompt returns, even if the event has not been raised.
No error message is displayed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Management.Automation.PSEventArgs

## NOTES
* Events, event subscriptions, and the event queue exist only in the current session. If you close the current session, the event queue is discarded and the event subscription is canceled.

*

## RELATED LINKS

[Get-Event](Get-Event.md)

[Get-EventSubscriber](Get-EventSubscriber.md)

[New-Event](New-Event.md)

[Register-EngineEvent](Register-EngineEvent.md)

[Register-ObjectEvent](Register-ObjectEvent.md)

[Register-WmiEvent](../Microsoft.PowerShell.Management/Register-WmiEvent.md)

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)

