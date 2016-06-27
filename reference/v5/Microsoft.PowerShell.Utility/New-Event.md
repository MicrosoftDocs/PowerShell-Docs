---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293992
schema: 2.0.0
---

# New-Event
## SYNOPSIS
Creates a new event.

## SYNTAX

```
New-Event [-SourceIdentifier] <String> [[-Sender] <PSObject>] [[-EventArguments] <PSObject[]>]
 [[-MessageData] <PSObject>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The New-Event cmdlet creates a new custom event.

You can use custom events to notify users about state changes in your program and any change that your program can detect, including hardware or system conditions, application status, disk status, network status, or the completion of a background job.

Custom events are automatically added to the event queue in your session whenever they are raised; you do not need to subscribe to them.
However, if you want to forward an event to the local session or specify an action to respond to the event, use the Register-EngineEvent cmdlet to subscribe to the custom event.

When you subscribe to a custom event, the event subscriber is added to your session.
If you cancel the event subscription by using the Unregister-Event cmdlet, the event subscriber and custom event are deleted from the session.
If you do not subscribe to the custom event, to delete the event, you must change the program conditions or close the Windows PowerShell session.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>new-event -sourceidentifier Timer -sender windows.timer  -messagedata "Test"
```

This command creates a new event in the Windows PowerShell event queue.
It uses a Windows.Timer object to send the event.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>function Enable-ProcessCreationEvent
{
   $query = New-Object System.Management.WqlEventQuery "__InstanceCreationEvent", (New-Object TimeSpan 0,0,1), "TargetInstance isa 'Win32_Process'"
   $processWatcher = New-Object System.Management.ManagementEventWatcher $query
   $identifier = "WMI.ProcessCreated"
   Register-ObjectEvent $processWatcher "EventArrived" -SupportEvent $identifier -Action 
   {
      [void] (New-Event -sourceID "PowerShell.ProcessCreated" -Sender $args[0] -EventArguments $args[1].SourceEventArgs.NewEvent.TargetInstance)
   }
}
```

This sample function uses the New-Event cmdlet to raise an event in response to another event.
The command uses the Register-ObjectEvent cmdlet to subscribe to the Windows Management Instrumentation (WMI) event that is raised when a new process is created.
The command uses the Action parameter of the cmdlet to call the New-Event cmdlet, which creates the new event.

Because the events that New-Event raises are automatically added to the Windows PowerShell event queue, you do not need to register for that event.

## PARAMETERS

### -EventArguments
Specifies an object that contains options for the event.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
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

### -MessageData
Specifies additional data associated with the event.
The value of this parameter appears in the MessageData property of the event object.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sender
Specifies the object that raises the event.
The default is the Windows PowerShell engine.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceIdentifier
Specifies a name for the new event.
This parameter is required, and it must be unique in the session.

The value of this parameter appears in the SourceIdentifier property of the events.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSEventArgs

## NOTES
The new custom event, the event subscription, and the event queue exist only in the current session.
If you close the current session, the event queue is discarded and the event subscription is canceled.

## RELATED LINKS

[Get-Event]()

[Register-EngineEvent]()

[Register-ObjectEvent]()

[Register-WmiEvent]()

[Remove-Event]()

[Unregister-Event]()

[Wait-Event]()

