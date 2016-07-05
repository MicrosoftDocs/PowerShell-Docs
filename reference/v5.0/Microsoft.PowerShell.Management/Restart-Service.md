---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293906
schema: 2.0.0
---

# Restart-Service
## SYNOPSIS
Stops and then starts one or more services.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Restart-Service [-InputObject] <ServiceController[]> [-Exclude <String[]>] [-Force] [-Include <String[]>]
 [-PassThru] [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Restart-Service [-Exclude <String[]>] [-Force] [-Include <String[]>] [-PassThru] -DisplayName <String[]>
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Restart-Service [-Name] <String[]> [-Exclude <String[]>] [-Force] [-Include <String[]>] [-PassThru] [-Confirm]
 [-WhatIf]
```

## DESCRIPTION
The Restart-Service cmdlet sends a stop message and then a start message to the Windows Service Controller for a specified service.
If a service was already stopped, it is started without notifying you of an error.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass an object that represents each service that you want to restart.

## EXAMPLES

### Example 1: Restart a service on the local computer
```
PS C:\>Restart-Service -Name winmgmt
```

This command restarts the Windows Management Instrumentation service (WinMgmt) on the local computer.

### Example 2: Exclude a service
```
PS C:\>Restart-Service -DisplayName "net*" -Exclude "net logon"
```

This command restarts the services that have a display name that starts with Net, except for the Net Logon service.

### Example 3: Start all stopped network services
```
PS C:\>Get-Service -Name "net*" | Where-Object {$_.Status -eq "Stopped"} | Restart-Service
```

This command starts all of the stopped network services on the computer.

This command uses the Get-Service cmdlet to get objects that represent the services whose service name starts with net.
The pipeline operator (|) sends the services object to the Where-Object cmdlet, which selects only the services that have a status of stopped.
Another pipeline operator sends the selected services to Restart-Service.

In practice, you would use the WhatIf parameter to determine the effect of the command before you run it.

## PARAMETERS

### -DisplayName
Specifies the display names of services to restarted.
Wildcard carachters are permitted.

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
Restarts a service that has dependent services.

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
Specifies services that this cmdlet restarts.
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
Specifies ServiceController objects that represent the services to restart.
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
Specifies the service names of the services to restart.

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
You can pipe a service object or a string that contains a service name to this cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController
This cmdlet generates a System.ServiceProcess.ServiceController object that represents the restarted service, if you specify the PassThru parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* Restart-Service can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
* To find the service names and display names of the services on your system, type Get-Service". The service names appear in the Name column, and the display names appear in the DisplayName column.

## RELATED LINKS

[Get-Service](77f3c94b-6ffd-4906-8216-3debbf5ffe79)

[New-Service](ad24021a-4603-4c9c-bd20-8f9bdde123fa)

[Resume-Service](84ac7b53-a313-4617-b983-097c33792a6b)

[Set-Service](d4a1bd34-7122-4c01-83b0-ec4ca78371d7)

[Start-Service](a3abab52-805c-4054-a41a-82cd81dc7fd3)

[Stop-Service](58033475-759b-42e4-9395-c077aa55934e)

[Suspend-Service](5b8bd69a-0a18-4478-b257-d442ddef417c)

[Where-Object](6a70160b-cf62-48df-ae5b-0a9b173013b4)

