---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293906
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Restart-Service
---

# Restart-Service

## SYNOPSIS
Stops and then starts one or more services.

## SYNTAX

### InputObject (Default)
```
Restart-Service [-InputObject] <ServiceController[]>
 [-Force] [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default
```
Restart-Service [-Name] <String[]>
 [-Force] [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DisplayName
```
Restart-Service -DisplayName <String[]>
 [-Force] [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Restart-Service cmdlet sends a stop message and then a start message to the Windows Service Controller for a specified service.
If a service was already stopped, it is started without notifying you of an error.
You can specify the services by their service names or display names, or you can use the InputObject parameter to pass an object that represents each service that you want to restart.

## EXAMPLES

### Example 1

```powershell
PS C:\> Restart-Service winmgmt
```

This command restarts the Windows Management Instrumentation service (WinMgmt) on the local computer.

### Example 2

```powershell
PS C:\> Restart-Service -DisplayName net* -Exclude "net logon"
```

This command restarts the services that have a display name that begins with "Net", except for the "Net Logon" service.

### Example 3

```powershell
PS C:\> Get-Service net* | Where-Object {$_.Status -eq "Stopped"} | Restart-Service
```

This command starts all of the stopped network services on the computer.

It uses the Get-Service cmdlet to get objects representing the services whose service name begins with "net".
(The optional Name parameter name is omitted.) The pipeline operator (|) sends the services object to the Where-Object cmdlet, which selects only the services with a status of "stopped." Another pipeline operator sends the selected services to Restart-Service.
In practice, you would use the WhatIf parameter to see the effect of the command before using it.

## PARAMETERS

### -DisplayName
Specifies the display names of services to be restarted.
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
Restarts a service that has dependent services.

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
Restarts only the specified services.
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
Specifies ServiceController objects that represent the services to be restarted.
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
Specifies the service names of the services to be restarted.

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ServiceName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.ServiceProcess.ServiceController, System.String
You can pipe a service object or a string that contains a service name to Restart-Service.

## OUTPUTS

### None or System.ServiceProcess.ServiceController
When you use the PassThru parameter, Restart-Service generates a System.ServiceProcess.ServiceController object that represents the restarted service.
Otherwise, this cmdlet does not generate any output.

## NOTES
* Restart-Service can control services only when the current user has permission to do so. If a command does not work correctly, you might not have the required permissions.

  To find the service names and display names of the services on your system, type "get-service".
The service names appears in the Name column, and the display names appear in the DisplayName column.

*

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)