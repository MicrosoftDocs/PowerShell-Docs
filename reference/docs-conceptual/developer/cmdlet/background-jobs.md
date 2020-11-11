---
ms.date: 09/13/2016
ms.topic: reference
title: Background Jobs
description: Background Jobs
---
# Background Jobs

Cmdlets can perform their action internally or as a Windows PowerShell*background job*. When a cmdlet runs as a background job, the work is done asynchronously in its own thread separate from the pipeline thread that the cmdlet is using. From the user perspective, when a cmdlet runs as a background job, the command prompt returns immediately even if the job takes an extended amount of time to complete, and the user can continue without interruption while the job runs.

## Background Jobs, Child Jobs, and the Job Repository

The job object that is returned by the cmdlets that support background jobs defines the job. (The [Start-Job](/powershell/module/Microsoft.PowerShell.Core/Start-Job) cmdlet also returns a job object.) The name of the job, an identifier that is used to specify the job, the state information, and the child jobs are included in this definition. The job does not perform any of the work. Each background job has at least one child job because the child job performs the actual work. When you run a cmdlet so that the work is performed as a background job, the cmdlet must add the job and the child jobs to a common repository, referred to as the *job repository*.

For more information about how background jobs are handled at the command line, see the following:

- [about_Jobs](/powershell/module/microsoft.powershell.core/about/about_jobs)

- [about_Job_Details](/powershell/module/microsoft.powershell.core/about/about_job_details)

- [about_Remote_Jobs](/powershell/module/microsoft.powershell.core/about/about_remote_jobs)

## Writing a Cmdlet That Runs as a Background Job

To write a cmdlet that can be run as a background job, you must complete the following tasks:

- Define an `asJob` switch parameter so that the user can decide whether to run the cmdlet as a background job.

- Create an object that derives from the [System.Management.Automation.Job](/dotnet/api/System.Management.Automation.Job) class. This object can be a custom job object or a job object provided by Windows PowerShell, such as a [System.Management.Automation.Pseventjob](/dotnet/api/System.Management.Automation.PSEventJob) object.

- In a record processing method, add an `if` statement that detects whether the cmdlet should run as a background job.

- For custom job objects, implement the job class.

- Return the appropriate objects, depending on whether the cmdlet is run as a background job.

For a code example, see [How to Support Jobs](./how-to-support-jobs.md).

## Background Job-Related APIs

The following APIs are provided by Windows PowerShell to manage background jobs.

[System.Management.Automation.Job](/dotnet/api/System.Management.Automation.Job)
Derives custom job objects. This is an abstract class.

[System.Management.Automation.Jobrepository](/dotnet/api/System.Management.Automation.JobRepository)
Manages and provides information about the current active background jobs.

[System.Management.Automation.Jobstate](/dotnet/api/System.Management.Automation.JobState)
Defines the state of the background job. States include Started, Running, and Stopped.

[System.Management.Automation.Jobstateinfo](/dotnet/api/System.Management.Automation.JobStateInfo)
Provides information about the state of a background job and, if the last state change was caused by an error, the reason the job entered its current state.

[System.Management.Automation.Jobstateeventargs](/dotnet/api/System.Management.Automation.JobStateEventArgs)
Provides the arguments for an event that is raised when a background job changes state.

## Windows PowerShell Job Cmdlets

The following cmdlets are provided by Windows PowerShell to manage background jobs.

[Get-Job](/powershell/module/Microsoft.PowerShell.Core/Get-Job)

Gets Windows PowerShell background jobs that are running in the current session.

[Receive-Job](/powershell/module/Microsoft.PowerShell.Core/Receive-Job)

Gets the results of the Windows PowerShell background jobs in the current session.

[Remove-Job](/powershell/module/Microsoft.PowerShell.Core/Remove-Job)

Deletes a Windows PowerShell background job.

[Start-Job](/powershell/module/Microsoft.PowerShell.Core/Start-Job)

Starts a Windows PowerShell background job.

[Stop-Job](/powershell/module/Microsoft.PowerShell.Core/Stop-Job)

Stops a Windows PowerShell background job.

[Wait-Job](/powershell/module/Microsoft.PowerShell.Core/Wait-Job)

Suppresses the command prompt until one or all of the Windows PowerShell background jobs running in the session are complete.

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
