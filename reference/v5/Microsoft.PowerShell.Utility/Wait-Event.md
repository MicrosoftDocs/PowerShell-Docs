---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294026
schema: 2.0.0
---

# Wait-Event
## SYNOPSIS
Waits until a particular event is raised before continuing to run.

## SYNTAX

```
Wait-Event [[-SourceIdentifier] <String>] [-Timeout <Int32>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
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
Waits only for events with the specified source identifier.
By default, Wait-Events waits for any event.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
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
Default value: None
Accept pipeline input: False
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

[Get-Event]()

[Get-EventSubscriber]()

[New-Event]()

[Register-EngineEvent]()

[Register-ObjectEvent]()

[Register-WmiEvent]()

[Remove-Event]()

[Unregister-Event]()

[Wait-Event]()

