---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/suspend-service?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Suspend-Service
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

The `Suspend-Service` cmdlet sends a suspend message to the Windows Service Controller for each of
the specified services. While suspended, the service is still running, but its action is stopped
until resumed, such as by usingthe `Resume-Service` cmdlet. You can specify the services by their
service names or display names, or you can use the **InputObject** parameter to pass a service
object that represents the services that you want to suspend.

## EXAMPLES

### Example 1: Suspend a service

```
PS C:\> Suspend-Service -DisplayName "Telnet"
```

This command suspends the Telnet service (Tlntsvr) service on the local computer.

### Example 2: Display what would happen if you suspend services

```
PS C:\> Suspend-Service -Name lanman* -WhatIf
```

This command tells what would happen if you suspended the services that have a service name that
starts with lanman. To suspend the services, rerun the command without the **WhatIf** parameter.

### Example 3: Get and suspend a service

```
PS C:\> Get-Service schedule | Suspend-Service
```

This command uses the `Get-Service` cmdlet to get an object that represents the Task Scheduler
(Schedule) service on the computer. The pipeline operator (`|`) passes the result to
`Suspend-Service`, which suspends the service.

### Example 4: Suspend all services that can be suspended

```
PS C:\> Get-Service | Where-Object {$_.CanPauseAndContinue -eq "True"} | Suspend-Service -Confirm
```

This command suspends all of the services on the computer that can be suspended. It uses
`Get-Service` to get objects that represent the services on the computer. The pipeline operator
passes the results to the `Where-Object` cmdlet, which selects only the services that have a value
of `$True` for the **CanPauseAndContinue** property. Another pipeline operator passes the results to
`Suspend-Service`. The **Confirm** parameter prompts you for confirmation before suspending each of
the services.

## PARAMETERS

### -DisplayName

Specifies the display names of the services to be suspended. Wildcard characters are permitted.

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

Specifies services to omit from the specified services. The value of this parameter qualifies the
**Name** parameter. Enter a name element or pattern, such as "s*". Wildcard characters are
permitted.

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

### -Include

Specifies services to suspend. The value of this parameter qualifies the **Name** parameter. Enter a
name element or pattern, such as "s*". Wildcard characters are permitted.

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

Specifies **ServiceController** objects that represent the services to suspend. Enter a variable
that contains the objects, or type a command or expression that gets the objects.

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

Specifies the service names of the services to suspend. Wildcard characters are permitted.

The parameter name is optional. You can use **Name** or its alias, **ServiceName**, or you can omit
the parameter name.

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

### -PassThru

Returns an object representing the item with which you are working. By default, this cmdlet does not
generate any output.

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

You can pipe a service object or a string that contains a service name to this cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController

This cmdlet generates a **System.ServiceProcess.ServiceController** object that represents the
service, if you specify the **PassThru** parameter. Otherwise, this cmdlet does not generate any
output.

## NOTES

- `Suspend-Service` can control services only when the current user has permission to do this. If a
  command does not work correctly, you might not have the required permissions.
- `Suspend-Service` can suspend only services that support being suspended and resumed. To determine
  whether a particular service can be suspended, use the `Get-Service` cmdlet together with the
  **CanPauseAndContinue** property. For example,
  `Get-Service wmi | Format-List Name, CanPauseAndContinue`. To find all services on the computer
  that can be suspended, type `Get-Service | Where-Object {$_.CanPauseAndContinue -eq $true}`.
- To find the service names and display names of the services on your system, type `Get-Service`.
  The service names appear in the **Name** column, and the display names appear in the
  **DisplayName** column.

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)
