---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/write-progress?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-Progress
---
# Write-Progress

## SYNOPSIS
Displays a progress bar within a PowerShell command window.

## SYNTAX

```
Write-Progress [-Activity] <String> [[-Status] <String>] [[-Id] <Int32>] [-PercentComplete <Int32>]
 [-SecondsRemaining <Int32>] [-CurrentOperation <String>] [-ParentId <Int32>] [-Completed] [-SourceId <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Write-Progress` cmdlet displays a progress bar in a PowerShell command window that depicts the
status of a running command or script. You can select the indicators that the bar reflects and the
text that appears above and below the progress bar.

## EXAMPLES

### Example 1: Display the progress of a For loop

```powershell
for ($i = 1; $i -le 100; $i++ )
{
    Write-Progress -Activity "Search in Progress" -Status "$i% Complete:" -PercentComplete $i;
}
```

This command displays the progress of a For loop that counts from 1 to 100.

The `Write-Progress` cmdlet includes a status bar heading `Activity`, a status line, and the
variable `$i` (the counter in the For loop), which indicates the relative completeness of the task.

### Example 2: Display the progress of nested For loops

```powershell
for($I = 1; $I -lt 101; $I++ )
{
    Write-Progress -Activity Updating -Status 'Progress->' -PercentComplete $I -CurrentOperation OuterLoop
    for($j = 1; $j -lt 101; $j++ )
    {
        Write-Progress -Id 1 -Activity Updating -Status 'Progress' -PercentComplete $j -CurrentOperation InnerLoop
    }
}
```

```Output
Updating
Progress ->
 [ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo]
OuterLoop
Updating
Progress
 [oooooooooooooooooo                                                   ]
InnerLoop
```

This example displays the progress of two nested For loops, each of which is represented by a
progress bar.

The `Write-Progress` command for the second progress bar includes the **Id** parameter that
distinguishes it from the first progress bar.

Without the **Id** parameter, the progress bars would be superimposed on each other instead of being
displayed one below the other.

### Example 3: Display the progress while searching for a string

```powershell
# Use Get-EventLog to get the events in the System log and store them in the $Events variable.
$Events = Get-EventLog -LogName system
# Pipe the events to the ForEach-Object cmdlet.
$Events | ForEach-Object -Begin {
    # In the Begin block, use Clear-Host to clear the screen.
    Clear-Host
    # Set the $i counter variable to zero.
    $i = 0
    # Set the $out variable to a empty string.
    $out = ""
} -Process {
    # In the Process script block search the message property of each incoming object for "bios".
    if($_.message -like "*bios*")
    {
        # Append the matching message to the out variable.
        $out=$out + $_.Message
    }
    # Increment the $i counter variable which is used to create the progress bar.
    $i = $i+1
    # Use Write-Progress to output a progress bar.
    # The Activity and Status parameters create the first and second lines of the progress bar heading, respectively.
    Write-Progress -Activity "Searching Events" -Status "Progress:" -PercentComplete ($i/$Events.count*100)
} -End {
    # Display the matching messages using the out variable.
    $out
}
```

This command displays the progress of a command to find the string "bios" in the System event log.

The **PercentComplete** parameter value is calculated by dividing the number of events that have
been processed `$I` by the total number of events retrieved `$Events.count` and then multiplying
that result by 100.

### Example 4: Display progress for each level of a nested process

```powershell
foreach ( $i in 1..10 ) {
  Write-Progress -Id 0 "Step $i"
  foreach ( $j in 1..10 ) {
    Write-Progress -Id 1 -ParentId 0 "Step $i - Substep $j"
    foreach ( $k in 1..10 ) {
      Write-Progress -Id 2  -ParentId 1 "Step $i - Substep $j - iteration $k"; start-sleep -m 150
    }
  }
}
```

```Output
Step 1
     Processing
    Step 1 - Substep 2
         Processing
        Step 1 - Substep 2 - Iteration 3
             Processing
```

In this example you can use the **ParentId** parameter to have indented output to show parent/child
relationships in the progress of each step.

## PARAMETERS

### -Activity

Specifies the first line of text in the heading above the status bar.
This text describes the activity whose progress is being reported.

```yaml
Type: System.String
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
If this parameter is omitted, `Write-Progress` displays progress information.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies an ID that distinguishes each progress bar from the others. Use this parameter when you
are creating more than one progress bar in a single command. If the progress bars do not have
different IDs, they are superimposed instead of being displayed in a series.

```yaml
Type: System.Int32
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
Type: System.Int32
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
Type: System.Int32
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
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceId

Specifies the source of the record. You can use this in place of **Id** but cannot be used with
other parameters like **ParentId**.

```yaml
Type: System.Int32
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
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

`Write-Progress` does not generate any output.

## NOTES

If the progress bar does not appear, check the value of the `$ProgressPreference` variable. If the
value is set to SilentlyContinue, the progress bar is not displayed. For more information about
PowerShell preferences, see
[about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

The parameters of the cmdlet correspond to the properties of the
**System.Management.Automation.ProgressRecord** class. For more information, see
[ProgressRecord Class](/dotnet/api/system.management.automation.progressrecord).

## RELATED LINKS

[Write-Debug](Write-Debug.md)

[Write-Error](Write-Error.md)

[Write-Host](Write-Host.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)
