---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=113414
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Stop-Service
---

# Stop-Service
## SYNOPSIS
Stops one or more running services.
## SYNTAX

### InputObject (Default)
```
Stop-Service [-Force] [-InputObject] <ServiceController[]> [-PassThru] [-Include <String[]>]
 [-Exclude <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default
```
Stop-Service [-Force] [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### DisplayName
```
Stop-Service [-Force] [-PassThru] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Stop-Service cmdlet sends a stop message to the Windows Service Controller for each of the specified services.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object representing the services that you want to stop.
## EXAMPLES

### Example 1
```
PS C:\> stop-service sysmonlog
```

This command stops the Performance Logs and Alerts (SysmonLog) service on the local computer.
### Example 2
```
PS C:\> get-service -displayname telnet | stop-service
```

This command stops the Telnet service on the local computer.
The command uses the Get-Service cmdlet to get an object representing the Telnet service.
The pipeline operator (|) pipes the object to the Stop-Service cmdlet, which stops the service.
### Example 3
```
PS C:\> get-service iisadmin | format-list -property name, dependentservices
PS C:\> stop-service iisadmin -force -confirm
```

The Stop-Service command stops the IISAdmin service on the local computer.
Because stopping this service also stops the services that depend on the IISAdmin service, it is best to precede the Stop-Service command with a command that lists the services that depend on the IISAdmin service.

The first command lists the services that depend on IISAdmin.
It uses the Get-Service cmdlet to get an object representing the IISAdmin service.
The pipeline operator (|) passes the result to the Format-List cmdlet.
The command uses the Property parameter of Format-List to list only the Name and DependentServices properties of the service.

The second command stops the IISAdmin service.
The Force parameter is required to stop a service that has dependent services.
The command uses the Confirm parameter to request confirmation from the user before stopping each service.
## PARAMETERS

### -DisplayName
Specifies the display names of the services to be stopped.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: DisplayName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
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
Accept wildcard characters: True
```

### -Force
Allows the cmdlet to stop a service even if that service has dependent services.

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

### -Include
Stops only the specified services.
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
Accept wildcard characters: True
```

### -InputObject
Specifies ServiceController objects representing the services to be stopped.
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
Specifies the service names of the services to be stopped.
Wildcards are permitted.

The parameter name is optional.
You can use "Name" or its alias, "ServiceName", or you can omit the parameter name.

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ServiceName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
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
Default value: False
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

### System.ServiceProcess.ServiceController or System.String
You can pipe a service object or a string that contains the name of a service to Stop-Service.
## OUTPUTS

### None or System.ServiceProcess.ServiceController
When you use the PassThru parameter, Stop-Service generates a System.ServiceProcess.ServiceController object representing the service.
Otherwise, this cmdlet does not generate any output.
## NOTES
* You can also refer to Stop-Service by its built-in alias, "spsv". For more information, see about_Aliases.

  Stop-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

  To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column and the display names appear in the DisplayName column.

*
## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Suspend-Service](Suspend-Service.md)
