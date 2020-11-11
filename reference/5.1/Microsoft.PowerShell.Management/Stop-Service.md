---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/stop-service?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Stop-Service
---
# Stop-Service

## SYNOPSIS
Stops one or more running services.

## SYNTAX

### InputObject (Default)

```
Stop-Service [-Force] [-NoWait] [-InputObject] <ServiceController[]> [-PassThru] [-Include <String[]>]
 [-Exclude <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default

```
Stop-Service [-Force] [-NoWait] [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DisplayName

```
Stop-Service [-Force] [-NoWait] [-PassThru] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Stop-Service` cmdlet sends a stop message to the Windows Service Controller for each of the
specified services. You can specify the services by their service names or display names, or you can
use the **InputObject** parameter to pass a service object that represents the service that you want
to stop.

## EXAMPLES

### Example 1: Stop a service on the local computer

```
PS C:\> Stop-Service -Name "sysmonlog"
```

This command stops the Performance Logs and Alerts (SysmonLog) service on the local computer.

### Example 2: Stop a service by using the display name

```
PS C:\> Get-Service -DisplayName "telnet" | Stop-Service
```

This command stops the Telnet service on the local computer. The command uses `Get-Service` to get
an object that represents the Telnet service. The pipeline operator (`|`) pipes the object to
`Stop-Service`, which stops the service.

### Example 3: Stop a service that has dependent services

```
PS C:\> Get-Service -Name "iisadmin" | Format-List -Property Name, DependentServices
PS C:\> Stop-Service -Name "iisadmin" -Force -Confirm
```

This example stops the IISAdmin service on the local computer. Because stopping this service also
stops the services that depend on the IISAdmin service, it is best to precede `Stop-Service` with a
command that lists the services that depend on the IISAdmin service.

The first command lists the services that depend on IISAdmin. It uses `Get-Service` to get an object
that represents the IISAdmin service. The pipeline operator (`|`) passes the result to the
`Format-List` cmdlet. The command uses the **Property** parameter of `Format-List` to list only the
**Name** and **DependentServices** properties of the service.

The second command stops the IISAdmin service. The **Force** parameter is required to stop a service
that has dependent services. The command uses the **Confirm** parameter to request confirmation from
the user before it stops each service.

## PARAMETERS

### -DisplayName

Specifies the display names of the services to stop.
Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: DisplayName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Exclude

Specifies services that this cmdlet omits. The value of this parameter qualifies the **Name**
parameter. Enter a name element or pattern, such as s*. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Force

Forces the cmdlet to stop a service even if that service has dependent services.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include

Specifies services that this cmdlet stops. The value of this parameter qualifies the **Name**
parameter. Enter a name element or pattern, such as s*. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -InputObject

Specifies **ServiceController** objects that represent the services to stop. Enter a variable that
contains the objects, or type a command or expression that gets the objects.

```yaml
Type: System.ServiceProcess.ServiceController[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the service names of the services to stop. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Default
Aliases: ServiceName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -NoWait

Indicates that this cmdlet uses the no wait option.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns an object that represents the service. By default, this cmdlet does not generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.ServiceProcess.ServiceController, System.String

You can pipe a service object or a string that contains the name of a service to this cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController

This cmdlet generates a **System.ServiceProcess.ServiceController** object that represents the
service, if you use the **PassThru** parameter. Otherwise, this cmdlet does not generate any output.

## NOTES

You can also refer to `Stop-Service` by its built-in alias, **spsv**. For more information, see
about_Aliases.

`Stop-Service` can control services only when the current user has permission to do this. If a
command does not work correctly, you might not have the required permissions.

To find the service names and display names of the services on your system, type `Get-Service`. The
service names appear in the **Name** column and the display names appear in the **DisplayName**
column.

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Suspend-Service](Suspend-Service.md)
