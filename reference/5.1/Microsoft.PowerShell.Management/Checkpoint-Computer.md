---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 07/12/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/checkpoint-computer?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Checkpoint-Computer
---
# Checkpoint-Computer

## SYNOPSIS
Creates a system restore point on the local computer.

## SYNTAX

```
Checkpoint-Computer [-Description] <String> [[-RestorePointType] <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Checkpoint-Computer` cmdlet creates a system restore point on the local computer.

System restore points and the `Checkpoint-Computer` cmdlet are supported only on client operating
systems, such as Windows 10 or Windows 11. `Checkpoint-Computer` cannot create more than one
checkpoint each day.

## EXAMPLES

### Example 1: Create a system restore point

```powershell
Checkpoint-Computer -Description "Install MyApp"
```

This command creates a system restore point called Install MyApp. It uses the default
`APPLICATION_INSTALL` restore point type.

### Example 2: Create a system MODIFY_SETTINGS restore point

```powershell
Checkpoint-Computer -Description "ChangeNetSettings" -RestorePointType MODIFY_SETTINGS
```

This command creates a `MODIFY_SETTINGS` system restore point called "ChangeNetSettings".

## PARAMETERS

### -Description

Specifies a descriptive name for the restore point. This parameter is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestorePointType

Specifies the type of restore point. The default is `APPLICATION_INSTALL`.

The acceptable values for this parameter are:

- `APPLICATION_INSTALL`
- `APPLICATION_UNINSTALL`
- `DEVICE_DRIVER_INSTALL`
- `MODIFY_SETTINGS`
- `CANCELLED_OPERATION`

The cmdlet accepts `CANCELLED_OPERATION` but this type of restore point operation is no longer
supported. For more information about these types, see the
[Restore Point Description Text](/windows/win32/sr/restore-point-description-text) documentation.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RPT
Accepted values: APPLICATION_INSTALL, APPLICATION_UNINSTALL, DEVICE_DRIVER_INSTALL, MODIFY_SETTINGS, CANCELLED_OPERATION

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe objects to `Checkpoint-Computer`.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- This cmdlet uses the **CreateRestorePoint** method of the **SystemRestore** class with a
  **BEGIN_SYSTEM_CHANGE** event.
- Beginning in Windows 8, `Checkpoint-Computer` cannot create more than one system restore point
  each day. If you try to create a new restore point before the 24-hour period has elapsed, Windows
  PowerShell generates the following error:

  `"A new system restore point cannot be created because one has already been created within the
  past 24 hours. Please try again later."`

## RELATED LINKS

[Disable-ComputerRestore](Disable-ComputerRestore.md)

[Enable-ComputerRestore](Enable-ComputerRestore.md)

[Get-ComputerRestorePoint](Get-ComputerRestorePoint.md)

[Restore-Computer](Restore-Computer.md)
