---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 04/23/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
aliases:
  - %
  - foreach
title: ForEach-Object
---
# ForEach-Object

## SYNOPSIS
Performs an operation against each item in a collection of input objects.

## SYNTAX

### ScriptBlockSet (Default)

```
ForEach-Object [-InputObject <PSObject>] [-Begin <ScriptBlock>] [-Process] <ScriptBlock[]>
 [-End <ScriptBlock>] [-RemainingScripts <ScriptBlock[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PropertyAndMethodSet

```
ForEach-Object [-InputObject <PSObject>] [-MemberName] <String> [-ArgumentList <Object[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ParallelParameterSet

```
ForEach-Object -Parallel <scriptblock> [-InputObject <psobject>] [-ThrottleLimit <int>]
 [-TimeoutSeconds <int>] [-AsJob] [-UseNewRunspace] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `ForEach-Object` cmdlet performs an operation on each item in a collection of input objects. The
input objects can be piped to the cmdlet or specified using the **InputObject** parameter.

Starting in Windows PowerShell 3.0, there are two different ways to construct a `ForEach-Object`
command.

- **Script block syntax**. You can use a script block to specify the operation. Within the script block,
  use the `$_` variable to represent the current object. The script block is the value of the
  **Process** parameter. The script block can contain any PowerShell script.

  For example, the following command gets the value of the **ProcessName** property of each process
  on the computer.

  `Get-Process | ForEach-Object {$_.ProcessName}`

  `ForEach-Object` supports the `begin`, `process`, and `end` blocks as described in
  [about_Functions](about/about_functions.md#piping-objects-to-functions).

  > [!NOTE]
  > The script blocks run in the caller's scope. Therefore, the blocks have access to variables in
  > that scope and can create new variables that persist in that scope after the cmdlet completes.

- **Simplified syntax**. Using the simplified syntax, you specify a property or method name of the
  object in the pipeline. `ForEach-Object` returns the value of the property or method for each
  object in the pipeline.

  For example, the following command also gets the value of the **ProcessName** property of each
  process on the computer.

  `Get-Process | ForEach-Object ProcessName`

  The simplified syntax was introduced in Windows PowerShell 3.0. For more information, see
  [about_Simplified_Syntax](About/about_Simplified_Syntax.md).

- **Parallel running script block**. Beginning with PowerShell 7.0, a third parameter set is
  available that runs each script block in parallel. The **ThrottleLimit** parameter limits the
  number of parallel scripts running at a time. As before, use the `$_` variable to represent the
  current input object in the script block. Use the `Using:` scope modifier to pass variable
  references to the running script.

  In PowerShell 7, a new runspace is created for each loop iteration to ensure maximum isolation.
  This can be a large performance and resource hit if the work you are doing is small compared to
  creating new runspaces or if there are a lot of iterations performing significant work. As of
  PowerShell 7.1, runspaces from a runspace pool are reused by default. The **ThrottleLimit**
  parameter sets the runspace pool size. The default runspace pool size is 5. You can still create a
  new runspace for each iteration using the **UseNewRunspace** switch.

  By default, the parallel scriptblocks use the current working directory of the caller that started
  the parallel tasks.

  For more information, see the [NOTES](#notes) section of this article.

## EXAMPLES

### Example 1: Divide integers in an array

This example takes an array of three integers and divides each one of them by 1024.

```powershell
30000, 56798, 12432 | ForEach-Object -Process {$_/1024}
```

```Output
29.296875
55.466796875
12.140625
```

### Example 2: Get the length of all the files in a directory

This example processes the files and directories in the PowerShell installation directory `$PSHOME`.

```powershell
Get-ChildItem $PSHOME | ForEach-Object -Process {
    if (!$_.PSIsContainer) {$_.Name; $_.Length / 1024; " " }
}
```

If the object isn't a directory, the script block gets the name of the file, divides the value of
its **Length** property by 1024, and adds a space (" ") to separate it from the next entry. The
cmdlet uses the **PSIsContainer** property to determine whether an object is a directory.

### Example 3: Operate on the most recent System events

This example writes the 1000 most recent events from the System event log to a text file. The
current time is displayed before and after processing the events.

```powershell
Get-EventLog -LogName System -Newest 1000 |
    ForEach-Object -Begin {Get-Date} -Process {
        Out-File -FilePath Events.txt -Append -InputObject $_.Message
    } -End {Get-Date}
```

`Get-EventLog` gets the 1000 most recent events from the System event log and pipes them to the
`ForEach-Object` cmdlet. The **Begin** parameter displays the current date and time. Next, the
**Process** parameter uses the `Out-File` cmdlet to create a text file that's named events.txt and
stores the message property of each of the events in that file. Last, the **End** parameter is used
to display the date and time after all the processing has completed.

### Example 4: Change the value of a Registry key

This example changes the value of the **RemotePath** registry entry in all the subkeys under the
`HKCU:\Network` key to uppercase text.

```powershell
Get-ItemProperty -Path HKCU:\Network\* |
  ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name RemotePath -Value $_.RemotePath.ToUpper()
  }
```

You can use this format to change the form or content of a registry entry value.

Each subkey in the **Network** key represents a mapped network drive that reconnects at sign on. The
**RemotePath** entry contains the UNC path of the connected drive. For example, if you map the `E:`
drive to `\\Server\Share`, an **E** subkey is created in `HKCU:\Network` with the **RemotePath**
registry value set to `\\Server\Share`.

The command uses the `Get-ItemProperty` cmdlet to get all the subkeys of the **Network** key and the
`Set-ItemProperty` cmdlet to change the value of the **RemotePath** registry entry in each key. In
the `Set-ItemProperty` command, the path is the value of the **PSPath** property of the registry
key. This is a property of the Microsoft .NET Framework object that represents the registry key, not
a registry entry. The command uses the **ToUpper()** method of the **RemotePath** value, which is a
string **REG_SZ**.

Because `Set-ItemProperty` is changing the property of each key, the `ForEach-Object` cmdlet is
required to access the property.

### Example 5: Use the $null automatic variable

This example shows the effect of piping the `$null` automatic variable to the `ForEach-Object`
cmdlet.

```powershell
1, 2, $null, 4 | ForEach-Object {"Hello"}
```

```Output
Hello
Hello
Hello
Hello
```

Because PowerShell treats `$null` as an explicit placeholder, the `ForEach-Object` cmdlet generates
a value for `$null` as it does for other objects piped to it.

### Example 6: Get property values

This example gets the value of the **Path** property of all installed PowerShell modules using
the **MemberName** parameter of the `ForEach-Object` cmdlet.

```powershell
Get-Module -ListAvailable | ForEach-Object -MemberName Path
Get-Module -ListAvailable | foreach Path
```

The second command is equivalent to the first. It uses the `Foreach` alias of the `ForEach-Object`
cmdlet and omits the name of the **MemberName** parameter, which is optional.

The `ForEach-Object` cmdlet is useful for getting property values, because it gets the value without
changing the type, unlike the **Format** cmdlets or the `Select-Object` cmdlet, which change the
property value type.

### Example 7: Split module names into component names

This example shows three ways to split two dot-separated module names into their component names.
The commands call the **Split** method of strings. The three commands use different syntax, but they
are equivalent and interchangeable. The output is the same for all three cases.

```powershell
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" |
    ForEach-Object {$_.Split(".")}
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" |
    ForEach-Object -MemberName Split -ArgumentList "."
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" |
    foreach Split "."
```

```Output
Microsoft
PowerShell
Core
Microsoft
PowerShell
Host
```

The first command uses the traditional syntax, which includes a script block and the current object
operator `$_`. It uses the dot syntax to specify the method and parentheses to enclose the delimiter
argument.

The second command uses the **MemberName** parameter to specify the **Split** method and the
**ArgumentList** parameter to identify the dot (`.`) as the split delimiter.

The third command uses the `foreach` alias of the `ForEach-Object` cmdlet and omits the names of
the **MemberName** and **ArgumentList** parameters, which are optional.

### Example 8: Using ForEach-Object with two script blocks

In this example, we pass two script blocks positionally. All the script blocks bind to the
**Process** parameter. However, they're treated as if they had been passed to the **Begin** and
**Process** parameters.

```powershell
1..2 | ForEach-Object { 'begin' } { 'process' }
```

```Output
begin
process
process
```

### Example 9: Using ForEach-Object with more than two script blocks

In this example, we pass four script blocks positionally. All the script blocks bind to the
**Process** parameter. However, they're treated as if they had been passed to the **Begin**,
**Process**, and **End** parameters.

```powershell
1..2 | ForEach-Object { 'begin' } { 'process A' }  { 'process B' } { 'end' }
```

```Output
begin
process A
process B
process A
process B
end
```

> [!NOTE]
> The first script block is always mapped to the `begin` block, the last block is mapped to the
> `end` block, and the two middle blocks are mapped to the `process` block.

### Example 10: Run multiple script blocks for each pipeline item

As shown in the previous example, multiple script blocks passed using the **Process** parameter get
mapped to the **Begin** and **End** parameters. To avoid this mapping, you must provide explicit
values for the **Begin** and **End** parameters.

```powershell
1..2 | ForEach-Object -Begin $null -Process { 'one' }, { 'two' }, { 'three' } -End $null
```

```Output
one
two
three
one
two
three
```

### Example 11: Run slow script in parallel batches

This example runs a script block that evaluates a string and sleeps for one second.

```powershell
$Message = "Output:"

1..8 | ForEach-Object -Parallel {
    "$Using:Message $_"
    Start-Sleep 1
} -ThrottleLimit 4
```

```Output
Output: 1
Output: 2
Output: 3
Output: 4
Output: 5
Output: 6
Output: 7
Output: 8
```

The **ThrottleLimit** parameter value is set to 4 so that the input is processed in batches of four.
The `Using:` scope modifier is used to pass the `$Message` variable into each parallel script block.

### Example 12: Retrieve log entries in parallel

This example retrieves 50,000 log entries from 5 system logs on a local Windows machine.

```powershell
$logNames = 'Security', 'Application', 'System', 'Windows PowerShell',
    'Microsoft-Windows-Store/Operational'

$logEntries = $logNames | ForEach-Object -Parallel {
    Get-WinEvent -LogName $_ -MaxEvents 10000
} -ThrottleLimit 5

$logEntries.Count
```

```Output
50000
```

The **Parallel** parameter specifies the script block that's run in parallel for each input log
name. The **ThrottleLimit** parameter ensures that all five script blocks run at the same time.

### Example 13: Run in parallel as a job

This example creates a job that runs a script block in parallel, two at a time.

```powershell
PS> $job = 1..10 | ForEach-Object -Parallel {
    "Output: $_"
    Start-Sleep 1
} -ThrottleLimit 2 -AsJob

PS> $job

Id     Name            PSJobTypeName   State         HasMoreData     Location      Command
--     ----            -------------   -----         -----------     --------      -------
23     Job23           PSTaskJob       Running       True            PowerShell    …

PS> $job.ChildJobs

Id     Name            PSJobTypeName   State         HasMoreData     Location      Command
--     ----            -------------   -----         -----------     --------      -------
24     Job24           PSTaskChildJob  Completed     True            PowerShell    …
25     Job25           PSTaskChildJob  Completed     True            PowerShell    …
26     Job26           PSTaskChildJob  Running       True            PowerShell    …
27     Job27           PSTaskChildJob  Running       True            PowerShell    …
28     Job28           PSTaskChildJob  NotStarted    False           PowerShell    …
29     Job29           PSTaskChildJob  NotStarted    False           PowerShell    …
30     Job30           PSTaskChildJob  NotStarted    False           PowerShell    …
31     Job31           PSTaskChildJob  NotStarted    False           PowerShell    …
32     Job32           PSTaskChildJob  NotStarted    False           PowerShell    …
33     Job33           PSTaskChildJob  NotStarted    False           PowerShell    …
```

The **ThrottleLimit** parameter limits the number of parallel script blocks running at a time. The
**AsJob** parameter causes the `ForEach-Object` cmdlet to return a job object instead of streaming
output to the console. The `$job` variable receives the job object that collects output data and
monitors running state. The `$job.ChildJobs` property contains the child jobs that run the parallel
script blocks.

### Example 14: Using thread safe variable references

This example invokes script blocks in parallel to collect uniquely named Process objects.

```powershell
$threadSafeDictionary = [System.Collections.Concurrent.ConcurrentDictionary[string,object]]::new()
Get-Process | ForEach-Object -Parallel {
    $dict = $Using:threadSafeDictionary
    $dict.TryAdd($_.ProcessName, $_)
}

$threadSafeDictionary["pwsh"]
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     82    82.87     130.85      15.55    2808   2 pwsh
```

A single instance of a **ConcurrentDictionary** object is passed to each script block to collect the
objects. Since the **ConcurrentDictionary** is thread safe, it's safe to be modified by each
parallel script. A non-thread-safe object, such as **System.Collections.Generic.Dictionary**, would
not be safe to use here.

> [!NOTE]
> This example is an inefficient use of **Parallel** parameter. The script adds the input object to
> a concurrent dictionary object. It's trivial and not worth the overhead of invoking each script in
> a separate thread. Running `ForEach-Object` without the **Parallel** switch is more efficient and
> faster. This example is only intended to demonstrate how to use thread safe variables.

### Example 15: Writing errors with parallel execution

This example writes to the error stream in parallel, where the order of written errors is random.

```powershell
1..3 | ForEach-Object -Parallel {
    Write-Error "Error: $_"
}
```

```Output
Write-Error: Error: 1
Write-Error: Error: 3
Write-Error: Error: 2
```

### Example 16: Terminating errors in parallel execution

This example demonstrates a terminating error in one parallel running scriptblock.

```powershell
1..5 | ForEach-Object -Parallel {
    if ($_ -eq 3)
    {
        throw "Terminating Error: $_"
    }

    Write-Output "Output: $_"
}
```

```Output
Exception: Terminating Error: 3
Output: 1
Output: 4
Output: 2
Output: 5
```

`Output: 3` is never written because the parallel scriptblock for that iteration was terminated.

> [!NOTE]
> [PipelineVariable](About/about_CommonParameters.md) common parameter variables are _not_
> supported in `ForEach-Object -Parallel` scenarios even with the `Using:` scope modifier.

### Example 17: Passing variables in nested parallel scriptblocks

You can create a variable outside a `ForEach-Object -Parallel` scoped scriptblock and use it inside
the scriptblock with the `Using:` scope modifier. Beginning in PowerShell 7.2, you can create a
variable inside a `ForEach-Object -Parallel` scoped scriptblock and use it inside a nested
scriptblock.

```powershell
$test1 = 'TestA'
1..2 | ForEach-Object -Parallel {
    $Using:test1
    $test2 = 'TestB'
    1..2 | ForEach-Object -Parallel {
        $Using:test2
    }
}
```

```Output
TestA
TestA
TestB
TestB
TestB
TestB
```

> [!NOTE]
> In versions prior to PowerShell 7.2, the nested scriptblock can't access the `$test2` variable and
> an error is thrown.

### Example 18: Creating multiple jobs that run scripts in parallel

The ThrottleLimit parameter limits the number of parallel scripts running during each instance of
`ForEach-Object -Parallel`. It doesn't limit the number of jobs that can be created when using the
**AsJob** parameter. Since jobs themselves run concurrently, it's possible to create multiple
parallel jobs, each running up to the throttle limit number of concurrent scriptblocks.

```powershell
$jobs = for ($i=0; $i -lt 10; $i++) {
    1..10 | ForEach-Object -Parallel {
        ./RunMyScript.ps1
    } -AsJob -ThrottleLimit 5
}

$jobs | Receive-Job -Wait
```

This example creates 10 running jobs. Each job runs no more that 5 scripts concurrently. The total
number of instances running concurrently is limited to 50 (10 jobs times the **ThrottleLimit** of
5).

## PARAMETERS

### -ArgumentList

Specifies an array of arguments to a method call. For more information about the behavior of
**ArgumentList**, see [about_Splatting](about/about_Splatting.md#splatting-with-arrays).

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Object[]
Parameter Sets: PropertyAndMethodSet
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsJob

Causes the parallel invocation to run as a PowerShell job. A single job object is returned instead
of output from the running script blocks. The job object contains child jobs for each parallel
script block that runs. You can use the job object with any of the PowerShell job cmdlets to see the
running state and retrieve data.

This parameter was introduced in PowerShell 7.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ParallelParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Begin

Specifies a script block that runs before this cmdlet processes any input objects. This script block
is only run once for the entire pipeline. For more information about the `begin` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlockSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -End

Specifies a script block that runs after this cmdlet processes all input objects. This script block
is only run once for the entire pipeline. For more information about the `end` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlockSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the input objects. `ForEach-Object` runs the script block or operation statement on each
input object. Enter a variable that contains the objects, or type a command or expression that gets
the objects.

When you use the **InputObject** parameter with `ForEach-Object`, instead of piping command results
to `ForEach-Object`, the **InputObject** value is treated as a single object. This is true even if
the value is a collection that's the result of a command, such as `-InputObject (Get-Process)`.
Because **InputObject** can't return individual properties from an array or collection of objects,
we recommend that if you use `ForEach-Object` to perform operations on a collection of objects for
those objects that have specific values in defined properties, you use `ForEach-Object` in the
pipeline, as shown in the examples in this topic.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MemberName

Specifies the name of the member property to get or the member method to call. The members must be
instance members, not static members.

Wildcard characters are permitted, but work only if the resulting string resolves to a unique value.
For example, if you run `Get-Process | foreach -MemberName *Name`, the wildcard pattern matches more
than one member causing the command to fail.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: PropertyAndMethodSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Parallel

Specifies the script block to be used for parallel processing of input objects. Enter a script block
that describes the operation.

This parameter was introduced in PowerShell 7.0.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ParallelParameterSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Process

Specifies the operation that's performed on each input object. This script block is run for every
object in the pipeline. For more information about the `process` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

When you provide multiple script blocks to the **Process** parameter, the first script block is
always mapped to the `begin` block. If there are only two script blocks, the second block is mapped
to the `process` block. If there are three or more script blocks, first script block is always
mapped to the `begin` block, the last block is mapped to the `end` block, and the middle blocks are
mapped to the `process` block.

```yaml
Type: System.Management.Automation.ScriptBlock[]
Parameter Sets: ScriptBlockSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemainingScripts

Specifies all script blocks that aren't taken by the **Process** parameter.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.ScriptBlock[]
Parameter Sets: ScriptBlockSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

Specifies the number of script blocks that run in parallel. Input objects are blocked until
the running script block count falls below the **ThrottleLimit**. The default value is `5`.

The ThrottleLimit parameter limits the number of parallel scripts running during each instance of
`ForEach-Object -Parallel`. It doesn't limit the number of jobs that can be created when using the
**AsJob** parameter. Since jobs themselves run concurrently, it's possible to create a number of
parallel jobs, each running up to the throttle limit number of concurrent scriptblocks.

This parameter was introduced in PowerShell 7.0.

```yaml
Type: System.Int32
Parameter Sets: ParallelParameterSet
Aliases:

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutSeconds

Specifies the number of seconds to wait for all input to be processed in parallel. After the
specified timeout time, all running scripts are stopped. And any remaining input objects to be
processed are ignored. Default value of `0` disables the timeout, and `ForEach-Object -Parallel` can
run indefinitely. Typing <kbd>Ctrl</kbd>+<kbd>C</kbd> at the command line stops a running
`ForEach-Object -Parallel` command. This parameter can't be used along with the **AsJob** parameter.

This parameter was introduced in PowerShell 7.0.

```yaml
Type: System.Int32
Parameter Sets: ParallelParameterSet
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseNewRunspace

Causes the parallel invocation to create a new runspace for every loop iteration instead of reusing
runspaces from the runspace pool.

This parameter was introduced in PowerShell 7.1

```yaml
Type: SwitchParameter
Parameter Sets: ParallelParameterSet
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSObject

This cmdlet returns objects that are determined by the input.

## NOTES

PowerShell includes the following aliases for `ForEach-Object`:

- All Platforms:
  - `%`
  - `foreach`

The `ForEach-Object` cmdlet works much like the `foreach` statement, except that you can't pipe
input to a `foreach` statement. For more information about the `foreach` statement, see
[about_Foreach](./About/about_Foreach.md).

Starting in PowerShell 4.0, `Where` and `ForEach` methods were added for use with collections. You
can read more about these new methods here [about_Arrays](./About/about_Arrays.md)

Using `ForEach-Object -Parallel`:

- `ForEach-Object -Parallel` runs each script block in a new runspace. The new runspaces create
  significantly more overhead than running `ForEach-Object` with sequential processing. It's
  important to use **Parallel** where the overhead of running in parallel is small compared to work
  the script block performs. For example:

  - Compute intensive scripts on multi-core machines
  - Scripts that spend time waiting for results or doing file operations

  Using the **Parallel** parameter can cause scripts to run much slower than normal. Especially if
  the parallel scripts are trivial. Experiment with **Parallel** to discover where it can be
  beneficial.

- When running in parallel, objects decorated with **ScriptProperties** or **ScriptMethods** can't
  be guaranteed to function correctly if they're run in a different runspace than the scripts were
  originally attached to them.

  Scriptblock invocation always attempts to run in its _home_ runspace, regardless of where it's
  actually invoked. However, `ForEach-Object -Parallel` creates temporary runspaces that get deleted
  after use, so there's no runspace for the scripts to execute in anymore.

  This behavior can work as long as the _home_ runspace still exists. However, you may not get
  the desired result if the script is dependent on external variables that are only present in the
  caller's runspace and not the _home_ runspace.

- Non-terminating errors are written to the cmdlet error stream as they occur in parallel running
  scriptblocks. Because parallel scriptblock execution order is non-deterministic, the order in
  which errors appear in the error stream is random. Likewise, messages written to other data
  streams, like warning, verbose, or information are written to those data streams in an
  indeterminate order.

  Terminating errors, such as exceptions, terminate the individual parallel instance of the
  scriptblocks in which they occur. A terminating error in one scriptblocks may not cause the
  termination of the `ForEach-Object` cmdlet. The other scriptblocks, running in parallel, continue
  to run unless they also encounter a terminating error. The terminating error is written to the
  error data stream as an **ErrorRecord** with a **FullyQualifiedErrorId** of `PSTaskException`.
  Terminating errors can be converted to non-terminating errors using PowerShell `try`/`catch` or
  `trap` blocks.

- [PipelineVariable](About/about_CommonParameters.md) common parameter variables are _not_ supported
  in parallel scenarios even with the `Using:` scope modifier.

  > [!IMPORTANT]
  > The `ForEach-Object -Parallel` parameter set runs script blocks in parallel on separate process
  > threads. The `Using:` modifier allows passing variable references from the cmdlet invocation
  > thread to each running script block thread. Since the script blocks run in different threads,
  > the object variables passed by reference must be used safely. Generally it's safe to read from
  > referenced objects that don't change. If you need to modify the object state then you must
  > use thread safe objects, such as .NET **System.Collection.Concurrent** types (See Example 14).

## RELATED LINKS

[Compare-Object](../Microsoft.PowerShell.Utility/Compare-Object.md)

[Where-Object](Where-Object.md)

[Group-Object](../Microsoft.PowerShell.Utility/Group-Object.md)

[Measure-Object](../Microsoft.PowerShell.Utility/Measure-Object.md)

[New-Object](../Microsoft.PowerShell.Utility/New-Object.md)

[Select-Object](../Microsoft.PowerShell.Utility/Select-Object.md)

[Sort-Object](../Microsoft.PowerShell.Utility/Sort-Object.md)

[Tee-Object](../Microsoft.PowerShell.Utility/Tee-Object.md)
