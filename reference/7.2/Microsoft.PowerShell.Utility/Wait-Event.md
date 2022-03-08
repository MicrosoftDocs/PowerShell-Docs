---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/23/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/wait-event?view=powershell-7.2&WT.mc_id=ps-gethelp
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

The `Wait-Event` cmdlet suspends execution of a script or function until a particular event is
raised. Execution resumes when the event is detected. To cancel the wait, press
<kbd>CTRL</kbd>+<kbd>C</kbd>.

This feature provides an alternative to polling for an event. It also allows you to determine the
response to an event in two different ways:

- using the **Action** parameter of the event subscription
- waiting for an event to return and then respond with an action

## EXAMPLES

### Example 1: Wait for the next event

This example waits for the next event that is raised.

```powershell
Wait-Event
```

### Example 2: Wait for an event with a specified source identifier

This example waits for the next event that is raised and that has a source identifier of ProcessStarted.

```powershell
Wait-Event -SourceIdentifier "ProcessStarted"
```

### Example 3: Wait for a timer elapsed event

This example uses the `Wait-Event` cmdlet to wait for a timer event on a timer that is set for 2000 milliseconds.

```powershell
$Timer = New-Object Timers.Timer
$objectEventArgs = @{
    InputObject = $Timer
    EventName = 'Elapsed'
    SourceIdentifier = 'Timer.Elapsed'
}
Register-ObjectEvent @objectEventArgs
$Timer.Interval = 2000
$Timer.Autoreset = $False
$Timer.Enabled = $True
Wait-Event Timer.Elapsed
```

```Output
ComputerName     :
RunspaceId       : bb560b14-ff43-48d4-b801-5adc31bbc6fb
EventIdentifier  : 1
Sender           : System.Timers.Timer
SourceEventArgs  : System.Timers.ElapsedEventArgs
SourceArgs       : {System.Timers.Timer, System.Timers.ElapsedEventArgs}
SourceIdentifier : Timer.Elapsed
TimeGenerated    : 4/23/2020 2:30:37 PM
MessageData      :
```

### Example 4: Wait for an event after a specified timeout

This example waits up to 90 seconds for the next event that is raised and that has a source
identifier of **ProcessStarted**. If the specified time expires, the wait ends.

```powershell
Wait-Event -SourceIdentifier "ProcessStarted" -Timeout 90
```

## PARAMETERS

### -SourceIdentifier

Specifies the source identifier that this cmdlet waits for events.
By default, `Wait-Event` waits for any event.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Timeout

Specifies the maximum time, in seconds, that `Wait-Event` waits for the event to occur. The default,
-1, waits indefinitely. The timing starts when you submit the `Wait-Event` command.

If the specified time is exceeded, the wait ends and the command prompt returns, even if the event
has not been raised. No error message is displayed.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: Named
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Management.Automation.PSEventArgs

## NOTES

Events, event subscriptions, and the event queue exist only in the current session. If you close the
current session, the event queue is discarded and the event subscription is canceled.

## RELATED LINKS

[Get-Event](Get-Event.md)

[Get-EventSubscriber](Get-EventSubscriber.md)

[New-Event](New-Event.md)

[Register-EngineEvent](Register-EngineEvent.md)

[Register-ObjectEvent](Register-ObjectEvent.md)

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)

