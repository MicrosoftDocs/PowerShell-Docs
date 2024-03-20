---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 03/20/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/set-service?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Service
---

# Set-Service

## SYNOPSIS
Starts, stops, and suspends a service, and changes its properties.

## SYNTAX

### Name (Default)

```
Set-Service [-ComputerName <String[]>] [-Name] <String> [-DisplayName <String>]
 [-Description <String>] [-StartupType <ServiceStartMode>] [-Status <String>] [-PassThru] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### InputObject

```
Set-Service [-ComputerName <String[]>] [-DisplayName <String>] [-Description <String>]
 [-StartupType <ServiceStartMode>] [-Status <String>] [-InputObject <ServiceController>] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Service` cmdlet changes the properties of a service such as the **Status**,
**Description**, **DisplayName**, and **StartupType**. `Set-Service` can start, stop, suspend, or
pause a service. To identify a service, enter its service name or submit a service object. Or, send
a service name or service object down the pipeline to `Set-Service`.

## EXAMPLES

### Example 1: Change a display name

In this example, a service's display name is changed. To view the original display name, use
`Get-Service`.

```powershell
Set-Service -Name LanmanWorkstation -DisplayName "LanMan Workstation"
```

`Set-Service` uses the **Name** parameter to specify the service's name, **LanmanWorkstation**. The
**DisplayName** parameter specifies the new display name, **LanMan Workstation**.

### Example 2: Change the startup type of services

This example shows how to change a service's startup type.

```powershell
Set-Service -Name BITS -StartupType Automatic
Get-Service BITS | Select-Object -Property Name, StartType, Status
```

```Output
Name  StartType   Status
----  ---------   ------
BITS  Automatic  Running
```

`Set-Service` uses the **Name** parameter to specify the service's name, **BITS**. The
**StartupType** parameter sets the service to **Automatic**.

`Get-Service` uses the **Name** parameter to specify the **BITS** service and sends the object down
the pipeline. `Select-Object` uses the **Property** parameter to display the **BITS** service's
status.

### Example 3: Change the description of a service

This example changes the BITS service's description and displays the result.

The `Get-CimInstance` cmdlet is used because it returns a **Win32_Service** object that includes the
service's **Description**.

```powershell
Get-CimInstance Win32_Service -Filter 'Name = "BITS"'  | Format-List  Name, Description
```

```Output
Name        : BITS
Description : Transfers files in the background using idle network bandwidth. If the service is
              disabled, then any applications that depend on BITS, such as Windows Update or MSN
              Explorer, will be unable to automatically download programs and other information.
```

```powershell
Set-Service -Name BITS -Description "Transfers files in the background using idle network bandwidth."
Get-CimInstance Win32_Service -Filter 'Name = "BITS"' | Format-List  Name, Description
```

```Output
Name        : BITS
Description : Transfers files in the background using idle network bandwidth.
```

`Get-CimInstance` sends the object down the pipeline to `Format-List` and displays the service's
name and description. For comparison purposes, the command is run before and after the description
is updated.

`Set-Service` uses the **Name** parameter to specify the **BITS** service. The **Description**
parameter specifies the updated text for the services' description.

### Example 4: Start a service

In this example, a service is started.

```powershell
Set-Service -Name WinRM -Status Running -PassThru
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  WinRM              Windows Remote Management (WS-Manag...
```

`Set-Service` uses the **Name** parameter to specify the service, **WinRM**. The **Status**
parameter uses the value **Running** to start the service. The **PassThru** parameter outputs a
**ServiceController** object that displays the results.

### Example 5: Suspend a service

This example uses the pipeline to pause to service.

```powershell
Get-Service -Name Schedule | Set-Service -Status Paused
```

`Get-Service` uses the **Name** parameter to specify the **Schedule** service, and sends the object
down the pipeline. `Set-Service` uses the **Status** parameter to set the service to **Paused**.

### Example 6: Stop a service

This example uses a variable to stop a service.

```powershell
$S = Get-Service -Name Schedule
Set-Service -InputObject $S -Status Stopped
```

`Get-Service` uses the **Name** parameter to specify the service, **Schedule**. The object is stored
in the variable, `$S`. `Set-Service` uses the **InputObject** parameter and specifies the object
stored `$S`. The **Status** parameter sets the service to **Stopped**.

### Example 7: Set the startup type for multiple services

The `Set-Service` cmdlet only accepts one service name at a time. However, you can pipe multiple
services to `Set-Service` to change the configuration of multiple services.

```powershell
Get-Service SQLWriter,spooler |
    Set-Service -StartupType Automatic -PassThru |
    Select-Object Name, StartType
```

```Output
Name      StartType
----      ---------
spooler   Automatic
SQLWriter Automatic
```
## PARAMETERS

### -ComputerName

Specifies one or more computers. For remote computers, type the NetBIOS name, an IP address, or a
fully qualified domain name. If the **ComputerName** parameter isn't specified, the command runs on
the local computer.

This parameter doesn't rely on PowerShell remoting. You can use the **ComputerName** parameter even
if your computer isn't configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: cn

Required: False
Position: Named
Default value: Local computer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description

Specifies a new description for the service.

The service description appears in **Computer Management, Services**. The **Description** isn't a
property of the `Get-Service` **ServiceController** object. To see the service description, use
`Get-CimInstance` that returns a **Win32_Service** object that represents the service.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies a new display name for the service.

> [!NOTE]
> Typically, `Set-Service` only operates on Windows services and not drivers. However, if you
> specify the name of a driver, `Set-Service` can target the driver.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: DN

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a **ServiceController** object that represents the service to change. Enter a variable
that contains the object, or type a command or expression that gets the object, such as a
`Get-Service` command. You can use the pipeline to send a service object to `Set-Service`.

```yaml
Type: System.ServiceProcess.ServiceController
Parameter Sets: InputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the service name of the service to be changed. Wildcard characters aren't permitted. You
can use the pipeline to send a service name to `Set-Service`.

> [!NOTE]
> Typically, `Set-Service` only operates on Windows services and not drivers. However, if you
> specify the name of a driver, `Set-Service` can target the driver.

```yaml
Type: System.String
Parameter Sets: Name
Aliases: ServiceName, SN

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PassThru

Returns a **ServiceController** object that represents the services that were changed. By default,
`Set-Service` doesn't generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupType

Sets the startup type of the service. The acceptable values for this parameter are:

- **Automatic** - The service is started or was started by the operating system, at system start-up.
  If an automatically started service depends on a manually started service, the manually started
  service is also started automatically at system startup.
- **Disabled** - The service is disabled and cannot be started by a user or application.
- **Manual** - The service is started only manually, by a user, using the Service Control Manager,
  or by an application.
- **Boot** - Indicates that the service is a device driver started by the system loader. This
  value is valid only for device drivers.
- **System** - Indicates that the service is a device driver started by the 'IOInitSystem()'
  function. This value is valid only for device drivers.

 The default value is **Automatic**.

```yaml
Type: System.ServiceProcess.ServiceStartMode
Parameter Sets: (All)
Aliases: StartMode, SM, ST
Accepted values: Boot, System, Automatic, Manual, Disabled

Required: False
Position: Named
Default value: Automatic
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Specifies the status for the service.

The acceptable values for this parameter are as follows:

- **Paused**. Suspends the service.
- **Running**. Starts the service.
- **Stopped**. Stops the service.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Paused, Running, Stopped

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running `Set-Service`.

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

Shows what would happen if `Set-Service` runs. The cmdlet isn't run.

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

When you use the **PassThru** parameter, this cmdlet returns a **ServiceController** object.

## NOTES

`Set-Service` requires elevated permissions. Use the **Run as administrator** option.

`Set-Service` can only control services when the current user has permissions to manage services. If
a command doesn't work correctly, you might not have the required permissions.

To find a service's service name or display name, use `Get-Service`. The service names are in the
**Name** column and the display names are in the **DisplayName** column.

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)
