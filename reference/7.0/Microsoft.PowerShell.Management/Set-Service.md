---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 10/25/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-service?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Service
---

# Set-Service

## SYNOPSIS
Starts, stops, and suspends a service, and changes its properties.

## SYNTAX

### Name (Default)

```
Set-Service [-Name] <String> [-DisplayName <String>] [-Credential <PSCredential>]
 [-Description <String>] [-StartupType <ServiceStartupType>] [-Status <String>]
 [-SecurityDescriptorSddl <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject

```
Set-Service [-InputObject] <ServiceController> [-DisplayName <String>] [-Credential <PSCredential>]
 [-Description <String>] [-StartupType <ServiceStartupType>] [-SecurityDescriptorSddl <String>]
 [-Status <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
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

### Example 7: Stop a service on a remote system

This example stops a service on a remote computer.
For more information, see [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

```powershell
$Cred = Get-Credential
$S = Get-Service -Name Schedule
Invoke-Command -ComputerName server01.contoso.com -Credential $Cred -ScriptBlock {
  Set-Service -InputObject $S -Status Stopped
}
```

`Get-Credential` prompts for a username and password, and stores the credentials in the `$Cred`
variable. `Get-Service` uses the **Name** parameter to specify the **Schedule** service. The object
is stored in the variable, `$S`.

`Invoke-Command` uses the **ComputerName** parameter to specify a remote computer. The
**Credential** parameter uses the `$Cred` variable to sign on to the computer. The **ScriptBlock**
calls `Set-Service`. The **InputObject** parameter specifies the service object stored `$S`. The
**Status** parameter sets the service to **Stopped**.

### Example 8: Change credential of a service

This example changes the credentials that are used to manage a service.

```powershell
$credential = Get-Credential
Set-Service -Name Schedule -Credential $credential
```

`Get-Credential` prompts for a username and password, and stores the credentials in the
`$credential` variable. `Set-Service` uses the **Name** parameter to specify the **Schedule**
service. The **Credential** parameter uses the `$credential` variable and updates the **Schedule**
service.

### Example 9: Change the SecurityDescriptor of a service

This example changes a service's **SecurityDescriptor**.

```powershell
$SDDL = "D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;SU)"
Set-Service -Name "BITS" -SecurityDescriptorSddl $SDDL
```

The **SecurityDescriptor** is stored in the `$SDDL` variable. `Set-Service` uses the **Name**
parameter to specify the **BITS** service. The **SecurityDescriptorSddl** parameter uses
`$SDDL` to change the **SecurityDescriptor** for the **BITS** service.

## PARAMETERS

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

### -Credential

Specifies the account used by the service as the [Service Logon Account](/windows/desktop/ad/about-service-logon-accounts).

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object,
such as one generated by the `Get-Credential` cmdlet. If you type a user name, this cmdlet prompts
you for a password.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -Force

Specifies the Stop mode of the service. This parameter only works when `-Status Stopped` is used. If
enabled, `Set-Service` stops the dependent services before the target service is stopped. By
default, exceptions are raised when other running services depend on the target service.

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

### -InputObject

Specifies a **ServiceController** object that represents the service to change. Enter a variable
that contains the object, or type a command or expression that gets the object, such as a
`Get-Service` command. You can use the pipeline to send a service object to `Set-Service`.

```yaml
Type: System.ServiceProcess.ServiceController
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the service name of the service to be changed. Wildcard characters aren't permitted. You
can use the pipeline to send a service name to `Set-Service`.

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

Specifies the start mode of the service.

The acceptable values for this parameter are as follows:

- **Automatic** - The service is started or was started by the operating system, at system start-up.
  If an automatically started service depends on a manually started service, the manually started
  service is also started automatically at system startup.
- **AutomaticDelayedStart** - Starts shortly after the system boots.
- **Disabled** - The service is disabled and cannot be started by a user or application.
- **InvalidValue** - Has no effect. The cmdlet does not return an error but the StartupType of the
  service is not changed.
- **Manual** - The service is started only manually, by a user, using the Service Control Manager,
  or by an application.

```yaml
Type: Microsoft.PowerShell.Commands.ServiceStartupType
Parameter Sets: (All)
Aliases: StartMode, SM, ST, StartType
Accepted values: Automatic, AutomaticDelayedStart, Disabled, InvalidValue, Manual

Required: False
Position: Named
Default value: None
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

### -SecurityDescriptorSddl

Specifies the **SecurityDescriptor** for the service in **Sddl** format.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: sd

Required: False
Position: Named
Default value: None
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.ServiceProcess.ServiceController, System.String

You can use the pipeline to send a service object or a string that contains a service name to
`Set-Service`.

## OUTPUTS

### System.ServiceProcess.ServiceController

By default, `Set-Service` doesn't return any objects. Use the **PassThru** parameter to output a
**ServiceController** object.

## NOTES

This cmdlet is only available on Windows platforms.

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

[Remove-Service](Remove-Service.md)
