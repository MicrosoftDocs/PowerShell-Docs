---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=113416
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Suspend-Service
---

# Suspend-Service
## SYNOPSIS
Suspends (pauses) one or more running services.
## SYNTAX

### InputObject (Default)
```
Suspend-Service [-InputObject] <ServiceController[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default
```
Suspend-Service [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DisplayName
```
Suspend-Service [-PassThru] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Suspend-Service cmdlet sends a suspend message to the Windows Service Controller for each of the specified services.
While suspended, the service is still running, but its action is halted until resumed, such as by using Resume-Service.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object representing the services that you want to suspend.
## EXAMPLES

### Example 1
```
PS C:\> suspend-service -displayname "Telnet"
```

This command suspends the Telnet service (Tlntsvr) service on the local computer.
### Example 2
```
PS C:\> suspend-service -name lanman* -whatif
```

This command tells what would happen if you suspended the services that have a service name that begins with "lanman".
To suspend the services, rerun the command without the WhatIf parameter.
### Example 3
```
PS C:\> get-service schedule | suspend-service
```

This command uses the Get-Service cmdlet to get an object that represents the Task Scheduler (Schedule) service on the computer.
The pipeline operator (|) passes the result to the Suspend-Service cmdlet, which suspends the service.
### Example 4
```
PS C:\> get-service | where-object {$_.canpauseandcontinue -eq "True"} | suspend-service -confirm
```

This command suspends all of the services on the computer that can be suspended.
It uses the Get-Service cmdlet to get objects representing the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects only the services that have a value of "True" for the CanPauseAndContinue property.
Another pipeline operator passes the results to the Suspend-Service cmdlet.
The Confirm parameter prompts you for confirmation before suspending each of the services.
## PARAMETERS

### -DisplayName
Specifies the display names of the services to be suspended.
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

### -Include
Suspends only the specified services.
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
Specifies ServiceController objects representing the services to be suspended.
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
Specifies the service names of the services to be suspended.
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
You can pipe a service object or a string that contains a service name to Suspend-Service.
## OUTPUTS

### None or System.ServiceProcess.ServiceController
When you use the PassThru parameter, Suspend-Service generates a System.ServiceProcess.ServiceController object representing the service.
Otherwise, this cmdlet does not generate any output.
## NOTES
* Suspend-Service can control services only when the current user has permission to do so. If a command does not work correctly, you might not have the required permissions.

  Also, Suspend-Service can suspend only services that support being suspended and resumed.
To determine whether a particular service can be suspended, use the Get-Service cmdlet with the CanPauseAndContinue property.
For example, "get-service wmi | format-list name, canpauseandcontinue".
To find all services on the computer that can be suspended, type "get-service | where-object {$_.canpauseandcontinue -eq "True"}".

  To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column, and the display names appear in the DisplayName column.

*
## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)
