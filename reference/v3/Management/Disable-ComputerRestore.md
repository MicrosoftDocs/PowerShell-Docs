---
external help file: PSITPro3_Management.xml
schema: 2.0.0
---

# Disable-ComputerRestore
## SYNOPSIS
Disables the System Restore feature on the specified file system drive.

## SYNTAX

```
Disable-ComputerRestore [-Drive] <String[]> [-Confirm] [-WhatIf]
```

## DESCRIPTION
The Disable-ComputerRestore cmdlet turns off the System Restore feature on one or more file system drives.
As a result, attempts to restore the computer do not affect the specified drive.

To disable System Restore on any drive, it must be disabled on the system drive, either first or concurrently.

To re-enable System Restore, use the Enable-ComputerRestore cmdlet.
To find the state of System Restore for each drive, use Rstrui.exe.

System restore points and the ComputerRestore cmdlets are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>disable-computerrestore -drive "C:\"
```

This command disables System Restore on the C: drive.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>disable-computerrestore "C:\", "D:\"
```

This command disables System Restore on the C: and D: drives.
The command uses the Drive parameter, but it the omits the optional parameter name.

## PARAMETERS

### -Drive
Specifies the file system drives.
Enter one or more file system drive letters, each followed by a colon and a backslash and enclosed in quotation marks, such as "C:\" or "D:\". 
This parameter is required.

You cannot use this cmdlet to disable System Restore on a remote network drive, even if the drive is mapped to the local computer, and you cannot disable System Restore on drives that are not eligible for System Restore, such as external drives.

To disable System Restore on any drive, System Restore must be disabled on the system drive, either before or concurrently.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
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
Default value: false
Accept pipeline input: false
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
To run a Disable-ComputerRestore command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

To find the file system drives that are eligible for system restore, in System in Control Panel, see the System Protection tab.
To open this tab in Windows PowerShell, type "SystemPropertiesProtection".

This cmdlet uses the Windows Management Instrumentation \(WMI\) SystemRestore class.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=135207)

[Checkpoint-Computer](9ef7dd97-dbd9-43de-8988-9ab85e7827ad)

[Enable-ComputerRestore](47fd013a-d03b-487d-8c7b-17e93f038d1f)

[Get-ComputerRestorePoint](3afe67e8-56bd-4505-b7f6-b822143a28d5)

[Restart-Computer](ba50f64c-866e-4315-91c7-0ce16b44c47e)

[Restore-Computer](c570f18d-f1dd-462a-b00b-3eb1d2a81dfc)


