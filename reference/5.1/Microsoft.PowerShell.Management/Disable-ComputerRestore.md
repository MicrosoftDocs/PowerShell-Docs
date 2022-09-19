---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/30/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/disable-computerrestore?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Disable-ComputerRestore
---

# Disable-ComputerRestore

## SYNOPSIS
Disables the System Restore feature on the specified file system drive.

## SYNTAX

```Syntax
Disable-ComputerRestore [-Drive] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Disable-ComputerRestore` cmdlet turns off the System Restore feature on one or more file system
drives. As a result, attempts to restore the computer do not affect the specified drive.

To disable System Restore on any drive, it must be disabled on the system drive, either first or
concurrently.

To re-enable System Restore, use the Enable-ComputerRestore cmdlet. To find the state of System
Restore for each drive, use `Rstrui.exe`.

System restore points and the ComputerRestore cmdlets are supported only on client operating
systems, such as Windows 7, Windows Vista, and Windows XP.

## EXAMPLES

### Example 1: Disable System Restore on the specified drive

```powershell
Disable-ComputerRestore -Drive "C:\"
```

This command disables System Restore on the C: drive.

### Example 2: Disable System Restore on multiple drives

```powershell
Disable-ComputerRestore "C:\", "D:\"
```

This command disables System Restore on the C: and D: drives. The command uses the **Drive**
parameter, but it omits the Drive parameter name.

## PARAMETERS

### -Drive

Specifies the file system drives. Enter one or more file system drive letters, each followed by a
colon and a backslash and enclosed in quotation marks, such as C:\ or D:\. This parameter is
required.

You cannot use this cmdlet to disable System Restore on a remote network drive, even if the drive is
mapped to the local computer, and you cannot disable System Restore on drives that are not eligible
for System Restore, such as external drives.

To disable System Restore on any drive, System Restore must be disabled on the system drive, either
before or concurrently.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

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

- To run this cmdlet on Windows Vista and later versions of Windows, open Windows PowerShell with
  the Run as administrator option.

  To find the file system drives that are eligible for system restore, in System in Control Panel,
  see the System Protection tab. To open this tab in Windows PowerShell, type
  `SystemPropertiesProtection`.

  This cmdlet uses the Windows Management Instrumentation (WMI) **SystemRestore** class.

## RELATED LINKS

[Checkpoint-Computer](Checkpoint-Computer.md)

[Enable-ComputerRestore](Enable-ComputerRestore.md)

[Get-ComputerRestorePoint](Get-ComputerRestorePoint.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](Restore-Computer.md)
