---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821628
schema: 2.0.0
title: Resume-Service
---

# Resume-Service

## SYNOPSIS
Resumes one or more suspended (paused) services.

## SYNTAX

### InputObject (Default)
```
Resume-Service [-InputObject] <ServiceController[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default
```
Resume-Service [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DisplayName
```
Resume-Service [-PassThru] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Resume-Service** cmdlet sends a resume message to the Windows Service Controller for each of the specified services.
If a service is suspended, it resumes.
If it is currently running, the message is ignored.
You can specify the services by their service names or display names, or you can use the *InputObject* parameter to pass a service object that represents the services that you want to resume.

## EXAMPLES

### Example 1: Resume a service on the local computer
```
PS C:\> Resume-Service "sens"
```

This command resumes the System Event Notification service  on the local computer.
The service name is represented in the command by sens.
The command uses the *Name* parameter to specify the service name of the service, but the command omits the parameter name because the parameter name is optional.

### Example 2: Resume all suspended services
```
PS C:\> Get-Service | Where-Object {$_.Status -eq "Paused"} | Resume-Service
```

This command resumes all of the suspended  services on the computer.
The Get-Service cmdlet command gets all of the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects the services that have a **Status** property of Paused.
The next pipeline operator sends the results to **Resume-Service**, which resumes the paused services.

In practice, you would use the *WhatIf* parameter to determine the effect of the command before you run it.

## PARAMETERS

### -DisplayName
Specifies the display names of the services to be resumed.
Wildcard characters are permitted.

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
Specifies services that this cmdlet omits.
The value of this parameter qualifies the *Name* parameter.
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
The value of this parameter qualifies *Name* parameter.
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
Specifies **ServiceController** objects that represent the services to resumed.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: ServiceController[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service names of the services to be resumed.

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ServiceName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
You can pipe a service object or a string that contains a service name to this cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController
This cmdlet generates a **System.ServiceProcess.ServiceController** object that represents the resumed service, if you specify the *PassThru* parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The status of services that have been suspended is Paused. When services are resumed, their status is Running.
* **Resume-Service** can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
* To find the service names and display names of the services on your system, type `Get-Service`. The service names appear in the **Name** column, and the display names appear in the **DisplayName** column.

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)