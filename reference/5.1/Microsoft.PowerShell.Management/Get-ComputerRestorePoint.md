---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 08/13/2019
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-computerrestorepoint?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-ComputerRestorePoint
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
Get-ComputerRestorePoint -LastStatus [<CommonParameters>]
```

## DESCRIPTION

The `Get-ComputerRestorePoint` cmdlet gets the local computer's system restore points. And, it can
display the status of the most recent attempt to restore the computer.

You can use the information from `Get-ComputerRestorePoint` to select a restore point. For example,
use a sequence number to identify a restore point for the `Restore-Computer` cmdlet.

System restore points and the `Get-ComputerRestorePoint` cmdlet are supported only on client
operating systems such as Windows 10.

## EXAMPLES

### Example 1: Get all system restore points

In this example, `Get-ComputerRestorePoint` gets all the local computer's system restore points.

```powershell
Get-ComputerRestorePoint
```

```Output
CreationTime           Description                    SequenceNumber    EventType         RestorePointType
------------           -----------                    --------------    ---------         ----------------
7/30/2019 09:17:24     Windows Update                 4                 BEGIN_SYSTEM_C... 17
8/5/2019  08:15:37     Installed PowerShell 7-prev... 5                 BEGIN_SYSTEM_C... APPLICATION_INSTALL
8/7/2019  12:56:45     Installed PowerShell 6-x64     6                 BEGIN_SYSTEM_C... APPLICATION_INSTALL
```

### Example 2: Get specific sequence numbers

This example gets system restore points for specific sequence numbers.

```powershell
Get-ComputerRestorePoint -RestorePoint 4, 5
```

```Output
CreationTime           Description                    SequenceNumber    EventType         RestorePointType
------------           -----------                    --------------    ---------         ----------------
7/30/2019 09:17:24     Windows Update                 4                 BEGIN_SYSTEM_C... 17
8/5/2019  08:15:37     Installed PowerShell 7-prev... 5                 BEGIN_SYSTEM_C... APPLICATION_INSTALL
```

`Get-ComputerRestorePoint` uses the **RestorePoint** parameter to specify a comma-separated array of
sequence numbers.

### Example 3: Display the status of a system restore

This example displays the status of the most recent system restore on the local computer.

```powershell
Get-ComputerRestorePoint -LastStatus
```

```Output
The last attempt to restore the computer failed.
```

`Get-ComputerRestorePoint` uses the **LastStatus** parameter to display the result of the most
recent system restore.

### Example 4: Use an expression to convert the CreationTime

`Get-ComputerRestorePoint` outputs the **CreationTime** as a Windows Management Instrumentation
(WMI) date and time string.

In this example, a variable stores an expression that converts the **CreationTime** string to a
**DateTime** object. To view **CreationTime** strings before they're converted, use a command such
as `((Get-ComputerRestorePoint).CreationTime)`. For more information about the WMI date and time
string, see [CIM_DATETIME](/windows/win32/wmisdk/cim-datetime).

```powershell
$date = @{Label="Date"; Expression={$_.ConvertToDateTime($_.CreationTime)}}
Get-ComputerRestorePoint | Select-Object -Property SequenceNumber, $date, Description
```

```Output
SequenceNumber   Date                 Description
--------------   ----                 -----------
             4   7/30/2019 09:17:24   Windows Update
             5   8/5/2019  08:15:37   Installed PowerShell 7-preview-x64
             6   8/7/2019  12:56:45   Installed PowerShell 6-x64
```

The `$date` variable stores a hash table with the expression that uses the **ConvertToDateTime**
method. The expression converts the **CreationTime** property's value from a WMI string to a
**DateTime** object.

`Get-ComputerRestorePoint` sends the system restore point objects down the pipeline. `Select-Object`
uses the **Property** parameter to specify the properties to display. For each object in the
pipeline, the expression in `$date` converts the **CreationTime** and outputs the result in the
**Date** property.

### Example 5: Use a property to get a sequence number

This example gets a sequence number by using the **SequenceNumber** property and an array index. The
output only contains the sequence number.

```powershell
((Get-ComputerRestorePoint).SequenceNumber)[-1]
```

```Output
6
```

`Get-ComputerRestorePoint` uses the **SequenceNumber** property with an array index. The array index
of `-1` gets the most recent sequence number in the array.

## PARAMETERS

### -LastStatus

Indicates that `Get-ComputerRestorePoint` gets the status of the most recent system restore
operation.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: LastStatus
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestorePoint

Specifies the sequence numbers of the system restore points. You can specify either a single
sequence number or a comma-separated array of sequence numbers.

If the **RestorePoint** parameter isn't specified, `Get-ComputerRestorePoint` returns all the local
computer's system restore points.

```yaml
Type: System.Int32[]
Parameter Sets: ID
Aliases:

Required: False
Position: 0
Default value: All restore points
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't send objects down the pipeline to `Get-ComputerRestorePoint`.

## OUTPUTS

### System.Management.ManagementObject#root\default\SystemRestore or String

`Get-ComputerRestorePoint` returns a **SystemRestore** object, which is an instance of the Windows
Management Instrumentation (WMI) **SystemRestore** class.

When you use the **LastStatus** parameter, `Get-ComputerRestorePoint` returns a string.

## NOTES

To run a `Get-ComputerRestorePoint` command on Windows Vista and later versions of Windows, open
PowerShell with the **Run as administrator** option.

`Get-ComputerRestorePoint` uses the WMI **SystemRestore** class.

## RELATED LINKS

[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md)

[about_Arrays](../Microsoft.PowerShell.Core/About/about_Arrays.md)

[Checkpoint-Computer](Checkpoint-Computer.md)

[Disable-ComputerRestore](Disable-ComputerRestore.md)

[Enable-ComputerRestore](Enable-ComputerRestore.md)

[Restart-Computer](Restart-Computer.md)

[Restore-Computer](Restore-Computer.md)

[SystemRestore](/windows/win32/sr/systemrestore)
