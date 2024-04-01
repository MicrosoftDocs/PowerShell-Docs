---
description: Explains the methods for running commands on remote systems using PowerShell.
ms.date: 07/03/2023
title: Running Remote Commands
---
# Running Remote Commands

You can run commands on one or hundreds of computers with a single PowerShell command. Windows
PowerShell supports remote computing using various technologies, including WMI, RPC, and
WS-Management.

PowerShell supports WMI, WS-Management, and SSH remoting. In PowerShell 7 and higher, RPC is
supported only on Windows.

For more information about remoting in PowerShell, see the following articles:

- [SSH Remoting in PowerShell][09]
- [WSMan Remoting in PowerShell][10]

## Windows PowerShell remoting without configuration

Many Windows PowerShell cmdlets have the **ComputerName** parameter that enables you to collect data
and change settings on one or more remote computers. These cmdlets use varying communication
protocols and work on all Windows operating systems without any special configuration.

These cmdlets include:

- [Restart-Computer][23]
- [Test-Connection][25]
- [Clear-EventLog][17]
- [Get-EventLog][18]
- [Get-HotFix][19]
- [Get-Process][20]
- [Get-Service][21]
- [Set-Service][24]
- [Get-WinEvent][16]
- [Get-WmiObject][22]

Typically, cmdlets that support remoting without special configuration have the **ComputerName**
parameter and don't have the **Session** parameter. To find these cmdlets in your session, type:

```powershell
Get-Command | Where-Object {
    $_.Parameters.Keys -contains "ComputerName" -and
    $_.Parameters.Keys -notcontains "Session"
}
```

## Windows PowerShell remoting

Using the WS-Management protocol, Windows PowerShell remoting lets you run any Windows PowerShell
command on one or more remote computers. You can establish persistent connections, start interactive
sessions, and run scripts on remote computers.

To use Windows PowerShell remoting, the remote computer must be configured for remote management.
For more information, including instructions, see [About Remote Requirements][04].

Once you have configured Windows PowerShell remoting, many remoting strategies are available to you.
This article lists just a few of them. For more information, see [About Remote][02].

### Start an interactive session

To start an interactive session with a single remote computer, use the [Enter-PSSession][11] cmdlet.
For example, to start an interactive session with the Server01 remote computer, type:

```powershell
Enter-PSSession Server01
```

The command prompt changes to display the name of the remote computer. Any commands that you type at
the prompt run on the remote computer and the results are displayed on the local computer.

To end the interactive session, type:

```powershell
Exit-PSSession
```

For more information about the `Enter-PSSession` and `Exit-PSSession` cmdlets, see:

- [Enter-PSSession][11]
- [Exit-PSSession][12]

### Run a Remote Command

To run a command on one or more computers, use the [Invoke-Command][13] cmdlet. For example, to run
a [Get-UICulture][27] command on the Server01 and Server02 remote computers, type:

```powershell
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock {Get-UICulture}
```

The output is returned to your computer.

```output
LCID    Name     DisplayName               PSComputerName
----    ----     -----------               --------------
1033    en-US    English (United States)   server01.corp.fabrikam.com
1033    en-US    English (United States)   server02.corp.fabrikam.com
```

### Run a Script

To run a script on one or many remote computers, use the **FilePath** parameter of the
`Invoke-Command` cmdlet. The script must be on or accessible to your local computer. The results are
returned to your local computer.

For example, the following command runs the `DiskCollect.ps1` script on the remote computers,
Server01 and Server02.

```powershell
Invoke-Command -ComputerName Server01, Server02 -FilePath c:\Scripts\DiskCollect.ps1
```

### Establish a Persistent Connection

Use the `New-PSSession` cmdlet to create a persistent session on a remote computer. The following
example creates remote sessions on Server01 and Server02. The session objects are stored in the `$s`
variable.

```powershell
$s = New-PSSession -ComputerName Server01, Server02
```

Now that the sessions are established, you can run any command in them. And because the sessions are
persistent, you can collect data from one command and use it in another command.

For example, the following command runs a `Get-HotFix` command in the sessions in the `$s` variable
and it saves the results in the `$h` variable. The `$h` variable is created in each of the sessions
in `$s`, but it doesn't exist in the local session.

```powershell
Invoke-Command -Session $s {$h = Get-HotFix}
```

Now you can use the data in the `$h` variable with other commands in the same session. The results
are displayed on the local computer. For example:

```powershell
Invoke-Command -Session $s {$h | where {$_.InstalledBy -ne "NT AUTHORITY\SYSTEM"}}
```

### Advanced Remoting

PowerShell includes cmdlets that allow you to:

- Configure and create remote sessions both from the local and remote ends
- Create customized and restricted sessions
- Import commands from a remote session that actually run implicitly on the remote session
- Configure the security of a remote session

PowerShell on Windows includes a WSMan provider. The provider creates a `WSMAN:` drive that lets you
navigate through a hierarchy of configuration settings on the local computer and remote computers.

For more information about the WSMan provider, see [WSMan Provider][07] and
[About WS-Management Cmdlets][06], or in the Windows PowerShell console, type `Get-Help wsman`.

For more information, see:

- [PowerShell Remoting FAQ][08]
- [Register-PSSessionConfiguration][15]
- [Import-PSSession][26]

For help with remoting errors, see [about_Remote_Troubleshooting][05].

## See Also

- [about_Remote][03]
- [about_Remote_Requirements][04]
- [about_Remote_Troubleshooting][05]
- [about_PSSessions][01]
- [about_WS-Management_Cmdlets][06]
- [Invoke-Command][13]
- [Import-PSSession][26]
- [New-PSSession][14]
- [Register-PSSessionConfiguration][15]
- [WSMan Provider][07]

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_PSSessions
[02]: /powershell/module/microsoft.powershell.core/about/about_remote
[03]: /powershell/module/microsoft.powershell.core/about/about_remote_faq
[04]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[05]: /powershell/module/microsoft.powershell.core/about/about_Remote_Troubleshooting
[06]: /powershell/module/microsoft.wsman.management/about/about_ws-management_cmdlets
[07]: /powershell/module/microsoft.wsman.management/about/about_wsman_provider
[08]: powershell-remoting-faq.yml
[09]: ssh-remoting-in-powershell.md
[10]: wsman-remoting-in-powershell.md
[11]: xref:Microsoft.PowerShell.Core.Enter-PSSession
[12]: xref:Microsoft.PowerShell.Core.Exit-PSSession
[13]: xref:Microsoft.PowerShell.Core.Invoke-Command
[14]: xref:Microsoft.PowerShell.Core.New-PSSession
[15]: xref:Microsoft.PowerShell.Core.Register-PSSessionConfiguration
[16]: xref:Microsoft.PowerShell.Diagnostics.Get-WinEvent
[17]: xref:Microsoft.PowerShell.Management.Clear-EventLog
[18]: xref:Microsoft.PowerShell.Management.Get-EventLog
[19]: xref:Microsoft.PowerShell.Management.Get-HotFix
[20]: xref:Microsoft.PowerShell.Management.Get-Process
[21]: xref:Microsoft.PowerShell.Management.Get-Service
[22]: xref:Microsoft.PowerShell.Management.Get-WmiObject
[23]: xref:Microsoft.PowerShell.Management.Restart-Computer
[24]: xref:Microsoft.PowerShell.Management.Set-Service
[25]: xref:Microsoft.PowerShell.Management.Test-Connection
[26]: xref:Microsoft.PowerShell.Utility.Import-PSSession
[27]: xref:Microsoft.PowerShell.Utility.Get-UICulture
