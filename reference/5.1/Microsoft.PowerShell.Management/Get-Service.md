---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 03/20/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-service?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Service
---

# Get-Service

## SYNOPSIS
Gets the services on a local or remote computer.

## SYNTAX

### Default (Default)

```
Get-Service [[-Name] <String[]>] [-ComputerName <String[]>] [-DependentServices] [-RequiredServices]
 [-Include <String[]>] [-Exclude <String[]>] [<CommonParameters>]
```

### DisplayName

```
Get-Service [-ComputerName <String[]>] [-DependentServices] [-RequiredServices] -DisplayName <String[]>
 [-Include <String[]>] [-Exclude <String[]>] [<CommonParameters>]
```

### InputObject

```
Get-Service [-ComputerName <String[]>] [-DependentServices] [-RequiredServices] [-Include <String[]>]
 [-Exclude <String[]>] [-InputObject <ServiceController[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Service` cmdlet gets objects that represent the services on a local computer or on a remote
computer, including running and stopped services. By default, when `Get-Service` is run without
parameters, all the local computer's services are returned.

You can direct this cmdlet to get only particular services by specifying the service name or the
display name of the services, or you can pipe service objects to this cmdlet.

## EXAMPLES

### Example 1: Get all services on the computer

This example gets all of the services on the computer. It behaves as though you typed
`Get-Service *`. The default display shows the status, service name, and display name of each
service.

```powershell
Get-Service
```

### Example 2: Get services that begin with a search string

This example retrieves services with service names that begin with `WMI` (Windows Management
Instrumentation).

```powershell
Get-Service "wmi*"
```

### Example 3: Display services that include a search string

This example displays services with a display name that includes the word `network`. Searching the
display name finds network-related services even when the service name doesn't include `Net`, such as
xmlprov, the Network Provisioning Service.

```powershell
Get-Service -Displayname "*network*"
```

### Example 4: Get services that begin with a search string and an exclusion

This example only gets the services with service names that begin with `win`, except for the WinRM
service.

```powershell
Get-Service -Name "win*" -Exclude "WinRM"
```

### Example 5: Display services that are currently active

This example displays only the services with a status of `Running`.

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

`Get-Service` gets all the services on the computer and sends the objects down the pipeline. The
`Where-Object` cmdlet, selects only the services with a **Status** property that equals `Running`.

Status is only one property of service objects. To see all of the properties, type
`Get-Service | Get-Member`.

### Example 6: Get the services on a remote computer

```powershell
Get-Service -ComputerName "Server02"
```

This command gets the services on the Server02 remote computer.

Because the **ComputerName** parameter of `Get-Service` does not use Windows PowerShell remoting,
you can use this parameter even if the computer is not configured for remoting in Windows
PowerShell.

### Example 7: List the services on the local computer that have dependent services

This example gets services that have dependent services.

```powershell
Get-Service |
  Where-Object {$_.DependentServices} |
    Format-List -Property Name, DependentServices, @{
      Label="NoOfDependentServices"; Expression={$_.dependentservices.count}
    }
```

```Output
Name                  : AudioEndpointBuilder
DependentServices     : {AudioSrv}
NoOfDependentServices : 1

Name                  : Dhcp
DependentServices     : {WinHttpAutoProxySvc}
NoOfDependentServices : 1
...
```

The `Get-Service` cmdlet gets all the services on the computer and sends the objects down the
pipeline. The `Where-Object` cmdlet selects the services whose **DependentServices** property isn't
null.

The results are sent down the pipeline to the `Format-List` cmdlet. The **Property** parameter
displays the name of the service, the name of the dependent services, and a calculated property that
displays the number of dependent services for each service.

### Example 8: Sort services by property value

This example shows that when you sort services in ascending order by the value of their **Status**
property, stopped services appear before running services. This happens because the value of
**Status** is an enumeration, in which `Stopped` has a value of `1`, and `Running` has a value of
`4`. For more information, see
[ServiceControllerStatus](/dotnet/api/system.serviceprocess.servicecontrollerstatus).

To list running services first, use the **Descending** parameter of the `Sort-Object` cmdlet.

```powershell
Get-Service "s*" | Sort-Object status
```

```Output
Status   Name               DisplayName
------   ----               -----------
Stopped  stisvc             Windows Image Acquisition (WIA)
Stopped  SwPrv              MS Software Shadow Copy Provider
Stopped  SysmonLog          Performance Logs and Alerts
Running  Spooler            Print Spooler
Running  srservice          System Restore Service
Running  SSDPSRV            SSDP Discovery Service
Running  ShellHWDetection   Shell Hardware Detection
Running  Schedule           Task Scheduler
Running  SCardSvr           Smart Card
Running  SamSs              Security Accounts Manager
Running  SharedAccess       Windows Firewall/Internet Connectio...
Running  SENS               System Event Notification
Running  seclogon           Secondary Logon
```

### Example 9: Get services on multiple computers

```powershell
Get-Service -Name "WinRM" -ComputerName "localhost", "Server01", "Server02" |
 Format-Table -Property MachineName, Status, Name, DisplayName -auto
```

```Output
MachineName    Status  Name  DisplayName
------------   ------  ----  -----------
localhost      Running WinRM Windows Remote Management (WS-Management)
Server01       Running WinRM Windows Remote Management (WS-Management)
Server02       Running WinRM Windows Remote Management (WS-Management)
```

This command uses the `Get-Service` cmdlet to run a `Get-Service Winrm` command on two remote
computers and the local computer (`localhost`).

The command runs on the remote computers, and the results are returned to the local computer. A
pipeline operator (`|`) sends the results to the `Format-Table` cmdlet, which formats the services
as a table. The `Format-Table` command uses the **Property** parameter to specify the properties
displayed in the table, including the **MachineName** property.

### Example 10: Get the dependent services of a service

This example gets the services that the WinRM service requires. The value of the service's
**ServicesDependedOn** property is returned.

```powershell
Get-Service "WinRM" -RequiredServices
```

### Example 11: Get a service through the pipeline operator

This example gets the WinRM service on the local computer. The service name string, enclosed in
quotation marks, is sent down the pipeline to `Get-Service`.

```powershell
"WinRM" | Get-Service
```

## PARAMETERS

### -ComputerName

Gets the services running on the specified computers. The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name (FQDN) of a remote computer.
To specify the local computer, type the computer name, a dot (`.`), or `localhost`.

This parameter does not rely on Windows PowerShell remoting. You can use the **ComputerName**
parameter of `Get-Service` even if your computer is not configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DependentServices

Indicates that this cmdlet gets only the services that depend upon the specified service.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: DS

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies, as a string array, the display names of services to be retrieved. Wildcards are
permitted.

```yaml
Type: System.String[]
Parameter Sets: DisplayName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Exclude

Specifies, as a string array, a service or services that this cmdlet excludes from the operation.
The value of this parameter qualifies the **Name** parameter. Enter a name element or pattern, such
as `s*`. Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include

Specifies, as a string array, a service or services that this cmdlet includes in the operation. The
value of this parameter qualifies the **Name** parameter. Enter a name element or pattern, such as
`s*`. Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -InputObject

Specifies **ServiceController** objects representing the services to be retrieved. Enter a variable
that contains the objects, or type a command or expression that gets the objects. You can pipe a
service object to this cmdlet.

```yaml
Type: System.ServiceProcess.ServiceController[]
Parameter Sets: InputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the service names of services to be retrieved. Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: Default
Aliases: ServiceName

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -RequiredServices

Indicates that this cmdlet gets only the services that this service requires. This parameter gets
the value of the **ServicesDependedOn** property of the service.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: SDO, ServicesDependedOn

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.ServiceProcess.ServiceController

You can pipe a service object to this cmdlet.

### System.String

You can pipe a service name to this cmdlet.

## OUTPUTS

### System.ServiceProcess.ServiceController

This cmdlet returns objects that represent the services on the computer.

## NOTES

Windows PowerShell includes the following aliases for `Get-Service`:

- `gsv`

This cmdlet can display services only when the current user has permission to see them. If this
cmdlet does not display services, you might not have permission to see them.

To find the service name and display name of each service on your system, type `Get-Service`. The
service names appear in the **Name** column, and the display names appear in the **DisplayName**
column.

> [!NOTE]
> Typically, `Get-Service` returns information about services and not driver. However, if you
> specify the name of a driver, `Get-Service` returns information about the driver.
>
> - Enumeration doesn't include device driver services
> - When a wildcard is specified, the cmdlet only returns Windows services
> - If you specify the **Name** or **DisplayName** that is an exact match to a device service name,
>   then the device instance is returned

When you sort in ascending order by status value, `Stopped` services appear before `Running`
services. The **Status** property of a service is an enumerated value in which the names of the
statuses represent integer values. The sort is based on the integer value, not the name. `Running`
appears before `Stopped` because `Stopped` has a value of `1`, and `Running` has a value of `4`. For
more information, see
[ServiceControllerStatus](/dotnet/api/system.serviceprocess.servicecontrollerstatus).

## RELATED LINKS

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)
