---
description: PowerShell provides several cmdlets that help manage services on local and remote computers.
ms.date: 12/08/2022
title: Managing services
---
# Managing services

> This sample only applies to Windows PowerShell 5.1.

There are eight core **Service** cmdlets, designed for a wide range of service tasks . This article
only looks at listing and changing running state for services. You can get a list of service cmdlets
using `Get-Command *-Service`. You can find information about each cmdlet by using
`Get-Help <Cmdlet-Name>`, such as `Get-Help New-Service`.

## Getting services

You can get the services on a local or remote computer by using the `Get-Service` cmdlet. As with
`Get-Process`, using the `Get-Service` command without parameters returns all services. You can
filter by name, even using an asterisk as a wildcard:

```powershell
PS> Get-Service -Name se*

Status   Name               DisplayName
------   ----               -----------
Running  seclogon           Secondary Logon
Running  SENS               System Event Notification
Stopped  ServiceLayer       ServiceLayer
```

Because it isn't always apparent what the real name for the service is, you may find you need to
find services by display name. You can search by specific name, use wildcards, or provide a list of
display names:

```powershell
PS> Get-Service -DisplayName se*

Status   Name               DisplayName
------   ----               -----------
Running  lanmanserver       Server
Running  SamSs              Security Accounts Manager
Running  seclogon           Secondary Logon
Stopped  ServiceLayer       ServiceLayer
Running  wscsvc             Security Center

PS> Get-Service -DisplayName ServiceLayer, Server

Status   Name               DisplayName
------   ----               -----------
Running  lanmanserver       Server
Stopped  ServiceLayer       ServiceLayer
```

## Getting remote services

With Windows PowerShell, you can use the **ComputerName** parameter of the `Get-Service` cmdlet to
get the services on remote computers. The **ComputerName** parameter accepts multiple values and
wildcard characters, so you can get the services on multiple computers with a single command. For
example, the following command gets the services on the Server01 remote computer.

```powershell
Get-Service -ComputerName Server01
```

Starting in PowerShell 6.0, the `*-Service` cmdlets don't have the **ComputerName** parameter. You
can still get services on remote computers with PowerShell remoting. For example, the following
command gets the services on the Server02 remote computer.

```powershell
Invoke-Command -ComputerName Server02 -ScriptBlock { Get-Service }
```

You can also manage services with the other `*-Service` cmdlets. For more information on PowerShell
remoting, see [about_Remote][01].

## Getting required and dependent services

The Get-Service cmdlet has two parameters that are very useful in service administration. The
DependentServices parameter gets services that depend on the service.

The **RequiredServices** parameter gets services upon which the LanmanWorkstation service depends.

```powershell
PS> Get-Service -Name LanmanWorkstation -RequiredServices

Status   Name               DisplayName
------   ----               -----------
Running  MRxSmb20           SMB 2.0 MiniRedirector
Running  bowser             Bowser
Running  MRxSmb10           SMB 1.x MiniRedirector
Running  NSI                Network Store Interface Service
```

The **DependentServices** parameter gets that require the LanmanWorkstation service.

```powershell
PS> Get-Service -Name LanmanWorkstation -DependentServices

Status   Name               DisplayName
------   ----               -----------
Running  SessionEnv         Terminal Services Configuration
Running  Netlogon           Netlogon
Stopped  Browser            Computer Browser
Running  BITS               Background Intelligent Transfer Ser...
```

The following command gets all services that have dependencies. The `Format-Table` cmdlet to display
the **Status**, **Name**, **RequiredServices**, and **DependentServices** properties of the
services.

```powershell
Get-Service -Name * | Where-Object {$_.RequiredServices -or $_.DependentServices} |
  Format-Table -Property Status, Name, RequiredServices, DependentServices -auto
```

## Stopping, starting, suspending, and restarting services

The Service cmdlets all have the same general form. Services can be specified by common name or
display name, and take lists and wildcards as values. To stop the print spooler, use:

```powershell
Stop-Service -Name spooler
```

To start the print spooler after it's stopped, use:

```powershell
Start-Service -Name spooler
```

To suspend the print spooler, use:

```powershell
Suspend-Service -Name spooler
```

The `Restart-Service` cmdlet works in the same manner as the other Service cmdlets:

```powershell
PS> Restart-Service -Name spooler

WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
PS>
```

Notice that you get a repeated warning message about the Print Spooler starting up. When you perform
a service operation that takes some time, PowerShell notifies you that it's still attempting to
perform the task.

If you want to restart multiple services, you can get a list of services, filter them, and then
perform the restart:

```powershell
PS> Get-Service | Where-Object -FilterScript {$_.CanStop} | Restart-Service

WARNING: Waiting for service 'Computer Browser (Browser)' to finish stopping...
WARNING: Waiting for service 'Computer Browser (Browser)' to finish stopping...
Restart-Service : can't stop service 'Logical Disk Manager (dmserver)' because
 it has dependent services. It can only be stopped if the Force flag is set.
At line:1 char:57
+ Get-Service | Where-Object -FilterScript {$_.CanStop} | Restart-Service <<<<
WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
```

These Service cmdlets don't have a **ComputerName** parameter, but you can run them on a remote
computer by using the `Invoke-Command` cmdlet. For example, the following command restarts the
Spooler service on the Server01 remote computer.

```powershell
Invoke-Command -ComputerName Server01 {Restart-Service Spooler}
```

## Setting service properties

The `Set-Service` cmdlet changes the properties of a service on a local or remote computer. Because
the service status is a property, you can use this cmdlet to start, stop, and suspend a service.
The Set-Service cmdlet also has a StartupType parameter that lets you change the service startup
type.

To use `Set-Service` on Windows Vista and later versions of Windows, open PowerShell with the **Run
as administrator** option.

For more information, see [Set-Service][04]

## See also

- [about_Remote][01]
- [Get-Service][02]
- [Set-Service][04]
- [Restart-Service][03]
- [Suspend-Service][05]

<!-- link references -->
[01]: /powershell/module/Microsoft.PowerShell.Core/about/about_Remote
[02]: /powershell/module/Microsoft.PowerShell.Management/get-service
[03]: /powershell/module/Microsoft.PowerShell.Management/restart-service
[04]: /powershell/module/Microsoft.PowerShell.Management/set-service
[05]: /powershell/module/Microsoft.PowerShell.Management/suspend-service
