---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/start-service?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Start-Service
---
# Start-Service

## SYNOPSIS
Starts one or more stopped services.

## SYNTAX

### InputObject (Default)

```
Start-Service [-InputObject] <ServiceController[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Default

```
Start-Service [-Name] <String[]> [-PassThru] [-Include <String[]>] [-Exclude <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DisplayName

```
Start-Service [-PassThru] -DisplayName <String[]> [-Include <String[]>] [-Exclude <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Start-Service` cmdlet sends a start message to the Windows Service Controller for each of the
specified services. If a service is already running, the message is ignored without error. You can
specify the services by their service names or display names, or you can use the **InputObject**
parameter to supply a service object that represents the services that you want to start.

## EXAMPLES

### Example 1: Start a service by using its name

This example starts the EventLog service on the local computer. The **Name** parameter identifies
the service by its service name.

```powershell
Start-Service -Name "eventlog"
```

### Example 2: Display information without starting a service

This example shows what would occur if you started the services that have a display name that
includes "remote".

```powershell
Start-Service -DisplayName *remote* -WhatIf
```

The **DisplayName** parameter identifies the services by their display name instead of their service
name. The **WhatIf** parameter causes the cmdlet to display what would happen when you run the
command but does not make changes.

### Example 3: Start a service and record the action in a text file

This example starts the Windows Management Instrumentation (WMI) service on the computer and adds a
record of the action to the services.txt file.

```powershell
$s = Get-Service wmi
Start-Service -InputObject $s -PassThru | Format-List >> services.txt
```

First we use `Get-Service` to get an object that represent the WMI service and store it in the `$s`
variable. Next, we start the service. Without the **PassThru** parameter, `Start-Service` does not
create any output. The pipeline operator (|) passes the object output by `Start-Service` to the
`Format-List` cmdlet to format the object as a list of its properties. The append redirection
operator (\>\>) redirects the output to the services.txt file. The output is added to the end of the
existing file.

### Example 4: Start a disabled service

This example shows how to start a service when the start type of the service is **Disabled**.

```
PS> Start-Service tlntsvr
Start-Service : Service 'Telnet (TlntSvr)' cannot be started due to the following error: Cannot start service TlntSvr on computer '.'.
At line:1 char:14
+ Start-Service  <<<< tlntsvr

PS> Get-CimInstance win32_service | Where-Object Name -eq "tlntsvr"
ExitCode  : 0
Name      : TlntSvr
ProcessId : 0
StartMode : Disabled
State     : Stopped
Status    : OK

PS> Set-Service tlntsvr -StartupType manual
PS> Start-Service tlntsvr
```

The first attempt to start the Telnet service (tlntsvr) fails. The `Get-CimInstance` command shows
that the **StartMode** property of the Tlntsvr service is **Disabled**. The `Set-Service` cmdlet
changes the start type to **Manual**. Now, we can resubmit the `Start-Service` command. This time,
the command succeeds. To verify that the command succeeded, run `Get-Service`.

## PARAMETERS

### -DisplayName

Specifies the display names of the services to start. Wildcard characters are permitted.

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
parameter. Enter a name element or pattern, such as `s*`. Wildcard characters are permitted.

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

Specifies services that this cmdlet starts. The value of this parameter qualifies the **Name**
parameter. Enter a name element or pattern, such as `s*`. Wildcard characters are permitted.

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

Specifies **ServiceController** objects representing the services to be started. Enter a variable
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

Specifies the service names for the service to be started.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.ServiceProcess.ServiceController, System.String

You can pipe objects that represent the services or strings that contain the service names to this
cmdlet.

## OUTPUTS

### None, System.ServiceProcess.ServiceController

This cmdlet generates a **System.ServiceProcess.ServiceController** object that represents the
service, if you specify **PassThru**. Otherwise, this cmdlet does not generate any output.

## NOTES

This cmdlet is only available on Windows platforms.

- You can also refer to `Start-Service` by its built-in alias, `sasv`. For more information, see
  [about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).
- `Start-Service` can control services only if the current user has permission to do this. If a
  command does not work correctly, you might not have the required permissions.
- To find the service names and display names of the services on your system, type `Get-Service`.
  The service names appear in the **Name** column, and the display names appear in the
  **DisplayName** column.
- You can start only the services that have a start type of Manual, Automatic, or Automatic (Delayed
  Start). You cannot start the services that have a start type of Disabled. If a `Start-Service`
  command fails with the message `Cannot start service \<service-name\> on computer`, use
  `Get-CimInstance` to find the start type of the service and, if you have to, use the `Set-Service`
  cmdlet to change the start type of the service.
- Some services, such as Performance Logs and Alerts (SysmonLog) stop automatically if they have no
  work to do. When PowerShell starts a service that stops itself almost immediately, it displays the
  following message: `Service \<display-name\> start failed.`

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)

[Remove-Service](Remove-Service.md)
