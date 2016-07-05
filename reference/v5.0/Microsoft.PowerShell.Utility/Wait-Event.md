---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294026
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

### Example 1: Wait for the next event
```
PS C:\>Wait-Event
```

This command waits for the next event that is raised.

### Example 2: Wait for an event with a specified source identifier
```
PS C:\>Wait-Event -SourceIdentifier "ProcessStarted"
```

This command waits for the next event that is raised and that has a source identifier of ProcessStarted.

### Example 3: Wait for a timer elapsed event
```
PS C:\>$Timer.Interval = 2000
PS C:\>$Timer.Autoreset = $False
PS C:\>$Timer.Enabled = $True; Wait-Event Timer.Elapsed
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

### Example 4: Wait for an event after a specified timeout
```
PS C:\>Wait-Event -SourceIdentifier "ProcessStarted" -Timeout 90
```

This command waits up to 90 seconds for the next event that is raised and that has a source identifier of "ProcessStarted".
If the specified time expires, the wait ends.

## PARAMETERS

### -SourceIdentifier
Waits only for events with the specified source identifier.
By default, Wait-Event waits for any event.

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
* Events, event subscriptions, and the event queue exist only in the current session. If you close the current session, the event queue is discarded and the event subscription is canceled.

*

## RELATED LINKS

[Get-Event](4ac85bbe-2abd-4e86-a313-edae6a08e435)

[Get-EventSubscriber](f03c3f66-0472-40d1-b971-ce4af6ea7c02)

[New-Event](d5f16c15-8a98-4221-8f96-0867578f5430)

[Register-EngineEvent](f5c43ecf-b8ef-44d2-b586-0480121c397c)

[Register-ObjectEvent](896cbb3f-f415-481e-985b-1999e95c7407)

[Register-WmiEvent](bc569c33-ee85-4a13-82c1-7d5f117f23f4)

[Remove-Event](7f3788ee-44af-407f-8f7b-9f1b4a262c71)

[Unregister-Event](313e8361-8646-4b0d-b72f-f76987c49591)

[Wait-Event](bd2e7d77-2642-4628-b937-0a7d52033399)

