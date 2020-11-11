---
description: Describes how to run remote commands in PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote
---
# About Remote

## SHORT DESCRIPTION
Describes how to run remote commands in PowerShell.

## LONG DESCRIPTION

You can run remote commands on a single computer or on multiple computers by
using a temporary or persistent connection. You can also start an interactive
session with a single remote computer.

This topic provides a series of examples to show you how to run different
types of remote command. After you try these basic commands, read the Help
topics that describe each cmdlet that is used in these commands. The topics
provide the details and explain how you can modify the commands to meet your
needs.

Note: To use PowerShell remoting, the local and remote computers must
be configured for remoting. For more information, see
[about_Remote_Requirements](about_Remote_Requirements.md).

## HOW TO START AN INTERACTIVE SESSION (ENTER-PSSESSION)

The easiest way to run remote commands is to start an interactive session with
a remote computer.

When the session starts, the commands that you type run on the remote
computer, just as though you typed them directly on the remote computer. You
can connect to only one computer in each interactive session.

To start an interactive session, use the Enter-PSSession cmdlet. The following
command starts an interactive session with the Server01 computer:

```powershell
Enter-PSSession Server01
```

The command prompt changes to indicate that you are connected to the Server01
computer.

```
Server01\PS>
```

Now, you can type commands on the Server01 computer.

To end the interactive session, type:

```powershell
Exit-PSSession
```

For more information, see Enter-PSSession.

## HOW TO USE CMDLETS THAT HAVE A COMPUTERNAME PARAMETER TO GET REMOTE DATA

Several cmdlets have a ComputerName parameter that lets you get objects from
remote computers.

Because these cmdlets do not use WS-Management-based PowerShell
remoting, you can use the ComputerName parameter of these cmdlets on any
computer that is running PowerShell. The computers do not have to be
configured for PowerShell remoting, and the computers do not have to
meet the system requirements for remoting.

The following cmdlets have a ComputerName parameter:

```
Clear-EventLog    Limit-EventLog
Get-Counter       New-EventLog
Get-EventLog      Remove-EventLog
Get-HotFix        Restart-Computer
Get-Process       Show-EventLog
Get-Service       Stop-Computer
Get-WinEvent      Test-Connection
Get-WmiObject     Write-EventLog
```

For example, the following command gets the services on
the Server01 remote computer:

```powershell
Get-Service -ComputerName Server01
```

Typically, cmdlets that support remoting without special configuration have a
**ComputerName** parameter and do not have a **Session** parameter. To find
these cmdlets in your session, type:

```powershell
Get-Command | Where-Object {
  $_.Parameters.Keys -contains 'ComputerName' -and
  $_.Parameters.Keys -notcontains 'Session'
}
```

## HOW TO RUN A REMOTE COMMAND

To run other commands on remote computers, use the Invoke-Command cmdlet.

To run a single command or a few unrelated commands, use the ComputerName
parameter of Invoke-Command to specify the remote computers. Use the
ScriptBlock parameter to specify the command.

For example, the following command runs a Get-Culture command on the Server01
computer.

```powershell
Invoke-Command -ComputerName Server01 -ScriptBlock {Get-Culture}
```

The ComputerName parameter is designed for situation in which you run a single
command or several unrelated commands on one or many computers. To establish a
persistent connection to a remote computer, use the Session parameter.

## HOW TO CREATE A PERSISTENT CONNECTION (PSSESSION)

When you use the ComputerName parameter of the Invoke-Command cmdlet, Windows
PowerShell establishes a connection just for the command. Then, it closes the
connection when the command is complete. Any variables or functions that are
defined in the command are lost.

To create a persistent connection to a remote computer, use the New-PSSession
cmdlet. For example, the following command creates PSSessions on the Server01
and Server02 computers and then saves the PSSessions in the $s variable.

```powershell
$s = New-PSSession -ComputerName Server01, Server02
```

## HOW TO RUN COMMANDS IN A PSSESSION

With a PSSession, you can run a series of remote commands that share data,
like functions, aliases, and the values of variables. To run commands in a
PSSession, use the Session parameter of the Invoke-Command cmdlet.

For example, the following command uses the Invoke-Command cmdlet to run a
Get-Process command in the PSSessions on the Server01 and Server02 computers.
The command saves the processes in a $p variable in each PSSession.

```powershell
Invoke-Command -Session $s -ScriptBlock {$p = Get-Process}
```

Because the PSSession uses a persistent connection, you can run another
command in the same PSSession that uses the $p variable. The following command
counts the number of processes saved in $p.

```powershell
Invoke-Command -Session $s -ScriptBlock {$p.count}
```

## HOW TO RUN A REMOTE COMMAND ON MULTIPLE COMPUTERS

To run a remote command on multiple computers, type all of the computer names
in the value of the ComputerName parameter of Invoke-Command. Separate the
names with commas.

For example, the following command runs a Get-Culture command on three
computers:

```powershell
Invoke-Command -ComputerName S1, S2, S3 -ScriptBlock {Get-Culture}
```

You can also run a command in multiple PSSessions. The following commands
create PSSessions on the Server01, Server02, and Server03 computers and then
run a Get-Culture command in each of the PSSessions.

```powershell
$s = New-PSSession -ComputerName S1, S2, S3
Invoke-Command -Session $s -ScriptBlock {Get-Culture}
```

To include the local computer list of computers, type the name of
the local computer, type a dot (.), or type  "localhost".

```powershell
Invoke-Command -ComputerName S1, S2, S3, localhost -ScriptBlock {Get-Culture}
```

## HOW TO RUN A SCRIPT ON REMOTE COMPUTERS

To run a local script on remote computers, use the FilePath parameter of
Invoke-Command.

For example, the following command runs the Sample.ps1 script on the S1 and S2
computers:

```powershell
Invoke-Command -ComputerName S1, S2 -FilePath C:\Test\Sample.ps1
```

The results of the script are returned to the local computer. You do not need
to copy any files.

## HOW TO STOP A REMOTE COMMAND

To interrupt a command, press CTRL+C. The interrupt request is passed to the
remote computer where it terminates the remote command.

## FOR MORE INFORMATION

- For information about the system requirements for remoting, see
  [about_Remote_Requirements](about_Remote_Requirements.md).

- For help in formatting remote output, see [about_Remote_Output](about_Remote_Output.md).

- For information about how remoting works, how to manage remote data, special
  configurations, security issues, and other frequently asked questions, see
  [about_Remote_FAQ](about_Remote_FAQ.md).

- For help in resolving remoting errors, see about_Remote_Troubleshooting.

- For information about PSSessions and persistent connections, see
  [about_PSSessions](about_PSSessions.md).

- For information about PowerShell background jobs, see [about_Jobs](about_Jobs.md).

## KEYWORDS

about_Remoting

## SEE ALSO

[about_PSSessions](about_PSSessions.md)

[about_Remote_Disconnected_Sessions](about_Remote_Disconnected_Sessions.md)

[about_Remote_Requirements](about_Remote_Requirements.md)

[about_Remote_FAQ](about_Remote_FAQ.md)

[about_Remote_TroubleShooting](about_Remote_TroubleShooting.md)

[about_Remote_Variables](about_Remote_Variables.md)

[Enter-PSSession](xref:Microsoft.PowerShell.Core.Enter-PSSession)

[Invoke-Command](xref:Microsoft.PowerShell.Core.Invoke-Command)

[New-PSSession](xref:Microsoft.PowerShell.Core.New-PSSession)

