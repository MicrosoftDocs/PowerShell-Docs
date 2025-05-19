---
description: The article discusses the performance characteristics of parallel execution to help you choose the best approach for your code.
ms.date: 05/15/2025
title: Optimize performance using parallel execution
---
# Optimize performance using parallel execution

PowerShell provides several options for the creation of parallel invocations.

- `Start-Job` runs each job in a separate process, each with a new instance of PowerShell. In many
  cases, a linear loop is faster. Also, serialization and deserialization can limit the usefulness
  of the objects returned. This command is built in to all versions of PowerShell.
- `Start-ThreadJob` is a cmdlet found in the **ThreadJob** module. This command uses PowerShell
  runspaces to create and manage thread-based jobs. These jobs are lighter-weight than the jobs
  created by `Start-Job` and avoid potential loss of type fidelity required by cross-process
  serialization and deserialization. The **ThreadJob** module comes with PowerShell 7 and higher.
  For Windows PowerShell 5.1, you can install this module from the PowerShell Gallery.
- Use the **System.Management.Automation.Runspaces** namespace from the PowerShell SDK to create
  your own parallel logic. Both `ForEach-Object -Parallel` and `Start-ThreadJob` use PowerShell
  runspaces to execute the code in parallel.
- Workflows are a feature of Windows PowerShell 5.1. Workflows aren't available in PowerShell 7.0
  and higher. Workflows are a special type of PowerShell script that can run in parallel. They're
  designed for long-running tasks and can be paused and resumed. Workflows aren't recommended for
  new development. For more information, see [about_Workflows][02].
- `ForEach-Object -Parallel` is a feature of PowerShell 7.0 and higher. Like `Start-ThreadJob`, it
  uses PowerShell runspaces to create and manage thread-based jobs. This command is designed for use
  in a pipeline.

## Limit execution concurrency

Running scripts in parallel doesn't guarantee improved performance. For example, the following
scenarios can benefit from parallel execution:

- Compute intensive scripts on multi-threaded multi-core processors
- Scripts that spend time waiting for results or doing file operations, as long as those operations
  don't block each other.

It's important to balance the overhead of parallel execution with the type of work done. Also, there
are limits to the number of invocations that can run in parallel.

The `Start-ThreadJob` and `ForEach-Object -Parallel` commands have a **ThrottleLimit** parameter to
limit the number of jobs running at one time. As more jobs are started, they're queued and wait
until the current number of jobs drops below the throttle limit. As of PowerShell 7.1,
`ForEach-Object -Parallel` reuses runspaces from a runspace pool by default. The **ThrottleLimit**
parameter sets the runspace pool size. The default runspace pool size is 5. You can still create a
new runspace for each iteration using the UseNewRunspace switch.

The `Start-Job` command doesn't have a **ThrottleLimit** parameter. You have to manage the number of
jobs running at one time.

## Measure performance

The following function, `Measure-Parallel`, compares the speed of the following parallel execution
approaches:

- `Start-Job` - creates a child PowerShell process behind the scenes
- `Start-ThreadJob` - runs each job in a separate thread
- `ForEach-Object -Parallel` - runs each job in a separate thread
- `Start-Process` - invokes an external program asynchronously

   > [!NOTE]
   > This approach only makes sense if your parallel tasks only consist of a single call to an
   > external program, as opposed to running a block of PowerShell code. Also, the only way to
   > capture output with this approach is by redirecting to a file.

```powershell
function Measure-Parallel {
    [CmdletBinding()]
    param(
        [ValidateRange(2, 2147483647)]
        [int] $BatchSize = 5,

        [ValidateSet('Job', 'ThreadJob', 'Process', 'ForEachParallel', 'All')]
        [string[]] $Approach,

        # pass a higher count to run multiple batches
        [ValidateRange(2, 2147483647)]
        [int] $JobCount = $BatchSize
    )

    $noForEachParallel = $PSVersionTable.PSVersion.Major -lt 7
    $noStartThreadJob = -not (Get-Command -ErrorAction Ignore Start-ThreadJob)

    # Translate the approach arguments into their corresponding hashtable keys (see below).
    if ('All' -eq $Approach) { $Approach = 'Job', 'ThreadJob', 'Process', 'ForEachParallel' }
    $approaches = $Approach.ForEach({
            if ($_ -eq 'ForEachParallel') { 'ForEach-Object -Parallel' }
            else { $_ -replace '^', 'Start-' }
        })

    if ($noStartThreadJob) {
        if ($interactive -or $approaches -contains 'Start-ThreadJob') {
            Write-Warning "Start-ThreadJob is not installed, omitting its test."
            $approaches = $approaches.Where({ $_ -ne 'Start-ThreadJob' })
        }
    }
    if ($noForEachParallel) {
        if ($interactive -or $approaches -contains 'ForEach-Object -Parallel') {
            Write-Warning 'ForEach-Object -Parallel require PowerShell v7+, omitting its test.'
            $approaches = $approaches.Where({ $_ -ne 'ForEach-Object -Parallel' })
        }
    }

    # Simulated input: Create 'f0.zip', 'f1'.zip', ... file names.
    $zipFiles = 0..($JobCount - 1) -replace '^', 'f' -replace '$', '.zip'

    # Sample executables to run - here, the native shell is called to simply
    # echo the argument given.
    $exe = if ($env:OS -eq 'Windows_NT') { 'cmd.exe' } else { 'sh' }

    # The list of its arguments *as a single string* - use '{0}' as the placeholder
    # for where the input object should go.
    $exeArgList = if ($env:OS -eq 'Windows_NT') {
        '/c "echo {0} > NUL:"'
     } else {
        '-c "echo {0} > /dev/null"'
    }

    # A hashtable with script blocks that implement the 3 approaches to parallelism.
    $approachImpl = [ordered] @{}

    # child-process-based job
    $approachImpl['Start-Job'] = {
        param([array] $batch)
        $batch |
            ForEach-Object {
                Start-Job {
                    Invoke-Expression ($using:exe + ' ' + ($using:exeArgList -f $args[0]))
                } -ArgumentList $_
            } |
            Receive-Job -Wait -AutoRemoveJob | Out-Null
    }

    # thread-based job - requires the ThreadJob module
    if (-not $noStartThreadJob) {
        # If Start-ThreadJob is available, add an approach for it.
        $approachImpl['Start-ThreadJob'] = {
            param([array] $batch)
            $batch |
                ForEach-Object {
                    Start-ThreadJob -ThrottleLimit $BatchSize {
                        Invoke-Expression ($using:exe + ' ' + ($using:exeArgList -f $args[0]))
                    } -ArgumentList $_
                } |
                Receive-Job -Wait -AutoRemoveJob | Out-Null
        }
    }

    # ForEach-Object -Parallel job
    if (-not $noForEachParallel) {
        $approachImpl['ForEach-Object -Parallel'] = {
            param([array] $batch)
            $batch | ForEach-Object -ThrottleLimit $BatchSize -Parallel {
                Invoke-Expression ($using:exe + ' ' + ($using:exeArgList -f $_))
            }
        }
    }

    # direct execution of an external program
    $approachImpl['Start-Process'] = {
        param([array] $batch)
        $batch |
            ForEach-Object {
                Start-Process -NoNewWindow -PassThru $exe -ArgumentList ($exeArgList -f $_)
            } |
            Wait-Process
    }

    # Partition the array of all indices into subarrays (batches)
    $batches = @(
        0..([math]::Ceiling($zipFiles.Count / $batchSize) - 1) | ForEach-Object {
            , $zipFiles[($_ * $batchSize)..($_ * $batchSize + $batchSize - 1)]
        }
    )

    $tsTotals = foreach ($appr in $approaches) {
        $i = 0
        $tsTotal = [timespan] 0
        $batches | ForEach-Object {
            Write-Verbose "$batchSize-element '$appr' batch"
            $ts = Measure-Command { & $approachImpl[$appr] $_ | Out-Null }
            $tsTotal += $ts
            if (++$i -eq $batches.Count) {
                # last batch processed.
                if ($batches.Count -gt 1) {
                    Write-Verbose ("'$appr' processing $JobCount items finished in " +
                        "$($tsTotal.TotalSeconds.ToString('N2')) secs.")
                }
                $tsTotal # output the overall timing for this approach
            }
        }
    }

    # Output a result object with the overall timings.
    $oht = [ordered] @{}
    $oht['JobCount'] = $JobCount
    $oht['BatchSize'] = $BatchSize
    $oht['BatchCount'] = $batches.Count
    $i = 0
    foreach ($appr in $approaches) {
        $oht[($appr + ' (secs.)')] = $tsTotals[$i++].TotalSeconds.ToString('N2')
    }
    [pscustomobject] $oht
}
```

The following example uses `Measure-Parallel` to run 20 jobs in parallel, 5 at a time, using all
available approaches.

```powershell
Measure-Parallel -Approach All -BatchSize 5 -JobCount 20 -Verbose
```

The following output comes from a Windows computer running PowerShell 7.5.1. Your timing can vary
based on many factors, but the ratios should provide a sense of relative performance.

```Output
VERBOSE: 5-element 'Start-Job' batch
VERBOSE: 5-element 'Start-Job' batch
VERBOSE: 5-element 'Start-Job' batch
VERBOSE: 5-element 'Start-Job' batch
VERBOSE: 'Start-Job' processing 20 items finished in 7.58 secs.
VERBOSE: 5-element 'Start-ThreadJob' batch
VERBOSE: 5-element 'Start-ThreadJob' batch
VERBOSE: 5-element 'Start-ThreadJob' batch
VERBOSE: 5-element 'Start-ThreadJob' batch
VERBOSE: 'Start-ThreadJob' processing 20 items finished in 2.37 secs.
VERBOSE: 5-element 'Start-Process' batch
VERBOSE: 5-element 'Start-Process' batch
VERBOSE: 5-element 'Start-Process' batch
VERBOSE: 5-element 'Start-Process' batch
VERBOSE: 'Start-Process' processing 20 items finished in 0.26 secs.
VERBOSE: 5-element 'ForEach-Object -Parallel' batch
VERBOSE: 5-element 'ForEach-Object -Parallel' batch
VERBOSE: 5-element 'ForEach-Object -Parallel' batch
VERBOSE: 5-element 'ForEach-Object -Parallel' batch
VERBOSE: 'ForEach-Object -Parallel' processing 20 items finished in 0.79 secs.

JobCount                         : 20
BatchSize                        : 5
BatchCount                       : 4
Start-Job (secs.)                : 7.58
Start-ThreadJob (secs.)          : 2.37
Start-Process (secs.)            : 0.26
ForEach-Object -Parallel (secs.) : 0.79
```

Conclusions

- The `Start-Process` approach performs best because it doesn't have the overhead of job management.
  However, as previously noted, this approach has fundamental limitations.
- The `ForEach-Object -Parallel` adds the least overhead, followed by `Start-ThreadJob`.
- `Start-Job` has the most overhead because of the hidden PowerShell instances it creates for each
  job.

## Acknowledgments

Much of the information is this article is based on the answers from [Santiago Squarzon][04] and
[mklement0][05] in this [Stack Overflow post][03].

You may also be interested in the [PSParallelPipeline][06] module created by Santiago Squarzon.

## Further reading

- [Start-Job][08]
- [about_Jobs][01]
- [Start-ThreadJob][10]
- [ForEach-Object][07]
- [Start-Process][09]

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_jobs
[02]: /powershell/module/psworkflow/about/about_workflows
[03]: https://stackoverflow.com/questions/73997250/powershell-test-the-performance-efficiency-of-asynchronous-tasks-with-start-job/
[04]: https://stackoverflow.com/users/15339544/santiago-squarzon
[05]: https://stackoverflow.com/users/45375/mklement0
[06]: https://www.powershellgallery.com/packages/PSParallelPipeline/
[07]: xref:Microsoft.PowerShell.Core.ForEach-Object
[08]: xref:Microsoft.PowerShell.Core.Start-Job
[09]: xref:Microsoft.PowerShell.Management.Start-Process
[10]: xref:ThreadJob.Start-ThreadJob
