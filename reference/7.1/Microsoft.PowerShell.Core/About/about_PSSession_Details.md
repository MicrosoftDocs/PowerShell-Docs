---
description: Provides detailed information about PowerShell sessions and the role they play in remote commands. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pssession_details?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSSession_Details
---
# About PSSession Details

## Short Description
Provides detailed information about PowerShell sessions and the
role they play in remote commands.

## Long Description

A session is an environment in which PowerShell runs. A session is
created for you whenever you start PowerShell. You can create
additional sessions, called "PowerShell sessions" or "PSSessions"
on your computer or another computer.

Unlike the sessions that PowerShell creates for you, you control
and manage the PSSessions that you create.

PSSessions play an important role in remote computing. When you create a
PSSession that is connected to a remote computer, PowerShell
establishes a persistent connection to the remote computer to support the
PSSession. You can use the PSSession to run a series of commands,
functions, and scripts that share data.

This topic provides detailed information about sessions and PSSessions
in PowerShell. For basic information about the tasks that you
can perform with sessions, see [about_PSSessions](about_PSSessions.md).

## About Sessions

Technically, a session is an execution environment in which
PowerShell runs. Each session includes an instance of the
System.Management.Automation engine and a host program in which
PowerShell runs. The host can be the familiar PowerShell console
or another program that runs commands, such as Cmd.exe, or a program built
to host PowerShell, such as Windows PowerShell Integrated Scripting
Environment (ISE). From a Windows perspective, a session is a Windows
process on the target computer.

Each session is configured independently. It includes its own properties,
its own execution policy, and its own profiles. The environment that exists
when the session is created persists for its lifetime even if you change
the environment on the computer. All sessions are created in a global
scope, even sessions that you create in a script.

You can run only one command (or command pipeline) in a session at one
time. A second command run synchronously (one at a time) waits up to four
minutes for the first command to be completed. A second command run
asynchronously (concurrently) fails.

## About PSSessions

A session is created each time that you start PowerShell. And,
PowerShell creates temporary sessions to run individual commands.
However, you can also create sessions (called "PowerShell sessions"
or "PSSessions") that you control and manage.

PSSessions are critical to remote commands. If you use the **ComputerName**
parameter of the `Invoke-Command` or `Enter-PSSession` cmdlets, PowerShell
establishes a temporary session to run the command and then closes the session
as soon as the command or the interactive session is complete.

However, if you use the `New-PSSession` cmdlet to create a PSSession,
PowerShell establishes a persistent session on the remote computer in which you
can run multiple commands or interactive sessions. The PSSessions that you
create remain open and available for use until you delete them or until you
close the session in which they were created.

When you create a PSSession on a remote computer, the system creates a
PowerShell process on the remote computer and establishes a connection
from the local computer to the process on the remote computer. When you
create a PSSession on the local computer, both the new process and the
connections are created on the local computer.

## When Do I Need a PSSession?

The `Invoke-Command` and `Enter-PSSession` cmdlets have both **ComputerName** and
**Session** parameters. You can use either to run a remote command.

Use the **ComputerName** parameter to run a single command or a series of
unrelated commands on one or many computers.

To run commands that share data, you need a persistent connection to the
remote computer. In that case, create a PSSession, and then use the **Session**
parameter to run commands in the PSSession.

Many other cmdlets that get data from remote computers, such as
`Get-Process`, `Get-Service`, `Get-EventLog`, and `Get-WmiObject` have only a
**ComputerName** parameter. They use technologies other than PowerShell
remoting to gather data remotely. These cmdlets do not have a **Session**
parameter, but you can use the `Invoke-Command` cmdlet to run these commands
in a PSSession.

## How Do I Create a PSSession?

To create a PSSession, use the `New-PSSession` cmdlet. You can use
`New-PSSession` to create a PSSession on a local or remote computer.

## Can I Create a PSSession on Any Computer?

To create a PSSession that is connected to a remote computer, the computer
must be configured for remoting in PowerShell. The current user
must be a member of the Administrators group on the remote computer, or
the current user must be able to supply the credentials of a member of
the Administrators group. For more information,
see [about_Remote_Requirements](about_Remote_Requirements.md).

## Can I See My PSSessions in Other Sessions?

Beginning in Windows PowerShell 3.0, the **ComputerName**
parameter of the `Get-PSSession` cmdlet gets PSSessions
that you created on the specified remote computers.

Active PSSessions are maintained on the remote computer
(the "server-side" of a connection) and you can get them
from any session on any computer.

For example, if you create a PSSession from the Server01
computer to the Server02 computer, and then switch to the
Server03 computer, you can use a command like the following
one to get the session.

```powershell
Get-PSSession -ComputerName Server02
```

Even if you disconnect from the session, the session is
maintained on the remote computer until you delete it or it
times out.

In Windows PowerShell 2.0, you can get only the PSSessions
that you have created in the current session. You cannot get
PSSessions that you created in other sessions.

For more information, see [Get-PSSession](xref:Microsoft.PowerShell.Core.Get-PSSession).

## Can I See the PSSessions That Others Have Created on My Computer?

You can get and manage only the PSSessions that others have created
only if you can supply the credentials of the user who created the
PSSession or the session configuration that the PSSession uses
includes RunAs credentials. Otherwise, you can get, connect to, use,
and manage only the PSSessions that you created.

## Can I Connect to a PSSession From a Different Computer?

Beginning in Windows PowerShell 3.0, PSSessions are independent
of the sessions in which they were created. Active PSSessions
are maintained on the computer at the remote or "server-side" of
a connection.

You can use the `Disconnect-PSSession` cmdlet to disconnect
from a PSSession. The PSSession is disconnected from the
local session, but is maintained on the remote computer.
Commands continue to run in the disconnected PSSession. You
can close PowerShell and shut down the originating computer
without interrupting the PSSession.

Then, even hours later, you can use the `Get-PSSession` cmdlet to
get the PSSession and the `Connect-PSSession` cmdlet to connect to the
PSSession from a new session on a different computer.

For more information, see [about_Remote_Disconnected_Sessions](about_Remote_Disconnected_Sessions.md).

## What Happens to My PSSession if My Computer Stops?

Disconnected PSSessions are independent of the sessions
in which they were created. If you disconnect a PSSession
and then close the originating computer, the PSSession is
maintained on the remote computer.

In addition, PowerShell attempts to recover active
PSSessions that are disconnected unintentionally, such as
by a computer reboot, a temporary power outage or network
disruption. PowerShell attempts to maintain or recover
the PSSession to an Opened state, if the originating session
is still available, or to a disconnected state if it is not.

An "active" PSSession is one that is running commands. If
a PSSession is connected (not disconnected) and commands are
running in the PSSession when the connected session closes,
PowerShell attempts to maintain the PSSession on the
remote computer. However, if no commands are running in the
PSSession, PowerShell closes the PSSession when the
connected session closes.

For more information, see [about_Remote_Disconnected_Sessions](about_Remote_Disconnected_Sessions.md).

## Can I Run a Background Job in a PSSession?

Yes. A background job is a command that runs asynchronously in the
background without interacting with the current session. When you submit
a command to start a job, the command returns a job object, but the job
continues to run in the background until it is complete.

To start a background job on a local computer, use the `Start-Job` command.
You can run the background job in a temporary connection (by using the
**ComputerName** parameter) or in a PSSession (by using the **Session** parameter).

To start a background job on a remote computer, use the `Invoke-Command`
cmdlet with its **AsJob** parameter, or use the `Invoke-Command` cmdlet to run a
`Start-Job` command on a remote computer. When using the **AsJob** parameter,
you can use the **ComputerName** or **Session** parameters.

When using `Invoke-Command` to run a `Start-Job` command, you must run the
command in a PSSession. If you use the **ComputerName** parameter, PowerShell
ends the connection when the job object returns, and the job is interrupted.

For more information, see [about_Jobs](about_Jobs.md).

## Can I Run an Interactive Session?

Yes. To start an interactive session with a remote computer, use the
`Enter-PSSession` cmdlet. In an interactive session, the commands that you
type run on the remote computer, just as if you typed them directly on the
remote computer.

You can run an interactive session in a temporary session (by using the
**ComputerName** parameter) or in a PSSession (by using the **Session** parameter).
If you use a PSSession, the PSSession retains the data from previous
commands, and the PSSession retains any data generated during the
interactive session for use in later commands.

When you end the interactive session, the PSSession remains open and
available for use.

For more information, see [Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession) and [Exit-PSSession](xref:Microsoft.PowerShell.Core.Exit-PSSession).

## Must I Delete the PSSessions?

Yes. A PSSession is a process, which is a self-contained environment that
uses memory and other resources even when you are not using it. When you are
finished with a PSSession, delete it. If you create multiple PSSessions,
close the ones that you are not using, and maintain only the ones currently
in use.

To delete PSSessions, use the `Remove-PSSession` cmdlet. It deletes the
PSSessions and releases all of the resources that they were using.

You can also use the **IdleTimeOut** parameter of `New-PSSessionOption` to close
an idle PSSession after an interval that you specify. For more information,
see [New-PSSessionOption](xref:Microsoft.PowerShell.Core.New-PSSessionOption).

If you save a PSSession object in a variable and then delete the PSSession
or let it time out, the variable still contains the PSSession object, but
the PSSession is not active and cannot be used or repaired.

## Are All Sessions and PSSessions Alike?

No. Developers can create custom sessions that include only selected
providers and cmdlets. If a command works in one session but not in
another, it might be because the session is restricted.

## See Also

[about_Jobs](about_Jobs.md)

[about_PSSessions](about_PSSessions.md)

[about_Remote](about_Remote.md)

[about_Remote_Disconnected_Sessions](about_Remote_Disconnected_Sessions.md)

[about_Remote_Requirements](about_Remote_Requirements.md)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)

[Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)

[Exit-PSSession](xref:Microsoft.PowerShell.Core.Exit-PSSession)

[Get-PSSession](xref:Microsoft.PowerShell.Core.Get-PSSession)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

[Remove-PSSession](xref:Microsoft.PowerShell.Core.Remove-PSSession)

