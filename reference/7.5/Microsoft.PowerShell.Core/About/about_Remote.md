---
description: Describes how to run remote commands in PowerShell.
Locale: en-US
ms.date: 07/03/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_remote?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Remote
---
# about_Remote

## Short description

Describes how to run remote commands in PowerShell.

## Long description

You can run remote commands on a single or multiple remote computers using a
temporary or persistent connection. You can also start an interactive session
with a single remote computer.

> [!NOTE]
> To use PowerShell remoting, you must configure the local and remote computers
> for remoting. For more information, see [about_Remote_Requirements][06].

## How to start an interactive session

The easiest way to run remote commands is to start an interactive session with
a remote computer.

When the session starts, the commands that you type run on the remote computer,
as though you typed them directly on the remote computer. You can connect to
only one computer in each interactive session.

To start an interactive session, use the `Enter-PSSession` cmdlet. The
following command starts an interactive session with the Server01 computer:

```powershell
Enter-PSSession Server01
```

PowerShell changes the command prompt to include the name of the remote
computer.

```
Server01\PS>
```

Now, you can type commands on the Server01 computer.

To end the interactive session, type:

```powershell
Exit-PSSession
```

For more information, see [Enter-PSSession][09].

## How to run a remote command

To run other commands on remote computers, use the `Invoke-Command` cmdlet.

To run a single command or a few unrelated commands, use the **ComputerName**
parameter of `Invoke-Command` to specify the remote computers. Use the
**ScriptBlock** parameter to specify the command.

For example, the following command runs a `Get-Culture` command on the Server01
computer.

```powershell
Invoke-Command -ComputerName Server01 -ScriptBlock {Get-Culture}
```

## How to create a persistent connection

When you use the **ComputerName** parameter of the `Invoke-Command` cmdlet,
PowerShell establishes a temporary connection to the remote computer. It closes
the connection when the command is complete. Any variables or functions defined
in this temporary session are lost.

To create a persistent connection to a remote computer, use the `New-PSSession`
cmdlet. For example, the following command creates PSSessions on the Server01
and Server02 computers and then saves the PSSessions in the `$s` variable.

```powershell
$s = New-PSSession -ComputerName Server01, Server02
```

## How to run commands in a PSSession

With a PSSession, you can run a series of remote commands that share data, like
functions, aliases, and the values of variables. To run commands in a
PSSession, use the **Session** parameter of the `Invoke-Command` cmdlet.

For example, the following command uses the `Invoke-Command` cmdlet to run a
`Get-Process` command in the PSSessions on the Server01 and Server02 computers.
The command saves the processes in a `$p` variable in each PSSession.

```powershell
Invoke-Command -Session $s -ScriptBlock {$p = Get-Process}
```

Because the PSSession uses a persistent connection, you can run another command
in the same PSSession that uses the `$p` variable. The following command counts
the number of processes saved in `$p`.

```powershell
Invoke-Command -Session $s -ScriptBlock {$p.count}
```

## How to run a remote command on multiple computers

To run a remote command on multiple computers, type all the computer names in
the value of the **ComputerName** parameter of `Invoke-Command`. Separate the
names with commas.

For example, the following command runs a `Get-Culture` command on three
computers:

```powershell
Invoke-Command -ComputerName S1, S2, S3 -ScriptBlock {Get-Culture}
```

You can also run a command in multiple PSSessions. The following commands
create PSSessions on the Server01, Server02, and Server03 computers and then
run a `Get-Culture` command in each of the PSSessions.

```powershell
$s = New-PSSession -ComputerName S1, S2, S3
Invoke-Command -Session $s -ScriptBlock {Get-Culture}
```

To include the local computer list of computers, type the name of the local
computer, type a dot (`.`), or type `localhost`.

```powershell
Invoke-Command -ComputerName S1, S2, S3, localhost -ScriptBlock {Get-Culture}
```

## How to run a script on remote computers

To run a local script on remote computers, use the **FilePath** parameter of
`Invoke-Command`. You don't need to copy any files. For example, the following
command runs the `Sample.ps1` script on the S1 and S2 computers:

```powershell
Invoke-Command -ComputerName S1, S2 -FilePath C:\Test\Sample.ps1
```

PowerShell returns the results of the script to the local computer.

## How to stop a remote command

To interrupt a command, press <kbd>Ctrl</kbd>+<kbd>c</kbd>. PowerShell passes
the interrupt request to the remote computer where it terminates the remote
command.

## For more information

- For information about the system requirements for remoting, see
  [about_Remote_Requirements][06].

- For help in formatting remote output, see [about_Remote_Output][05].

- For information about how remoting works, how to manage remote data, special
  configurations, security issues, and other frequently asked questions, see
  [PowerShell Remoting FAQ][01].

- For help with resolving remoting errors, see
  [about_Remote_Troubleshooting][07].

- For information about PSSessions and persistent connections, see
  [about_PSSessions][03].

- For information about PowerShell background jobs, see [about_Jobs][02].

## See also

- [about_Remote_Disconnected_Sessions][04]
- [about_Remote_Variables][08]
- [Invoke-Command][10]
- [Enter-PSSession][09]
- [New-PSSession][11]

<!-- link references -->
[01]: /powershell/scripting/learn/remoting/powershell-remoting-faq
[02]: about_Jobs.md
[03]: about_PSSessions.md
[04]: about_Remote_Disconnected_Sessions.md
[05]: about_Remote_Output.md
[06]: about_Remote_Requirements.md
[07]: about_Remote_Troubleshooting.md
[08]: about_Remote_Variables.md
[09]: xref:Microsoft.PowerShell.Core.Enter-PSSession
[10]: xref:Microsoft.PowerShell.Core.Invoke-Command
[11]: xref:Microsoft.PowerShell.Core.New-PSSession
