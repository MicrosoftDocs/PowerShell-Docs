---
title: Displaying progress while multi-threading
description: How to use Write-Progress across multiple threads with Foreach-Object -Parallel
ms.date: 08/02/2020
---

# Writing Progress across multiple threads with Foreach Parallel

Starting in PowerShell 7.0, the ability to work in multiple threads simultaneously is possible using
the **Parallel** parameter in the
[Foreach-Object](/powershell/module/Microsoft.PowerShell.Core/Foreach-Object) cmdlet. Monitoring the
progress of these threads can be a challenge though. Normally, you can monitor the progress of a
process using [Write-Progress](/powershell/module/Microsoft.PowerShell.Utility/Write-Progress).
However, since PowerShell uses a separate runspace for each thread when using **Parallel**,
reporting the progress back to the host isn't as straight forward as normal use of `Write-Progress`.

## Using a synced hashtable to track progress

When writing the progress from multiple threads, tracking becomes difficult because when running
parallel processes in PowerShell, each process has it's own runspace. To get around this, you can
use a [synchronized hashtable](/dotnet/api/system.collections.hashtable.synchronized). A synced
hashtable is a thread safe data structure that can be modified by multiple threads simultaneously
without throwing an error.

### Set up

One of the downsides to this approach is it takes a, somewhat, complex set up to ensure everything
runs without error.

```powershell
$dataset = @(
    @{
        Id   = 1
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 2
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 3
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 4
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 5
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
)

# Create a hashtable for process.
# Keys should be ID's of the processes
$origin = @{}
$dataset | Foreach-Object {$origin.($_.id) = @{}}

# Create synced hashtable
$sync = [System.Collections.Hashtable]::Synchronized($origin)
```

This section creates three different data structures, for three different purposes.

The `$dataSet` variable stores an array of hashtables that is used to coordinate the next steps
without the risk of being modified. If an object collection is modified while iterating through the
collection, PowerShell throws an error. You must keep the object collection in the loop separate
from the objects being modified. The `Id` key in each hashtable is the identifier for a mock
process. The `Wait` key simulates the workload of each mock process being tracked.

The `$origin` variable stores a nested hashtable with each key being one of the mock process id's.
Then, it is used to hydrate the synchronized hashtable stored in the `$sync` variable. The `$sync`
variable is responsible for reporting the progress back to the parent runspace, which displays the
progress.

### Running the processes

This section runs the multi-threaded processes and creates some of the output used to display
progress.

```powershell
$job = $dataset | Foreach-Object -ThrottleLimit 3 -AsJob -Parallel {
    $syncCopy = $using:sync
    $process = $syncCopy.$($PSItem.Id)

    $process.Id = $PSItem.Id
    $process.Activity = "Id $($PSItem.Id) starting"
    $process.Status = "Processing"

    # Fake workload start up that takes x amount of time to complete
    start-sleep -Milliseconds ($PSItem.wait*5)

    # Process. update activity
    $process.Activity = "Id $($PSItem.id) processing"
    foreach ($percent in 1..100)
    {
        # Update process on status
        $process.Status = "Handling $percent/100"
        $process.PercentComplete = (($percent / 100) * 100)

        # Fake workload that takes x amount of time to complete
        Start-Sleep -Milliseconds $PSItem.Wait
    }

    # Mark process as completed
    $process.Completed = $true
}
```

The mock processes are sent to `Foreach-Object` and started as jobs. The **ThrottleLimit** is set to
**3** to highlight running multiple processes in a queue. The jobs are stored in the `$job` variable
and allows us to know when all the processes have finished later on.

When using the `using:` statement to reference a parent scope variable in PowerShell, you can't use
expressions to make it dynamic. For example, if you tried to create the `$process` variable like
this, `$process = $using:sync.$($PSItem.id)`, you would get an error stating you can't use
expressions there. So, we create the `$syncCopy` variable to be able to reference and modify the
`$sync` variable without the risk of it failing.

Next, we build out a hashtable to represent the progress of the process currently in the loop using
the `$process` variable by referencing the synchronized hashtable keys. The **Activity** and the
**Status** keys are used as parameter values for `Write-Progress` to display the status of a given
mock process in the next section.

The `foreach` loop is just a way to simulate the process working and is randomized based on the
`$dataSet` **Wait** attribute to set `Start-Sleep` using milliseconds. How you calculate the
progress of your process may vary.

### Displaying the progress of multiple processes

Now that the mock processes are running as jobs, we can start to write the processes progress to the
PowerShell window.

```powershell
while($job.State -eq 'Running')
{
    $sync.Keys | Foreach-Object {
        # If key is not defined, ignore
        if(![string]::IsNullOrEmpty($sync.$_.keys))
        {
            # Create parameter hashtable to splat
            $param = $sync.$_

            # Execute Write-Progress
            Write-Progress @param
        }
    }

    # Wait to refresh to not overload gui
    Start-Sleep -Seconds 0.1
}
```

The `$job` variable contains the parent **job** and has a child **job** for each of the mock
processes. While any of the child jobs are still running, the parent job **State** will remain
"Running". This allows us to use the `while` loop to continually update the progress of
every process until all processes are finished.

Within the while loop, we loop through each of the keys in the `$sync` variable. Since this is
a synchronized hashtable, it is constantly updated but can still be accessed without throwing any
errors.

There is a check to ensure that the process being reported is actually running using the
`IsNullOrEmpty()` method. If the process hasn't been started, the loop won't report on it and move
on to the next until it gets to a process that has been started. If the process is started, the
hashtable from the current key is used to splat the parameters to `Write-Progress`.

### Full example

```powershell
# Example workload
$dataset = @(
    @{
        Id   = 1
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 2
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 3
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 4
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
    @{
        Id   = 5
        Wait = 3..10 | get-random | Foreach-Object {$_*100}
    }
)

# Create a hashtable for process.
# Keys should be ID's of the processes
$origin = @{}
$dataset | Foreach-Object {$origin.($_.id) = @{}}

# Create synced hashtable
$sync = [System.Collections.Hashtable]::Synchronized($origin)

$job = $dataset | Foreach-Object -ThrottleLimit 3 -AsJob -Parallel {
    $syncCopy = $using:sync
    $process = $syncCopy.$($PSItem.Id)

    $process.Id = $PSItem.Id
    $process.Activity = "Id $($PSItem.Id) starting"
    $process.Status = "Processing"

    # Fake workload start up that takes x amount of time to complete
    start-sleep -Milliseconds ($PSItem.wait*5)

    # Process. update activity
    $process.Activity = "Id $($PSItem.id) processing"
    foreach ($percent in 1..100)
    {
        # Update process on status
        $process.Status = "Handling $percent/100"
        $process.PercentComplete = (($percent / 100) * 100)

        # Fake workload that takes x amount of time to complete
        Start-Sleep -Milliseconds $PSItem.Wait
    }

    # Mark process as completed
    $process.Completed = $true
}

while($job.State -eq 'Running')
{
    $sync.Keys | Foreach-Object {
        # If key is not defined, ignore
        if(![string]::IsNullOrEmpty($sync.$_.keys))
        {
            # Create parameter hashtable to splat
            $param = $sync.$_

            # Execute Write-Progress
            Write-Progress @param
        }
    }

    # Wait to refresh to not overload gui
    Start-Sleep -Seconds 0.1
}
```

## Related Links

- [about_Jobs](/powershell/module/Microsoft.PowerShell.Core/About/about_Jobs)
- [about_Scopes](/powershell/module/Microsoft.PowerShell.Core/About/about_Scopes)
- [about_Splatting](/powershell/module/Microsoft.PowerShell.Core/About/about_Splatting)
