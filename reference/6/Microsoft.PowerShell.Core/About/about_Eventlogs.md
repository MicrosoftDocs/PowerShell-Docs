---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Eventlogs
---

# About Eventlogs

## Short Description

Windows PowerShell creates a Windows event log that is
named "Windows PowerShell" to record Windows PowerShell events. You can
view this log in Event Viewer or by using cmdlets that get events, such as
the `Get-EventLog` cmdlet. By default, Windows PowerShell engine and provider
events are recorded in the event log, but you can use the event log
preference variables to customize the event log. For example, you can add
events about Windows PowerShell commands.

## Long Description

The Windows PowerShell event log records details of Windows PowerShell
operations, such as starting and stopping the program engine and starting
and stopping the Windows PowerShell providers. You can also log details
about Windows PowerShell commands.

The Windows PowerShell event log is in the Application and Services Logs
group. The Windows PowerShell log is a classic event log that does not use
the Windows Eventing technology. To view the log, use the cmdlets designed
for classic event logs, such as `Get-EventLog`.

## Viewing the Windows PowerShell Event Log

You can view the Windows PowerShell event log in Event Viewer or by
using the `Get-EventLog` and `Get-WmiObject` cmdlets. To view the contents
of the Windows PowerShell log, type:

```powershell
Get-EventLog -LogName "Windows PowerShell"
```

To examine the events and their properties, use the `Sort-Object` cmdlet,
the `Group-Object` cmdlet, and the cmdlets that contain the `Format` verb
(the `Format` cmdlets).

For example, to view the events in the log grouped by the event ID, type:

```powershell
Get-EventLog "Windows PowerShell" | Format-Table -GroupBy EventID
```

Or, type:

```powershell
Get-EventLog "Windows PowerShell" |
	Sort-Object EventID |
	Group-Object EventID
```

To view all the classic event logs, type:

```powershell
Get-EventLog -List
```

You can also use the `Get-WmiObject` cmdlet to use the event-related
Windows Management Instumentation (WMI) classes to examine the event log.
For example, to view all the properties of the event log file, type:

```powershell
Get-WmiObject Win32_NTEventlogFile |
	where LogFileName -EQ "Windows PowerShell" |
	Format-List -Property *
```

To find the Win32 event-related WMI classes, type:

```powershell
Get-WmiObject -List | where Name -Like "win32*event*"
```

For more information, type "Get-Help Get-EventLog" and
"Get-Help Get-WmiObject".

## Selecting Events for the Windows PowerShell Event Log

You can use the event log preference variables to determine which events
are recorded in the Windows PowerShell event log.

There are six event log preference variables; two variables for each of
the three logging components: the engine (the Windows PowerShell
program), the providers, and the commands. The LifeCycleEvent variables
log normal starting and stopping events. The Health variables log error
events.

The following table lists the event log preference variables.

| Variable                   | Description                                                |
| -------------------------- | ---------------------------------------------------------- |
| $LogEngineLifeCycleEvent   | Logs starting and stopping of Windows PowerShell           |
| $LogEngineHealthEvent      | Logs Windows PowerShell program errors                     |
| $LogProviderLifeCycleEvent | Logs starting and stopping of Windows PowerShell providers |
| $LogProviderHealthEvent    | Logs Windows PowerShell provider errors                    |
| $LogCommandLifeCycleEvent  | Logs starting and completion of commands                   |
| $LogCommandHealthEvent     | Logs command errors                                        |

(For information about Windows PowerShell providers,
see [about_Providers](about_Providers.md).)

By default, only the following event types are enabled:

* $LogEngineLifeCycleEvent
* $LogEngineHealthEvent
* $LogProviderLifeCycleEvent
* $LogProviderHealthEvent

To enable an event type, set the preference variable for that event type
to $true. For example, to enable command life-cycle events, type:

```powershell
$LogCommandLifeCycleEvent
```

Or, type:

```powershell
$LogCommandLifeCycleEvent = $true
```

To disable an event type, set the preference variable for that event type
to $false. For example, to disable command life-cycle events, type:

```powershell
$LogProviderLifeCycleEvent = $false
```

You can disable any event, except for the events that indicate that the
Windows PowerShell engine and the core providers are started. These events
are generated before the Windows PowerShell profiles are run and before
the host program is ready to accept commands.

The variable settings apply only for the current Windows PowerShell
session. To apply them to all Windows PowerShell sessions, add them to
your Windows PowerShell profile.

## Logging Module Events

Beginning in Windows PowerShell 3.0, you can record execution events for the cmdlets
and functions in Windows PowerShell modules and snap-ins by setting the
LogPipelineExecutionDetails property of modules and snap-ins to TRUE. In Windows
PowerShell 2.0, this feature is available only for snap-ins.

When the LogPipelineExecutionDetails property value is TRUE (`$true`), Windows PowerShell
writes cmdlet and function execution events in the session to the Windows PowerShell
log in Event Viewer. The setting is effective only in the current session.

To enable logging of execution events of cmdlets and functions in a module, use the
following command sequence.

```powershell
Import-Module <ModuleName>
$m = Get-Module <ModuleName>
$m.LogPipelineExecutionDetails = $true
```

To enable logging of execution events of cmdlets in a snap-in, use the following
command sequence.

```powershell
$m = Get-PSSnapin <SnapInName> [-Registered]
$m.LogPipelineExecutionDetails = $True
```

To disable logging, use the same command sequence to set the property
value to FALSE (`$false`).

You can also use the "Turn on Module Logging" Group Policy setting to enable
and disable module and snap-in logging. The policy value includes a list of
module and snap-in names. Wildcards are supported.

When "Turn on Module Logging" is set for a module, the value of the
LogPipelineExecutionDetails property of the module is TRUE in all sessions
and it cannot be changed.

The Turn On Module Logging group policy setting is located in the following
Group Policy paths:

Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell
User Configuration\Administrative Templates\Windows Components\Windows PowerShell

The User Configuration policy takes precedence over the Computer Configuration policy,
and both policies take preference over the value of the LogPipelineExecutionDetails
property of modules and snap-ins.

For more information about this Group Policy setting,
see [about_Group_Policy_Settings](about_Group_Policy_Settings.md).

## Security and Auditing

The Windows PowerShell event log is designed to indicate activity and
to provide operational details for troubleshooting.

However, like most Windows-based application event logs, the
Windows PowerShell event log is not designed to be secure. It should not
be used to audit security or to record confidential or proprietary
information.

Event logs are designed to be read and understood by users. Users can
read from and write to the log. A malicious user could read an event log
on a local or remote computer, record false data, and then prevent the
logging of their activities.

## Notes

Authors of module authors can add logging features to their modules.
For more information, see
[Writing a Windows PowerShell Module](https://go.microsoft.com/fwlink/?LinkID=144916)
in the MSDN library.

## See Also

[Get-EventLog](https://go.microsoft.com/fwlink/?LinkId=821585)

[Get-WmiObject](https://go.microsoft.com/fwlink/?LinkId=821595)

[about_Group_Policy_Settings](about_Group_Policy_Settings.md)

[about_Preference_Variables](about_Preference_Variables.md)
