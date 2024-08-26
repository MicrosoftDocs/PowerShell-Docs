---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/26/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/write-progress?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-Progress
---

# Write-Progress

## SYNOPSIS
Displays a progress bar within a PowerShell command window.

## SYNTAX

```
Write-Progress [[-Activity] <String>] [[-Status] <String>] [[-Id] <Int32>]
 [-PercentComplete <Int32>] [-SecondsRemaining <Int32>] [-CurrentOperation <String>]
 [-ParentId <Int32>] [-Completed] [-SourceId <Int32>] [<CommonParameters>]
```

## DESCRIPTION

The `Write-Progress` cmdlet displays a progress bar in a PowerShell command window that depicts the
status of a running command or script. You can select the indicators that the bar reflects and the
text that appears above and below the progress bar.

PowerShell 7.2 added the `$PSStyle` automatic variable that's used to control how PowerShell
displays certain information using ANSI escape sequences. The `$PSStyle.Progress` member allows you
to control progress view bar rendering.

- `$PSStyle.Progress.Style` - An ANSI string setting the rendering style.
- `$PSStyle.Progress.MaxWidth` - Sets the max width of the view. Defaults to `120`. The minimum
  value is 18.
- `$PSStyle.Progress.View` - An enum with values, `Minimal` and `Classic`. `Classic` is the existing
  rendering with no changes. `Minimal` is a single line minimal rendering. `Minimal` is the default.

For more information about `$PSStyle`, see
[about_ANSI_Terminals.md](../Microsoft.PowerShell.Core/About/about_ANSI_Terminals.md).

> [!NOTE]
> If the host doesn't support Virtual Terminal, `$PSStyle.Progress.View` is automatically set to
> `Classic`.

## EXAMPLES

### Example 1: Display the progress of a For loop

```powershell
for ($i = 1; $i -le 100; $i++ ) {
    Write-Progress -Activity "Search in Progress" -Status "$i% Complete:" -PercentComplete $i
    Start-Sleep -Milliseconds 250
}
```

This command displays the progress of a `for` loop that counts from 1 to 100.

The `Write-Progress` cmdlet includes a status bar heading `Activity`, a status line, and the
variable `$i` (the counter in the `for` loop), which indicates the relative completeness of the
task.

### Example 2: Display the progress of nested For loops

```powershell
$PSStyle.Progress.View = 'Classic'

for($I = 0; $I -lt 10; $I++ ) {
    $OuterLoopProgressParameters = @{
        Activity         = 'Updating'
        Status           = 'Progress->'
        PercentComplete  = $I * 10
        CurrentOperation = 'OuterLoop'
    }
    Write-Progress @OuterLoopProgressParameters
    for($j = 1; $j -lt 101; $j++ ) {
        $InnerLoopProgressParameters = @{
            ID               = 1
            Activity         = 'Updating'
            Status           = 'Inner Progress'
            PercentComplete  = $j
            CurrentOperation = 'InnerLoop'
        }
        Write-Progress @InnerLoopProgressParameters
        Start-Sleep -Milliseconds 25
    }
}
```

```Output
Updating
Progress ->
 [ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo]
OuterLoop
Updating
Inner Progress
 [oooooooooooooooooo                                                   ]
InnerLoop
```

This example sets the progress view to `Classic` and then displays the progress of two nested `for`
loops, each represented by a progress bar.

The `Write-Progress` command for the second progress bar includes the **Id** parameter that
distinguishes it from the first progress bar.

Without the **Id** parameter, the progress bars would be superimposed on each other instead of
being displayed one below the other.

> [!NOTE]
> This example sets the progress view to `Classic`, which displays the **CurrentOperation** values
> For each progress bar. When the progress view is set to `Minimal`, the **CurrentOperation**
> values aren't displayed.

### Example 3: Display the progress while searching for a string

```powershell
# Use Get-WinEvent to get the events in the System log and store them in the $Events variable.
$Events = Get-WinEvent -LogName system
# Pipe the events to the ForEach-Object cmdlet.
$Events | ForEach-Object -Begin {
    # In the Begin block, use Clear-Host to clear the screen.
    Clear-Host
    # Set the $i counter variable to zero.
    $i = 0
    # Set the $out variable to an empty string.
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
    # Determine the completion percentage
    $Completed = ($i/$Events.count) * 100
    # Use Write-Progress to output a progress bar.
    # The Activity and Status parameters create the first and second lines of the progress bar
    # heading, respectively.
    Write-Progress -Activity "Searching Events" -Status "Progress:" -PercentComplete $Completed
} -End {
    # Display the matching messages using the out variable.
    $out
}
```

This command displays the progress of a command to find the string "bios" in the System event log.

The **PercentComplete** parameter value is calculated by dividing the number of events that have
been processed `$i` by the total number of events retrieved `$Events.count` and then multiplying
that result by 100.

### Example 4: Display progress for each level of a nested process

```powershell
$PSStyle.Progress.View = 'Classic'

foreach ( $i in 1..10 ) {
  Write-Progress -Id 0 "Step $i"
  foreach ( $j in 1..10 ) {
    Write-Progress -Id 1 -ParentId 0 "Step $i - Substep $j"
    foreach ( $k in 1..10 ) {
      Write-Progress -Id 2  -ParentId 1 "Step $i - Substep $j - iteration $k"
      Start-Sleep -Milliseconds 150
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

In this example you can use the **ParentId** parameter to have indented output to show parent-child
relationships in the progress of each step.

## PARAMETERS

### -Activity

Specifies the first line of text in the heading above the status bar. This text describes the
activity whose progress is being reported.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Completed

Indicates whether the progress bar is visible. If this parameter is omitted, `Write-Progress`
displays progress information.

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

Specifies the line of text below the progress bar in the `Classic` progress view. This text
describes the operation that's currently taking place. This parameter has no effect when the
progress view is set to `Minimal`.

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
are creating more than one progress bar in a single command. If the progress bars don't have
different IDs, they're superimposed instead of being displayed in a series. Negative values aren't
allowed.

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

Specifies the parent activity of the current activity. Use the value `-1` if the current activity
has no parent activity.

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

Specifies the percentage of the activity that's completed. Use the value `-1` if the percentage
complete is unknown or not applicable.

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

Specifies the projected number of seconds remaining until the activity is completed. Use the value
`-1` if the number of seconds remaining is unknown or not applicable.

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

Specifies the source of the record. You can use this in place of **Id** but can't be used with
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

Specifies the second line of text in the heading above the status bar. This text describes current
state of the activity.

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

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

If the progress bar doesn't appear, check the value of the `$ProgressPreference` variable. If the
value is set to `SilentlyContinue`, the progress bar isn't displayed. For more information about
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
