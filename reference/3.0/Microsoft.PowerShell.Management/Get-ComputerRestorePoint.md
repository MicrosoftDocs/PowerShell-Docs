---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: https://go.microsoft.com/fwlink/?linkid=135215
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-ComputerRestorePoint
---

# Get-ComputerRestorePoint
## SYNOPSIS
Gets the restore points on the local computer.
## SYNTAX

### ID (Default)
```
Get-ComputerRestorePoint [[-RestorePoint] <Int32[]>] [<CommonParameters>]
```

### LastStatus
```
Get-ComputerRestorePoint [-LastStatus] [<CommonParameters>]
```

## DESCRIPTION
The Get-ComputerRestorePoint cmdlet gets the restore points on the local computer.
This cmdlet can also display the status of the most recent attempt to restore the computer.

You can use the information returned by Get-ComputerRestorePoint to select a restore point, and you can use the sequence number to identify a restore point for the Restore-Computer cmdlet.

System restore points and the Get-ComputerRestorePoint cmdlet are supported only on client operating systems, such as Windows 7, Windows Vista, and Windows XP.
## EXAMPLES

### Example 1
```
PS C:\> get-computerrestorepoint
```

This command gets all of the restore points on the local computer.
### Example 2
```
PS C:\> get-computerrestorepoint -restorepoint 232, 240, 245
```

This command gets the restore points with sequence numbers 232, 240, and 245.
### Example 3
```
PS C:\> get-computerrestorepoint -laststatus
The last restore failed.
```

This command displays the status of the most recent system restore operation on the local computer.
### Example 4
```
PS C:\> get-computerrestorepoint | format-table SequenceNumber, @{Label="Date"; Expression={$_.ConvertToDateTime($_.CreationTime)}}, Description -auto

SequenceNumber Date                  Description
-------------- ----                  -----------
253 8/5/2008 3:19:20 PM   Windows Update
254 8/6/2008 1:53:24 AM   Windows Update
255 8/7/2008 12:00:04 AM  Scheduled Checkpoint
...
```

This command displays the restore points in a table for easy reading.

The Format-Table command includes a calculated property that uses the ConvertToDateTime method to convert the value of the CreationTime property from WMI format to a DateTime object.
### Example 5
```
PS C:\> ((get-computerrestorepoint)[-1]).sequencenumber
```

This command gets the sequence number of the most recently created restore point on the computer.

The command uses the -1 index to get the last item in the array that Get-ComputerRestorePoint returns.
## PARAMETERS

### -LastStatus
Gets the status of the most recent system restore operation.

```yaml
Type: SwitchParameter
Parameter Sets: LastStatus
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestorePoint
Gets the restore points with the specified sequence numbers.
Enter the sequence numbers of one or more restore points.
By default, Get-ComputerRestorePoint gets all restore points on the local computer.

```yaml
Type: Int32[]
Parameter Sets: ID
Aliases:

Required: False
Position: 1
Default value: All restore points
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe objects to this cmdlet.
## OUTPUTS

### System.Management.ManagementObject#root\default\SystemRestore or String.
Get-ComputerRestore returns a SystemRestore object, which is an instance of the WMI SystemRestore class.
When you use the LastStatus parameter, this cmdlet returns a string.
## NOTES
* To run a Get-ComputerRestorePoint command on Windows Vista and later versions of Windows, open Windows PowerShell with the "Run as administrator" option.

  This cmdlet uses the Windows Management Instrumentation (WMI) SystemRestore class.

*
## RELATED LINKS

[Checkpoint-Computer](Checkpoint-Computer.md)

[Disable-ComputerRestore](Disable-ComputerRestore.md)

[Enable-ComputerRestore](Enable-ComputerRestore.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](Restore-Computer.md)
