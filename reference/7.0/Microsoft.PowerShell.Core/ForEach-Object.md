---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 09/08/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ForEach-Object
---
# ForEach-Object

## Synopsis
Performs an operation against each item in a collection of input objects.

## Syntax

### ScriptBlockSet (Default)

```
ForEach-Object [-InputObject <PSObject>] [-Begin <ScriptBlock>] [-Process] <ScriptBlock[]>
 [-End <ScriptBlock>] [-RemainingScripts <ScriptBlock[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PropertyAndMethodSet

```
ForEach-Object [-InputObject <PSObject>] [-MemberName] <String> [-ArgumentList <Object[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### ParallelParameterSet

```
ForEach-Object [-InputObject <PSObject>] -Parallel <ScriptBlock> [-ThrottleLimit <Int32>]
 [-TimeoutSeconds <Int32>] [-AsJob] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## Description

The `ForEach-Object` cmdlet performs an operation on each item in a collection of input objects. The
input objects can be piped to the cmdlet or specified by using the **InputObject** parameter.

Starting in Windows PowerShell 3.0, there are two different ways to construct a `ForEach-Object`
command.

- **Script block**. You can use a script block to specify the operation. Within the script block,
  use the `$_` variable to represent the current object. The script block is the value of the
  **Process** parameter. The script block can contain any PowerShell script.

  For example, the following command gets the value of the **ProcessName** property of each process
  on the computer.

  `Get-Process | ForEach-Object {$_.ProcessName}`

  `ForEach-Object` supports the `begin`, `process`, and `end` blocks as described in
  [about_functions](about/about_functions.md#piping-objects-to-functions).

  > [!NOTE]
  > The script blocks run in the caller's scope. Therefore the blocks have access to variables in
  > that scope and can create new variables that persist in that scope after the cmdlet completes.

- **Operation statement**. You can also write an operation statement, which is much more like
  natural language. You can use the operation statement to specify a property value or call a
  method. Operation statements were introduced in Windows PowerShell 3.0.

  For example, the following command also gets the value of the **ProcessName** property of each
  process on the computer.

  `Get-Process | ForEach-Object ProcessName`

- **Parallel running script block**. Beginning with PowerShell 7.0, a third parameter set is
  available that runs each script block in parallel. The **ThrottleLimit** parameter limits the
  number of parallel scripts running at a time. As before, use the `$_` variable to represent the
  current input object in the script block. Use the `$using:` keyword to pass variable references to
  the running script.

  In PowerShell 7, a new runspace is created for each loop iteration to ensure maximum isolation.
  This can be a large performance and resource hit if the work you are doing is small compared to
  creating new runspaces or if there are a lot of iterations performing significant work.

  By default, the parallel scriptblocks use the current working directory of the caller that started
  the parallel tasks.

  Non-terminating errors are written to the cmdlet error stream as they occur in parallel running
  scriptblocks. Because parallel scriptblock execution order cannot be determined, the order in
  which errors appear in the error stream is random. Likewise, messages written to other data
  streams, like warning, verbose, or information are written to those data streams in an
  indeterminate order.

  Terminating errors, such as exceptions, terminate the individual parallel instance of the
  scriptblocks in which they occur. A terminating error in one scriptblocks may not cause the
  termination of the `Foreach-Object` cmdlet. The other scriptblocks, running in parallel, continue
  to run unless they also encounter a terminating error. The terminating error is written to the
  error data stream as an **ErrorRecord** with a **FullyQualifiedErrorId** of `PSTaskException`.
  Terminating errors can be converted to non-terminating errors using PowerShell try/catch or trap
  blocks.

## Examples

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
Get-ChildItem $PSHOME |
  ForEach-Object -Process {if (!$_.PSIsContainer) {$_.Name; $_.Length / 1024; " " }}
```

If the object is not a directory, the script block gets the name of the file, divides the value of
its **Length** property by 1024, and adds a space (" ") to separate it from the next entry. The
cmdlet uses the **PSISContainer** property to determine whether an object is a directory.

### Example 3: Operate on the most recent System events

This example writes the 1000 most recent events from the System event log to a text file. The
current time is displayed before and after processing the events.

```powershell
$Events = Get-EventLog -LogName System -Newest 1000
$events | ForEach-Object -Begin {Get-Date} -Process {Out-File -FilePath Events.txt -Append -InputObject $_.Message} -End {Get-Date}
```

`Get-EventLog` gets the 1000 most recent events from the System event log and stores them in the
`$Events` variable. `$Events` is then piped to the `ForEach-Object` cmdlet. The **Begin** parameter
displays the current date and time. Next, the **Process** parameter uses the `Out-File` cmdlet to
create a text file that is named events.txt and stores the message property of each of the events in
that file. Last, the **End** parameter is used to display the date and time after all of the
processing has completed.

### Example 4: Change the value of a Registry key

This example changes the value of the **RemotePath** registry entry in all of the subkeys under the
`HKCU:\Network` key to uppercase text.

```powershell
Get-ItemProperty -Path HKCU:\Network\* |
  ForEach-Object {Set-ItemProperty -Path $_.PSPath -Name RemotePath -Value $_.RemotePath.ToUpper();}
```

You can use this format to change the form or content of a registry entry value.

Each subkey in the **Network** key represents a mapped network drive that reconnects at sign on. The
**RemotePath** entry contains the UNC path of the connected drive. For example, if you map the E:
drive to `\\Server\Share`, an **E** subkey is created in `HKCU:\Network` with the **RemotePath**
registry value set to `\\Server\Share`.

The command uses the `Get-ItemProperty` cmdlet to get all of the subkeys of the **Network** key and
the `Set-ItemProperty` cmdlet to change the value of the **RemotePath** registry entry in each key.
In the `Set-ItemProperty` command, the path is the value of the **PSPath** property of the registry
key. This is a property of the Microsoft .NET Framework object that represents the registry key, not
a registry entry. The command uses the **ToUpper()** method of the **RemotePath** value, which is a
string (REG_SZ).

Because `Set-ItemProperty` is changing the property of each key, the `ForEach-Object` cmdlet is
required to access the property.

### Example 5: Use the $Null automatic variable

This example shows the effect of piping the `$Null` automatic variable to the `ForEach-Object`
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

Because PowerShell treats null as an explicit placeholder, the `ForEach-Object` cmdlet generates a
value for `$Null`, just as it does for other objects that you pipe to it.

### Example 6: Get property values

This example gets the value of the **Path** property of all installed PowerShell modules by using
the **MemberName** parameter of the `ForEach-Object` cmdlet.

```powershell
Get-Module -ListAvailable | ForEach-Object -MemberName Path
Get-Module -ListAvailable | Foreach Path
```

The second command is equivalent to the first. It uses the `Foreach` alias of the `ForEach-Object`
cmdlet and omits the name of the **MemberName** parameter, which is optional.

The `ForEach-Object` cmdlet is useful for getting property values, because it gets the value without
changing the type, unlike the **Format** cmdlets or the `Select-Object` cmdlet, which change the
property value type.

### Example 7: Split module names into component names

This example shows three ways to split two dot-separated module names into their component names.

```powershell
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" | ForEach-Object {$_.Split(".")}
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" | ForEach-Object -MemberName Split -ArgumentList "."
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" | Foreach Split "."
```

```Output
Microsoft
PowerShell
Core
Microsoft
PowerShell
Host
```

The commands call the **Split** method of strings. The three commands use different syntax, but they
are equivalent and interchangeable.

The first command uses the traditional syntax, which includes a script block and the current object
operator `$_`. It uses the dot syntax to specify the method and parentheses to enclose the delimiter
argument.

The second command uses the **MemberName** parameter to specify the **Split** method and the
**ArgumentName** parameter to identify the dot (".") as the split delimiter.

The third command uses the **Foreach** alias of the `ForEach-Object` cmdlet and omits the names of
the **MemberName** and **ArgumentList** parameters, which are optional.

### Example 8: Using ForEach-Object with two script blocks

In this example, we pass two script blocks positionally. All the script blocks bind to the
**Process** parameter. However, they are treated as if they had been passed to the **Begin** and
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

In this example, we pass two script blocks positionally. All the script blocks bind to the
**Process** parameter. However, they are treated as if they had been passed to the **Begin**,
**Process**, and **End** parameters.

```powershell
1..2 | ForEach-Object { 'begin' } { 'process A' }  { 'process B' }  { 'end' }
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
> `end` block, and the blocks in between are all mapped to the `process` block.

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

This example runs a simple script block that evaluates a string and sleeps for one second.

```powershell
$Message = "Output:"

1..8 | ForEach-Object -Parallel {
    "$using:Message $_"
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
The `$using:` keyword is used to pass the `$Message` variable into each parallel script block.

### Example 12: Retrieve log entries in parallel

This example retrieves 50,000 log entries from 5 system logs on a local Windows machine.

```powershell
$logNames = 'Security','Application','System','Windows PowerShell','Microsoft-Windows-Store/Operational'

$logEntries = $logNames | ForEach-Object -Parallel {
    Get-WinEvent -LogName $_ -MaxEvents 10000
} -ThrottleLimit 5

$logEntries.Count
```

```Output
50000
```

The **Parallel** parameter specifies the script block that is run in parallel for each input log
name. The **ThrottleLimit** parameter ensures that all five script blocks run at the same time.

### Example 13: Run in parallel as a job

This example runs a simple script block in parallel, creating two background jobs at a time.

```powershell
$job = 1..10 | ForEach-Object -Parallel {
    "Output: $_"
    Start-Sleep 1
} -ThrottleLimit 2 -AsJob

$job | Receive-Job -Wait
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
Output: 9
Output: 10
```

the `$job` variable receives the job object that collects output data and monitors running state.
The job object is piped to `Receive-Job` with the **Wait** switch parameter. And this streams output
to the console, just as if `ForEach-Object -Parallel` was run without **AsJob**.

### Example 14: Using thread safe variable references

This example invokes script blocks in parallel to collect uniquely named Process objects.

```powershell
$threadSafeDictionary = [System.Collections.Concurrent.ConcurrentDictionary[string,object]]::new()
Get-Process | ForEach-Object -Parallel {
    $dict = $using:threadSafeDictionary
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
objects. Since the **ConcurrentDictionary** is thread safe, it is safe to be modified by each
parallel script. A non-thread-safe object, such as **System.Collections.Generic.Dictionary**, would
not be safe to use here.

> [!NOTE]
> This example is a very inefficient use of **Parallel** parameter. The script simply adds the input
> object to a concurrent dictionary object. It is trivial and not worth the overhead of invoking
> each script in a separate thread. Running `ForEach-Object` normally without the **Parallel**
> switch is much more efficient and faster. This example is only intended to demonstrate how to use
> thread safe variables.

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

## Parameters

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
the value is a collection that is the result of a command, such as `-InputObject (Get-Process)`.
Because **InputObject** cannot return individual properties from an array or collection of objects,
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

Specifies the property to get or the method to call.

Wildcard characters are permitted, but work only if the resulting string resolves to a unique value.
For example, if you run `Get-Process | ForEach -MemberName *Name`, the wildcard pattern matches more
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

### -Process

Specifies the operation that is performed on each input object. This script block is run for every
object in the pipeline. For more information about the `process` block, see
[about_Functions](about/about_functions.md#piping-objects-to-functions).

When you provide multiple script blocks to the **Process** parameter, the first script block is
always mapped to the `begin` block. If there are only two script blocks, the second block is mapped
to the `process` block. If there are three or more script blocks, first script block is always
mapped to the `begin` block, the last block is mapped to the `end` block, and the blocks in between
are all mapped to the `process` block.

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

Specifies all script blocks that are not taken by the **Process** parameter.

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

### -ThrottleLimit

Specifies the number of script blocks that in parallel. Input objects are blocked until
the running script block count falls below the **ThrottleLimit**. The default value is `5`.

This parameter was introduced in PowerShell 7.0.

```yaml
Type: System.Int32
Parameter Sets: ParallelParameterSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeoutSeconds

Specifies the number of seconds to wait for all input to be processed in parallel. After the
specified timeout time, all running scripts are stopped. And any remaining input objects to be
processed are ignored. Default value of `0` disables the timeout, and `ForEach-Object -Parallel` can
run indefinitely. Typing <kbd>Ctrl</kbd>+<kbd>C</kbd> at the command line stops a running
`ForEach-Object -Parallel` command. This parameter cannot be used along with the **AsJob**
parameter.

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

### -AsJob

Causes the parallel invocation to run as a PowerShell job. A single job object is returned instead
of output from the running script blocks. The job object contains child jobs for each parallel
script block that runs. The job object can be used by all PowerShell job cmdlets, to monitor running
state and retrieve data.

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

## Inputs

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet.

## Outputs

### System.Management.Automation.PSObject

This cmdlet returns objects that are determined by the input.

## Notes

- The `ForEach-Object` cmdlet works much like the **Foreach** statement, except that you cannot pipe
  input to a **Foreach** statement. For more information about the **Foreach** statement, see
  [about_Foreach](./About/about_Foreach.md).

- Starting in PowerShell 4.0, `Where` and `ForEach` methods were added for use with collections. You
  can read more about these new methods here [about_arrays](./About/about_Arrays.md)

- The `ForEach-Object -Parallel` parameter set uses PowerShell's internal API to run each script
  block. This is significantly more overhead than running `ForEach-Object` normally with sequential
  processing. It is important to use **Parallel** where the overhead of running in parallel is small
  compared to work the script block performs. For example:

  - Compute intensive scripts on multi-core machines
  - Scripts that spend time waiting for results or doing file operations

  Using the **Parallel** parameter can cause scripts to run much slower than normal. Especially if
  the parallel scripts are trivial. Experiment with **Parallel** to discover where it can be
  beneficial.

  > [!IMPORTANT]
  > The `ForEach-Object -Parallel` parameter set runs script blocks in parallel on separate process
  > threads. The `$using:` keyword allows passing variable references from the cmdlet invocation
  > thread to each running script block thread. Since the script blocks run in different threads,
  > the object variables passed by reference must be used safely. Generally it is safe to read from
  > referenced objects that don't change. But if the object state is being modified then you must
  > used thread safe objects, such as .Net **System.Collection.Concurrent** types (See Example 11).

## Related links

[Compare-Object](../Microsoft.PowerShell.Utility/Compare-Object.md)

[Where-Object](Where-Object.md)

[Group-Object](../Microsoft.PowerShell.Utility/Group-Object.md)

[Measure-Object](../Microsoft.PowerShell.Utility/Measure-Object.md)

[New-Object](../Microsoft.PowerShell.Utility/New-Object.md)

[Select-Object](../Microsoft.PowerShell.Utility/Select-Object.md)

[Sort-Object](../Microsoft.PowerShell.Utility/Sort-Object.md)

[Tee-Object](../Microsoft.PowerShell.Utility/Tee-Object.md)
