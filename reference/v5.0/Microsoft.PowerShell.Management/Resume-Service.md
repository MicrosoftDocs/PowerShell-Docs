---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293908
schema: 2.0.0
---

# Resume-Service
## SYNOPSIS
Resumes one or more suspended (paused) services.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Resume-Service [-InputObject] <ServiceController[]> [-Exclude <String[]>] [-Include <String[]>] [-PassThru]
 [-Confirm] [-WhatIf]
```

### UNNAMED_PARAMETER_SET_2
```
Resume-Service [-Exclude <String[]>] [-Include <String[]>] [-PassThru] -DisplayName <String[]> [-Confirm]
 [-WhatIf]
```

### UNNAMED_PARAMETER_SET_3
```
Resume-Service [-Name] <String[]> [-Exclude <String[]>] [-Include <String[]>] [-PassThru] [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Resume-Service cmdlet sends a resume message to the Windows Service Controller for each of the specified services.
If a service is suspended, it resumes.
If it is currently running, the message is ignored.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object that represents the services that you want to resume.

## EXAMPLES

### Example 1: Resume a service on the local computer
```
PS C:\>Resume-Service "sens"
```

This command resumes the System Event Notification service  on the local computer.
The service name is represented in the command by sens.
The command uses the Name parameter to specify the service name of the service, but the command omits the parameter name because the parameter name is optional.

### Example 2: Resume all suspended services
```
PS C:\>Get-Service | Where-Object {$_.Status -eq "Paused"} | Resume-Service
```

This command resumes all of the suspended  services on the computer.
The Get-Service cmdlet command gets all of the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects the services that have a Status property of Paused.
The next pipeline operator sends the results to Resume-Service, which resumes the paused services.

In practice, you would use the WhatIf parameter to determine the effect of the command before you run it.

## PARAMETERS

### -DisplayName
Specifies the display names of the services to be resumed.
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

### -Include
Specifies services to resume.
The value of this parameter qualifies Name parameter.
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
Specifies ServiceController objects that represent the services to resumed.
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
Specifies the service names of the services to be resumed.

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
This cmdlet generates a System.ServiceProcess.ServiceController object that represents the resumed service, if you specify the PassThru parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The status of services that have been suspended is Paused. When services are resumed, their status is Running.
* Resume-Service can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
* To find the service names and display names of the services on your system, type Get-Service. The service names appear in the Name column, and the display names appear in the DisplayName column.

## RELATED LINKS

[Get-Service](77f3c94b-6ffd-4906-8216-3debbf5ffe79)

[New-Service](ad24021a-4603-4c9c-bd20-8f9bdde123fa)

[Restart-Service](9fa33bc1-264e-40aa-8731-607ca99cc805)

[Set-Service](d4a1bd34-7122-4c01-83b0-ec4ca78371d7)

[Start-Service](a3abab52-805c-4054-a41a-82cd81dc7fd3)

[Stop-Service](58033475-759b-42e4-9395-c077aa55934e)

[Suspend-Service](5b8bd69a-0a18-4478-b257-d442ddef417c)

[Where-Object](6a70160b-cf62-48df-ae5b-0a9b173013b4)

