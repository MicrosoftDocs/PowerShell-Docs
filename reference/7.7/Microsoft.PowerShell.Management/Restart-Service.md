---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 11/10/2026
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/restart-service?view=powershell-7.7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Restart-Service
---

# Restart-Service

## SYNOPSIS
Stops and then starts one or more services.

## SYNTAX

### InputObject (Default)

```
Restart-Service [-Force] [-InputObject] <ServiceController[]> [-PassThru]
 [-Include <String[]>] [-Exclude <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default

```
Restart-Service [-Force] [-Name] <String[]> [-PassThru] [-Include <String[]>]
 [-Exclude <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DisplayName

```
Restart-Service [-Force] [-PassThru] -DisplayName <String[]> [-Include <String[]>]
 [-Exclude <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

On Windows, the `Restart-Service` cmdlet sends a stop message and then a start message to the
Windows Service Controller for a specified service. If a service was already stopped, it is started
without notifying you of an error. You can specify the services by their service names or display
names, or you can use the **InputObject** parameter to pass an object that represents each service
that you want to restart.

Beginning in PowerShell 7.7, this cmdlet is also available on Linux and macOS. On Unix platforms
the cmdlet restarts services through the system service manager, which it discovers in this order:
`systemctl` (systemd), `launchctl` (macOS), `service` (sysvinit), and `rc-service` (OpenRC).
Restarting a service requires root privileges; when not running as root, the cmdlet wraps the
service manager command with `sudo -n`. For more information, see the [Notes](#notes) section.

## EXAMPLES

### Example 1: Restart a service on the local computer

```powershell
Restart-Service -Name winmgmt
```

This command restarts the Windows Management Instrumentation service (WinMgmt) on the local
computer.

On Unix platforms, this command restarts a service by its unit name, for example
`Restart-Service -Name sshd`.

### Example 2: Exclude a service

```powershell
Restart-Service -DisplayName "net*" -Exclude "net logon"
```

This command restarts the services that have a display name that starts with Net, except for the Net
Logon service.

### Example 3: Start all stopped network services

```powershell
Get-Service -Name "net*" | Where-Object {$_.Status -eq "Stopped"} | Restart-Service
```

This command starts all of the stopped network services on the computer.

This command uses the `Get-Service` cmdlet to get objects that represent the services whose service
name starts with net. The pipeline operator (`|`) sends the services object to the `Where-Object`
cmdlet, which selects only the services that have a status of stopped. Another pipeline operator
sends the selected services to `Restart-Service`.

In practice, you would use the **WhatIf** parameter to determine the effect of the command before
you run it.

## PARAMETERS

### -DisplayName

Specifies the display names of the services to restarted. Wildcard characters are permitted.

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

On Windows platforms, forces the command to run without asking for user confirmation.

On Unix platforms, the parameter is accepted for script compatibility but has no effect; the system
service manager handles service ordering and dependencies itself.

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

Specifies services that this cmdlet restarts. The value of this parameter qualifies the **Name**
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

Specifies **ServiceController** objects that represent the services to restart. Enter a variable
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

Specifies the service names of the services to restart.

On Unix platforms, service names can be specified with or without the systemd unit suffix
`.service`.

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

### System.ServiceProcess.ServiceController

You can pipe a service object to this cmdlet.

### System.String

You can pipe a string that contains a service name to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.ServiceProcess.ServiceController

On Windows platforms, when you use the **PassThru** parameter, this cmdlet returns a
**ServiceController** object representing the restarted service.

### Microsoft.PowerShell.Commands.UnixServiceController

On Unix platforms, when you use the **PassThru** parameter, this cmdlet returns a
**UnixServiceController** object representing the restarted service.

## NOTES

On Windows platforms, `Restart-Service` can control services only when the current user has
permission to do this. If a command does not work correctly, you might not have the required
permissions.

To find the service names and display names of the services on your system, type `Get-Service`".
The service names appear in the **Name** column, and the display names appear in the
**DisplayName** column.

Beginning in PowerShell 6.0, the command no longer includes the **ComputerName** parameter. To use
this command on a remote computer, use the `Invoke-Command` to target a remote system.

Unix platform support, beginning in PowerShell 7.7:

- On systemd, `Restart-Service` stops and then starts the unit (`systemctl stop <unit>` followed by
  `systemctl start <unit>`).
- On macOS, the cmdlet stops the job (`launchctl kill SIGTERM <domain>/<label>`) and then starts it
  again (`launchctl kickstart <domain>/<label>`).
- On sysvinit and OpenRC, the cmdlet runs the service script or `rc-service` with the `stop` action
  and then the `start` action.
- Restarting a service requires root privileges on Unix. When not running as root, the service
  management cmdlets (`Start-Service`, `Stop-Service`, and `Restart-Service`) wrap the service
  manager command with `sudo -n`. If sudo would require a password, the cmdlet writes a
  non-terminating error explaining how to proceed: run PowerShell as root (`sudo pwsh`) or
  configure passwordless sudo for the service manager command.
- The **Force** parameter is accepted for script compatibility but has no effect on Unix; the
  system service manager handles service ordering and dependencies itself.

## RELATED LINKS

[Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)

[Remove-Service](Remove-Service.md)
