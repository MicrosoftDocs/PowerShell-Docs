---
description:  Explains how to disconnect and reconnect to a PowerShell Session (PSSession). 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 12/01/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote_disconnected_sessions?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote_Disconnected_Sessions
---

# About Remote Disconnected Sessions

## Short description

Explains how to disconnect and reconnect to a PowerShell Session (PSSession).

## Long description

Beginning in PowerShell 3.0, you can disconnect from a PSSession and reconnect
to the PSSession on the same computer or a different computer. The session
state is maintained and commands in the PSSession continue to run while the
session is disconnected.

The Disconnected Sessions feature is only available when the remote computer is
running PowerShell 3.0 or a later version.

The Disconnected Sessions feature allows you to close the session in which a
PSSession was created, and even close PowerShell, and shut down the computer,
without disrupting commands running in the PSSession. Disconnected sessions are
useful for running commands that take an extended time to complete, and
provides the time and device flexibility that IT professionals require.

You can't disconnect from an interactive session that is started by using the
`Enter-PSSession` cmdlet.

You can use disconnected sessions to manage PSSessions that were disconnected
unintentionally as the result of a computer or network outage.

In real-world use, the Disconnected Sessions feature allows you to begin
solving a problem, turn your attention to a higher priority issue, and then
resume work on the solution, even on a different computer in a different
location.

## Disconnected session cmdlets

The following cmdlets support the Disconnected Sessions feature:

- `Connect-PSSession`: Connects to a disconnected PSSession.
- `Disconnect-PSSession`: Disconnects a PSSession.
- `Get-PSSession`: Gets PSSessions on the local computer or on remote computers.
- `Receive-PSSession`: Gets the results of commands that ran in disconnected
  sessions.
- `Invoke-Command`: **InDisconnectedSession** parameter creates a PSSession and
  disconnects immediately.

## How the Disconnected Sessions feature works

Beginning in PowerShell 3.0, PSSessions are independent of the sessions in
which they're created. Active PSSessions are maintained on the remote computer
or **server-side** of the connection, even if the session in which the
PSSession was created is closed and the originating computer is shut down or
disconnected from the network.

In PowerShell 2.0, the PSSession is deleted from the remote computer when it's
disconnected from the originating session or the session in which it was
created ends.

When you disconnect a PSSession, the PSSession remains active and is maintained
on the remote computer. The session state changes from **Running** to
**Disconnected**. You can reconnect to a disconnected PSSession from the
current session or from a different session on the same computer, or from a
different computer. The remote computer that maintains the session must be
running and be connected to the network.

Commands in a disconnected PSSession continue to run uninterrupted on the
remote computer until the command completes or the output buffer fills. To
prevent a full output buffer from suspending a command, use the
**OutputBufferingMode** parameter of the `Disconnect-PSSession`,
`New-PSSessionOption`, or `New-PSTransportOption` cmdlets.

Disconnected sessions are maintained in the disconnected state on the remote
computer. They're available for you to reconnect, until you delete the
PSSession, such as by using the `Remove-PSSession` cmdlet, or until the idle
timeout of the PSSession expires. You can adjust the idle timeout of a
PSSession by using the **IdleTimeoutSec** or **IdleTimeout** parameters of the
`Disconnect-PSSession`, `New-PSSessionOption`, or `New-PSTransportOption`
cmdlets.

Another user can connect to PSSessions that you created, but only if they can
provide the credentials that were used to create the session, or use the
`RunAs` credentials of the session configuration.

## How to get PSSessions

Beginning in PowerShell 3.0, the `Get-PSSession` cmdlet gets PSSessions on the
local computer and remote computers. It can also get PSSessions that were
created in the current session.

To get PSSessions on the local computer or remote computers, use the
**ComputerName** or **ConnectionUri** parameters. Without parameters,
`Get-PSSession` gets PSSession that were created in the local session,
regardless of where they terminate.

When getting PSSessions, remember to look for them on the computer on which
they're maintained, that is, the remote or **server-side** computer.

For example, if you create a PSSession to the Server01 computer, get the
session from the Server01 computer. If you create a PSSession from another
computer to the local computer, get the session from the local computer.

The following command sequence shows how `Get-PSSession` works.

The first command creates a session to the Server01 computer. The session
resides on the Server01 computer.

```powershell
New-PSSession -ComputerName Server01
```

```Output
Id Name      ComputerName  State    ConfigurationName     Availability
-- ----      ------------  -----    -----------------     ------------
 2 Session2  Server01      Opened   Microsoft.PowerShell     Available
```

To get the session, use the **ComputerName** parameter of `Get-PSSession` with
a value of Server01.

```powershell
Get-PSSession -ComputerName Server01
```

```Output
Id Name      ComputerName  State    ConfigurationName     Availability
-- ----      ------------  -----    -----------------     ------------
 2 Session2  Server01      Opened   Microsoft.PowerShell     Available
```

If the value of the **ComputerName** parameter of `Get-PSSession` is localhost,
`Get-PSSession` gets PSSessions that terminate at and are maintained on the
local computer. It doesn't get PSSessions on the Server01 computer, even if
they were started on the local computer.

```powershell
Get-PSSession -ComputerName localhost
```

To get sessions that were created in the current session, use the
`Get-PSSession` cmdlet without parameters. In this example, `Get-PSSession`
gets the PSSession that was created in the current session and connects to the
Server01 computer.

```powershell
Get-PSSession
```

```Output
Id Name      ComputerName  State    ConfigurationName     Availability
-- ----      ------------  -----    -----------------     ------------
 2 Session2  Server01      Opened   Microsoft.PowerShell     Available
```

## How to disconnect sessions

To disconnect a PSSession, use the `Disconnect-PSSession` cmdlet. To identify
the PSSession, use the **Session** parameter, or pipeline a PSSession from the
`New-PSSession` or `Get-PSSession` cmdlets to `Disconnect-PSSession`.

The following command disconnects the PSSession to the Server01 computer.
Notice that the value of the **State** property is **Disconnected** and the
**Availability** is **None**.

```powershell
Get-PSSession -ComputerName Server01 | Disconnect-PSSession
```

```Output
Id Name      ComputerName  State         ConfigurationName     Availability
-- ----      ------------  -----         -----------------     ------------
 2 Session2  Server01      Disconnected  Microsoft.PowerShell          None
```

To create a disconnected session, use the **InDisconnectedSession** parameter
of the `Invoke-Command` cmdlet. It creates a session, starts the command, and
disconnects immediately, before the command can return any output.

The following command runs a `Get-WinEvent` command in a disconnected session
on the Server02 remote computer.

```powershell
Invoke-Command -ComputerName Server02 -InDisconnectedSession -ScriptBlock {
   Get-WinEvent -LogName "*PowerShell*" }
```

```Output
Id Name      ComputerName  State         ConfigurationName     Availability
-- ----      ------------  -----         -----------------     ------------
 4 Session3  Server02      Disconnected  Microsoft.PowerShell          None
```

## How to connect to disconnected sessions

You can connect to any available disconnected PSSession from the session in
which you created the PSSession or from other sessions on the local computer or
other computers.

You can create a PSSession, run commands in the PSSession, disconnect from the
PSSession, close PowerShell, and shut down the computer. Hours later, you can
open a different computer, get the PSSession, connect to it, and get the
results of commands that ran in the PSSession while it was disconnected. Then
you can run more commands in the session.

To connect a disconnected PSSession, use the `Connect-PSSession` cmdlet. Use
the **ComputerName** or **ConnectionUri** parameters to identify the PSSession,
or pipeline a PSSession from `Get-PSSession` to `Connect-PSSession`.

The following command gets the sessions on the Server02 computer. The output
includes two disconnected sessions, both of which are available.

```powershell
Get-PSSession -ComputerName Server02
```

```Output
Id Name      ComputerName   State         ConfigurationName     Availability
-- ----      ------------   -----         -----------------     ------------
 2 Session2  juneb-srv8320  Disconnected  Microsoft.PowerShell          None
 4 Session3  juneb-srv8320  Disconnected  Microsoft.PowerShell          None
```

The following command connects to Session2. The PSSession is now open and
available.

```powershell
Connect-PSSession -ComputerName Server02 -Name Session2
```

```Output
Id Name      ComputerName    State    ConfigurationName     Availability
-- ----      ------------    -----    -----------------     ------------
 2 Session2  juneb-srv8320   Opened   Microsoft.PowerShell     Available
```

## How to get the results

To get the results of commands that ran in a disconnected PSSession, use the
`Receive-PSSession` cmdlet.

You can use `Receive-PSSession` rather than using the `Connect-PSSession`
cmdlet. If the session is already reconnected, `Receive-PSSession` gets the
results of commands that ran when the session was disconnected. If the
PSSession is still disconnected, `Receive-PSSession` connects to it and then
gets the results of commands that ran while it was disconnected.

`Receive-PSSession` can return the results in a job (asynchronously) or to the
host program (synchronously). Use the **OutTarget** parameter to select **Job**
or **Host**. The default value is **Host**. However, if the command that's
being received was started in the current session as a **Job**, it's returned
as a **Job** by default.

The following command uses the `Receive-PSSession` cmdlet to connect to the
PSSession on the Server02 computer and get the results of the `Get-WinEvent`
command that ran in the Session3 session. The command uses the **OutTarget**
parameter to get the results in a **Job**.

```powershell
Receive-PSSession -ComputerName Server02 -Name Session3 -OutTarget Job
```

```Output
Id   Name   PSJobTypeName   State         HasMoreData     Location
--   ----   -------------   -----         -----------     --------
 3   Job3   RemoteJob       Running       True            Server02
```

To get the job's results, use the `Receive-Job` cmdlet.

```powershell
Get-Job | Receive-Job -Keep
```

```Output
ProviderName: PowerShell

TimeCreated             Id LevelDisplayName Message     PSComputerName
-----------             -- ---------------- -------     --------------
5/14/2012 7:26:04 PM   400 Information      Engine stat Server02
5/14/2012 7:26:03 PM   600 Information      Provider "W Server02
5/14/2012 7:26:03 PM   600 Information      Provider "C Server02
5/14/2012 7:26:03 PM   600 Information      Provider "V Server02
```

## State and Availability properties

The **State** and **Availability** properties of a disconnected PSSession tell
you whether the session is available for you to reconnect to it.

When a PSSession is connected to the current session, its state is **Opened**
and its availability is **Available**. When you disconnect from the PSSession,
the PSSession state is **Disconnected** and its availability is **None**.

The value of the **State** property is relative to the current session. A value
of **Disconnected** means that the PSSession isn't connected to the current
session. But, it doesn't mean that the PSSession is disconnected from all
sessions. It might be connected to a different session.

To determine whether you can connect or reconnect to the PSSession, use the
**Availability** property. A value of **None** indicates that you can connect
to the session. A value of **Busy** indicates that you can't connect to the
PSSession because it's connected to another session.

The following example is run in two PowerShell sessions on the same computer.
Note the changing values of the **State** and **Availability** properties in
each session as the PSSession is disconnected and reconnected.

```powershell
# Session 1
New-PSSession -ComputerName Server30 -Name Test
```

```Output
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
1  Test   Server30        Opened        Microsoft.PowerShell     Available
```

```powershell
# Session 2
Get-PSSession -ComputerName Server30 -Name Test
```

```Output
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
1 Test    Server30        Disconnected  Microsoft.PowerShell          Busy
```

```powershell
# Session 1
Get-PSSession -ComputerName Server30 -Name Test | Disconnect-PSSession
```

```Output
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
1 Test    Server30        Disconnected  Microsoft.PowerShell          None
```

```powershell
# Session 2
Get-PSSession -ComputerName Server30
```

```Output
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
1 Test    Server30        Disconnected  Microsoft.PowerShell          None
```

```powershell
# Session 2
Connect-PSSession -ComputerName Server30 -Name Test
```

```Output
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
3 Test    Server30        Opened        Microsoft.PowerShell     Available
```

```powershell
# Session 1
Get-PSSession -ComputerName Server30
```

```Output
Id Name   ComputerName    State         ConfigurationName     Availability
-- ----   ------------    -----         -----------------     ------------
1 Test    Server30        Disconnected  Microsoft.PowerShell          Busy
```

```Output
# Idle Timeout
```

Disconnected sessions are maintained on the remote computer until you delete
them, such as by using the `Remove-PSSession` cmdlet, or they time out. The
**IdleTimeout** property of a PSSession determines how long a disconnected
session is maintained before it's deleted.

PSSessions are idle when the **heartbeat thread** receives no response.
Disconnecting a session makes it idle and starts the **IdleTimeout** clock,
even if commands are still running in the disconnected session. PowerShell
considers disconnected sessions to be active, but idle.

When creating and disconnecting sessions, verify that the idle timeout in the
PSSession is long enough to maintain the session for your needs, but not so
long that it consumes unnecessary resources on the remote computer.

The **IdleTimeoutMs** property of the session configuration determines the
default idle timeout of sessions that use the session configuration. You can
override the default value, but the value that you use can't exceed the
**MaxIdleTimeoutMs** property of the session configuration.

To find the value of the **IdleTimeoutMs** and **MaxIdleTimeoutMs** values of a
session configuration, use the following command format.

```powershell
Get-PSSessionConfiguration |
  Format-Table Name, IdleTimeoutMs, MaxIdleTimeoutMs
```

You can override the default value in the session configuration and set the
idle timeout of a PSSession when you create a PSSession and when you
disconnect.

If you're a member of the Administrators group on the remote computer, you can
create and change the **IdleTimeoutMs** and **MaxIdleTimeoutMs** properties of
session configurations.

## Idle timeout values

The idle timeout value of session configurations and session options is in
milliseconds. The idle timeout value of sessions and session configuration
options is in seconds.

You can set the idle timeout of a PSSession when you create the PSSession
(`New-PSSession`, `Invoke-Command`) and when you disconnect from it
(`Disconnect-PSSession`). However, you can't change the **IdleTimeout** value
when you connect to the PSSession (`Connect-PSSession`) or get results
(`Receive-PSSession`).

The `Connect-PSSession` and `Receive-PSSession` cmdlets have a
**SessionOption** parameter that takes a **SessionOption** object, such as one
returned by the `New-PSSessionOption` cmdlet. The **IdleTimeout** value in
**SessionOption** object and the **IdleTimeout** value in the
`$PSSessionOption` preference variable don't change the value of the
**IdleTimeout** of the PSSession in a `Connect-PSSession` or
`Receive-PSSession` command.

To create a PSSession with a particular idle timeout value, create a
`$PSSessionOption` preference variable. Set the value of the **IdleTimeout**
property to the desired value (in milliseconds).

When you create PSSessions, the values in `$PSSessionOption` variable take
precedence over the values in the session configuration.

For example, the following command sets an idle timeout of 48 hours:

```powershell
$PSSessionOption = New-PSSessionOption -IdleTimeoutMSec 172800000
```

To create a PSSession with a particular idle timeout value, use the
**IdleTimeoutMSec** parameter of the `New-PSSessionOption` cmdlet. Then, use
the session option in the value of the **SessionOption** parameter of the
`New-PSSession` or `Invoke-Command` cmdlets.

The values set when creating the session take precedence over the values set
in the `$PSSessionOption` preference variable and the session configuration.

For example:

```powershell
$o = New-PSSessionOption -IdleTimeoutMSec 172800000
New-PSSession -SessionOption $o
```

To change the idle timeout of a PSSession when disconnecting, use the
**IdleTimeoutSec** parameter of the `Disconnect-PSSession` cmdlet.

For example:

```powershell
Disconnect-PSSession -IdleTimeoutSec 172800
```

To create a session configuration with a particular idle timeout and maximum
idle timeout, use the **IdleTimeoutSec** and **MaxIdleTimeoutSec** parameters
of the `New-PSTransportOption` cmdlet. Then, use the transport option in the
value of the **TransportOption** parameter of
`Register-PSSessionConfiguration`.

For example:

```powershell
$o = New-PSTransportOption -IdleTimeoutSec 172800 -MaxIdleTimeoutSec 259200
Register-PSSessionConfiguration -Name Test -TransportOption $o
```

To change the default idle timeout and maximum idle timeout of a session
configuration, use the **IdleTimeoutSec** and **MaxIdleTimeoutSec**
parameters of the `New-PSTransportOption` cmdlet. Then, use the transport
option in the value of the **TransportOption** parameter of
`Set-PSSessionConfiguration`.

For example:

```powershell
$o = New-PSTransportOption -IdleTimeoutSec 172800 -MaxIdleTimeoutSec 259200
Set-PSSessionConfiguration -Name Test -TransportOption $o
```

## Output buffering mode

The output buffering mode of a PSSession determines how command output is
managed when the output buffer of the PSSession is full.

In a disconnected session, the output buffering mode effectively determines
whether the command continues to run while the session is disconnected.

The valid values as follows:

- **Block**. When the output buffer is full, execution is suspended until the
  buffer is clear. The default value.
- **Drop**. When the output buffer is full, execution continues. As new output
  is generated, the oldest output is discarded.

**Block** preserves data, but might interrupt the command. A value of **Drop**
allows the command to complete, although data might be lost. When using the
**Drop** value, redirect the command output to a file on disk. This value is
recommended for disconnected sessions.

The **OutputBufferingMode** property of the session configuration determines
the default output buffering mode of sessions that use the session
configuration.

To find a session configuration's value of the **OutputBufferingMode**, you can
use either of the following command formats:

```powershell
(Get-PSSessionConfiguration <ConfigurationName>).OutputBufferingMode
```

```powershell
Get-PSSessionConfiguration | Format-Table Name, OutputBufferingMode
```

You can override the default value in the session configuration and set the
output buffering mode of a PSSession when you create a PSSession, when you
disconnect, and when you reconnect.

If you're a member of the Administrators group on the remote computer, you can
create and change the output buffering mode of session configurations.

To create a PSSession with an output buffering mode of **Drop**, create a
`$PSSessionOption` preference variable in which the value of the
**OutputBufferingMode** property is **Drop**.

When you create PSSessions, the values in `$PSSessionOption` variable take
precedence over the values in the session configuration.

For example:

```powershell
$PSSessionOption = New-PSSessionOption -OutputBufferingMode Drop
```

To create a PSSession with an output buffering mode of **Drop**, use the
**OutputBufferingMode** parameter of the `New-PSSessionOption` cmdlet to
create a session option with a value of **Drop**. Then, use the session
option in the value of the **SessionOption** parameter of the `New-PSSession`
or `Invoke-Command` cmdlets.

The values set when creating the session take precedence over the values set
in the `$PSSessionOption` preference variable and the session configuration.

For example:

```powershell
$o = New-PSSessionOption -OutputBufferingMode Drop
New-PSSession -SessionOption $o
```

To change the output buffering mode of a PSSession when disconnecting, use
the **OutputBufferingMode** parameter of the `Disconnect-PSSession` cmdlet.

For example:

```powershell
Disconnect-PSSession -OutputBufferingMode Drop
```

To change the output buffering mode of a PSSession when reconnecting, use the
**OutputBufferingMode** parameter of the `New-PSSessionOption` cmdlet to
create a session option with a value of **Drop**. Then, use the session
option in the value of the **SessionOption** parameter of `Connect-PSSession`
or `Receive-PSSession`.

For example:

```powershell
$o = New-PSSessionOption -OutputBufferingMode Drop
Connect-PSSession -ComputerName Server01 -Name Test -SessionOption $o
```

To create a session configuration with a default output buffering mode of
**Drop**, use the **OutputBufferingMode** parameter of the
`New-PSTransportOption` cmdlet to create a transport option object with a
value of **Drop**. Then, use the transport option in the value of the
**TransportOption** parameter of `Register-PSSessionConfiguration`.

For example:

```powershell
$o = New-PSTransportOption -OutputBufferingMode Drop
Register-PSSessionConfiguration -Name Test -TransportOption $o
```

To change the default output buffering mode of a session configuration, use
the **OutputBufferingMode** parameter of the `New-PSTransportOption` cmdlet
to create a transport option with a value of **Drop**. Then, use the
Transport option in the value of the **SessionOption** parameter of
`Set-PSSessionConfiguration`.

For example:

```powershell
$o = New-PSTransportOption -OutputBufferingMode Drop
Set-PSSessionConfiguration -Name Test -TransportOption $o
```

## Disconnecting loopback sessions

Loopback sessions, or local sessions, are PSSessions that originate and
terminate on the same computer. Like other PSSessions, active loopback sessions
are maintained on the computer on the remote end of the connection (the local
computer), so you can disconnect from and reconnect to loopback sessions.

By default, loopback sessions are created with a network security token that
doesn't permit commands run in the session to access other computers. You can
reconnect to loopback sessions that have a network security token from any
session on the local computer or a remote computer.

However, if you use the **EnableNetworkAccess** parameter of the
`New-PSSession`, `Enter-PSSession`, or `Invoke-Command` cmdlet, the loopback
session is created with an interactive security token. The interactive token
enables commands that run in the loopback session to get data from other
computers.

You can disconnect loopback sessions with interactive tokens and then reconnect
to them from the same session or a different session on the same computer.
However, to prevent malicious access, you can reconnect to loopback sessions
with interactive tokens only from the computer on which they were created.

## Waiting for jobs in disconnected sessions

The `Wait-Job` cmdlet waits until a job completes and then returns to the
command prompt or the next command. By default, `Wait-Job` returns if the
session in which a job is running is disconnected. To direct the `Wait-Job`
cmdlet to wait until the session is reconnected, in the **Opened** state, use
the **Force** parameter. For more information, see [Wait-Job](xref:Microsoft.PowerShell.Core.Wait-Job).

## Robust sessions and unintentional disconnection

A PSSession might be unintentionally disconnected because of a computer failure
or network outage. PowerShell attempts to recover the PSSession, but its
success depends upon the severity and duration of the cause.

The state of an unintentionally disconnected PSSession might be **Broken** or
**Closed**, but it might also be **Disconnected**. If the value of **State** is
**Disconnected**, you can use the same techniques to manage the PSSession as
you would if the session were disconnected intentionally. For example, you can
use the `Connect-PSSession` cmdlet to reconnect to the session and the
`Receive-PSSession` cmdlet to get results of commands that ran while the
session was disconnected.

If you close (exit) the session in which a PSSession was created while commands
are running in the PSSession, PowerShell maintains the PSSession in the
**Disconnected** state on the remote computer. If you close (exit) the session
in which a PSSession was created, but no commands are running in the PSSession,
PowerShell doesn't attempt to maintain the PSSession.

## See also

[about_Jobs](about_Jobs.md)

[about_Remote](about_Remote.md)

[about_Remote_Variables](about_Remote_Variables.md)

[about_PSSessions](about_PSSessions.md)

[about_Session_Configurations](about_Session_Configurations.md)

[Connect-PSSession](xref:Microsoft.PowerShell.Core.Connect-PSSession)

[Disconnect-PSSession](xref:Microsoft.PowerShell.Core.Disconnect-PSSession)

[Get-PSSession](xref:Microsoft.PowerShell.Core.Get-PSSession)

[Receive-PSSession](xref:Microsoft.PowerShell.Core.Receive-PSSession)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)
