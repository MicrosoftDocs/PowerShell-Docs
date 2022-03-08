---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 10/06/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/get-history?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-History
---
# Get-History

## SYNOPSIS
Gets a list of the commands entered during the current session.

## SYNTAX

```
Get-History [[-Id] <Int64[]>] [[-Count] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-History` cmdlet gets the session history, that is, the list of commands entered during the
current session.

PowerShell automatically maintains a history of each session. The number of entries in the session
history is determined by the value of the `$MaximumHistoryCount` preference variable. Beginning in
Windows PowerShell 3.0, the default value is `4096`. By default, history files are saved in the home
directory, but you can save the file in any location. For more information about the history
features in PowerShell, see [about_History](About/about_History.md).

The session history is managed separately from the history maintained by the **PSReadLine** module.
Both histories are available in sessions where **PSReadLine** is loaded. This cmdlet only works with
the session history. For more information see, [about_PSReadLine](../PSReadLine/About/about_PSReadLine.md).

## EXAMPLES

### Example 1: Get the session history

This example gets the entries in the session history. The default display shows each command and its
ID, which indicates the order in which they ran.

```powershell
Get-History
```

### Example 2: Get entries that include a string

This example gets entries in the command history that include the string service. The first command
gets all entries in the session history. The pipeline operator (`|`) passes the results to the
`Where-Object` cmdlet, which selects only the commands that include service.

```powershell
Get-History | Where-Object {$_.CommandLine -like "*Service*"}
```

### Example 3: Export history entries up to a specific ID

This example gets the five most recent history entries ending with entry 7. The pipeline operator
passes the result to the `Export-Csv` cmdlet, which formats the history as comma-separated text and
saves it in the History.csv file. The file includes the data that is displayed when you format the
history as a list. This includes the status and start and end times of the command.

```powershell
Get-History -ID 7 -Count 5 | Export-Csv History.csv
```

### Example 4: Display the most recent command

This example gets the last command in the command history. The last command is the most recently
entered command. This command uses the **Count** parameter to display just one command. By default,
`Get-History` gets the most recent commands. This command can be abbreviated to "h -c 1" and is
equivalent to pressing the up-arrow key.

```powershell
Get-History -Count 1
```

### Example 5: Display all the properties of the entries in the history

This example displays all of the properties of entries in the session history. The pipeline operator
passes the results of a `Get-History` command to the `Format-List` cmdlet, which displays all of the
properties of each history entry. This includes the ID, status, and start and end times of the
command.

```powershell
Get-History | Format-List -Property *
```

## PARAMETERS

### -Count

Specifies the number of the most recent history entries that this cmdlet gets. By, default,
`Get-History` gets all entries in the session history. If you use both the **Count** and **Id**
parameters in a command, the display ends with the command that is specified by the **Id**
parameter.

In Windows PowerShell 2.0, by default, `Get-History` gets the 32 most recent entries.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies an array of the IDs of entries in the session history. `Get-History` gets only specified
entries. If you use both the **Id** and **Count** parameters in a command, `Get-History` gets the
most recent entries ending with the entry specified by the **Id** parameter.

```yaml
Type: System.Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int64

You can pipe a history ID to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.HistoryInfo

This cmdlet returns a history object for each history item that it gets.

## NOTES

The session history is a list of the commands entered during the session. The session history
represents the run order, the status, and the start and end times of the command. As you enter each
command, PowerShell adds it to the history so that you can reuse it. For more information about the
command history, see [about_History](About/about_History.md).

Starting in Windows PowerShell 3.0, the default value of the `$MaximumHistoryCount` preference
variable is `4096`. In Windows PowerShell 2.0, the default value is `64`. For more information about
the `$MaximumHistoryCount` variable, see [about_Preference_Variables](About/about_Preference_Variables.md).

## RELATED LINKS

[Add-History](Add-History.md)

[Clear-History](Clear-History.md)

[Invoke-History](Invoke-History.md)

[about_History](About/about_History.md)
