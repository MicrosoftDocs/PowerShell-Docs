---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293923
schema: 2.0.0
---

# Stop-Service
## SYNOPSIS
Stops one or more running services.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Stop-Service [-InputObject] <ServiceController[]> [-Exclude <String[]>] [-Force] [-Include <String[]>]
 [-NoWait] [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Stop-Service [-Exclude <String[]>] [-Force] [-Include <String[]>] [-NoWait] [-PassThru] -DisplayName <String[]>
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Stop-Service [-Name] <String[]> [-Exclude <String[]>] [-Force] [-Include <String[]>] [-NoWait] [-PassThru]
 [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Stop-Service cmdlet sends a stop message to the Windows Service Controller for each of the specified services.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object that represents the service that you want to stop.

## EXAMPLES

### Example 1: Stop a service on the local computer
```
PS C:\>Stop-Service -Name "sysmonlog"
```

This command stops the Performance Logs and Alerts (SysmonLog) service on the local computer.

### Example 2: Stop a service by using the display name
```
PS C:\>Get-Service -DisplayName "telnet" | Stop-Service
```

This command stops the Telnet service on the local computer.
The command uses Get-Service to get an object that represents the Telnet service.
The pipeline operator (|) pipes the object to Stop-Service, which stops the service.

### Example 3: Stop a service that has dependent services
```
PS C:\>Get-Service -Name "iisadmin" | Format-List -Property Name, DependentServices
PS C:\> Stop-Service -Name "iisadmin" -Force -Confirm
```

This example stops the IISAdmin service on the local computer.
Because stopping this service also stops the services that depend on the IISAdmin service, it is best to precede Stop-Service with a command that lists the services that depend on the IISAdmin service.

The first command lists the services that depend on IISAdmin.
It uses Get-Service to get an object that represents the IISAdmin service.
The pipeline operator (|) passes the result to the Format-List cmdlet.
The command uses the Property parameter of Format-List to list only the Name and DependentServices properties of the service.

The second command stops the IISAdmin service.
The Force parameter is required to stop a service that has dependent services.
The command uses the Confirm parameter to request confirmation from the user before it stops each service.

## PARAMETERS

### -DisplayName
Specifies the display names of the services to stop.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
Specifies services that this cmdlet omits.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as s*.
Wildcard characters are permitted.

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

### -Force
Forces the cmdlet to stop a service even if that service has dependent services.

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

### -Include
Specifies services that this cmdlet stops.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as s*.
Wildcard characters are permitted.

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

### -InputObject
Specifies ServiceController objects that represent the services to stop.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: ServiceController[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service names of the services to stop.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: ServiceName

Required: True
Position: 1
Default value: None
Accept pipeline input: True(ByValue,ByPropertyName)
Accept wildcard characters: False
```

### -NoWait
Indicates that this cmdlet uses the no wait option.

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

### -PassThru
Returns an object that represents the service.
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
You can pipe a service object or a string that contains the name of a service to this cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController
This cmdlet generates a System.ServiceProcess.ServiceController object that represents the service, if you use the PassThru parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* You can also refer to Stop-Service by its built-in alias, spsv. For more information, see about_Aliases.

  Stop-Service can control services only when the current user has permission to do this.
If a command does not work correctly, you might not have the required permissions.

  To find the service names and display names of the services on your system, type Get-Service.
The service names appear in the Name column and the display names appear in the DisplayName column.

*

## RELATED LINKS

[Get-Service](77f3c94b-6ffd-4906-8216-3debbf5ffe79)

[New-Service](ad24021a-4603-4c9c-bd20-8f9bdde123fa)

[Restart-Service](9fa33bc1-264e-40aa-8731-607ca99cc805)

[Resume-Service](84ac7b53-a313-4617-b983-097c33792a6b)

[Set-Service](d4a1bd34-7122-4c01-83b0-ec4ca78371d7)

[Start-Service](a3abab52-805c-4054-a41a-82cd81dc7fd3)

[Suspend-Service](5b8bd69a-0a18-4478-b257-d442ddef417c)

