---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821873
schema: 2.0.0
title: Wait-Event
---

# Wait-Event

## SYNOPSIS
Waits until a particular event is raised before continuing to run.

## SYNTAX

```
Wait-Event [[-SourceIdentifier] <String>] [-Timeout <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The **Wait-Event** cmdlet suspends execution of a script or function until a particular event is raised.
Execution resumes when the event is detected.
To cancel the wait, press CTRL+C.

This feature provides an alternative to polling for an event.
It also allows you to determine the response to an event in two different ways: by using the *Action* parameter of the event subscription and by waiting for an event to return and then respond with an action.

## EXAMPLES

### Example 1: Wait for the next event
```
PS C:\> Wait-Event
```

This command waits for the next event that is raised.

### Example 2: Wait for an event with a specified source identifier
```
PS C:\> Wait-Event -SourceIdentifier "ProcessStarted"
```

This command waits for the next event that is raised and that has a source identifier of ProcessStarted.

### Example 3: Wait for a timer elapsed event
```
PS C:\> $Timer.Interval = 2000
PS C:\> $Timer.Autoreset = $False
PS C:\> $Timer.Enabled = $True; Wait-Event Timer.Elapsed
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

This command uses the **Wait-Event** cmdlet to wait for a timer event on a timer that is set for 2000 milliseconds.

### Example 4: Wait for an event after a specified timeout
```
PS C:\> Wait-Event -SourceIdentifier "ProcessStarted" -Timeout 90
```

This command waits up to 90 seconds for the next event that is raised and that has a source identifier of "ProcessStarted".
If the specified time expires, the wait ends.

## PARAMETERS

### -SourceIdentifier
Specifies the source identifier that this cmdlet waits for events.
By default, **Wait-Event** waits for any event.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Timeout
Specifies the maximum time, in seconds, that**Wait-Event** waits for the event to occur.
The default, -1, waits indefinitely.
The timing starts when you submit the **Wait-Event** command.

If the specified time is exceeded, the wait ends and the command prompt returns, even if the event has not been raised.
No error message is displayed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: Named
Default value: None
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

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)