---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/30/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/restore-computer?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Restore-Computer
---

# Restore-Computer

## SYNOPSIS
Starts a system restore on the local computer.

## SYNTAX

```
Restore-Computer [-RestorePoint] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Restore-Computer` cmdlet restores the local computer to the specified system restore point.

`Restore-Computer` restarts the computer. The restore is completed during the restart operation.

System restore points and `Restore-Computer` are supported only on client operating systems, such as
Windows 7, Windows Vista, and Windows XP.

## EXAMPLES

### Example 1: Restore the local computer

```powershell
Restore-Computer -RestorePoint 253
```

This command restores the local computer to the restore point that has sequence number 253.

### Example 2: Restore the local computer with confirmation

```powershell
PS> Restore-Computer -RestorePoint 255 -Confirm
Confirm
Are you sure you want to perform this action?
Performing operation "Restore-Computer" .
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

This command restores the local computer to the restore point that has sequence number 255. It uses
the **Confirm** parameter to prompt the user before actually performing the operation.

### Example 3: Restore a computer and check the status

```powershell
Get-ComputerRestorePoint
Restore-Computer -RestorePoint 255
Get-ComputerRestorePoint -LastStatus
```

These commands run a system restore and then check its status.

The first command uses `Get-ComputerRestorePoint` to get the restore points on the local computer.

The second command restores the computer to the restore point with sequence number 255.

The third command uses the **LastStatus** parameter of `Get-ComputerRestorePoint` cmdlet to check
the status of the restore operation. Because `Restore-Computer` forces a restart, this command would
be entered after the computer restarts.

## PARAMETERS

### -RestorePoint

Specifies the sequence number of the restore point. To find the sequence number, use the
`Get-ComputerRestorePoint` cmdlet. This parameter is required.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: SequenceNumber, SN, RP

Required: True
Position: 0
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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- To run a `Restore-Computer` command on Windows Vista and later versions of the Windows operating
  system, open Windows PowerShell by using the Run as administrator option.
- This cmdlet uses the Windows Management Instrumentation (WMI) **SystemRestore** class.

## RELATED LINKS

[Checkpoint-Computer](Checkpoint-Computer.md)

[Disable-ComputerRestore](Disable-ComputerRestore.md)

[Enable-ComputerRestore](Enable-ComputerRestore.md)

[Get-ComputerRestorePoint](Get-ComputerRestorePoint.md)

[Restart-Computer](Restart-Computer.md)
