---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Resume Service
ms.technology:  powershell
external help file:  PSITPro3_Management.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113386
schema:  2.0.0
---


# Resume-Service
## SYNOPSIS
Resumes one or more suspended (paused) services.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Resume-Service [-InputObject] <ServiceController[]> [-Exclude <String[]>] [-Include <String[]>] [-PassThru]
```

### UNNAMED_PARAMETER_SET_2
```
Resume-Service [-Exclude <String[]>] [-Include <String[]>] [-PassThru] -DisplayName <String[]>
```

### UNNAMED_PARAMETER_SET_3
```
Resume-Service [-Name] <String[]> [-Exclude <String[]>] [-Include <String[]>] [-PassThru]
```

## DESCRIPTION
The Resume-Service cmdlet sends a resume message to the Windows Service Controller for each of the specified services.
If they have been suspended, they will resume service.
If they are currently running, the message is ignored.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass a service object that represents the services that you want to resume.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>resume-service sens
```

This command resumes the System Event Notification service (the service name is represented in the command by "sens") on the local computer.
The command uses the Name parameter to specify the service name of the service, but the command omits the parameter name because the parameter name is optional.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-service | where-object {$_.Status -eq "Paused"} | resume-service
```

This command resumes all of the suspended (paused) services on the computer.
The first command gets all of the services on the computer.
The pipeline operator (|) passes the results to the Where-Object cmdlet, which selects the services with a Status property of "Paused".
The next pipeline operator sends the results to Resume-Service, which resumes the paused services.

In practice, you would use the WhatIf parameter to determine the effect of the command before running it without WhatIf.

## PARAMETERS

### -DisplayName
Specifies the display names of the services to be resumed.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: 
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
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include
Resumes only the specified services.
The value of this parameter qualifies the Name parameter.
Enter a name element or pattern, such as "s*".
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -InputObject
Specifies ServiceController objects representing the services to be resumed.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: ServiceController[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service names of the services to be resumed.

The parameter name is optional.
You can use "-Name" or its alias, "-ServiceName", or you can omit the parameter name.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: 
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.ServiceProcess.ServiceController or System.String
You can pipe a service object or a string that contains a service name to Resume-Service.

## OUTPUTS

### None or System.ServiceProcess.ServiceController
When you use the PassThru parameter, Resume-Service generates a System.ServiceProcess.ServiceController object representing the resumed service.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The status of services that have been suspended is "Paused". When services are resumed, their status is "Running".

  Resume-Service can control services only when the current user has permission to do so.
If a command does not work correctly, you might not have the required permissions.

  To find the service names and display names of the services on your system, type "get-service".
The service names appear in the Name column, and the display names appear in the DisplayName column.

*

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)

