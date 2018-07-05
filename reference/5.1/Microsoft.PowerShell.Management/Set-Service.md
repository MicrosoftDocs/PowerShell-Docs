---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821633
schema: 2.0.0
title: Set-Service
---

# Set-Service

## SYNOPSIS

Starts, stops, and suspends a service, and changes its properties.

## SYNTAX

### Name (Default)
```
Set-Service [-ComputerName <String[]>] [-Name] <String> [-DisplayName <String>] [-Description <String>]
 [-StartupType <ServiceStartMode>] [-Status <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject
```
Set-Service [-ComputerName <String[]>] [-DisplayName <String>] [-Description <String>]
 [-StartupType <ServiceStartMode>] [-Status <String>] [-InputObject <ServiceController>] [-PassThru] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Service` cmdlet changes the properties of a service.
This includes the status, description, display name, and start mode.
You can use this cmdlet to start, stop, or suspend, or pause, a service.
To identify the service, enter its service name or submit a service object, or pipe a service name or service object to `Set-Service`.

## EXAMPLES

### Example 1: Change a display name

```powershell
Set-Service -Name "lanmanworkstation" -DisplayName "LanMan Workstation"
```

This command changes the display name of the lanmanworkstation service to LanMan Workstation.
The default is Workstation.

### Example 2: Change the startup type of services

```powershell
Set-Service -Name BITS -StartupType Automatic
Get-Service BITS | Select-Object Name, StartType, Status
```

```output
Name StartType  Status
---- ---------  ------
BITS      Auto Stopped
```

These commands get the startup type of the Background Intelligent Transfer Service (BITS) service, set the start mode to automatic, and then display the result of the change.

### Example 3: Change the description of a service

```powershell
Get-CimInstance Win32_Service -Filter 'Name = "BITS"'  | Format-List  Name, Description
```

```output
Name        : BITS
Description : Transfers files in the background using idle network bandwidth. If the service is
              disabled, then any applications that depend on BITS, such as Windows Update or MSN
              Explorer, will be unable to automatically download programs and other information.
```

```powershell
Set-Service -Name BITS -Description "Transfers files in the background using idle network bandwidth."
Get-CimInstance Win32_Service -Filter 'Name = "BITS"'  | Format-List  Name, Description
```

```output
Name        : BITS
Description : Transfers files in the background using idle network bandwidth.
```

These commands change the description of the BITS service and then display the result.

These commands use the `Get-CimInstance` cmdlet to get the **Win32_Service** object for the service, because the **ServiceController** object that `Get-Service` returns does not include the service description.

### Example 4: Start a service

```powershell
Set-Service -Name "winrm" -Status Running -PassThru
```

This command starts the WinRM service.
The command uses the **Status** parameter to specify the desired status, which is running, and the **PassThru** parameter to direct `Set-Service` to return an object that represents the WinRM service.

### Example 5: Suspend a service

```powershell
Get-Service -Name "schedule" | Set-Service -Status paused
```

This command suspends the Schedule service.
It uses `Get-Service` to get the service.
A pipeline operator (|) sends the service to `Set-Service`, which changes its status to Paused.

### Example 6: Stop a service

```powershell
$s = Get-Service -Name "schedule"
Set-Service -InputObject $s -Status stopped
```

These commands stop the Schedule service.

The first command uses `Get-Service` to get the Schedule service.
The command stores the service in the `$s` variable.

The second command changes the status of the Schedule service to Stopped.
It uses the **InputObject** parameter to submit the service stored in the `$s` variable, and it uses the **Status** parameter to specify the desired status.

## PARAMETERS

### -ComputerName

Specifies one or more computers.
The default is the local computer.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer.
To specify the local computer, type the computer name, a dot (.), or localhost.

This parameter does not rely on Windows PowerShell remoting.
You can use the **ComputerName** parameter even if your computer is not configured to run remote commands.

```yaml
Type: String[]
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

The service description appears in Services in Computer Management.
**Description** is not a property of the **ServiceController** object that `Get-Service` gets.
To see the service description, use `Get-CimInstance` to get a **Win32_Service** object that represents the service.

```yaml
Type: String
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
Type: String
Parameter Sets: (All)
Aliases: DN

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies a **ServiceController** object that represents the service to change.
Enter a variable that contains the object, or type a command or expression that gets the object, such as a `Get-Service` command.
You can also pipe a service object to `Set-Service`.

```yaml
Type: ServiceController
Parameter Sets: InputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the service name of the service to be changed.
Wildcard characters are not permitted.
You can also pipe a service name to `Set-Service`.

```yaml
Type: String
Parameter Sets: Name
Aliases: ServiceName, SN

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PassThru

Returns objects that represent the services that were changed.
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

### -StartupType

Specifies the start mode of the service.
The acceptable values for this parameter are:

- Automatic.
  Start when the system starts.
- Manual.
  Starts only when started by a user or program.
- Disabled.
  Cannot be started.

```yaml
Type: ServiceStartMode
Parameter Sets: (All)
Aliases: StartMode, SM, ST
Accepted values: Boot, System, Automatic, Manual, Disabled

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Specifies the status for the service.
The acceptable values for this parameter are:

- Running.
  Starts the service.
- Stopped.
  Stops the service.
- Paused.
  Suspends the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Running, Stopped, Paused

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

You can pipe a service object or a string that contains a service name to `Set-Service`.

## OUTPUTS

### System.ServiceProcess.ServiceController

This cmdlet does not return any objects.

## NOTES

Use of `Set-Service` requires elevated permissions. Start  PowerShell by using the Run as administrator option.
`Set-Service` can control services only when the current user has permission to do this. If a command does not work correctly, you might not have the required permissions.
To find the service names and display names of the services on your system, type `Get-Service`. The service names appear in the **Name** column and the display names appear in the **DisplayName** column.

## RELATED LINKS

[Get-Service](Get-Service.md)

[New-Service](New-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)