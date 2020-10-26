---
ms.date: 09/13/2016
ms.topic: reference
title: Creating a Cmdlet without Parameters
description: Creating a Cmdlet without Parameters
---
# Creating a Cmdlet without Parameters

This section describes how to create a cmdlet that retrieves information from the local computer without the use of parameters, and then writes the information to the pipeline. The cmdlet described here is a Get-Proc cmdlet that retrieves information about the processes of the local computer, and then displays that information at the command line.

> [!NOTE]
> Be aware that when writing cmdlets, the Windows PowerShell® reference assemblies are downloaded onto disk (by default at C:\Program Files\Reference Assemblies\Microsoft\WindowsPowerShell\v1.0). They are not installed in the Global Assembly Cache (GAC).

## Naming the Cmdlet

A cmdlet name consists of a verb that indicates the action the cmdlet takes and a noun that indicates the items that the cmdlet acts upon. Because this sample Get-Proc cmdlet retrieves process objects, it uses the verb "Get", defined by the [System.Management.Automation.Verbscommon](/dotnet/api/System.Management.Automation.VerbsCommon) enumeration, and the noun "Proc" to indicate that the cmdlet works on process items.

When naming cmdlets, do not use any of the following characters: # , () {} [] & - /\ $ ; : " '<> &#124; ? @ ` .

### Choosing a Noun

You should choose a noun that is specific. It is best to use a singular noun prefixed with a shortened version of the product name. An example cmdlet name of this type is "`Get-SQLServer`".

### Choosing a Verb

You should use a verb from the set of approved cmdlet verb names. For more information about the approved cmdlet verbs, see [Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md).

## Defining the Cmdlet Class

Once you have chosen a cmdlet name, define a .NET class to implement the cmdlet. Here is the class definition for this sample Get-Proc cmdlet:

```csharp
[Cmdlet(VerbsCommon.Get, "Proc")]
  public class GetProcCommand : Cmdlet
```

```vb
<Cmdlet(VerbsCommon.Get, "Proc")> _
Public Class GetProcCommand
    Inherits Cmdlet
```

Notice that previous to the class definition, the [System.Management.Automation.CmdletAttribute](/dotnet/api/System.Management.Automation.CmdletAttribute) attribute, with the syntax `[Cmdlet(verb, noun, ...)]`, is used to identify this class as a cmdlet. This is the only required attribute for all cmdlets, and it allows the Windows PowerShell runtime to call them correctly. You can set attribute keywords to further declare the class if necessary. Be aware that the attribute declaration for our sample GetProcCommand class declares only the noun and verb names for the Get-Proc cmdlet.

> [!NOTE]
> For all Windows PowerShell attribute classes, the keywords that you can set correspond to properties of the attribute class.

When naming the class of the cmdlet, it is a good practice to reflect the cmdlet name in the class name. To do this, use the form "VerbNounCommand" and replace "Verb" and "Noun" with the verb and noun used in the cmdlet name. As is shown in the previous class definition, the sample Get-Proc cmdlet defines a class called GetProcCommand, which derives from the [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) base class.

> [!IMPORTANT]
> If you want to define a cmdlet that accesses the Windows PowerShell runtime directly, your .NET class should derive from
> the [System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet)
> base class. For more information about this class, see [Creating a Cmdlet that Defines Parameter Sets](./adding-parameter-sets-to-a-cmdlet.md).

> [!NOTE]
> The class for a cmdlet must be explicitly marked as public. Classes that are not marked as public will default to internal and will not be found by the Windows PowerShell runtime.

Windows PowerShell uses the [Microsoft.PowerShell.Commands](/dotnet/api/Microsoft.PowerShell.Commands) namespace for its cmdlet classes. It is recommended to place your cmdlet classes in a Commands namespace of your API namespace, for example, xxx.PS.Commands.

## Overriding an Input Processing Method

The [System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) class provides three main input processing methods, at least one of which your cmdlet must override. For more information about how Windows PowerShell processes records, see [How Windows PowerShell Works](/previous-versions//ms714658(v=vs.85)).

For all types of input, the Windows PowerShell runtime calls [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing) to enable processing. If your cmdlet must perform some preprocessing or setup, it can do this by overriding this method.

> [!NOTE]
> Windows PowerShell uses the term "record" to describe the set of parameter values supplied when a cmdlet is called.

If your cmdlet accepts pipeline input, it must override the [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method, and optionally the [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) method. For example, a cmdlet might override both methods if it gathers all input using [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) and then operates on the input as a whole rather than one element at a time, as the `Sort-Object` cmdlet does.

If your cmdlet does not take pipeline input, it should override the [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) method. Be aware that this method is frequently used in place of [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing) when the cmdlet cannot operate on one element at a time, as is the case for a sorting cmdlet.

Because this sample Get-Proc cmdlet must receive pipeline input, it overrides the [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) method and uses the default implementations for [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing) and [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing). The [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord) override retrieves processes and writes them to the command line using the [System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject) method.

```csharp
protected override void ProcessRecord()
{
  // Get the current processes
  Process[] processes = Process.GetProcesses();

  // Write the processes to the pipeline making them available
  // to the next cmdlet. The second parameter of this call tells
  // PowerShell to enumerate the array, and send one process at a
  // time to the pipeline.
  WriteObject(processes, true);
}
```

```vb
Protected Overrides Sub ProcessRecord()

    '/ Get the current processes.
    Dim processes As Process()
    processes = Process.GetProcesses()

    '/ Write the processes to the pipeline making them available
    '/ to the next cmdlet. The second parameter of this call tells
    '/ PowerShell to enumerate the array, and send one process at a
    '/ time to the pipeline.
    WriteObject(processes, True)

End Sub 'ProcessRecord
```

#### Things to Remember About Input Processing

- The default source for input is an explicit object (for example, a string) provided by the user on the command line. For more information, see [Creating a Cmdlet to Process Command Line Input](./adding-parameters-that-process-command-line-input.md).

- An input processing method can also receive input from the output object of an upstream cmdlet on the pipeline. For more information, see [Creating a Cmdlet to Process Pipeline Input](./adding-parameters-that-process-pipeline-input.md). Be aware that your cmdlet can receive input from a combination of command-line and pipeline sources.

- The downstream cmdlet might not return for a long time, or not at all. For that reason, the input processing method in your cmdlet should not hold locks during calls to [System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject), especially locks for which the scope extends beyond the cmdlet instance.

> [!IMPORTANT]
> Cmdlets should never call [System.Console.Writeline*](/dotnet/api/System.Console.WriteLine) or its equivalent.

- Your cmdlet might have object variables to clean up when it is finished processing (for example, if it opens a file handle in the [System.Management.Automation.Cmdlet.BeginProcessing](/dotnet/api/System.Management.Automation.Cmdlet.BeginProcessing) method and keeps the handle open for use by [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)). It is important to remember that the Windows PowerShell runtime does not always call the [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) method, which should perform object cleanup.

For example, [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) might not be called if the cmdlet is canceled midway or if a terminating error occurs in any part of the cmdlet. Therefore, a cmdlet that requires object cleanup should implement the complete [System.IDisposable](/dotnet/api/System.IDisposable) pattern, including the finalizer, so that the runtime can call both [System.Management.Automation.Cmdlet.EndProcessing](/dotnet/api/System.Management.Automation.Cmdlet.EndProcessing) and [System.IDisposable.Dispose*](/dotnet/api/System.IDisposable.Dispose) at the end of processing.

## Code Sample

For the complete C# sample code, see [GetProcessSample01 Sample](./getprocesssample01-sample.md).

## Defining Object Types and Formatting

Windows PowerShell passes information between cmdlets using .NET objects. Consequently, a cmdlet might need to define its own type, or the cmdlet might need to extend an existing type provided by another cmdlet. For more information about defining new types or extending existing types, see [Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85)).

## Building the Cmdlet

After implementing a cmdlet, you must register it with Windows PowerShell through a Windows PowerShell snap-in. For more information about registering cmdlets, see [How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85)).

## Testing the Cmdlet

When your cmdlet has been registered with Windows PowerShell, you can test it by running it on the command line. The code for our sample Get-Proc cmdlet is small, but it still uses the Windows PowerShell runtime and an existing .NET object, which is enough to make it useful. Let's test it to better understand what Get-Proc can do and how its output can be used. For more information about using cmdlets from the command line, see the [Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell).

1. Start Windows PowerShell, and get the current processes running on the computer.

    ```powershell
    get-proc
    ```

    The following output appears.

    ```output
    Handles  NPM(K)  PM(K)  WS(K)  VS(M)  CPU(s)  Id   ProcessName
    -------  ------  -----  -----  -----  ------  --   ----------
    254      7       7664   12048  66     173.75  1200  QCTRAY
    32       2       1372   2628   31       0.04  1860  DLG
    271      6       1216   3688   33       0.03  3816  lg
    27       2       560    1920   24       0.01  1768  TpScrex
    ...
    ```

2. Assign a variable to the cmdlet results for easier manipulation.

    ```powershell
    $p=get-proc
    ```

3. Get the number of processes.

    ```powershell
    $p.length
    ```

    The following output appears.

    ```output
    63
    ```

4. Retrieve a specific process.

    ```powershell
    $p[6]
    ```

    The following output appears.

    ```output
    Handles  NPM(K)  PM(K)  WS(K)  VS(M)  CPU(s)  Id    ProcessName
    -------  ------  -----  -----  -----  ------  --    -----------
    1033     3       2400   3336   35     0.53    1588  rundll32
    ```

5. Get the start time of this process.

    ```powershell
    $p[6].starttime
    ```

    The following output appears.

    ```output
    Tuesday, July 26, 2005 9:34:15 AM
    ```

    ```powershell
    $p[6].starttime.dayofyear
    ```

    ```output
    207
    ```

6. Get the processes for which the handle count is greater than 500, and sort the result.

    ```powershell
    $p | Where-Object {$_.HandleCount -gt 500 } | Sort-Object HandleCount
    ```

    The following output appears.

    ```output
    Handles  NPM(K)  PM(K)  WS(K)  VS(M)  CPU(s)  Id   ProcessName
    -------  ------  -----  -----  -----  ------  --   ----------
    568      14      2164   4972   39     5.55    824  svchost
    716       7      2080   5332   28    25.38    468  csrss
    761      21      33060  56608  440  393.56    3300 WINWORD
    791      71      7412   4540   59     3.31    492  winlogon
    ...
    ```

7. Use the `Get-Member` cmdlet to list the properties available for each process.

    ```powershell
    $p | Get-Member -MemberType property
    ```

    ```output
        TypeName: System.Diagnostics.Process
    ```

    The following output appears.

    ```output
    Name                     MemberType Definition
    ----                     ---------- ----------
    BasePriority             Property   System.Int32 BasePriority {get;}
    Container                Property   System.ComponentModel.IContainer Conta...
    EnableRaisingEvents      Property   System.Boolean EnableRaisingEvents {ge...
    ...
    ```

## See Also

[Creating a Cmdlet to Process Command Line Input](./adding-parameters-that-process-command-line-input.md)

[Creating a Cmdlet to Process Pipeline Input](./adding-parameters-that-process-pipeline-input.md)

[How to Create a Windows PowerShell Cmdlet](/powershell/scripting/developer/cmdlet/writing-a-windows-powershell-cmdlet)

[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85))

[How Windows PowerShell Works](/previous-versions//ms714658(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85))

[Windows PowerShell Reference](../windows-powershell-reference.md)

[Cmdlet Samples](./cmdlet-samples.md)
