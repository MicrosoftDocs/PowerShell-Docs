---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Managing Services
ms.assetid:  7a410e4d-514b-4813-ba0c-0d8cef88df31
---
# Managing Services

There are eight core Service cmdlets, designed for a wide range of service tasks . We will look only at listing and changing running state for services, but you can get a list of Service cmdlets by using **Get-Help \*-Service**, and you can find information about each Service cmdlet by using **Get-Help \<Cmdlet-Name\>**, such as **Get-Help New-Service**.

## Getting Services

You can get the services on a local or remote computer by using the **Get-Service** cmdlet. As with **Get-Process**, using the **Get-Service** command without parameters returns all services. You can filter by name, even using an asterisk as a wildcard:

```
PS> Get-Service -Name se*

Status   Name               DisplayName
------   ----               -----------
Running  seclogon           Secondary Logon
Running  SENS               System Event Notification
Stopped  ServiceLayer       ServiceLayer
```

Because it is not always obvious what the real name for the service is, you may find you need to find services by display name. You can do this by specific name, using wildcards, or using a list of display names:

```
PS> Get-Service -DisplayName se*

Status   Name               DisplayName
------   ----               -----------
Running  lanmanserver       Server
Running  SamSs              Security Accounts Manager
Running  seclogon           Secondary Logon
Stopped  ServiceLayer       ServiceLayer
Running  wscsvc             Security Center

PS> Get-Service -DisplayName ServiceLayer,Server

Status   Name               DisplayName
------   ----               -----------
Running  lanmanserver       Server
Stopped  ServiceLayer       ServiceLayer
```

You can use the ComputerName parameter of the Get-Service cmdlet to get the services on remote computers. The ComputerName parameter accepts multiple values and wildcard characters, so you can get the services on multiple computers with a single command. For example, the following command gets the services on the Server01 remote computer.

```powershell
Get-Service -ComputerName Server01
```

## Getting Required and Dependent Services

The Get-Service cmdlet has two parameters that are very useful in service administration. The DependentServices parameter gets services that depend on the service. The RequiredServices parameter gets services upon which this service depends.

These parameters just display the values of the DependentServices and ServicesDependedOn (alias=RequiredServices) properties of the System.ServiceProcess.ServiceController object that Get-Service returns, but they simplify commands and make getting this information much simpler.

The following command gets the services that the LanmanWorkstation service requires.

```
PS> Get-Service -Name LanmanWorkstation -RequiredServices

Status   Name               DisplayName
------   ----               -----------
Running  MRxSmb20           SMB 2.0 MiniRedirector
Running  bowser             Bowser
Running  MRxSmb10           SMB 1.x MiniRedirector
Running  NSI                Network Store Interface Service
```

The following command gets the services that require the LanmanWorkstation service.

```
PS> Get-Service -Name LanmanWorkstation -DependentServices

Status   Name               DisplayName
------   ----               -----------
Running  SessionEnv         Terminal Services Configuration
Running  Netlogon           Netlogon
Stopped  Browser            Computer Browser
Running  BITS               Background Intelligent Transfer Ser...
```

You can even get all services that have dependencies. The following command does just that, and then it uses the Format-Table cmdlet to display the Status, Name, RequiredServices and DependentServices properties of the services on the computer.

```powershell
Get-Service -Name * | Where-Object {$_.RequiredServices -or $_.DependentServices} | Format-Table -Property Status, Name, RequiredServices, DependentServices -auto
```

## Stopping, Starting, Suspending, and Restarting Services
The Service cmdlets all have the same general form. Services can be specified by common name or display name, and take lists and wildcards as values. To stop the print spooler, use:

```powershell
Stop-Service -Name spooler
```

To start the print spooler after it is stopped, use:

```powershell
Start-Service -Name spooler
```

To suspend the print spooler, use:

```powershell
Suspend-Service -Name spooler
```

The **Restart-Service** cmdlet works in the same manner as the other Service cmdlets, but we will show some more complex examples for it. In the simplest use, you specify the name of the service:

```
PS> Restart-Service -Name spooler

WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
PS>
```

You will notice that you get a repeated warning message about the Print Spooler starting up. When you perform a service operation that takes some time, Windows PowerShell will notify you that it is still attempting to perform the task.

If you want to restart multiple services, you can get a list of services, filter them, and then perform the restart:

```
PS> Get-Service | Where-Object -FilterScript {$_.CanStop} | Restart-Service

WARNING: Waiting for service 'Computer Browser (Browser)' to finish stopping...
WARNING: Waiting for service 'Computer Browser (Browser)' to finish stopping...
Restart-Service : Cannot stop service 'Logical Disk Manager (dmserver)' because
 it has dependent services. It can only be stopped if the Force flag is set.
At line:1 char:57
+ Get-Service | Where-Object -FilterScript {$_.CanStop} | Restart-Service <<<<
WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
WARNING: Waiting for service 'Print Spooler (Spooler)' to finish starting...
```

These Service cmdlets do not have a ComputerName parameter, but you can run them on a remote computer by using the Invoke-Command cmdlet. For example, the following command restarts the Spooler service on the Server01 remote computer.

```powershell
Invoke-Command -ComputerName Server01 {Restart-Service Spooler}
```

## Setting Service Properties

The Set-Service cmdlet changes the properties of a service on a local or remote computer. Because the service status is a property, you can use this cmdlet to start, stop, and suspend a service. The Set-Service cmdlet also has a StartupType parameter that lets you change the service startup type.

To use Set-Service on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

For more information, see [Set-Service [m2]](https://technet.microsoft.com/library/b71e29ed-372b-4e32-a4b7-5eb6216e56c3)

## See Also

- [Get-Service [m2]](https://technet.microsoft.com/en-us/library/0a09cb22-0a1c-4a79-9851-4e53075f9cf6)
- [Set-Service [m2]](https://technet.microsoft.com/library/b71e29ed-372b-4e32-a4b7-5eb6216e56c3)
- [Restart-Service [m2]](https://technet.microsoft.com/en-us/library/45acf50d-2277-4523-baf7-ce7ced977d0f)
- [Suspend-Service [m2]](https://technet.microsoft.com/en-us/library/c8492b87-0e21-4faf-8054-3c83c2ec2826)