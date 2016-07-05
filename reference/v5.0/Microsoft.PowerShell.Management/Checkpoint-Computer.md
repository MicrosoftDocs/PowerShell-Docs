---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289797
schema: 2.0.0
---

# Checkpoint-Computer
## SYNOPSIS
Creates a system restore point on the local computer.

## SYNTAX

```
Checkpoint-Computer [-Description] <String> [-RestorePointType]
```

## DESCRIPTION
The Checkpoint-Computer cmdlet creates a system restore point on the local computer.

System restore points and the Checkpoint-Computer cmdlet are supported only on client operating systems, such as Windows 8, Windows 7, Windows Vista, and Windows XP.

Beginning in Windows 8, Checkpoint-Computer cannot create more than one checkpoint each day.

## EXAMPLES

### Example 1: Create a system restore point
```
PS C:\>Checkpoint-Computer -Description "Install MyApp"
```

This command creates a system restore point called Install MyApp.
It uses the default APPLICATION_INSTALL restore point type.

### Example 2: Create a system MODIFY_SETTINGS restore point
```
PS C:\>Checkpoint-Computer -Description "ChangeNetSettings" -RestorePointType MODIFY_SETTINGS
```

This command creates a MODIFY_SETTINGS system restore point called "ChangeNetSettings".

## PARAMETERS

### -Description
Specifies a descriptive name for the restore point.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestorePointType
Specifies the type of restore point.
The default is APPLICATION_INSTALL.

The acceptable values for this parameter are:

- APPLICATION_INSTALL
- APPLICATION_UNINSTALL
- DEVICE_DRIVER_INSTALL
- MODIFY_SETTINGS
- CANCELLED_OPERATION

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: RPT
Accepted values: APPLICATION_INSTALL, APPLICATION_UNINSTALL, DEVICE_DRIVER_INSTALL, MODIFY_SETTINGS, CANCELLED_OPERATION

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe objects to Checkpoint-Computer.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* This cmdlet uses the CreateRestorePoint method of the SystemRestore class with a BEGIN_SYSTEM_CHANGE event.
* Beginning in Windows 8, Checkpoint-Computer cannot create more than one system restore point each day. If you try to create a new restore point before the 24-hour period has elapsed, Windows PowerShell generates the following error:

  "A new system restore point cannot be created because one has already been created within the past 24 hours.
Please try again later."

## RELATED LINKS

[Disable-ComputerRestore](06c5d9de-8a14-449c-b13b-c6793297e3fe)

[Enable-ComputerRestore](47fd013a-d03b-487d-8c7b-17e93f038d1f)

[Get-ComputerRestorePoint](3afe67e8-56bd-4505-b7f6-b822143a28d5)

[Restore-Computer](c570f18d-f1dd-462a-b00b-3eb1d2a81dfc)

