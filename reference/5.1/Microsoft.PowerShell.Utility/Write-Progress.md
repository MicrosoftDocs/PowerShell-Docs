---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821879
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Write-Progress
---

# Write-Progress

## SYNOPSIS
Displays a progress bar within a Windows PowerShell command window.

## SYNTAX

```
Write-Progress [-Activity] <String> [[-Status] <String>] [[-Id] <Int32>] [-PercentComplete <Int32>]
 [-SecondsRemaining <Int32>] [-CurrentOperation <String>] [-ParentId <Int32>] [-Completed] [-SourceId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Write-Progress** cmdlet displays a progress bar in a Windows PowerShell command window that depicts the status of a running command or script.
You can select the indicators that the bar reflects and the text that appears above and below the progress bar.

## EXAMPLES

### Example 1: Display the progress of a For loop
```
PS C:\> for ($I = 1; $I -le 100; $I++ )
{Write-Progress -Activity "Search in Progress" -Status "$I% Complete:" -PercentComplete $I;}
```

This command displays the progress of a For loop that counts from 1 to 100.
The **Write-Progress** command includes a status bar heading ("activity"), a status line, and the variable $I (the counter in the For loop), which indicates the relative completeness of the task.

### Example 2: Display the progress of nested For loops
```
PS C:\> for($I = 1; $I -lt 101; $I++ )
{Write-Progress -Activity Updating -Status 'Progress->' -PercentComplete $I -CurrentOperation OuterLoop; `
PS C:\> for($j = 1; $j -lt 101; $j++ )
{Write-Progress -Id 1 -Activity Updating -Status 'Progress' -PercentComplete $j -CurrentOperation InnerLoop} }
Updating
Progress ->
 [ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo] 
OutsideLoop
Updating
Progress
 [oooooooooooooooooo                                                   ] 
InnerLoop
```

This example displays the progress of two nested For loops, each of which is represented by a progress bar.

The **Write-Progress** command for the second progress bar includes the *Id* parameter that distinguishes it from the first progress bar.
Without the *Id* parameter, the progress bars would be superimposed on each other instead of being displayed one below the other.

### Example 3: Display the progress while searching for a string
```
PS C:\> $Events = Get-EventLog -logname system
PS C:\> $Events | foreach-object -begin {clear-host;$I=0;$out=""} `
-process {if($_.message -like "*bios*") {$out=$out + $_.Message}; $I = $I+1;
Write-Progress -Activity "Searching Events" -Status "Progress:" -PercentComplete ($I/$Events.count*100)} `
-end {$out}
```

This command displays the progress of a command to find the string "bios" in the System event log.

In the first line of the command, the Get-EventLog cmdlet gets the events in the System log and stores them in the $Events variable.

In the second line, the events are piped to the ForEach-Object cmdlet.
Before processing begins, the Clear-Host cmdlet is used to clear the screen, the $I counter variable is set to zero, and the $out output variable is set to the empty string.

In the third line, which is the Process script block of the **ForEach-Object** cmdlet, the cmdlet searches the message property of each incoming object for "bios".
If the string is found, the message is added to $out.
Then, the $I counter variable is incremented to record that another event has been examined.

The fourth line uses the **Write-Progress** cmdlet with values for the Activity and Status text fields that create the first and second lines of the progress bar heading, respectively.
The *PercentComplete* parameter value is calculated by dividing the number of events that have been processed ($I) by the total number of events retrieved ($Events.count) and then multiplying that result by 100.

In the last line, the *End* parameter of the **ForEach-Object** cmdlet is used to display the messages that are stored in the $out variable.

## PARAMETERS

### -Activity
Specifies the first line of text in the heading above the status bar.
This text describes the activity whose progress is being reported.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Completed
Indicates whether the progress bar is visible.
If this parameter is omitted, Write-Progress displays progress information.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CurrentOperation
Specifies the line of text below the progress bar.
This text describes the operation that is currently taking place.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies an ID that distinguishes each progress bar from the others.
Use this parameter when you are creating more than one progress bar in a single command.
If the progress bars do not have different IDs, they are superimposed instead of being displayed in a series.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentId
Specifies the parent activity of the current activity.
Use the value -1 if the current activity has no parent activity.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PercentComplete
Specifies the percentage of the activity that is completed.
Use the value -1 if the percentage complete is unknown or not applicable.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondsRemaining
Specifies the projected number of seconds remaining until the activity is completed.
Use the value -1 if the number of seconds remaining is unknown or not applicable.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceId
Specifies the source of the record.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Specifies the second line of text in the heading above the status bar.
This text describes current state of the activity.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
**Write-Progress** does not generate any output.

## NOTES
* If the progress bar does not appear, check the value of the $ProgressPreference variable. If the value is set to SilentlyContinue, the progress bar is not displayed. For more information about Windows PowerShell preferences, see about_Preference_Variables.

* The parameters of the cmdlet correspond to the properties of the ProgressRecord class (**System.Management.Automation.ProgressRecord**). For more information, see [ProgressRecord Class](https://msdn.microsoft.com/library/system.management.automation.progressrecord) in the MSDN library.

## RELATED LINKS

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Host](Write-Host.md)

[Write-Information](Write-Information.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)

