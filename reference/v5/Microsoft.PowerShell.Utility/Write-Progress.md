---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294031
schema: 2.0.0
---

# Write-Progress
## SYNOPSIS
Displays a progress bar within a Windows PowerShell command window.

## SYNTAX

```
Write-Progress [-Activity] <String> [[-Status] <String>] [[-Id] <Int32>] [-PercentComplete <Int32>]
 [-SecondsRemaining <Int32>] [-CurrentOperation <String>] [-ParentId <Int32>] [-Completed] [-SourceId <Int32>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Write-Progress cmdlet displays a progress bar in a Windows PowerShell command window that depicts the status of a running command or script.
You can select the indicators that the bar reflects and the text that appears above and below the progress bar.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>for ($i = 1; $i -le 100; $i++ )
{write-progress -activity "Search in Progress" -status "$i% Complete:" -percentcomplete $i;}
```

This command displays the progress of a For loop that counts from 1 to 100.
The Write-Progress command includes a status bar heading ("activity"), a status line, and the variable $i (the counter in the For loop), which indicates the relative completeness of the task.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>for($i = 1; $i -lt 101; $i++ )
{write-progress -activity Updating -status 'Progress->' -percentcomplete $i -currentOperation OuterLoop; `
for($j = 1; $j -lt 101; $j++ )
{write-progress -id  1 -activity Updating -status 'Progress' -percentcomplete $j -currentOperation InnerLoop} }

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

The Write-Progress command for the second progress bar includes the Id parameter that distinguishes it from the first progress bar.
Without the Id parameter, the progress bars would be superimposed on each other instead of being displayed one below the other.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$events = get-eventlog -logname system
PS C:\>$events | foreach-object -begin {clear-host;$i=0;$out=""} `
-process {if($_.message -like "*bios*") {$out=$out + $_.Message}; $i = $i+1;
write-progress -activity "Searching Events" -status "Progress:" -percentcomplete ($i/$events.count*100)} `
-end {$out}
```

This command displays the progress of a command to find the string "bios" in the System event log.

In the first line of the command, the Get-EventLog cmdlet gets the events in the System log and stores them in the $events variable.

In the second line, the events are piped to the ForEach-Object cmdlet.
Before processing begins, the Clear-Host cmdlet is used to clear the screen, the $i counter variable is set to zero, and the $out output variable is set to the empty string.

In the third line, which is the Process script block of the ForEach-Object cmdlet, the cmdlet searches the message property of each incoming object for "bios".
If the string is found, the message is added to $out.
Then, the $i counter variable is incremented to record that another event has been examined.

The fourth line uses the Write-Progress cmdlet with values for the Activity and Status text fields that create the first and second lines of the progress bar heading, respectively.
The PercentComplete parameter value is calculated by dividing the number of events that have been processed ($i) by the total number of events retrieved ($events.count) and then multiplying that result by 100.

In the last line, the End parameter of the ForEach-Object cmdlet is used to display the messages that are stored in the $out variable.

## PARAMETERS

### -Activity
Specifies the first line of text in the heading above the status bar.
This text describes the activity whose progress is being reported.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentId
Identifies the parent activity of the current activity.
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
Identifies the source of the record.

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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
Write-Progress does not generate any output.

## NOTES
If the progress bar does not appear, check the value of the $ProgressPreference variable.
If the value is set to SilentlyContinue, the progress bar is not displayed.
For more information about Windows PowerShell preferences, see about_Preference_Variables.

The parameters of the cmdlet correspond to the properties of the ProgressRecord class (System.Management.Automation.ProgressRecord).
For more information, see the ProgressRecord topic in the Windows PowerShell Software Development Kit (SDK).

## RELATED LINKS

[Write-Debug]()

[Write-Error]()

[Write-Host]()

[Write-Output]()

[Write-Verbose]()

[Write-Warning]()

