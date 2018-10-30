---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=210611
external help file:  System.Management.Automation.dll-Help.xml
title:  Resume-Job
---
# Resume-Job

## SYNOPSIS

Restarts a suspended job

## SYNTAX

### SessionIdParameterSet (Default)

```
Resume-Job [-Wait] [-Id] <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### JobParameterSet

```
Resume-Job [-Job] <Job[]> [-Wait] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameParameterSet

```
Resume-Job [-Wait] [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceIdParameterSet

```
Resume-Job [-Wait] [-InstanceId] <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StateParameterSet

```
Resume-Job [-Wait] [-State] <JobState> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### FilterParameterSet

```
Resume-Job [-Wait] [-Filter] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Resume-Job** cmdlet resumes a workflow job that was suspended, such as by using the Suspend-Job cmdlet or the [about_Suspend-Workflow](../PSWorkflow/About/about_Suspend-Workflow.md) activity.
When a workflow job is resumed, the job engine reconstructs the state, metadata, and output from saved resources, such as checkpoints, so the job is restarted without any loss of state or data.
The job state is changed from **Suspended** to **Running**.

Use the parameters of **Resume-Job** to select jobs by name, ID, instance ID or pipe a job object, such as one returned by the Get-Job cmdlet, to **Resume-Job**.
You can also use a property filter to select a job to be resumed.

By default, **Resume-Job** returns immediately, even though all jobs might not yet be resumed.
To suppress the command prompt until all specified jobs are resumed, use the **Wait** parameter.

The **Resume-Job** cmdlet works only on custom job types, such as workflow jobs.
It does not work on standard background jobs, such as those that are started by using the Start-Job cmdlet.
If you submit a job of an unsupported type, **Resume-Job** generates a terminating error and stops running.

To identify a workflow job, look for a value of **PSWorkflowJob** in the **PSJobTypeName** property of the job.
To determine whether a particular custom job type supports the **Resume-Job** cmdlet, see the help topics for the custom job type.

NOTE: Before using a Job cmdlet on a custom job type, import the module that supports the custom job type, either by using the Import-Module cmdlet or getting or using a cmdlet in the module.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Resume a job by ID

```
The first command uses the **Get-Job** cmdlet to get the job. The output shows that the job is a suspended workflow job.
PS> Get-Job EventJob
Id     Name            PSJobTypeName   State         HasMoreData     Location   Command
--     ----            -------------   -----         -----------     --------   -------
4      EventJob        PSWorkflowJob   Suspended     True            Server01   \\Script\Share\Event.ps1

The second command uses the **Id** parameter of the **Resume-Job** cmdlet to resume the job with an **Id** value of 4.
PS> Resume-Job -Id 4
```

The commands in this example verify that the job is a suspended workflow job and then resume the job.

### Example 2: Resume a job by name

```
PS> Resume-Job -Name WorkflowJob, InventoryWorkflow, WFTest*
```

This command uses the **Name** parameter to resume several workflow jobs on the local computer.

### Example 3: Use custom property values

```
PS> Resume-Job -Filter @{CustomID="T091291"} -State Suspended
```

This command uses the value of a custom property to identify the workflow job to resume.
It uses the **Filter** parameter to identify the workflow job by its **CustomID** property.
It also uses the **State** parameter to verify that the workflow job is suspended, before it tries to resume it.

### Example 4: Resume all suspended jobs on a remote computer

```
PS> Invoke-Command -ComputerName Srv01 -ScriptBlock {Get-Job -State Suspended | Resume-Job}
```

This command resumes all suspended jobs on the Srv01 remote computer.

The command uses the Invoke-Command cmdlet to run a command on the Srv01 computer.
The remote command uses the **State** parameter of the Get-Job cmdlet to get all suspended jobs on the computer.
A pipeline operator (|) sends the suspended jobs to the **Resume-Job** cmdlet, which resumes them.

### Example 5: Wait for jobs to resume

```
PS> Resume-Job -Name WorkflowJob, InventoryWorkflow, WFTest* -Wait
```

This command uses the **Wait** parameter to direct Resume-Job to return only after all specified jobs are resumed.
The **Wait** parameter is especially useful in scripts that assume that jobs are resumed before the script continues.

### Example 6: Resume a Workflow that Suspends Itself

```
This code sample shows the **Suspend-Workflow** activity in a workflow.
#SampleWorkflow
Workflow Test-Suspend
{
    $a = Get-Date
    Suspend-Workflow
    (Get-Date)- $a
}

The following command runs the Test-Suspend workflow on the Server01 computer.When you run the workflow, the workflow runs the Get-Date activity and saves the result in the $a variable. Then it runs the **Suspend-Workflow** activity. In response, it takes a checkpoint, suspends the workflow, and returns a workflow job object. **Suspend-Workflow** returns a workflow job object even if the workflow is not explicitly run as a job.
PS> Test-Suspend -PSComputerName Server01
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command

--     ----            -------------   -----         -----------     --------             -------

8      Job8            PSWorkflowJob   Suspended     True            Server01             Test-Suspend

The following command resumes the Test-Suspend workflow in Job8. It uses the **Wait** parameter to hold the command prompt until the job is resumed.
PS> Resume-Job -Name Job8 -Wait
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command

--     ----            -------------   -----         -----------     --------             -------

8      Job8            PSWorkflowJob   Running       True            Server01             Test-Suspend

This command uses the **Receive-Job** cmdlet to get the results of the Test-Suspend workflow. The final command in the workflow returns a TimeSpan object that represents the elapsed time between the current date and time and the date and time that was saved in the $a variable before the workflow was suspended.
PS> Receive-Job -Name Job8
        Days              : 0

        Hours             : 0

        Minutes           : 0

        Seconds           : 19

        Milliseconds      : 823

        Ticks             : 198230041

        TotalDays         : 0.000229432917824074

        TotalHours        : 0.00550639002777778

        TotalMinutes      : 0.330383401666667

        TotalSeconds      : 19.8230041

        TotalMilliseconds : 19823.0041

        PSComputerName    : Server01
```

The Resume-Job cmdlet lets you resume a workflow job that was suspend by using the **Suspend-Workflow** activity.
This activity suspends a workflow from within a workflow.
It is valid only in workflows.

For information about the Suspend-Workflow, see [about_Suspend-Workflow](../PSWorkflow/About/about_Suspend-Workflow.md).

## PARAMETERS

### -Filter

Resumes only jobs that satisfy all of the conditions established in the associated hash table.
Enter a hash table where the keys are job properties and the values are job property values.

```yaml
Type: Hashtable
Parameter Sets: FilterParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id

Resumes the jobs with the specified IDs.

The ID is an integer that uniquely identifies the job within the current session.
It is easier to remember and to type than the instance ID, but it is unique only within the current session.
You can type one or more IDs (separated by commas).
To find the ID of a job, use the Get-Job cmdlet.

```yaml
Type: Int32[]
Parameter Sets: SessionIdParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Resumes jobs with the specified instance IDs.
The default is all jobs.

An instance ID is a GUID that uniquely identifies the job on the computer.
To find the instance ID of a job, use the Get-Job cmdlet.

```yaml
Type: Guid[]
Parameter Sets: InstanceIdParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Job

Specifies the jobs to be resumed.
Enter a variable that contains the jobs or a command that gets the jobs.
You can also pipe jobs to the **Resume-Job** cmdlet.

```yaml
Type: Job[]
Parameter Sets: JobParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name

Resumes jobs with the specified friendly names.
Enter one or more job names.
Wildcards are supported.

```yaml
Type: String[]
Parameter Sets: NameParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State

Resumes only those jobs in the specified state.
Valid values are NotStarted, Running, Completed, Failed, Stopped, Blocked, Suspended, Disconnected, Suspending, and Stopping, but **Resume-Job** resumes only jobs in the **Suspended** state.

For more information about job states, see [JobState Enumeration](/dotnet/api/system.management.automation.jobstate) in the MSDN library.

```yaml
Type: JobState
Parameter Sets: StateParameterSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Wait

Suspends the command prompt until all specified jobs are resumed.
By default, Resume-Job returns immediately.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.Job

You can pipe all types of jobs to **Resume-Job**.
However, if **Resume-Job** gets a job of an unsupported type, it throws a terminating error.

## OUTPUTS

### None or System.Management.Automation.Job

If you use the **PassThru** parameter, **Resume-Job** returns the jobs that it tried to resume.
Otherwise, this cmdlet does not generate any output.

## NOTES

- **Resume-Job** can only resume jobs that are suspended. If you submit a job in a different state, **Resume-Job** runs the resume operation on the job, but generates a warning to notify you that the job could not be resumed. To suppress the warning, use the **WarningAction** common parameter with a value of **SilentlyContinue**.
- If a job is not of a type that supports resuming, such as a workflow job (PSWorkflowJob), **Resume-Job** throws a terminating error.
- The mechanism and location for saving a suspended job might vary depending on the job type. For example, suspended workflow jobs are saved in a flat file store by default, but can also be saved in a SQL database.
- When you resume a job, the job state changes from **Suspended** to **Running**. To find the jobs that are running, including those that were resumed by this cmdlet, use the **State** parameter of the Get-Job cmdlet to get jobs in the **Running** state.
- Some job types have options or properties that prevent Windows PowerShell from suspending the job. If attempts to suspend the job fail, verify that the job options and properties allow suspending.

## RELATED LINKS

[Get-Job](Get-Job.md)

[Receive-Job](Receive-Job.md)

[Remove-Job](Remove-Job.md)

[Resume-Job](Resume-Job.md)

[Start-Job](Start-Job.md)

[Stop-Job](Stop-Job.md)

[Suspend-Job](Suspend-Job.md)

[Wait-Job](Wait-Job.md)