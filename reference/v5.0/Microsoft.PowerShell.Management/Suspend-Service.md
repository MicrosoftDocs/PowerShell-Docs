---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293924
schema: 2.0.0
---

# Suspend-Service
## SYNOPSIS
Suspends (pauses) one or more running services.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Suspend-Service [-InputObject] <ServiceController[]> [-Exclude <String[]>] [-Include <String[]>] [-PassThru]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Suspend-Service [-Exclude <String[]>] [-Include <String[]>] [-PassThru] -DisplayName <String[]> [-Confirm]
 [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Suspend-Service [-Name] <String[]> [-Exclude <String[]>] [-Include <String[]>] [-PassThru] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Suspend-Service cmdlet sends a suspend message to the Windows Service Controller for each of the specified services.
While suspended, the service is still running, but its action is stopped until resumed, such as by usingthe Resume-Service cmdlet.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object that represents the services that you want to suspend.

## EXAMPLES

### Example 1: Suspend a service
```
PS C:\>Suspend-Service -DisplayName "Telnet"
```

This command suspends the Telnet service (Tlntsvr) service on the local computer.

### Example 2: Display what would happen if you suspend services
```
PS C:\>Suspend-Service -Name lanman* -WhatIf
```

This command tells what would happen if you suspended the services that have a service name that starts with lanman.
To suspend the services, rerun the command without the WhatIf parameter.

### Example 3: Get and suspend a service
```
PS C:\>Get-Service schedule | Suspend-Service
```

This command uses the Get-Service cmdlet to get an object that represents the Task Scheduler (Schedule) service on the computer.
The pipeline operator (|) passes the result to Suspend-Service, which suspends the service.

### Example 4: Suspend all services that can be suspended
```
PS C:\>Get-Service | Where-Object {$_.CanPauseAndContinue -eq "True"} | Suspend-Service -Confirm
```

This command suspends all of the services on the computer that can be suspended.
It uses Get-Service to get objects that represent the services on the computer.
The pipeline operator passes the results to the Where-Object cmdlet, which selects only the services that have a value of $True for the CanPauseAndContinue property.
Another pipeline operator passes the results to Suspend-Service.
The Confirm parameter prompts you for confirmation before suspending each of the services.

## PARAMETERS

### -DisplayName
Specifies the display names of the services to be suspended.
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
Specifies services to omit from the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
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

### -Include
Specifies services to suspend.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
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
Specifies ServiceController objects that represent the services to suspend.
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
Specifies the service names of the services to suspend.
Wildcard characters are permitted.

The parameter name is optional.
You can use Name or its alias, ServiceName, or you can omit the parameter name.

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

### -PassThru
Returns an object representing the item with which you are working.
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
You can pipe a service object or a string that contains a service name to this cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController
This cmdlet generates a System.ServiceProcess.ServiceController object that represents the service, if you specify the PassThru parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* Suspend-Service can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
* Suspend-Service can suspend only services that support being suspended and resumed. To determine whether a particular service can be suspended, use the Get-Service cmdlet together with the CanPauseAndContinue property. For example, Get-Service wmi | Format-List Name, CanPauseAndContinue. To find all services on the computer that can be suspended, type Get-Service | Where-Object {$_.CanPauseAndContinue -eq "True"}.
* To find the service names and display names of the services on your system, type Get-Service. The service names appear in the Name column, and the display names appear in the DisplayName column.

## RELATED LINKS

[Get-Service](77f3c94b-6ffd-4906-8216-3debbf5ffe79)

[New-Service](ad24021a-4603-4c9c-bd20-8f9bdde123fa)

[Restart-Service](9fa33bc1-264e-40aa-8731-607ca99cc805)

[Resume-Service](84ac7b53-a313-4617-b983-097c33792a6b)

[Set-Service](d4a1bd34-7122-4c01-83b0-ec4ca78371d7)

[Start-Service](a3abab52-805c-4054-a41a-82cd81dc7fd3)

[Stop-Service](58033475-759b-42e4-9395-c077aa55934e)

