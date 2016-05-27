---
title:  Running Remote Commands
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  d6938b56-7dc8-44ba-b4d4-cd7b169fd74d
---

# Running Remote Commands
You can run commands on one or hundreds of computers with a single Windows PowerShell command. Windows PowerShell supports remote computing by using various technologies, including WMI, RPC, and WS\-Management.

## Remoting Without Configuration
Many Windows PowerShell cmdlets have a ComputerName parameter that enables you to collect data and change settings one or more remote computers. They use a variety of communication technologies and many work on all Windows operating systems that Windows PowerShell supports without any special configuration.

These cmdlets include:

-   [Restart-Computer](https://technet.microsoft.com/en-us/library/dd315301.aspx)

-   [Test-Connection](https://technet.microsoft.com/en-us/library/dd315259.aspx)

-   [Clear-EventLog](https://technet.microsoft.com/en-us/library/dd347552.aspx)

-   [Get-EventLog](https://technet.microsoft.com/en-us/library/dd315250.aspx)

-   [Get-Hotfix](https://technet.microsoft.com/en-us/library/e1ef636f-5170-4675-b564-199d9ef6f101)

-   [Get-Process](https://technet.microsoft.com/en-us/library/dd347630.aspx)

-   [Get-Service](https://technet.microsoft.com/en-us/library/dd347591.aspx)

-   [Set-Service](https://technet.microsoft.com/en-us/library/dd315324.aspx)

-   [Get-WinEvent](https://technet.microsoft.com/en-us/library/dd315358.aspx)

-   [Get-WmiObject](https://technet.microsoft.com/en-us/library/dd315295.aspx)

Typically, cmdlets that support remoting without special configuration have a ComputerName parameter and do not have a Session parameter. To find these cmdlets in your session, type:

```
get-command | where { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}
```

## Windows PowerShell Remoting
Windows PowerShell remoting, which uses the WS\-Management protocol, lets you run any Windows PowerShell command on one or many remote computers. It lets you establish persistent connections, start 1:1 interactive sessions, and run scripts on multiple computers.

To use Windows PowerShell remoting, the remote computer must be configured for remote management. For more information, including instructions, see [About Remote Requirements](https://technet.microsoft.com/en-us/library/dd315349.aspx).

After you have configured Windows PowerShell remoting, many remoting strategies are available to you. The remainder of this document lists just a few of them. For more information, see [About Remote](https://technet.microsoft.com/en-us/library/dd347744.aspx) and 
[About Remote FAQ](https://technet.microsoft.com/en-us/library/dd347744.aspx).

### Start an Interactive Session
To start an interactive session with a single remote computer, use the [Enter-PSSession](https://technet.microsoft.com/en-us/library/dd315384.aspx) cmdlet. For example, to start an interactive session with the Server01 remote computer, type:

```
enter-pssession Server01
```

The command prompt changes to display the name of the computer to which you are connected. From then on, any commands that you type at the prompt run on the remote computer and the results are displayed on the local computer.

To end the interactive session, type:

```
exit-pssession
```

For more information about the Enter\-PSSession and Exit\-PSSession cmdlets, see [Enter-PSSession](https://technet.microsoft.com/en-us/library/dd315384.aspx) 
and [Exit-PSSession](https://technet.microsoft.com/en-us/library/dd315322.aspx).

### Run a Remote Command
To run any command on one or many remote computers, use the [Invoke-Command](https://technet.microsoft.com/en-us/library/dd347578.aspx) cmdlet.
 For example, to run a [Get-UICulture](https://technet.microsoft.com/en-us/library/dd347742.aspx) command on the Server01 and Server02 remote computers, type:

```
invoke-command -computername Server01, Server02 {get-UICulture}
```

The output is returned to your computer.

```
LCID    Name     DisplayName               PSComputerName
----    ----     -----------               --------------
1033    en-US    English (United States)   server01.corp.fabrikam.com
1033    en-US    English (United States)   server02.corp.fabrikam.com
```

For more information about the Invoke\-Command cmdlet, see [Invoke-Command](https://technet.microsoft.com/en-us/library/22fd98ba-1874-492e-95a5-c069467b8462).

### Run a Script
To run a script on one or many remote computers, use the FilePath parameter of the Invoke\-Command cmdlet. The script must be on or accessible to your local computer. The results are returned to your local computer.

For example, the following command runs the DiskCollect.ps1 script on the Server01 and Server02 remote computers.

```
invoke-command -computername Server01, Server02 -filepath c:\Scripts\DiskCollect.ps1
```

For more information about the Invoke\-Command cmdlet, see [Invoke-Command](https://technet.microsoft.com/en-us/library/dd347578.aspx).

### Establish a Persistent Connection
To run a series of related commands that share data, create a session on the remote computer and then use the Invoke\-Command cmdlet to run commands in the session that you create. To create a remote session, use the New\-PSSession cmdlet.

For example, the following command creates a remote session on the Server01 computer and another remote session on the Server02 computer. It saves the session objects in the $s variable.

```
$s = new-pssession -computername Server01, Server02
```

Now that the sessions are established, you can run any command in them. And because the sessions are persistent, you can collect data in one command and use it in a subsequent command.

For example, the following command runs a Get\-Hotfix command in the sessions in the $s variable and it saves the results in the $h variable. The $h variable is created in each of the sessions in $s, but it does not exist in the local session.

```
invoke-command -session $s {$h = get-hotfix}
```

Now you can use the data in the $h variable in subsequent commands, such as the following one. The results are displayed on the local computer.

```
invoke-command -session $s {$h | where {$_.installedby -ne "NTAUTHORITY\SYSTEM"} }
```

### Advanced Remoting
Windows PowerShell remote management just begins here. By using the cmdlets installed with Windows PowerShell, you can establish and configure remote sessions both from the local and remote ends, create customized and restricted sessions, allow users to import commands from a remote session that actually run implicitly on the remote session, configure the security of a remote session, and much more.

To facilitate remote configuration, Windows PowerShell includes a WSMan provider. The WSMAN: drive that the provider creates lets you navigate through a hierarchy of configuration settings on the local computer and remote computers.
 For more information about the WSMan provider, see  [WSMan Provider](https://technet.microsoft.com/en-us/library/dd819476.aspx) and
  [About WS-Management Cmdlets](https://technet.microsoft.com/en-us/library/dd819481.aspx), or in the Windows PowerShell console, type "get\-help wsman".

For more information, see:
- [About Remote FAQ](https://technet.microsoft.com/en-us/library/dd315359.aspx)
- [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/dd819496.aspx)
- [Import-PSSession](https://technet.microsoft.com/en-us/library/dd347575.aspx). 

For help with remoting errors, see [about_Remote_Troubleshooting](https://technet.microsoft.com/en-us/library/dd347642.aspx).

## See Also
- [about_Remote](https://technet.microsoft.com/en-us/library/9b4a5c87-9162-4adf-bdfe-fbc80b9b8970)
- [about_Remote_FAQ](https://technet.microsoft.com/en-us/library/e23702fd-9415-4a98-9975-390a4d3adc42)
- [about_Remote_Requirements](https://technet.microsoft.com/en-us/library/da213949-134c-4741-b307-81f4492ba1bd)
- [about_Remote_Troubleshooting](https://technet.microsoft.com/en-us/library/2f890148-8578-49ed-85ea-79a489dd6317)
- [about_PSSessions](https://technet.microsoft.com/en-us/library/7a9b4e0e-fa1b-47b0-92f6-6e2995d70acb)
- [about_WS-Management_Cmdlets](https://technet.microsoft.com/en-us/library/6ed3370a-ea10-45a5-9493-696aeace27ed)
- [Invoke-Command](https://technet.microsoft.com/en-us/library/22fd98ba-1874-492e-95a5-c069467b8462)
- [Import-PSSession](https://technet.microsoft.com/en-us/library/048c115e-a6fb-4e0d-8cea-c5ca24630c9d)
- [New-PSSession](https://technet.microsoft.com/en-us/library/59452f12-a11d-4558-99ea-e6ca6ad5ffd3)
- [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/af68867a-d201-4b19-a1de-594015ed8a25)
- [WSMan Provider](https://technet.microsoft.com/en-us/library/66fe1241-e08f-49ca-832f-a84c33ca8735)

