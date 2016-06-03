---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Wait-Event
## SYNOPSIS
Waits until a particular event is raised before continuing to run.

## SYNTAX

```
Wait-Event [[-SourceIdentifier] <String>] [-Timeout <Int32>]
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
PS C:\>wait-event
```

This command waits for the next event that is raised.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>wait-event -sourceIdentifier "ProcessStarted"
```

This command waits for the next event that is raised and that has a source identifier of "ProcessStarted".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$timer.Interval = 2000
PS C:\>$timer.Autoreset = $false
PS C:\>$timer.Enabled = $true; Wait-Event Timer.Elapsed

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
PS C:\>wait-event -sourceIdentifier "ProcessStarted" -timeout 90
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
Accept pipeline input: true (ByPropertyName)
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
Aliases: 

Required: False
Position: Named
Default value: -1
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### System.String

## OUTPUTS

### System.Management.Automation.PSEventArgs

## NOTES
Events, event subscriptions, and the event queue exist only in the current session.
If you close the current session, the event queue is discarded and the event subscription is canceled.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=135276)

[Get-Event](4ac85bbe-2abd-4e86-a313-edae6a08e435)

[Get-EventSubscriber](f03c3f66-0472-40d1-b971-ce4af6ea7c02)

[New-Event](d5f16c15-8a98-4221-8f96-0867578f5430)

[Register-EngineEvent](f5c43ecf-b8ef-44d2-b586-0480121c397c)

[Register-ObjectEvent](896cbb3f-f415-481e-985b-1999e95c7407)

[Register-WmiEvent](00000000-0000-0000-0000-000000000000)

[Remove-Event](7f3788ee-44af-407f-8f7b-9f1b4a262c71)

[Unregister-Event](313e8361-8646-4b0d-b72f-f76987c49591)

[Wait-Event](bd2e7d77-2642-4628-b937-0a7d52033399)


