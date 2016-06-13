---
external help file: PSITPro4_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=290487
schema: 2.0.0
---

# Enable-ComputerRestore
## SYNOPSIS
Enables the System Restore feature on the specified file system drive.

## SYNTAX

```
Enable-ComputerRestore [-Drive] <String[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Enable-ComputerRestore cmdlet turns on the System Restore feature on one or more file system drives.
As a result, you can use tools, such as the Restore-Computer cmdlet, to restore the computer to a previous state.

By default, System Restore is enabled on all eligible drives, but you can disable it, such as by using the Disable-ComputerRestore cmdlet.
To enable (or re-enable) System Restore on any drive, it must be enabled on the system drive, either first or concurrently. 
To find the state of System Restore for each drive, use Rstrui.exe.

System restore points and the ComputerRestore cmdlets are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>enable-computerrestore -drive "C:\"
```

This command enables System Restore on the C: drive of the local computer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>enable-computerrestore -drive "C:\", "D:\"
```

This command enables System Restore on the C: and D: drives of the local computer.

## PARAMETERS

### -Drive
Specifies the file system drives.
Enter one or more file system drive letters, each followed by a colon and a backslash and enclosed in quotation marks, such as "C:\" or "D:\". 
This parameter is required.

You cannot use this cmdlet to enable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot enable System Restore on drives that are not eligible for System Restore, such as external drives.

To enable System Restore on any drive, System Restore must be enabled on the system drive, either before or concurrently.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
To run an Enable-ComputerRestore command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

To find the file system drives that are eligible for system restore, in System in Control Panel, see the System Protection tab.
To open this tab in Windows PowerShell, type "SystemPropertiesProtection".

This cmdlet uses the Windows Management Instrumentation (WMI) SystemRestore class.

## RELATED LINKS

[Checkpoint-Computer](9ef7dd97-dbd9-43de-8988-9ab85e7827ad)

[Disable-ComputerRestore](06c5d9de-8a14-449c-b13b-c6793297e3fe)

[Get-ComputerRestorePoint](3afe67e8-56bd-4505-b7f6-b822143a28d5)

[Restart-Computer](ba50f64c-866e-4315-91c7-0ce16b44c47e)

[Restore-Computer](c570f18d-f1dd-462a-b00b-3eb1d2a81dfc)

