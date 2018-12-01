---
ms.date:  08/14/2018
keywords:  powershell,cmdlet
title:  Running Remote Commands
ms.assetid:  d6938b56-7dc8-44ba-b4d4-cd7b169fd74d
---
# Running Remote Commands

You can run commands on one or hundreds of computers with a single PowerShell command. Windows
PowerShell supports remote computing by using various technologies, including WMI, RPC, and
WS-Management.

PowerShell Core supports WMI, WS-Management, and SSH remoting. RPC is no longer supported.

For more information about remoting in PowerShell Core, see the following articles:

- [SSH Remoting in PowerShell Core][ssh-remoting]
- [WSMan Remoting in PowerShell Core][wsman-remoting]

## Windows PowerShell Remoting Without Configuration

Many Windows PowerShell cmdlets have the ComputerName parameter that enables you to collect data
and change settings on one or more remote computers. These cmdlets use varying communication
protocols and work on all Windows operating systems without any special configuration.

These cmdlets include:

- [Restart-Computer](/powershell/module/microsoft.powershell.management/restart-computer)
- [Test-Connection](/powershell/module/microsoft.powershell.management/test-connection)
- [Clear-EventLog](/powershell/module/microsoft.powershell.management/clear-eventlog)
- [Get-EventLog](/powershell/module/microsoft.powershell.management/get-eventlog)
- [Get-HotFix](/powershell/module/microsoft.powershell.management/get-hotfix)
- [Get-Process](/powershell/module/microsoft.powershell.management/get-process)
- [Get-Service](/powershell/module/microsoft.powershell.management/get-service)
- [Set-Service](/powershell/module/microsoft.powershell.management/set-service)
- [Get-WinEvent](/powershell/module/microsoft.powershell.diagnostics/get-winevent)
- [Get-WmiObject](/powershell/module/microsoft.powershell.management/get-wmiobject)

Typically, cmdlets that support remoting without special configuration have the ComputerName parameter and don't have the Session parameter. To find these cmdlets in your session, type:

```powershell
Get-Command | where { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}
```

## Windows PowerShell Remoting

Using the WS-Management protocol, Windows PowerShell remoting lets you run any Windows
PowerShell command on one or more remote computers. You can establish persistent connections,
start interactive sessions, and run scripts on remote computers.

To use Windows PowerShell remoting, the remote computer must be configured for remote management.
For more information, including instructions, see
[About Remote Requirements](/powershell/module/microsoft.powershell.core/about/about_remote_requirements).

Once you have configured Windows PowerShell remoting, many remoting strategies are available to you.
This article lists just a few of them. For more information, see
[About Remote](/powershell/module/microsoft.powershell.core/about/about_remote).

### Start an Interactive Session

To start an interactive session with a single remote computer, use the
[Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet.
For example, to start an interactive session with the Server01 remote computer, type:

```powershell
Enter-PSSession Server01
```

The command prompt changes to display the name of the remote computer. Any commands that you type
at the prompt run on the remote computer and the results are displayed on the local computer.

To end the interactive session, type:

```powershell
Exit-PSSession
```

For more information about the Enter-PSSession and Exit-PSSession cmdlets, see:

- [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession)
- [Exit-PSSession](/powershell/module/microsoft.powershell.core/exit-pssession)

### Run a Remote Command

To run a command on one or more computers, use the [Invoke-Command](/powershell/module/microsoft.powershell.core/invoke-command)
cmdlet. For example, to run a [Get-UICulture](/powershell/module/microsoft.powershell.utility/get-uiculture)
command on the Server01 and Server02 remote computers, type:

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
cmdlet. The script must be on or accessible to your local computer. The results are returned to
your local computer.

For example, the following command runs the DiskCollect.ps1 script on the remote computers,
Server01 and Server02.

```powershell
Invoke-Command -ComputerName Server01, Server02 -FilePath c:\Scripts\DiskCollect.ps1
```

### Establish a Persistent Connection

Use the `New-PSSession` cmdlet to create a persistent session on a remote computer. The following
example creates remote sessions on Server01 and Server02. The session objects are stored in the
`$s` variable.

```powershell
$s = New-PSSession -ComputerName Server01, Server02
```

Now that the sessions are established, you can run any command in them. And because the sessions
are persistent, you can collect data from one command and use it in another command.

For example, the following command runs a Get-HotFix command in the sessions in the $s variable and
it saves the results in the $h variable. The $h variable is created in each of the sessions in $s,
but it doesn't exist in the local session.

```powershell
Invoke-Command -Session $s {$h = Get-HotFix}
```

Now you can use the data in the `$h` variable with other commands in the same session. The results
are displayed on the local computer. For example:

```powershell
Invoke-Command -Session $s {$h | where {$_.InstalledBy -ne "NTAUTHORITY\SYSTEM"}}
```

### Advanced Remoting

Windows PowerShell remote management just begins here. By using the cmdlets installed with Windows
PowerShell, you can establish and configure remote sessions both from the local and remote ends,
create customized and restricted sessions, allow users to import commands from a remote session
that actually run implicitly on the remote session, configure the security of a remote session, and
much more.

Windows PowerShell includes a WSMan provider. The provider creates a `WSMAN:` drive that lets you
navigate through a hierarchy of configuration settings on the local computer and remote computers.

For more information about the WSMan provider, see
[WSMan Provider](https://technet.microsoft.com/library/dd819476.aspx) and
[About WS-Management Cmdlets](/powershell/module/microsoft.powershell.core/about/about_ws-management_cmdlets),
or in the Windows PowerShell console, type `Get-Help wsman`.

For more information, see:

- [About Remote FAQ](https://technet.microsoft.com/library/dd315359.aspx)
- [Register-PSSessionConfiguration](https://go.microsoft.com/fwlink/?LinkId=821508)
- [Import-PSSession](https://go.microsoft.com/fwlink/?LinkId=821821)

For help with remoting errors, see [about_Remote_Troubleshooting](https://technet.microsoft.com/library/dd347642.aspx).

## See Also

- [about_Remote](https://technet.microsoft.com/library/9b4a5c87-9162-4adf-bdfe-fbc80b9b8970)
- [about_Remote_FAQ](https://technet.microsoft.com/library/e23702fd-9415-4a98-9975-390a4d3adc42)
- [about_Remote_Requirements](https://technet.microsoft.com/library/da213949-134c-4741-b307-81f4492ba1bd)
- [about_Remote_Troubleshooting](https://technet.microsoft.com/library/2f890148-8578-49ed-85ea-79a489dd6317)
- [about_PSSessions](https://technet.microsoft.com/library/7a9b4e0e-fa1b-47b0-92f6-6e2995d70acb)
- [about_WS-Management_Cmdlets](https://technet.microsoft.com/library/6ed3370a-ea10-45a5-9493-696aeace27ed)
- [Invoke-Command](/powershell/module/microsoft.powershell.core/invoke-command)
- [Import-PSSession](https://go.microsoft.com/fwlink/?LinkId=821821)
- [New-PSSession](https://go.microsoft.com/fwlink/?LinkId=821498)
- [Register-PSSessionConfiguration](https://go.microsoft.com/fwlink/?LinkId=821508)
- [WSMan Provider](https://technet.microsoft.com/library/66fe1241-e08f-49ca-832f-a84c33ca8735)

[wsman-remoting]: WSMan-Remoting-in-PowerShell-Core.md
[ssh-remoting]: SSH-Remoting-in-PowerShell-Core.md