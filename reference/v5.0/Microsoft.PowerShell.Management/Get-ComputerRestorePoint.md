---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=290489
schema: 2.0.0
---

# Get-ComputerRestorePoint
## SYNOPSIS
Gets the restore points on the local computer.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Get-ComputerRestorePoint [[-RestorePoint] <Int32[]>]
```

### UNNAMED_PARAMETER_SET_2
```
Get-ComputerRestorePoint [-LastStatus]
```

## DESCRIPTION
The Get-ComputerRestorePoint cmdlet gets the restore points on the local computer.
This cmdlet can also display the status of the most recent attempt to restore the computer.

You can use the information returned by this cmdlet to select a restore point, and you can use the sequence number to identify a restore point for the Restore-Computer cmdlet.

System restore points and the Get-ComputerRestorePoint cmdlet are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.

## EXAMPLES

### Example 1: Get all System Restore points from the local computer
```
PS C:\>Get-ComputerRestorePoint
```

This command gets all of the System Restore points on the local computer.

### Example 2: Get all System Restore points with the specified sequence numbers
```
PS C:\>Get-ComputerRestorePoint -RestorePoint 232, 240, 245
```

This command gets the System Restore points with sequence numbers 232, 240, and 245.

### Example 3: Display the status of the most recent system restore operation on the local computer
```
PS C:\>Get-ComputerRestorePoint -LastStatus

The last restore failed.
```

This command displays the status of the most recent System Restore operation on the local computer.

### Example 4: Display all the System Restore points in a table
```
PS C:\>Get-ComputerRestorePoint | Format-Table SequenceNumber, @{Label="Date"; Expression={$_.ConvertToDateTime($_.CreationTime)}}, Description -Auto







SequenceNumber Date                  Description
-------------- ----                  -----------
253 8/5/2008 3:19:20 PM   Windows Update
254 8/6/2008 1:53:24 AM   Windows Update
255 8/7/2008 12:00:04 AM  Scheduled Checkpoint.
```

This command displays the System Restore points in a table for easy reading.

The Format-Table cmdlet includes a calculated property that uses the ConvertToDateTime method to convert the value of the CreationTime property from WMI format to a DateTime object.

### Example 5: Get the sequence number of the most recent System Restore point
```
PS C:\>((Get-ComputerRestorePoint)[-1]).sequencenumber
```

This command gets the sequence number of the most recently created restore point on the computer.

The command uses the -1 index to get the last item in the array that this cmdlet returns.

## PARAMETERS

### -LastStatus
Indicates that this cmdlet gets the status of the most recent system restore operation.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestorePoint
Specifies the restore points, as sequence numbers, that this cmdlet gets.
Enter the sequence numbers of one or more restore points.
By default, this cmdlet gets all restore points on the local computer.

```yaml
Type: Int32[]
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### System.Management.ManagementObject#root\default\SystemRestore or String.
This cmdlet returns a SystemRestore object, which is an instance of the Windows Management Instrumentation (WMI) SystemRestore class.
When you use the LastStatus parameter, this cmdlet returns a string.

## NOTES
* To run a Get-ComputerRestorePoint command on Windows Vista and later versions of Windows, open Windows PowerShell with the Run as administrator option.

  This cmdlet uses the WMI SystemRestore class.

*

## RELATED LINKS

[Checkpoint-Computer](9ef7dd97-dbd9-43de-8988-9ab85e7827ad)

[Disable-ComputerRestore](06c5d9de-8a14-449c-b13b-c6793297e3fe)

[Enable-ComputerRestore](47fd013a-d03b-487d-8c7b-17e93f038d1f)

[Restart-Computer](ba50f64c-866e-4315-91c7-0ce16b44c47e)

[Restore-Computer](c570f18d-f1dd-462a-b00b-3eb1d2a81dfc)

[Format-Table](2b56a2d0-c067-40e4-b744-979fbaf847e2)

