---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-eventsubscriber?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-EventSubscriber
---
# Get-EventSubscriber

## SYNOPSIS
Gets the event subscribers in the current session.

## SYNTAX

### BySource (Default)

```
Get-EventSubscriber [[-SourceIdentifier] <String>] [-Force] [<CommonParameters>]
```

### ById

```
Get-EventSubscriber [-SubscriptionId] <Int32> [-Force] [<CommonParameters>]
```

## DESCRIPTION

The **Get-EventSubscriber** cmdlet gets the event subscribers in the current session.

When you subscribe to an event by using a Register event cmdlet, an event subscriber is added to your PowerShell session, and the events to which you subscribed are added to your event queue whenever they are raised.
To cancel an event subscription, delete the event subscriber by using the Unregister-Event cmdlet.

## EXAMPLES

### Example 1: Get the event subscriber for a timer event

```
PS C:\> $Timer = New-Object Timers.Timer
PS C:\> $Timer | Get-Member -Type Event
PS C:\> Register-ObjectEvent -InputObject $Timer -EventName Elapsed -SourceIdentifier Timer.Elapsed
PS C:\> Get-EventSubscriber
PS C:\> $Timer = New-Object Timers.Timer
PS C:\> $Timer | Get-Member -Type Event
TypeName: System.Timers.Timer
Name     MemberType Definition
----     ---------- ----------
Disposed Event      System.EventHandler Disposed(System.Object, System.EventArgs)
Elapsed  Event      System.Timers.ElapsedEventHandler Elapsed(System.Object, System.Timers.ElapsedEventArgs) PS C:\> Register-ObjectEvent -InputObject $Timer -EventName Elapsed -SourceIdentifier Timer.Elapsed
PS C:\> Get-EventSubscriber
SubscriptionId   : 4
SourceObject     : System.Timers.Timer
EventName        : Elapsed
SourceIdentifier : Timer.Elapsed
Action           :
HandlerDelegate  :
SupportEvent     : False
ForwardEvent     : False
```

This example uses a **Get-EventSubscriber** command to get the event subscriber for a timer event.

The first command uses the New-Object cmdlet to create an instance of a timer object.
It saves the new timer object in the $Timer variable.

The second command uses the Get-Member cmdlet to display the events that are available for timer objects.
The command uses the Type parameter of the **Get-Member** cmdlet with a value of Event.

The third command uses the Register-ObjectEvent cmdlet to register for the Elapsed event on the timer object.

The fourth command uses the **Get-EventSubscriber** cmdlet to get the event subscriber for the Elapsed event.

### Example 2: Use the dynamic module in PSEventJob in the Action property of the event subscriber

```
PS C:\> $Timer = New-Object Timers.Timer
PS C:\> $Timer.Interval = 500
PS C:\> Register-ObjectEvent -InputObject $Timer -EventName Elapsed -SourceIdentifier Timer.Random -Action { $Random = Get-Random -Min 0 -Max 100 }

Id  Name           State      HasMoreData  Location  Command
--  ----           -----      -----------  --------  -------
3   Timer.Random   NotStarted False                  $Random = Get-Random ...

PS C:\> $Timer.Enabled = $True
PS C:\> $Subscriber = Get-EventSubscriber -SourceIdentifier Timer.Random
PS C:\> ($Subscriber.action).gettype().fullname
System.Management.Automation.PSEventJob
PS C:\> $Subscriber.action | Format-List -Property *

State         : Running
Module        : __DynamicModule_6b5cbe82-d634-41d1-ae5e-ad7fe8d57fe0
StatusMessage :
HasMoreData   : True
Location      :
Command       : $random = Get-Random -Min 0 -Max 100
JobStateInfo  : Running
Finished      : System.Threading.ManualResetEvent
InstanceId    : 88944290-133d-4b44-8752-f901bd8012e2
Id            : 1
Name          : Timer.Random
ChildJobs     : {}
...

PS C:\> & $Subscriber.action.module {$Random}
96
PS C:\> & $Subscriber.action.module {$Random}
23
```

This example shows how to use the dynamic module in the **PSEventJob** object in the Action property of the event subscriber.

The first command uses the New-Object cmdlet to create a timer object.
The second command sets the interval of the timer to 500 (milliseconds).

The third command uses the Register-ObjectEvent cmdlet to register the Elapsed event of the timer object.
The command includes an action that handles the event.
Whenever the timer interval elapses, an event is raised and the commands in the action run.
In this case, the Get-Random cmdlet generates a random number between 0 and 100 and saves it in the $Random variable.
The source identifier of the event is Timer.Random.

When you use an *Action* parameter in a **Register-ObjectEvent** command, the command returns a **PSEventJob** object that represents the action.

The fourth command enables the timer.

The fifth command uses the **Get-EventSubscriber** cmdlet to get the event subscriber of the Timer.Random event.
It saves the event subscriber object in the $Subscriber variable.

The sixth command shows that the Action property of the event subscriber object contains a **PSEventJob** object.
In fact, it contains the same **PSEventJob** object that the **Register-ObjectEvent** command returned.

The seventh command uses the Format-List cmdlet to display all of the properties of the **PSEventJob** object in the Action property in a list.
The result reveals that the **PSEventJob** object has a Module property that contains a dynamic script module that implements the action.

The remaining commands use the call operator (&) to invoke the command in the module and display the value of the $Random variable.
You can use the call operator to invoke any command in a module, including commands that are not exported.
In this case, the commands show the random number that is being generated when the Elapsed event occurs.

For more information about modules, see [about_Modules](../Microsoft.PowerShell.Core/About/about_Modules.md).

## PARAMETERS

### -Force

Indicates that this cmdlet gets all event subscribers, including subscribers for events that are hidden by using the *SupportEvent* parameter of Register-ObjectEvent, Register-WmiEvent, and Register-EngineEvent.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceIdentifier

Specifies the **SourceIdentifier** property value that gets only the event subscribers.
By default, **Get-EventSubscriber** gets all event subscribers in the session.
Wildcards are not permitted.
This parameter is case-sensitive.

```yaml
Type: System.String
Parameter Sets: BySource
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionId

Specifies the subscription identifier that this cmdlet gets.
By default, **Get-EventSubscriber** gets all event subscribers in the session.

```yaml
Type: System.Int32
Parameter Sets: ById
Aliases: Id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSEventSubscriber

**Get-EventSubscriber** returns an object that represents each event subscriber.

## NOTES

* The New-Event cmdlet, which creates a custom event, does not generate a subscriber. Therefore, the **Get-EventSubscriber** cmdlet will not find a subscriber object for these events. However, if you use the Register-EngineEvent cmdlet to subscribe to a custom event (in order to forward the event or to specify an action), **Get-EventSubscriber** will find the subscriber that **Register-EngineEvent** generates.

  Events, event subscriptions, and the event queue exist only in the current session.
If you close the current session, the event queue is discarded and the event subscription is canceled.

*

## RELATED LINKS

[Get-Event](Get-Event.md)

[New-Event](New-Event.md)

[Register-EngineEvent](Register-EngineEvent.md)

[Register-ObjectEvent](Register-ObjectEvent.md)

[Remove-Event](Remove-Event.md)

[Unregister-Event](Unregister-Event.md)

[Wait-Event](Wait-Event.md)

