---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293968
schema: 2.0.0
---

# Get-EventSubscriber
## SYNOPSIS
Gets the event subscribers in the current session.

## SYNTAX

### BySource (Default)
```
Get-EventSubscriber [[-SourceIdentifier] <String>] [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### ById
```
Get-EventSubscriber [-SubscriptionId] <Int32> [-Force] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Get-EventSubscriber cmdlet gets the event subscribers in the current session.

When you subscribe to an event by using a Register event cmdlet, an event subscriber is added to your Windows PowerShell session, and the events to which you subscribed are added to your event queue whenever they are raised.
To cancel an event subscription, delete the event subscriber by using the Unregister-Event cmdlet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$timer = New-Object Timers.Timer
PS C:\>$timer | Get-Member -Type Event
PS C:\>Register-ObjectEvent -inputObject $timer -EventName Elapsed -SourceIdentifier Timer.Elapsed
PS C:\>Get-EventSubscriber
PS C:\>$timer = New-Object Timers.Timer
PS C:\>$timer | Get-Member -Type Event
TypeName: System.Timers.Timer

Name     MemberType Definition
----     ---------- ----------
Disposed Event      System.EventHandler Disposed(System.Object, System.EventArgs)
Elapsed  Event      System.Timers.ElapsedEventHandler Elapsed(System.Object, System.Timers.ElapsedEventArgs)

PS C:\>Register-ObjectEvent -InputObject $timer -EventName Elapsed -SourceIdentifier Timer.Elapsed
PS C:\>Get-EventSubscriber

SubscriptionId   : 4
SourceObject     : System.Timers.Timer
EventName        : Elapsed
SourceIdentifier : Timer.Elapsed
Action           :
HandlerDelegate  :
SupportEvent     : False
ForwardEvent     : False
```

This example uses a Get-EventSubscriber command to get the event subscriber for a timer event.

The first command uses the New-Object cmdlet to create an instance of a timer object.
It saves the new timer object in the $timer variable.

The second command uses the Get-Member cmdlet to display the events that are available for timer objects.
The command uses the Type parameter of the Get-Member cmdlet with a value of Event.

The third command uses the Register-ObjectEvent cmdlet to register for the Elapsed event on the timer object.

The fourth command uses the Get-EventSubscriber cmdlet to get the event subscriber for the Elapsed event.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$timer  = New-Object Timers.Timer
PS C:\>$timer.Interval = 500
PS C:\>Register-ObjectEvent -inputObject $timer -eventName Elapsed -sourceIdentifier Timer.Random -Action { $random = Get-Random -Min 0 -Max 100 }

Id  Name           State      HasMoreData  Location  Command
--  ----           -----      -----------  --------  -------
3   Timer.Random   NotStarted False                  $random = Get-Random ...

PS C:\>$timer.Enabled = $true
PS C:\>$subscriber = Get-EventSubcriber -sourceIdentifer Timer.Random
PS C:\>($subscriber.action).gettype().fullname
PSEventJob

PS C:\>$subscriber.action | format-list -property *

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
PS C:\>& $subscriber.action.module {$random}
96

PS C:\>& $subscriber.action.module {$random}
23
```

This example shows how to use the dynamic module in the PSEventJob object in the Action property of the event subscriber.

The first command uses the New-Object cmdlet to create a timer object.
The second command sets the interval of the timer to 500 (milliseconds).

The third command uses the Register-ObjectEvent cmdlet to register the Elapsed event of the timer object.
The command includes an action that handles the event.
Whenever the timer interval elapses, an event is raised and the commands in the action run.
In this case, the Get-Random cmdlet generates a random number between 0 and 100 and saves it in the $random variable.
The source identifier of the event is Timer.Random.

When you use an Action parameter in a Register-ObjectEvent command, the command returns a PSEventJob object that represents the action.

The fourth command enables the timer.

The fifth command uses the Get-EventSubscriber cmdlet to get the event subscriber of the Timer.Random event.
It saves the event subscriber object in the $subscriber variable.

The sixth command shows that the Action property of the event subscriber object contains a PSEventJob object.
In fact, it contains the same PSEventJob object that the Register-ObjectEvent command returned.

The seventh command uses the Format-List cmdlet to display all of the properties of the PSEventJob object in the Action property in a list.
The result reveal that the PSEventJob object has a Module property that contains a dynamic script module that implements the action.

The remaining commands use the call operator (&) to invoke the command in the module and display the value of the $random variable.
You can use the call operator to invoke any command in a module, including commands that are not exported.
In this case, the commands show the random number that is being generated when the Elapsed event occurs.

For more information about modules, see about_Modules.

## PARAMETERS

### -Force
Gets all event subscribers, including subscribers for events that are hidden by using the SupportEvent parameter of Register-ObjectEvent, Register-WmiEvent, and Register-EngineEvent.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
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
Gets only the event subscribers with the specified SourceIdentifier property value.
By default, Get-EventSubscriber gets all event subscribers in the session.
Wildcards are not permitted.
This parameter is case-sensitive.

```yaml
Type: String
Parameter Sets: BySource
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionId
Gets only the specified subscription identifier.
By default, Get-EventSubscriber gets all event subscribers in the session.

```yaml
Type: Int32
Parameter Sets: ById
Aliases: Id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSEventSubscriber
Get-EventSubscriber returns an object that represents each event subscriber.

## NOTES
The New-Event cmdlet, which creates a custom event, does not generate a subscriber.
Therefore, the Get-EventSubscriber cmdlet will not find a subscriber object for these events.
However, if you use the Register-EngineEvent cmdlet to subscribe to a custom event (in order to forward the event or to specify an action), Get-EventSubscriber will find the subscriber that Register-EngineEvent generates.

Events, event subscriptions, and the event queue exist only in the current session.
If you close the current session, the event queue is discarded and the event subscription is canceled.

## RELATED LINKS

[Get-Event]()

[New-Event]()

[Register-EngineEvent]()

[Register-ObjectEvent]()

[Register-WmiEvent]()

[Remove-Event]()

[Unregister-Event]()

[Wait-Event]()

