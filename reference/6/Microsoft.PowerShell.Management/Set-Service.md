---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821633
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Set-Service
---

# Set-Service

## SYNOPSIS
Starts, stops, and suspends a service, and changes its properties.

## SYNTAX

### Name (Default)
```
Set-Service [-Name] <String> [-DisplayName <String>] [-Description <String>]
 [-StartupType <ServiceStartMode>] [-Status <String>] [-PassThru] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject
```
Set-Service [-DisplayName <String>] [-Description <String>]
 [-StartupType <ServiceStartMode>] [-Status <String>] [-InputObject <ServiceController>] [-PassThru]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Set-Service** cmdlet changes the properties of a local or remote service.
This includes the status, description, display name, and start mode.
You can use this cmdlet to start, stop, or suspend, or pause, a service.
To identify the service, enter its service name or submit a service object, or pipe a service name or service object to **Set-Service**.

## EXAMPLES

### Example 1: Change a display name
```
PS C:\> Set-Service -Name "lanmanworkstation" -DisplayName "LanMan Workstation"
```

This command changes the display name of the lanmanworkstation service to LanMan Workstation.
The default is Workstation.

### Example 2: Change the startup type of services
```
PS C:\> Get-WMIObject win32_service -Filter "name = 'SysmonLog'"

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

These commands use the **Get-WmiObject** cmdlet to get the **Win32_Service** object for the service, because the **ServiceController** object that **Get-Service** returns does not include the start mode.

The first command uses the **Get-WmiObject** cmdlet to get the Windows Management Instrumentation (WMI) object that represents the **SysmonLog** service.
The default output of this command displays the start mode of the service.

The second command uses Set-Service to change the start mode to automatic.
Then, the first command is repeated to display the change.

The final command displays the start mode of all services on the computer.

### Example 3: Change the description of a service
```
PS C:\> Set-Service -Name "Schedule" -Description "Configures and schedules tasks."
PS C:\> Get-WMIObject win32_service | Where-Object {$_.Name -eq "Schedule"} | Format-List Name, Description
```

These commands change the description of the Task Scheduler service and then display the result.

These commands use the **Get-WmiObject** cmdlet to get the **Win32_Service** object for the service, because the **ServiceController** object that **Get-Service** returns does not include the service description.

The first command changes the description.
It identifies the service by using the service name of the service, Schedule.

The second command uses the **Get-WmiObject** cmdlet to get an instance of the WMI **Win32_Service** that represents the Task Scheduler service.
The first element in the command gets all instances of the **Win32_service** class.

The pipeline operator (|) passes the result to the Where-Object cmdlet, which selects instances with a value of Schedule in the **Name** property.

Another pipeline operator sends the result to the Format-List cmdlet, which formats the output as a list that has only the **Name** and **Description** properties.

### Example 4: Start a service
```
PS C:\> Set-Service -Name "winrm" -Status Running -PassThru
```

This command starts the WinRM service.
The command uses the Status parameter to specify the desired status, which is running, and the *PassThru* parameter to direct **Set-Service** to return an object that represents the WinRM service.

### Example 5: Suspend a service
```
PS C:\> Get-Service -Name "schedule" | Set-Service -Status paused
```

This command suspends the Schedule service.
It uses **Get-Service** to get the service.
A pipeline operator (|) sends the service to **Set-Service**, which changes its status to Paused.

### Example 6: Stop a service
```
PS C:\> $s = Get-Service -Name "schedule"
PS C:\> Set-Service -InputObject $s -Status stopped
```

These commands stop the Schedule service.

The first command uses **Get-Service** to get the Schedule service.
The command stores the service in the $s variable.

The second command changes the status of the Schedule service to Stopped.
It uses the *InputObject* parameter to submit the service stored in the $s variable, and it uses the *Status* parameter to specify the desired status.

### Example 7: Change credential of a service
```
PS C:\> $credential = Get-Credential
PS C:\> Set-Service -Name "schedule" -Credential $credential
```

These commands changes credentials of the Schedule service.

The first command uses **Get-Credential** to get the new credentials.
The command stores the credentials in the $credential variable.

The second command changes the credentials of the Schedule service.

## PARAMETERS

### -Description
Specifies a new description for the service.

The service description appears in Services in Computer Management.
Description is not a property of the **ServiceController** object that Get-Service gets.
To see the service description, use Get-WmiObject to get a **Win32_Service** object that represents the service.

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

### -InformationAction
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
Specifies a **ServiceController** object that represents the service to change.
Enter a variable that contains the object, or type a command or expression that gets the object, such as a **Get-Service** command.
You can also pipe a service object to Set-Service.

```yaml
Type: ServiceController
Parameter Sets: InputObject
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
You can also pipe a service name to **Set-Service**.

```yaml
Type: String
Parameter Sets: Name
Aliases: ServiceName, SN

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Credential
Specifies the credentials under which the service should be run.


```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Type: ServiceStartMode
Parameter Sets: (All)
Aliases: StartMode, SM, ST
Accepted values: Automatic, Manual, Disabled

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
Type: String
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
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.ServiceProcess.ServiceController, System.String
You can pipe a service object or a string that contains a service name to Set-Service.

## OUTPUTS

### System.ServiceProcess.ServiceController
This cmdlet does not return any objects.

## NOTES
* To use **Set-Service** on Windows Vista and later versions of the Windows operating system, start Windows PowerShell by using the Run as administrator option.
* **Set-Service** can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
* To find the service names and display names of the services on your system, type `Get-Service`. The service names appear in the **Name** column and the display names appear in the **DisplayName** column.

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)

[Remove-Service](Remove-Service.md)