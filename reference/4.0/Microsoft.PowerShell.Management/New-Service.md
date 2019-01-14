---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293889
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  New-Service
---

# New-Service

## SYNOPSIS
Creates a new Windows service.

## SYNTAX

```
New-Service [-Name] <String> [-BinaryPathName] <String> [-DisplayName <String>] [-Description <String>]
 [-StartupType <ServiceStartMode>] [-Credential <PSCredential>] [-DependsOn <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The New-Service cmdlet creates a new entry for a Windows service in the registry and in the service database.
A new service requires an executable file that executes during the service.

The parameters of this cmdlet let you set the display name, description, startup type, and dependencies of the service.

## EXAMPLES

### Example 1
```
PS C:\> new-service -name TestService -binaryPathName "C:\WINDOWS\System32\svchost.exe -k netsvcs"
```

This command creates a new service named "TestService".

### Example 2
```
PS C:\> new-service -name TestService -binaryPathName "C:\WINDOWS\System32\svchost.exe -k netsvcs" -dependson NetLogon -displayName "Test Service" -StartupType Manual -Description "This is a test service."
```

This command creates a new service named "TestService".
It uses the parameters of the New-Service cmdlet to specify a description, startup type, and display name for the new service.

### Example 3
```
PS C:\> get-wmiobject win32_service -filter "name='testservice'"

ExitCode  : 0
Name      : testservice
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK
```

This command uses the Get-WmiObject cmdlet to get the Win32_Service object for the new service.
This object includes the start mode and the service description.

### Example 4
```
PS C:\> sc.exe delete TestService
- or -
PS C:\> (get-wmiobject win32_service -filter "name='TestService'").delete()
```

This example shows two ways to delete the TestService service.
The first command uses the delete option of Sc.exe.
The second command uses the Delete method of the Win32_Service objects that the Get-WmiObject cmdlet returns.

## PARAMETERS

### -BinaryPathName
Specifies the path to the executable file for the service.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies the account used by the service as the [Service Logon Account](/windows/desktop/ad/about-service-logon-accounts).

Type a user name, such as "User01" or "Domain01\User01".
Or, enter a PSCredential object, such as one from the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DependsOn
Specifies the names of other services upon which the new service depends.
To enter multiple service names, use a comma to separate the names.

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

### -Description
Specifies a description of the service.

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
Specifies a display name for the service.

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

### -Name
Specifies the name of the service.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ServiceName

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupType
Sets the startup type of the service.
"Automatic" is the default.

Valid values are:

-  Manual:      The service is started only manually, by a user (using the Service Control Manager) or by an application.
-  Automatic:  The service is to be started (or was started) by the operating system, at system start-up. If an automatically started service depends on a manually started service, the manually started service is also started automatically at system startup.
- Disabled: The service is disabled and cannot be started by a user or application.

```yaml
Type: ServiceStartMode
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Automatic
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

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.ServiceProcess.ServiceController
New-Service returns an object that represents the new service.

## NOTES
* To run this cmdlet on Windows Vista and later versions of Windows, start Windows PowerShell with the "Run as administrator" option.

  To delete a service, use Sc.exe, or use the Get-WmiObject cmdlet to get the Win32_Service object that represents the service and then use the Delete method to delete the service.
(The object that Get-Service returns does not have a delete method.) For an example, see the Examples section.

*

## RELATED LINKS

[Get-Service](Get-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)