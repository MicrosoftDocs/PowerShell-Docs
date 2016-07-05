---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293913
schema: 2.0.0
---

# Set-Service
## SYNOPSIS
Starts, stops, and suspends a service, and changes its properties.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-Service [-Name] <String> [-ComputerName <String[]>] [-Description <String>] [-DisplayName <String>]
 [-PassThru] [-StartupType] [-Status] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Set-Service [-ComputerName <String[]>] [-Description <String>] [-DisplayName <String>]
 [-InputObject <ServiceController>] [-PassThru] [-StartupType] [-Status] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Set-Service cmdlet changes the properties of a local or remote service.
This includes the status, description, display name, and start mode.
You can use this cmdlet to start, stop, or suspend, or pause, a service.
To identify the service, enter its service name or submit a service object, or pipe a service name or service object to Set-Service.

## EXAMPLES

### Example 1: Change a display name
```
PS C:\>Set-Service -Name "lanmanworkstation" -DisplayName "LanMan Workstation"
```

This command changes the display name of the lanmanworkstation service to LanMan Workstation.
The default is Workstation.

### Example 2: Change the startup type of services
```
PS C:\>Get-WMIObject win32_service -Filter "name = 'SysmonLog'"

ExitCode  : 0
Name      : SysmonLog
ProcessId : 0
StartMode : Manual
State     : Stopped
Status    : OK
PS C:\> Set-Service -Name "sysmonlog" -StartupType automatic
PS C:\> Get-WMIObject win32_service -Filter "name = 'SysmonLog'"
ExitCode  : 0
Name      : SysmonLog
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

PS C:\> Get-WMIObject win32_service | Format-Table Name, StartMode -auto

Name                                  StartMode
----                                  ---------
AdtAgent                              Auto
Alerter                               Disabled
ALG                                   Manual
AppMgmt                               Manual
...
```

These commands get the startup type of the Performance Logs and Alerts (SysmonLog) service, set the start mode to automatic, and then display the result of the change.

These commands use the Get-WmiObject cmdlet to get the Win32_Service object for the service, because the ServiceController object that Get-Service returns does not include the start mode.

The first command uses the Get-WmiObject cmdlet to get the Windows Management Instrumentation (WMI) object that represents the SysmonLog service.
The default output of this command displays the start mode of the service.

The second command uses Set-Service to change the start mode to automatic.
Then, the first command is repeated to display the change.

The final command displays the start mode of all services on the computer.

### Example 3: Change the description of a service
```
PS C:\>Set-Service -Name "Schedule" -ComputerName "S1" -Description "Configures and schedules tasks."
PS C:\> Get-WMIObject win32_service -ComputerName "s1" | Where-Object {$_.Name -eq "Schedule"} | Format-List Name, Description
```

These commands change the description of the Task Scheduler service on the S1 remote computer and then display the result.

These commands use the Get-WmiObject cmdlet to get the Win32_Service object for the service, because the ServiceController object that Get-Service returns does not include the service description.

The first command changes the description.
It identifies the service by using the service name of the service, Schedule.

The second command uses the Get-WmiObject cmdlet to get an instance of the WMI Win32_Service that represents the Task Scheduler service.
The first element in the command gets all instances of the Win32_service class.

The pipeline operator (|) passes the result to the Where-Object cmdlet, which selects instances with a value of Schedule in the Name property.

Another pipeline operator sends the result to the Format-List cmdlet, which formats the output as a list that has only the Name and Description properties.

### Example 4: Start a service on a remote computer
```
PS C:\>Set-Service -Name "winrm" -Status Running -PassThru -ComputerName "Server02"
```

This command starts the WinRM service on the Server02 computer.
The command uses the Status parameter to specify the desired status, which is running, and the PassThru parameter to direct Set-Service to return an object that represents the WinRM service.

### Example 5: Suspend a service on remote computers
```
PS C:\>Get-Service -Name "schedule" -ComputerName "S1", "S2" | Set-Service -Status paused
```

This command suspends the Schedule service on the S1 and S2 remote computers.
It uses Get-Service to get the service.
A pipeline operator (|) sends the service to Set-Service, which changes its status to Paused.

### Example 6: Stop a service on the local computer
```
PS C:\>$s = Get-Service -Name "schedule"
PS C:\> Set-Service -InputObject $s -Status stopped
```

These commands stop the Schedule service on the local computer.

The first command uses Get-Service to get the Schedule service.
The command stores the service in the $s variable.

The second command changes the status of the Schedule service to Stopped.
It uses the InputObject parameter to submit the service stored in the $s variable, and it uses the Status parameter to specify the desired status.

## PARAMETERS

### -ComputerName
Specifies one or more computers.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or localhost.

This parameter does not rely on Windows PowerShell remoting.
You can use the ComputerName parameter even if your computer is not configured to run remote commands.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: cn

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description
Specifies a new description for the service.

The service description appears in Services in Computer Management.
Description is not a property of the ServiceController object that Get-Service gets.
To see the service description, use Get-WmiObject to get a Win32_Service object that represents the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies a new display name for the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases: DN

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a ServiceController object that represents the service to change.
Enter a variable that contains the object, or type a command or expression that gets the object, such as a Get-Service command.
You can also pipe a service object to Set-Service.

```yaml
Type: ServiceController
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service name of the service to be changed.
Wildcard characters are not permitted.
You can also pipe a service name to Set-Service.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: ServiceName,SN

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue, ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns objects that represent the services that were changed.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupType
Specifies the start mode of the service.
The acceptable values for this parameter are:

- Automatic.
Start when the system starts.
- Manual.
Starts only when started by a user or program.
- Disabled.
Cannot be started.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: StartMode,SM,ST
Accepted values: Boot, System, Automatic, Manual, Disabled

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Specifies the status for the service. 
The acceptable values for this parameter are:

- Running.
Starts the service.
- Stopped.
Stops the service.
- Paused.
Suspends the service.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Accepted values: Running, Stopped, Paused

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.ServiceProcess.ServiceController, System.String
You can pipe a service object or a string that contains a service name to Set-Service.

## OUTPUTS

### System.ServiceProcess.ServiceController
This cmdlet does not return any objects.

## NOTES
* To use Set-Service on Windows Vista and later versions of the Windows operating system, start Windows PowerShell by using the Run as administrator option.
* Set-Service can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
* To find the service names and display names of the services on your system, type Get-Service. The service names appear in the Name column and the display names appear in the DisplayName column.

## RELATED LINKS

[Get-Service](77f3c94b-6ffd-4906-8216-3debbf5ffe79)

[New-Service](ad24021a-4603-4c9c-bd20-8f9bdde123fa)

[Restart-Service](9fa33bc1-264e-40aa-8731-607ca99cc805)

[Resume-Service](84ac7b53-a313-4617-b983-097c33792a6b)

[Start-Service](a3abab52-805c-4054-a41a-82cd81dc7fd3)

[Stop-Service](58033475-759b-42e4-9395-c077aa55934e)

[Suspend-Service](5b8bd69a-0a18-4478-b257-d442ddef417c)

