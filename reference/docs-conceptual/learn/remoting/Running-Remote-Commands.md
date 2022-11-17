---
description: Explains the methods for running commands on remote systems using PowerShell.
ms.date: 11/16/2022
title: Running Remote Commands
---
# Running Remote Commands

You can run commands on one or hundreds of computers with a single PowerShell command. Windows
PowerShell supports remote computing by using various technologies, including WMI, RPC, and
WS-Management.

PowerShell supports WMI, WS-Management, and SSH remoting. In PowerShell 6, RPC is no longer
supported. In PowerShell 7 and above, RPC is supported only in Windows.

For more information about remoting in PowerShell, see the following articles:

- [SSH Remoting in PowerShell][23]
- [WSMan Remoting in PowerShell][24]

## Windows PowerShell Remoting Without Configuration

Many Windows PowerShell cmdlets have the ComputerName parameter that enables you to collect data and
change settings on one or more remote computers. These cmdlets use varying communication protocols
and work on all Windows operating systems without any special configuration.

These cmdlets include:

- [Restart-Computer][16]
- [Test-Connection][18]
- [Clear-EventLog][10]
- [Get-EventLog][11]
- [Get-HotFix][12]
- [Get-Process][13]
- [Get-Service][14]
- [Set-Service][17]
- [Get-WinEvent][09]
- [Get-WmiObject][15]

Typically, cmdlets that support remoting without special configuration have the ComputerName
parameter and don't have the Session parameter. To find these cmdlets in your session, type:

```powershell
Get-Command | Where-Object {
    $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"
}
```

## Windows PowerShell Remoting

Using the WS-Management protocol, Windows PowerShell remoting lets you run any Windows PowerShell
command on one or more remote computers. You can establish persistent connections, start interactive
sessions, and run scripts on remote computers.

To use Windows PowerShell remoting, the remote computer must be configured for remote management.
For more information, including instructions, see [About Remote Requirements][04].

Once you have configured Windows PowerShell remoting, many remoting strategies are available to you.
This article lists just a few of them. For more information, see [About Remote][02].

### Start an Interactive Session

To start an interactive session with a single remote computer, use the [Enter-PSSession][06] cmdlet.
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

For more information about the Enter-PSSession and Exit-PSSession cmdlets, see:

- [Enter-PSSession][06]
- [Exit-PSSession][07]

### Run a Remote Command

To run a command on one or more computers, use the [Invoke-Command][08] cmdlet. For example, to run
a [Get-UICulture][19] command on the Server01 and Server02 remote computers, type:

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

To run a script on one or many remote computers, use the FilePath parameter of the `Invoke-Command`
cmdlet. The script must be on or accessible to your local computer. The results are returned to your
local computer.

For example, the following command runs the DiskCollect.ps1 script on the remote computers, Server01
and Server02.

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

For example, the following command runs a Get-HotFix command in the sessions in the $s variable and
it saves the results in the $h variable. The $h variable is created in each of the sessions in $s,
but it doesn't exist in the local session.

```powershell
Invoke-Command -Session $s {$h = Get-HotFix}
```

Now you can use the data in the `$h` variable with other commands in the same session. The results
are displayed on the local computer. For example:

```powershell
Invoke-Command -Session $s {$h | where {$_.InstalledBy -ne "NT AUTHORITY\SYSTEM"}}
```

### Advanced Remoting

Windows PowerShell remote management just begins here. By using the cmdlets installed with Windows
PowerShell, you can establish and configure remote sessions both from the local and remote ends,
create customized and restricted sessions, allow users to import commands from a remote session that
actually run implicitly on the remote session, configure the security of a remote session, and much
more.

Windows PowerShell includes a WSMan provider. The provider creates a `WSMAN:` drive that lets you
navigate through a hierarchy of configuration settings on the local computer and remote computers.

For more information about the WSMan provider, see [WSMan Provider][21] and
[About WS-Management Cmdlets][20], or in the Windows PowerShell console, type `Get-Help wsman`.

For more information, see:

- [PowerShell Remoting FAQ][22]
- [Register-PSSessionConfiguration][27]
- [Import-PSSession][28]

For help with remoting errors, see [about_Remote_Troubleshooting][05].

## See Also

- [about_Remote][03]
- [about_Remote_Requirements][04]
- [about_Remote_Troubleshooting][05]
- [about_PSSessions][01]
- [about_WS-Management_Cmdlets][20]
- [Invoke-Command][25]
- [Import-PSSession][28]
- [New-PSSession][26]
- [Register-PSSessionConfiguration][27]
- [WSMan Provider][21]

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_PSSessions
[02]: /powershell/module/microsoft.powershell.core/about/about_remote
[03]: /powershell/module/microsoft.powershell.core/about/about_remote_faq
[04]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[05]: /powershell/module/microsoft.powershell.core/about/about_Remote_Troubleshooting
[06]: /powershell/module/microsoft.powershell.core/enter-pssession
[07]: /powershell/module/microsoft.powershell.core/exit-pssession
[08]: /powershell/module/microsoft.powershell.core/invoke-command
[09]: /powershell/module/microsoft.powershell.diagnostics/get-winevent
[10]: /powershell/module/microsoft.powershell.management/clear-eventlog
[11]: /powershell/module/microsoft.powershell.management/get-eventlog
[12]: /powershell/module/microsoft.powershell.management/get-hotfix
[13]: /powershell/module/microsoft.powershell.management/get-process
[14]: /powershell/module/microsoft.powershell.management/get-service
[15]: /powershell/module/microsoft.powershell.management/get-wmiobject
[16]: /powershell/module/microsoft.powershell.management/restart-computer
[17]: /powershell/module/microsoft.powershell.management/set-service
[18]: /powershell/module/microsoft.powershell.management/test-connection
[19]: /powershell/module/microsoft.powershell.utility/get-uiculture
[20]: /powershell/module/microsoft.wsman.management/about/about_ws-management_cmdlets
[21]: /powershell/module/microsoft.wsman.management/about/about_wsman_provider
[22]: powershell-remoting-faq.yml
[23]: SSH-Remoting-in-PowerShell-Core.md
[24]: WSMan-Remoting-in-PowerShell-Core.md
[25]: xref:Microsoft.PowerShell.Core.Invoke-Command
[26]: xref:Microsoft.PowerShell.Core.New-PSSession
[27]: xref:Microsoft.PowerShell.Core.Register-PSSessionConfiguration
[28]: xref:Microsoft.PowerShell.Utility.Import-PSSession
