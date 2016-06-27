---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293919
schema: 2.0.0
---

# Start-Service
## SYNOPSIS
Starts one or more stopped services.

## SYNTAX

### InputObject (Default)
```
Start-Service [-InputObject] <ServiceController[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### Default
```
Start-Service [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

### DisplayName
```
Start-Service [-PassThru] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Start-Service cmdlet sends a start message to the Windows Service Controller for each of the specified services.
If a service is already running, the message is ignored without error.
You can specify the services by their service names or display names, or you can use the InputObject parameter to supply a service object representing the services that you want to start.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>start-service -name eventlog
```

This command starts the EventLog service on the local computer.
It uses the Name parameter to identify the service by its service name.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>start-service -displayname *remote* -whatif
```

This command tells what would happen if you started the services with a display name that includes "remote".
It uses the DisplayName parameter to specify the services by their display name instead of by their service name.
And, it uses the WhatIf parameter to tell what would happen if the command were executed instead of executing the command.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$s = get-service wmi
PS C:\>start-service -InputObject $s -passthru | format-list >> services.txt
```

These commands start the Windows Management Instrumentation (WMI) service on the computer and add a record of the action to the services.txt file.
The first command uses the Get-Service cmdlet to get an object representing the WMI service and store it in the $s variable.

The second command uses the Start-Service cmdlet to start the WMI service.
It identifies the service by using the InputObject parameter to pass the $s variable containing the WMI service object to Start-Service.
Then, it uses the PassThru parameter to create an object that represents the starting of the service.
Without this parameter, Start-Service does not create any output.

The pipeline operator (|) passes the object that Start-Service creates to the Format-List cmdlet, which formats the object as a list of its properties.
The append redirection operator (\>\>) redirects the output to the services.txt file, where it is added to the end of the existing file.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>start-service tlntsvr
Start-Service : Service 'Telnet (TlntSvr)' cannot be started due to the    following error: Cannot start service TlntSvr on computer '.'.
At line:1 char:14
+ start-service  <<<< tlntsvr PS C:\>get-wmiobject win32_service | where-object {$_.Name -eq "tlntsvr"}

ExitCode  : 0
Name      : TlntSvr
ProcessId : 0
StartMode : Disabled
State     : Stopped
Status    : OK PS C:\>set-service tlntsvr -startuptype manual PS C:\>start-service tlntsvr
```

This series of commands shows how to start a service when the start type of the service is "Disabled".
The first command, which uses the Start-Service cmdlet to start the Telnet service (tlntsvr), fails.

The second command uses the Get-WmiObject cmdlet to get the Tlntsvr service.
This command retrieves an object with the start type property in the StartMode field.
The resulting display reveals that the start type of the Tlntsvr service is "Disabled".

The next command uses the Set-Service cmdlet to change the start type of the Tlntsvr service to "Manual".

Now, we can resubmit the Start-Service command.
This time, the command succeeds.

To verify that the command succeeded, run Get-Service.

## PARAMETERS

### -DisplayName
Specifies the display names of the services to be started.
Wildcards are permitted.

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
Starts only the specified services.
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
@{Text=}

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
@{Text=}

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
Specifies ServiceController objects representing the services to be started.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: ServiceController[]
Parameter Sets: InputObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service names for the service to be started.

The parameter name is optional.
You can use "-Name" or its alias, "-ServiceName", or you can omit the parameter name.

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ServiceName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the service.
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

### -Confirm
{{Fill Confirm Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
{{Fill WhatIf Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.ServiceProcess.ServiceController, System.String
You can pipe objects that represent the services or strings that contain the service names to Start-Service.

## OUTPUTS

### None or System.ServiceProcess.ServiceController
When you use the PassThru parameter, Start-Service generates a System.ServiceProcess.ServiceController object representing the service.
Otherwise, this cmdlet does not generate any output.

## NOTES
You can also refer to Start-Service by its built-in alias, "sasv".
For more information, see about_Aliases.

Start-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column, and the display names appear in the DisplayName column.

You can start only the services that have a start type of "Manual" or "Automatic".
You cannot start the services with a start type of "Disabled".
If a Start-Service command fails with the message "Cannot start service \<service-name\> on computer," use a Get-WmiObject command to find the start type of the service and, if necessary, use a Set-Service command to change the start type of the service.

Some services, such as Performance Logs and Alerts (SysmonLog) stop automatically if they have no work to do.
When Windows PowerShell starts a service that stops itself almost immediately, it displays the following message: "Service \<display-name\> start failed."

## RELATED LINKS

[Get-Service]()

[New-Service]()

[Restart-Service]()

[Resume-Service]()

[Set-Service]()

[Stop-Service]()

[Suspend-Service]()

