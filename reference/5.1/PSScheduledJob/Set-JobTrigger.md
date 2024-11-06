---
external help file: Microsoft.PowerShell.ScheduledJob.dll-Help.xml
Locale: en-US
Module Name: PSScheduledJob
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/psscheduledjob/set-jobtrigger?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-JobTrigger
---

# Set-JobTrigger

## SYNOPSIS
Changes the job trigger of a scheduled job.

## SYNTAX

```
Set-JobTrigger [-InputObject] <ScheduledJobTrigger[]> [-DaysInterval <Int32>] [-WeeksInterval <Int32>]
 [-RandomDelay <TimeSpan>] [-At <DateTime>] [-User <String>] [-DaysOfWeek <DayOfWeek[]>] [-AtStartup]
 [-AtLogOn] [-Once] [-RepetitionInterval <TimeSpan>] [-RepetitionDuration <TimeSpan>] [-RepeatIndefinitely]
 [-Daily] [-Weekly] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION

The `Set-JobTrigger` cmdlet changes the properties of the job triggers of scheduled jobs. You can
use it to change the time or frequency at which the jobs start or to change from a time-based
schedules to schedules that are triggered by a logon or startup.

A job trigger defines a recurring schedule or conditions for starting a scheduled job. Although job
triggers are not saved to disk, you can change the job triggers of scheduled jobs, which are saved
to disk.

To change a job trigger of a scheduled job, begin by using the `Get-JobTrigger` cmdlet to get the
job trigger of a scheduled job. Then, pipe the trigger to `Set-JobTrigger` or save the trigger in a
variable and use the **InputObject** parameter of `Set-JobTrigger` cmdlet to identify the trigger.
Use the remaining parameters of `Set-JobTrigger` to change the job trigger.

When you change the type of a job trigger, such as changing a job trigger from a daily or weekly
trigger to an **AtLogon** trigger, the original trigger properties are deleted. However, if you
change the values of the trigger, but not its type, such as changing the days in a weekly trigger,
only the properties that you specify are changed. All other properties of the original job trigger
are retained.

`Set-JobTrigger` is one of a collection of job scheduling cmdlets in the PSScheduledJob module that
is included in Windows PowerShell.

For more information about Scheduled Jobs, see the About topics in the PSScheduledJob module. Import
the PSScheduledJob module and then type: `Get-Help about_Scheduled*` or see
[about_Scheduled_Jobs](About/about_Scheduled_Jobs.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Change the days in a job trigger

This example shows how to change the days in a weekly job trigger.

```powershell
Get-JobTrigger -Name "DeployPackage"
```

```Output
Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          Weekly          9/29/2011 12:00:00 AM  {Wednesday, Saturday}   True
```

```powershell
Get-JobTrigger -Name "DeployPackage" | Set-JobTrigger -DaysOfWeek "Wednesday", "Sunday" -PassThru
```

```Output
Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          Weekly          9/29/2011 12:00:00 AM  {Wednesday, Sunday}     True
```

The first command uses the `Get-JobTrigger` cmdlet to get the job trigger of the `DeployPackage`
scheduled job. The output shows that the trigger starts the job at midnight on Wednesdays and
Saturdays.

The second command uses the `Get-JobTrigger` cmdlet to get the job trigger of the `DeployPackage`
scheduled job. A pipeline operator (`|`) sends the trigger to the `Set-JobTrigger` cmdlet, which
changes the job trigger so that it starts the `DeployPackage` job on Wednesdays and Sundays. The
command uses the **PassThru** parameter to return the trigger after the change.

This command is not required; it is included only to show the effect of the trigger change.

### Example 2: Change the job trigger type

This example shows how to change the type of job trigger that starts a job. The commands in this
example replace an `AtStartup` job trigger with a weekly trigger.

```powershell
Get-JobTrigger -Name "Inventory"
```

```Output
Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          Daily           9/27/2011 11:00:00 PM                          True
2          AtStartup                                                      True
```

```powershell
Get-JobTrigger -Name "Inventory" -TriggerID 2 | Set-JobTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Monday -At "12:00 AM"
```

```Output
Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          Daily           9/27/2011 11:00:00 PM                          True
2          Weekly          10/31/2011 12:00:00 AM {Monday}                True
```

The first command uses the `Get-JobTrigger` cmdlet to get the job trigger of the `Inventory`
scheduled job. The output shows that the job has two triggers a daily trigger and an **AtStartup**
trigger.

The second command uses the `Get-JobTrigger` cmdlet to get the **AtStartup** job trigger of the
`Inventory` job. The command uses the **TriggerID** parameter to identify the job trigger. A
pipeline operator (`|`) sends the job trigger to the `Set-JobTrigger` cmdlet, which changes it to a
weekly job trigger that runs every four weeks on Monday at midnight. The command uses the
**PassThru** parameter to return the trigger after the change.

This command is not required; it is included only to show the effect of the trigger change.

### Example 3: Change the user on a remote job trigger

```powershell
Invoke-Command -ComputerName "Server01" -ScriptBlock {Get-ScheduledJob | Get-JobTrigger | Where-Object {$_.User} | Set-JobTrigger -User "Domain01/Admin02"}
```

This command changes the user in all **AtLogon** job triggers of scheduled jobs on the Server01
computer.

The command uses the `Invoke-Command` cmdlet to run a command on the Server01 computer.

The remote command begins with a `Get-ScheduledJob` command that gets all scheduled jobs on the
computer. The scheduled jobs are piped to the `Get-JobTrigger` cmdlet, which gets the job triggers
of the scheduled jobs. Each job trigger contains a **JobDefinition** property that contains the
scheduled job, so the trigger remains associated with the scheduled job even when it is changed.

The job triggers are piped to the `Where-Object` cmdlet, which gets job triggers that have the
**User** property. The selected job triggers are piped to the `Set-JobTrigger` cmdlet, which changes
the user to `Domain01\Admin02`.

### Example 4: Change one of many job triggers

```powershell
Get-JobTrigger -Name "SecurityCheck"
```

```Output
Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          Daily           4/24/2013 3:00:00 AM                           True
2          Weekly          4/24/2013 4:00:00 PM   {Sunday}                True
3          Once            4/24/2013 4:00:00 PM                           True
```

```powershell
Get-JobTrigger -Name "SecurityCheck" -TriggerID 3 | Format-List -Property *
```

```Output
At                 : 4/24/2012 4:00:00 PM
DaysOfWeek         :
Interval           : 1
Frequency          : Once
RandomDelay        : 00:00:00
RepetitionInterval : 01:00:00
RepetitionDuration : 1.00:00:00
User               :
Id                 : 3
Enabled            : True
JobDefinition      : Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
```

```powershell
Get-JobTrigger -Name "SecurityCheck" -TriggerId 3 | Set-JobTrigger -RepetitionInterval (New-TimeSpan -Minutes 90)
Get-JobTrigger -Name "SecurityCheck" -TriggerID 3 | Format-List -Property *
```

```Output
At                 : 4/24/2012 4:00:00 PM
DaysOfWeek         :
Interval           : 1
Frequency          : Once
RandomDelay        : 00:00:00
RepetitionInterval : 01:30:00
RepetitionDuration : 1.00:00:00
User               :
Id                 : 3
Enabled            : True
JobDefinition      : Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
```

The commands in this example changes the repetition interval of the **Once** job trigger of
`SecurityCheck` scheduled job from every 60 minutes to every 90 minutes. The `SecurityCheck`
scheduled job has three job triggers, so the commands use the **TriggerId** parameter of the
`Get-JobTrigger` cmdlet to identify the job trigger that is being changed.

The first command uses the `Get-JobTrigger` cmdlet to get all job triggers of the `SecurityCheck`
scheduled job. The output, which displays the IDs of the job triggers, reveals that the **Once** job
trigger has an **ID** of `3`.

The second command uses the **TriggerID** parameter of the `Get-JobTrigger` cmdlet to get the
**Once** trigger of the `SecurityCheck` scheduled job. The command pipes the trigger to the
`Format-List` cmdlet, which displays all of the properties of the **Once** job trigger. The output
shows that the trigger starts the job once every hour (**RepetitionInterval** is 1 hour) for one day
(**RepetitionDuration** is 1 day).

The third command changes the repetition interval of the job trigger from one hour to 90 minutes.
The command does not return any output.

The fourth command displays the effect of the change.The output shows that the trigger starts the
job once every 90 minutes (**RepetitionInterval** is 1 hour, 30 minutes) for one day
(**RepetitionDuration** is 1 day).

## PARAMETERS

### -At

Starts the job at the specified date and time. Enter a **DateTime** object, such as one that the
`Get-Date` cmdlet returns, or a string that can be converted to a time, such as
`April 19, 2012 15:00`, `12/31/2013 9:00 PM`, or `3am`.

If you don't specify an element of the **DateTime** object, such as seconds, that element of the job
trigger is not changed. If the original job trigger didn't include a **DateTime** object and you
omit an element, the job trigger is created with the corresponding element from the current date and
time.

When using the **Once** parameter, set the value of the **At** parameter to a particular date and
time. Because the default date in a **DateTime** object is the current date, setting a time before
the current time without an explicit date results in a job trigger for a time in the past.

**DateTime** objects, and strings that are converted to **DateTime** objects, are automatically
adjusted to be compatible with the date and time formats selected for the local computer in Region
and Language in Control Panel.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AtLogOn

Starts the scheduled job when the specified users log on to the computer. To specify a user, use the
**User** parameter.

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

### -AtStartup

Starts the scheduled job when Windows starts.

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

### -Daily

Specifies a recurring daily job schedule. Use the other parameters in the **Daily** parameter set to
specify the schedule details.

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

### -DaysInterval

Specifies the number of days between occurrences on a daily schedule. For example, a value of `3`
starts the scheduled job on days `1`, `4`, `7` and so on. The default value is `1`.

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

### -DaysOfWeek

Specifies the days of the week on which a weekly scheduled job runs. Enter day names, such as
`Monday`, `Thursday`, integers `0`-`6`, where `0` represents Sunday, or an asterisk (`*`) to
represent every day. This parameter is required in the **Weekly** parameter set.

Day names are converted to their integer values in the job trigger. When you enclose day names in
quotation marks in a command, enclose each day name in separate quotation marks, such as
`"Monday", "Tuesday"`. If you enclose multiple day names in a single quotation mark pair, the
corresponding integer values are summed. For example, `"Monday, Tuesday"` (`1 + 2`) results in a
value of `Wednesday` (`3`).

```yaml
Type: System.DayOfWeek[]
Parameter Sets: (All)
Aliases:
Accepted values: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the job triggers. Enter a variable that contains **ScheduledJobTrigger** objects or type a
command or expression that gets **ScheduledJobTrigger** objects, such as a `Get-JobTrigger` command.
You can also pipe a **ScheduledJobTrigger** object to `Set-JobTrigger`.

If you specify multiple job triggers, `Set-JobTrigger` makes the same changes to all job triggers.

```yaml
Type: Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Once

Specifies a non-recurring (one time) schedule.

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

### -PassThru

Returns the job triggers that changed. By default, this cmdlet does not generate any output.

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

### -RandomDelay

Enables a random delay that begins at the scheduled start time, and sets the maximum delay value.
The length of the delay is set pseudo-randomly for each start and varies from no delay to the time
specified by the value of this parameter. The default value, zero (`00:00:00`), disables the random
delay.

Enter a timespan object, such as one returned by the `New-TimeSpan` cmdlet, or enter a value in
`<hours>:<minutes>:<seconds>` format, which is automatically converted to a timespan object.

```yaml
Type: System.TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepeatIndefinitely

This parameter, available starting in Windows PowerShell 4.0, eliminates the necessity of specifying
a **TimeSpan.MaxValue** value for the **RepetitionDuration** parameter to run a scheduled job
repeatedly, for an indefinite period.

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

### -RepetitionDuration

Repeats the job until the specified time expires. The repetition frequency is determined by the
value of the **RepetitionInterval** parameter. For example, if the value of **RepetitionInterval**
is 5 minutes and the value of **RepetitionDuration** is 2 hours, the job is triggered every five
minutes for two hours.

Enter a timespan object, such as one that the `New-TimeSpan` cmdlet returns or a string that can be
converted to a timespan object, such as `1:05:30`.

To run a job indefinitely, add the **RepeatIndefinitely** parameter instead.

To stop a job before the job trigger repetition duration expires, set the **RepetitionDuration**
value to zero (`0`).

To change the repetition duration or repetition interval of a **Once** job trigger, the command must
include both the **RepetitionInterval** and **RepetitionDuration** parameters. To change the
repetition duration or repetition intervals of other types of job triggers, the command must include
the **Once**, **At**, **RepetitionInterval** and **RepetitionDuration** parameters.

```yaml
Type: System.TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepetitionInterval

Repeats the job at the specified time interval. For example, if the value of this parameter is 2
hours, the job is triggered every two hours. The default value, `0`, does not repeat the job.

Enter a timespan object, such as one that the `New-TimeSpan` cmdlet returns or a string that can be
converted to a timespan object, such as `1:05:30`.

To change the repetition duration or repetition interval of a **Once** job trigger, the command must
include both the **RepetitionInterval** and **RepetitionDuration** parameters. To change the
repetition duration or repetition intervals of other types of job triggers, the command must include
the **Once**, **At**, **RepetitionInterval** and **RepetitionDuration** parameters.

```yaml
Type: System.TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -User

Specifies the users who trigger an **AtLogon** start of a scheduled job. Enter the name of a user in
`<UserName>` or `<Domain>\<Username>` format or enter an asterisk (`*`) to represent all users. The
default value is all users.

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

### -Weekly

Specifies a recurring weekly job schedule. Use the other parameters in the **Weekly** parameter set
to specify the schedule details.

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

### -WeeksInterval

Specifies the number of weeks between occurrences on a weekly job schedule. For example, a value of
`3` starts the scheduled job on weeks `1`, `4`, `7` and so on. The default value is `1`.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger

You can pipe a job trigger to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### Microsoft.PowerShell.ScheduledJob.ScheduledJobTrigger

When you use the **PassThru** parameter, this cmdlet returns the job triggers that it changed.

## NOTES

- Job triggers have a **JobDefinition** property that associates them with the scheduled job. When
  you change the job trigger of a scheduled job, the job is changed. You do not need to use a
  `Set-ScheduledJob` command to apply the changed trigger to the scheduled job.

## RELATED LINKS

[Add-JobTrigger](Add-JobTrigger.md)

[Disable-JobTrigger](Disable-JobTrigger.md)

[Disable-ScheduledJob](Disable-ScheduledJob.md)

[Enable-JobTrigger](Enable-JobTrigger.md)

[Enable-ScheduledJob](Enable-ScheduledJob.md)

[Get-JobTrigger](Get-JobTrigger.md)

[Get-ScheduledJob](Get-ScheduledJob.md)

[Get-ScheduledJobOption](Get-ScheduledJobOption.md)

[New-JobTrigger](New-JobTrigger.md)

[New-ScheduledJobOption](New-ScheduledJobOption.md)

[Register-ScheduledJob](Register-ScheduledJob.md)

[Remove-JobTrigger](Remove-JobTrigger.md)

[Set-JobTrigger](Set-JobTrigger.md)

[Set-ScheduledJob](Set-ScheduledJob.md)

[Set-ScheduledJobOption](Set-ScheduledJobOption.md)

[Unregister-ScheduledJob](Unregister-ScheduledJob.md)
