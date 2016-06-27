---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=290503
schema: 2.0.0
---

# Get-Service
## SYNOPSIS
Gets the services on a local or remote computer.

## SYNTAX

### Default (Default)
```
Get-Service [[-Name] <String[]>] [-ComputerName <String[]>] [-DependentServices] [-RequiredServices]
 [-Include <String[]>] [-Exclude <String[]>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### DisplayName
```
Get-Service [-ComputerName <String[]>] [-DependentServices] [-RequiredServices] -DisplayName <String[]>
 [-Include <String[]>] [-Exclude <String[]>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

### InputObject
```
Get-Service [-ComputerName <String[]>] [-DependentServices] [-RequiredServices] [-Include <String[]>]
 [-Exclude <String[]>] [-InputObject <ServiceController[]>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Get-Service cmdlet gets objects that represent the services on a local computer or on a remote computer, including running and stopped services.

You can direct Get-Service to get only particular services by specifying the service name or display name of the services, or you can pipe service objects to Get-Service.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-service
```

This command retrieves all of the services on the system.
It behaves as though you typed "get-service *".
The default display shows the status, service name, and display name of each service.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-service wmi*
```

This command retrieves services with service names that begin with "WMI" (the acronym for Windows Management Instrumentation).

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-service -displayname *network*
```

This command displays services with a display name that includes the word "network".
Searching the display name finds network-related services even when the service name does not include "Net", such as xmlprov, the Network Provisioning Service.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-service -name win* -exclude winrm
```

These commands get only the services with service names that begin with "win", except for the WinRM service.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-service | where-object {$_.Status -eq "Running"}
```

This command displays only the services that are currently running.
It uses the Get-Service cmdlet to get all of the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects only the services with a Status property that equals "Running".

Status is only one property of service objects.
To see all of the properties, type "get-service | get-member".

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>get-service -computername Server02
```

This command gets the services on the Server02 remote computer.

Because the ComputerName parameter of Get-Service does not use Windows PowerShell remoting, you can use this parameter even if the computer is not configured for remoting in Windows PowerShell.

### -------------------------- EXAMPLE 7 --------------------------
```
PS C:\>get-service | where-object {$_.DependentServices} | format-list -property Name, DependentServices, @{Label="NoOfDependentServices"; Expression={$_.dependentservices.count}}

Name                  : AudioEndpointBuilder
DependentServices     : {AudioSrv}
NoOfDependentServices : 1
Name                  : Dhcp
DependentServices     : {WinHttpAutoProxySvc}
NoOfDependentServices : 1
...
```

These commands list the services on the computer that have dependent services.

The first command uses the Get-Service cmdlet to get the services on the computer.
A pipeline operator (|) sends the services to the Where-Object cmdlet, which selects the services whose DependentServices property is not null.

Another pipeline operator sends the results to the Format-List cmdlet.
The command uses its Property parameter to display the name of the service, the name of the dependent services, and a calculated property that displays the number of dependent services that each service has.

### -------------------------- EXAMPLE 8 --------------------------
```
PS C:\>get-service s* | sort-object status

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

PS C:\>get-service s* | sort-object status -descending

Status   Name               DisplayName
------   ----               -----------
Running  ShellHWDetection   Shell Hardware Detection
Running  SharedAccess       Windows Firewall/Internet Connectio...
Running  Spooler            Print Spooler
Running  SSDPSRV            SSDP Discovery Service
Running  srservice          System Restore Service
Running  SCardSvr           Smart Card
Running  SamSs              Security Accounts Manager
Running  Schedule           Task Scheduler
Running  SENS               System Event Notification
Running  seclogon           Secondary Logon
Stopped  SysmonLog          Performance Logs and Alerts
Stopped  SwPrv              MS Software Shadow Copy Provider
Stopped  stisvc             Windows Image Acquisition (WIA)
```

This command shows that when you sort services in ascending order by the value of their Status property, stopped services appear before running services.
This happens because the value of Status is an enumeration, in which "Stopped" has a value of "1", and "Running" has a value of 4.

To list running services first, use the Descending parameter of the Sort-Object cmdlet.

### -------------------------- EXAMPLE 9 --------------------------
```
PS C:\>get-service -name winrm -computername localhost, Server01, Server02 | format-table -property MachineName, Status, Name, DisplayName -auto

MachineName    Status  Name  DisplayName
------------   ------  ----  -----------
localhost      Running WinRM Windows Remote Management (WS-Management)
Server01       Running WinRM Windows Remote Management (WS-Management)
Server02       Running WinRM Windows Remote Management (WS-Management)
```

This command uses the Get-Service cmdlet to run a "Get-Service Winrm" command on two remote computers and the local computer ("localhost").

The Get-Service command runs on the remote computers, and the results are returned to the local computer.
A pipeline operator (|) sends the results to the Format-Table cmdlet, which formats the services as a table.
The Format-Table command uses the Property parameter to specify the properties displayed in the table, including the MachineName property.

### -------------------------- EXAMPLE 10 --------------------------
```
PS C:\>get-service winrm -requiredServices
```

This command gets the services that the WinRM service requires.

The command returns the value of the ServicesDependedOn property of the service.

### -------------------------- EXAMPLE 11 --------------------------
```
PS C:\>"winrm" | get-service
```

This command gets the WinRM service on the local computer.
This example shows that you can pipe a service name string (enclosed in quotation marks) to Get-Service.

## PARAMETERS

### -ComputerName
Gets the services running on the specified computers.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-Service even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Cn

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DependentServices
Gets only the services that depend upon the specified service.

By default, Get-Service gets all services.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: DS

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display names of services to be retrieved.
Wildcards are permitted.
By default, Get-Service gets all services on the computer.

```yaml
Type: String[]
Parameter Sets: DisplayName
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
Omits the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Retrieves only the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-Service even if your computer is not configured to run remote commands.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or "localhost".

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter of Get-Service even if your computer is not configured to run remote commands.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies ServiceController objects representing the services to be retrieved.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe a service object to Get-Service.

```yaml
Type: ServiceController[]
Parameter Sets: InputObject
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service names of services to be retrieved.
Wildcards are permitted.
By default, Get-Service gets all of the services on the computer.

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ServiceName

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RequiredServices
Gets only the services that this service requires.

This parameter gets the value of the ServicesDependedOn property of the service.
By default, Get-Service gets all services.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: SDO, ServicesDependedOn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.ServiceProcess.ServiceController, System.String
You can pipe a service object or a service name to Get-Service.

## OUTPUTS

### System.ServiceProcess.ServiceController
Get-Service returns objects that represent the services on the computer.

## NOTES
You can also refer to Get-Service by its built-in alias, "gsv".
For more information, see about_Aliases.

Get-Service can display services only when the current user has permission to see them.
If Get-Service does not display services, you might not have permission to see them.

To find the service name and display name of each service on your system, type "get-service".
The service names appear in the Name column, and the display names appear in the DisplayName column.

When you sort in ascending order by status value, "Stopped" services appear before "Running" services.
The Status property of a service is an enumerated value in which the names of the statuses represent integer values.
The sort is based on the integer value, not the name.
"Running" appears before "Stopped" because "Stopped" has a value of "1", and "Running" has a value of "4".

## RELATED LINKS

[New-Service]()

[Restart-Service]()

[Resume-Service]()

[Set-Service]()

[Start-Service]()

[Stop-Service]()

[Suspend-Service]()

