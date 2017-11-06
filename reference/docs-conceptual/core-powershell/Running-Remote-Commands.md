---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Running Remote Commands
ms.assetid:  d6938b56-7dc8-44ba-b4d4-cd7b169fd74d
---

# Running Remote Commands
You can run commands on one or hundreds of computers with a single Windows PowerShell command. Windows PowerShell supports remote computing by using various technologies, including WMI, RPC, and WS-Management.

## Remoting Without Configuration
Many Windows PowerShell cmdlets have the ComputerName parameter that enables you to collect data and change settings on one or more remote computers. They use a variety of communication technologies and many work on all Windows operating systems that Windows PowerShell supports without any special configuration.

These cmdlets include:
* [Restart-Computer](https://go.microsoft.com/fwlink/?LinkId=821625)
* [Test-Connection](https://go.microsoft.com/fwlink/?LinkId=821646)
* [Clear-EventLog](https://go.microsoft.com/fwlink/?LinkId=821568)
* [Get-EventLog](https://go.microsoft.com/fwlink/?LinkId=821585)
* [Get-HotFix](https://go.microsoft.com/fwlink/?LinkId=821586)
  - [Get-Process](https://go.microsoft.com/fwlink/?linkid=821590)
* [Get-Service](https://go.microsoft.com/fwlink/?LinkId=821593)
* [Set-Service](https://go.microsoft.com/fwlink/?LinkId=821633)
* [Get-WinEvent](https://go.microsoft.com/fwlink/?linkid=821529)
* [Get-WmiObject](https://go.microsoft.com/fwlink/?LinkId=821595)

Typically, cmdlets that support remoting without special configuration have the ComputerName parameter and do not have the Session parameter. To find these cmdlets in your session, type:

```
Get-Command | where { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}
```

## Windows PowerShell Remoting
Windows PowerShell remoting, which uses the WS-Management protocol, lets you run any Windows PowerShell command on one or many remote computers. It lets you establish persistent connections, start 1:1 interactive sessions, and run scripts on multiple computers.

To use Windows PowerShell remoting, the remote computer must be configured for remote management. For more information, including instructions, see [About Remote Requirements](https://technet.microsoft.com/en-us/library/dd315349.aspx).

After you have configured Windows PowerShell remoting, many remoting strategies are available to you. The remainder of this document lists just a few of them. For more information, see [About Remote](https://technet.microsoft.com/en-us/library/dd347744.aspx) and 
[About Remote FAQ](https://technet.microsoft.com/en-us/library/dd347744.aspx).

### Start an Interactive Session
To start an interactive session with a single remote computer, use the [Enter-PSSession](https://go.microsoft.com/fwlink/?LinkId=821477) cmdlet.
For example, to start an interactive session with the Server01 remote computer, type:

```
Enter-PSSession Server01
```

The command prompt changes to display the name of the computer to which you are connected. From then on, any commands that you type at the prompt run on the remote computer and the results are displayed on the local computer.

To end the interactive session, type:

```
Exit-PSSession
```

For more information about the Enter-PSSession and Exit-PSSession cmdlets, see [Enter-PSSession](https://go.microsoft.com/fwlink/?LinkId=821477) 
and [Exit-PSSession](https://go.microsoft.com/fwlink/?LinkID=821478).

### Run a Remote Command
To run any command on one or many remote computers, use the [Invoke-Command](https://go.microsoft.com/fwlink/?LinkId=821493) cmdlet.
For example, to run a [Get-UICulture](https://go.microsoft.com/fwlink/?LinkId=821806) command on the Server01 and Server02 remote computers, type:

```
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock {Get-UICulture}
```

The output is returned to your computer.

```
LCID    Name     DisplayName               PSComputerName
----    ----     -----------               --------------
1033    en-US    English (United States)   server01.corp.fabrikam.com
1033    en-US    English (United States)   server02.corp.fabrikam.com
```
For more information about the Invoke-Command cmdlet, see [Invoke-Command](https://go.microsoft.com/fwlink/?LinkId=821493).

### Run a Script
To run a script on one or many remote computers, use the FilePath parameter of the Invoke-Command cmdlet. The script must be on or accessible to your local computer. The results are returned to your local computer.

For example, the following command runs the DiskCollect.ps1 script on the Server01 and Server02 remote computers.

```
Invoke-Command -ComputerName Server01, Server02 -FilePath c:\Scripts\DiskCollect.ps1
```

For more information about the Invoke-Command cmdlet, see [Invoke-Command](https://go.microsoft.com/fwlink/?LinkId=821493).

### Establish a Persistent Connection
To run a series of related commands that share data, create a session on the remote computer and then use the Invoke-Command cmdlet to run commands in the session that you create. To create a remote session, use the New-PSSession cmdlet.

For example, the following command creates a remote session on the Server01 computer and another remote session on the Server02 computer. It saves the session objects in the $s variable.

```
$s = New-PSSession -ComputerName Server01, Server02
```

Now that the sessions are established, you can run any command in them. And because the sessions are persistent, you can collect data in one command and use it in a subsequent command.

For example, the following command runs a Get-HotFix command in the sessions in the $s variable and it saves the results in the $h variable. The $h variable is created in each of the sessions in $s, but it does not exist in the local session.

```
Invoke-Command -Session $s {$h = Get-HotFix}
```

Now you can use the data in the $h variable in subsequent commands, such as the following one. The results are displayed on the local computer.

```
Invoke-Command -Session $s {$h | where {$_.InstalledBy -ne "NTAUTHORITY\SYSTEM"}}
```

### Advanced Remoting
Windows PowerShell remote management just begins here. By using the cmdlets installed with Windows PowerShell, you can establish and configure remote sessions both from the local and remote ends, create customized and restricted sessions, allow users to import commands from a remote session that actually run implicitly on the remote session, configure the security of a remote session, and much more.

To facilitate remote configuration, Windows PowerShell includes a WSMan provider. The WSMAN: drive that the provider creates lets you navigate through a hierarchy of configuration settings on the local computer and remote computers.
 For more information about the WSMan provider, see  [WSMan Provider](https://technet.microsoft.com/en-us/library/dd819476.aspx) and
  [About WS-Management Cmdlets](https://technet.microsoft.com/en-us/library/dd819481.aspx), or in the Windows PowerShell console, type "Get-Help wsman".

For more information, see:
- [About Remote FAQ](https://technet.microsoft.com/en-us/library/dd315359.aspx)
- [Register-PSSessionConfiguration](https://go.microsoft.com/fwlink/?LinkId=821508)
- [Import-PSSession](https://go.microsoft.com/fwlink/?LinkId=821821)

For help with remoting errors, see [about_Remote_Troubleshooting](https://technet.microsoft.com/en-us/library/dd347642.aspx).

## See Also
- [about_Remote](https://technet.microsoft.com/en-us/library/9b4a5c87-9162-4adf-bdfe-fbc80b9b8970)
- [about_Remote_FAQ](https://technet.microsoft.com/en-us/library/e23702fd-9415-4a98-9975-390a4d3adc42)
- [about_Remote_Requirements](https://technet.microsoft.com/en-us/library/da213949-134c-4741-b307-81f4492ba1bd)
- [about_Remote_Troubleshooting](https://technet.microsoft.com/en-us/library/2f890148-8578-49ed-85ea-79a489dd6317)
- [about_PSSessions](https://technet.microsoft.com/en-us/library/7a9b4e0e-fa1b-47b0-92f6-6e2995d70acb)
- [about_WS-Management_Cmdlets](https://technet.microsoft.com/en-us/library/6ed3370a-ea10-45a5-9493-696aeace27ed)
- [Invoke-Command](https://go.microsoft.com/fwlink/?LinkId=821493)
- [Import-PSSession](https://go.microsoft.com/fwlink/?LinkId=821821)
- [New-PSSession](https://go.microsoft.com/fwlink/?LinkId=821498)
- [Register-PSSessionConfiguration](https://go.microsoft.com/fwlink/?LinkId=821508)
- [WSMan Provider](https://technet.microsoft.com/en-us/library/66fe1241-e08f-49ca-832f-a84c33ca8735)
