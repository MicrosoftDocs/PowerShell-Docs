---
ms.date: 09/13/2016
ms.topic: reference
title: Adding Parameters that Process Pipeline Input
description: Adding Parameters that Process Pipeline Input
---
# Adding Parameters that Process Pipeline Input

One source of input for a cmdlet is an object on the pipeline that originates from an upstream
cmdlet. This section describes how to add a parameter to the Get-Proc cmdlet (described in
[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md)) so that the cmdlet can
process pipeline objects.

This Get-Proc cmdlet uses a `Name` parameter that accepts input from a pipeline object, retrieves
process information from the local computer based on the supplied names, and then displays
information about the processes at the command line.

## Defining the Cmdlet Class

The first step in cmdlet creation is always naming the cmdlet and declaring the .NET class that
implements the cmdlet. This cmdlet retrieves process information, so the verb name chosen here is
"Get". (Almost any sort of cmdlet that is capable of retrieving information can process command-line
input.) For more information about approved cmdlet verbs, see
[Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md).

The following is the definition for this Get-Proc cmdlet. Details of this definition are given in
[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md).

```csharp
[Cmdlet(VerbsCommon.Get, "proc")]
public class GetProcCommand : Cmdlet
```

```vb
<Cmdlet(VerbsCommon.Get, "Proc")> _
Public Class GetProcCommand
    Inherits Cmdlet
```

## Defining Input from the Pipeline

This section describes how to define input from the pipeline for a cmdlet. This Get-Proc cmdlet
defines a property that represents the `Name` parameter as described in
[Adding Parameters that Process Command Line Input](./adding-parameters-that-process-command-line-input.md).
(See that topic for general information about declaring parameters.)

However, when a cmdlet needs to process pipeline input, it must have its parameters bound to input
values by the Windows PowerShell runtime. To do this, you must add the `ValueFromPipeline` keyword
or add the `ValueFromPipelineByProperty` keyword to the
[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)
attribute declaration. Specify the `ValueFromPipeline` keyword if the cmdlet accesses the complete
input object. Specify the `ValueFromPipelineByProperty` if the cmdlet accesses only a property of
the object.

Here is the parameter declaration for the `Name` parameter of this Get-Proc cmdlet that accepts pipeline input.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/GetProcessSample03/GetProcessSample03.cs" range="35-44":::

```vb
<Parameter(Position:=0, ValueFromPipeline:=True, _
ValueFromPipelineByPropertyName:=True), ValidateNotNullOrEmpty()> _
Public Property Name() As String()
    Get
        Return processNames
    End Get

    Set(ByVal value As String())
        processNames = value
    End Set

End Property
```

<!-- TODO!!!: review snippet reference  [!CODE [Msh_samplesgetproc03#GetProc03VBNameParameter](Msh_samplesgetproc03#GetProc03VBNameParameter)]  -->

The previous declaration sets the `ValueFromPipeline` keyword to `true` so that the Windows
PowerShell runtime will bind the parameter to the incoming object if the object is the same type as
the parameter, or if it can be coerced to the same type. The `ValueFromPipelineByPropertyName`
keyword is also set to `true` so that the Windows PowerShell runtime will check the incoming object
for a `Name` property. If the incoming object has such a property, the runtime will bind the `Name`
parameter to the `Name` property of the incoming object.

> [!NOTE]
> The setting of the `ValueFromPipeline` attribute keyword for a parameter takes precedence over the
> setting for the `ValueFromPipelineByPropertyName` keyword.

## Overriding an Input Processing Method

If your cmdlet is to handle pipeline input, it needs to override the appropriate input processing
methods. The basic input processing methods are introduced in
[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md).

This Get-Proc cmdlet overrides the
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
method to handle the `Name` parameter input provided by the user or a script. This method will get
the processes for each requested process name or all processes if no name is provided. Notice that
within [System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord),
the call to [WriteObject(System.Object,System.Boolean)](/dotnet/api/system.management.automation.cmdlet.writeobject#System_Management_Automation_Cmdlet_WriteObject_System_Object_System_Boolean_)
is the output mechanism for sending output objects to the pipeline. The second parameter of this
call, `enumerateCollection`, is set to `true` to tell the Windows PowerShell runtime to enumerate
the array of process objects, and write one process at a time to the command line.

```csharp
protected override void ProcessRecord()
{
  // If no process names are passed to the cmdlet, get all processes.
  if (processNames == null)
  {
      // Write the processes to the pipeline making them available
      // to the next cmdlet. The second argument of this call tells
      // PowerShell to enumerate the array, and send one process at a
      // time to the pipeline.
      WriteObject(Process.GetProcesses(), true);
  }
  else
  {
    // If process names are passed to the cmdlet, get and write
    // the associated processes.
    foreach (string name in processNames)
    {
      WriteObject(Process.GetProcessesByName(name), true);
    } // End foreach (string name...).
  }
}
```

```vb
Protected Overrides Sub ProcessRecord()
    Dim processes As Process()

    '/ If no process names are passed to the cmdlet, get all processes.
    If processNames Is Nothing Then
        processes = Process.GetProcesses()
    Else

        '/ If process names are specified, write the processes to the
        '/ pipeline to display them or make them available to the next cmdlet.
        For Each name As String In processNames
            '/ The second parameter of this call tells PowerShell to enumerate the
            '/ array, and send one process at a time to the pipeline.
            WriteObject(Process.GetProcessesByName(name), True)
        Next
    End If

End Sub 'ProcessRecord
```

## Code Sample

For the complete C# sample code, see [GetProcessSample03 Sample](./getprocesssample03-sample.md).

## Defining Object Types and Formatting

Windows PowerShell passes information between cmdlets using .Net objects. Consequently, a cmdlet may
need to define its own type, or the cmdlet may need to extend an existing type provided by another
cmdlet. For more information about defining new types or extending existing types, see
[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85)).

## Building the Cmdlet

After implementing a cmdlet it must be registered with Windows PowerShell through a Windows
PowerShell snap-in. For more information about registering cmdlets, see
[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85)).

## Testing the Cmdlet

When your cmdlet has been registered with Windows PowerShell, test it by running it on the command
line. For example, test the code for the sample cmdlet. For more information about using cmdlets
from the command line, see the
[Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell).

- At the Windows PowerShell prompt, enter the following commands to retrieve the process names
  through the pipeline.

  ```powershell
  PS> type ProcessNames | get-proc
  ```

  The following output appears.

  ```
  Handles  NPM(K)  PM(K)   WS(K)  VS(M)  CPU(s)    Id  ProcessName
  -------  ------  -----   ----- -----   ------    --  -----------
      809      21  40856    4448    147    9.50  2288  iexplore
      737      21  26036   16348    144   22.03  3860  iexplore
       39       2   1024     388     30    0.08  3396  notepad
     3927      62  71836   26984    467  195.19  1848  OUTLOOK
  ```

- Enter the following lines to get the process objects that have a `Name` property from the
  processes called "IEXPLORE". This example uses the `Get-Process` cmdlet (provided by Windows
  PowerShell) as an upstream command to retrieve the "IEXPLORE" processes.

  ```powershell
  PS> get-process iexplore | get-proc
  ```

  The following output appears.

  ```
  Handles  NPM(K)  PM(K)   WS(K)  VS(M)  CPU(s)    Id  ProcessName
  -------  ------  -----   ----- -----   ------    --  -----------
      801      21  40720    6544    142    9.52  2288  iexplore
      726      21  25872   16652    138   22.09  3860  iexplore
      801      21  40720    6544    142    9.52  2288  iexplore
      726      21  25872   16652    138   22.09  3860  iexplore
  ```

## See Also

[Adding Parameters that Process Command Line Input](./adding-parameters-that-process-command-line-input.md)

[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md)

[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85))

[Windows PowerShell Reference](../windows-powershell-reference.md)

[Cmdlet Samples](./cmdlet-samples.md)
