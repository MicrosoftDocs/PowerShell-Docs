---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821608
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Remove-Service
---

# Remove-Service

## SYNOPSIS
Removes a Windows service.

## SYNTAX

### Name
```
Remove-Service [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```
### InputObject (Default)
```
Remove-Service [-InputObject] <ServiceController[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Remove-Service** cmdlet removes a Windows service in the registry and in the service database.

## EXAMPLES

### Example 1: Remove a service
```
PS C:\> Remove-Service -Name "TestService"
```

This command removes a service named TestService.

### Example 2: Remove a service using the display name
```
PS C:\> Get-Service -DisplayName "Test Service" | Remove-Service
```

This command creates a service named TestService.
The command uses **Get-Service** to get an object that represents the TestService service using the display name.
The pipeline operator (|) pipes the object to **Remove-Service**, which removes the service.

## PARAMETERS

### -InputObject
Specifies **ServiceController** objects that represent the services to stop.
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: ServiceController[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the service names of the services to stop.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: Default
Aliases: ServiceName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
You can pipe a service object or a string that contains the name of a service to this cmdlet.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
* To run this cmdlet on Windows Vista and later versions of the Windows operating system, start PowerShell by using the Run as administrator option.

## RELATED LINKS

[Get-Service](Get-Service.md)

[Restart-Service](Restart-Service.md)

[Resume-Service](Resume-Service.md)

[Set-Service](Set-Service.md)

[Start-Service](Start-Service.md)

[Stop-Service](Stop-Service.md)

[Suspend-Service](Suspend-Service.md)