---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821579
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Enable-ComputerRestore
---
# Enable-ComputerRestore

## SYNOPSIS
Enables the System Restore feature on the specified file system drive.

## SYNTAX

```
Enable-ComputerRestore [-Drive] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Enable-ComputerRestore** cmdlet turns on the System Restore feature on one or more file system drives.
As a result, you can use tools, such as the Restore-Computer cmdlet, to restore the computer to a previous state.

By default, System Restore is enabled on all eligible drives, but you can disable it, such as by using the Disable-ComputerRestore cmdlet.
To enable (or re-enable) System Restore on any drive, it must be enabled on the system drive, either first or concurrently.
To find the state of System Restore for each drive, use Rstrui.exe.

System restore points and the ComputerRestore cmdlets are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

## EXAMPLES

### Example 1: Enable System Restore on the specified drive

```
PS C:\> Enable-ComputerRestore -Drive "C:\"
```

This command enables System Restore on the C: drive of the local computer.

### Example 2: Enable System Restore on multiple drives

```
PS C:\> Enable-ComputerRestore -Drive "C:\", "D:\"
```

This command enables System Restore on the C: and D: drives of the local computer.

## PARAMETERS

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

### -Drive

Specifies the file system drives.
Enter one or more file system drive letters, each followed by a colon and a backslash and enclosed in quotation marks, such as C:\ or D:\.
This parameter is required.

You cannot use this cmdlet to enable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot enable System Restore on drives that are not eligible for System Restore, such as external drives.

To enable System Restore on any drive, System Restore must be enabled on the system drive, either before or concurrently.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
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

### None

You cannot pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

* To run this cmdlet on Windows Vista and later versions of Windows, open Windows PowerShell with the Run as administrator option.

  To find the file system drives that are eligible for system restore, in System in Control Panel, see the System Protection tab.
To open this tab in Windows PowerShell, type `SystemPropertiesProtection`.

  This cmdlet uses the Windows Management Instrumentation (WMI) **SystemRestore** class.

*

## RELATED LINKS

[Checkpoint-Computer](Checkpoint-Computer.md)

[Disable-ComputerRestore](Disable-ComputerRestore.md)

[Get-ComputerRestorePoint](Get-ComputerRestorePoint.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](Restore-Computer.md)