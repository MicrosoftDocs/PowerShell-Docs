---
ms.date: 09/13/2016
ms.topic: reference
title: Adding Parameter Sets to a Cmdlet
description: Adding Parameter Sets to a Cmdlet
---
# Adding Parameter Sets to a Cmdlet

## Things to Know About Parameter Sets

Windows PowerShell defines a parameter set as a group of parameters that operate together. By
grouping the parameters of a cmdlet, you can create a single cmdlet that can change its
functionality based on what group of parameters the user specifies.

An example of a cmdlet that uses two parameter sets to define different functionalities is the
`Get-EventLog` cmdlet that is provided by Windows PowerShell. This cmdlet returns different
information when the user specifies the `List` or `LogName` parameter. If the `LogName` parameter is
specified, the cmdlet returns information about the events in a given event log. If the `List`
parameter is specified, the cmdlet returns information about the log files themselves (not the event
information they contain). In this case, the `List` and `LogName` parameters identify two separate
parameter sets.

Two important things to remember about parameter sets is that the Windows PowerShell runtime uses
only one parameter set for a particular input, and that each parameter set must have at least one
parameter that is unique for that parameter set.

To illustrate that last point, this Stop-Proc cmdlet uses three parameter sets: `ProcessName`,
`ProcessId`, and `InputObject`. Each of these parameter sets has one parameter that is not in the
other parameter sets. The parameter sets could share other parameters, but the cmdlet uses the
unique parameters `ProcessName`, `ProcessId`, and `InputObject` to identify which set of parameters
that the Windows PowerShell runtime should use.

## Declaring the Cmdlet Class

The first step in cmdlet creation is always naming the cmdlet and declaring the .NET class that
implements the cmdlet. For this cmdlet, the lifecycle verb "Stop" is used because the cmdlet stops
system processes. The noun name "Proc" is used because the cmdlet works on processes. In the
declaration below, note that the cmdlet verb and noun name are reflected in the name of the cmdlet
class.

> [!NOTE]
> For more information about approved cmdlet verb names, see
> [Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md).

The following code is the class definition for this Stop-Proc cmdlet.

```csharp
[Cmdlet(VerbsLifecycle.Stop, "Proc",
        DefaultParameterSetName = "ProcessId",
        SupportsShouldProcess = true)]
public class StopProcCommand : PSCmdlet
```

```vb
<Cmdlet(VerbsLifecycle.Stop, "Proc", DefaultParameterSetName:="ProcessId", _
SupportsShouldProcess:=True)> _
Public Class StopProcCommand
    Inherits PSCmdlet
```

## Declaring the Parameters of the Cmdlet

This cmdlet defines three parameters needed as input to the cmdlet (these parameters also define the
parameter sets), as well as a `Force` parameter that manages what the cmdlet does and a `PassThru`
parameter that determines whether the cmdlet sends an output object through the pipeline. By
default, this cmdlet does not pass an object through the pipeline. For more information about these
last two parameters, see
[Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md).

### Declaring the Name Parameter

This input parameter allows the user to specify the names of the processes to be stopped. Note that
the `ParameterSetName` attribute keyword of the
[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)
attribute specifies the `ProcessName` parameter set for this parameter.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/StopProcessSample04/StopProcessSample04.cs" range="44-58":::

```vb
<Parameter(Position:=0, ParameterSetName:="ProcessName", _
Mandatory:=True, _
ValueFromPipeline:=True, ValueFromPipelineByPropertyName:=True, _
HelpMessage:="The name of one or more processes to stop. " & _
    "Wildcards are permitted."), [Alias]("ProcessName")> _
Public Property Name() As String()
    Get
        Return processNames
    End Get
    Set(ByVal value As String())
        processNames = value
    End Set
End Property

Private processNames() As String
```

Note also that the alias "ProcessName" is given to this parameter.

### Declaring the Id Parameter

This input parameter allows the user to specify the identifiers of the processes to be stopped. Note
that the `ParameterSetName` attribute keyword of the
[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)
attribute specifies the `ProcessId` parameter set.

```csharp
[Parameter(
           ParameterSetName = "ProcessId",
           Mandatory = true,
           ValueFromPipelineByPropertyName = true,
           ValueFromPipeline = true
)]
[Alias("ProcessId")]
public int[] Id
{
  get { return processIds; }
  set { processIds = value; }
}
private int[] processIds;
```

```vb
<Parameter(ParameterSetName:="ProcessId", _
Mandatory:=True, _
ValueFromPipelineByPropertyName:=True, _
ValueFromPipeline:=True), [Alias]("ProcessId")> _
Public Property Id() As Integer()
    Get
        Return processIds
    End Get
    Set(ByVal value As Integer())
        processIds = value
    End Set
End Property
Private processIds() As Integer
```

Note also that the alias "ProcessId" is given to this parameter.

### Declaring the InputObject Parameter

This input parameter allows the user to specify an input object that contains information about the
processes to be stopped. Note that the `ParameterSetName` attribute keyword of the
[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)
attribute specifies the `InputObject` parameter set for this parameter.

```csharp
[Parameter(
           ParameterSetName = "InputObject",
           Mandatory = true,
           ValueFromPipeline = true)]
public Process[] InputObject
{
  get { return inputObject; }
  set { inputObject = value; }
}
private Process[] inputObject;
```

```vb
<Parameter(ParameterSetName:="InputObject", _
Mandatory:=True, ValueFromPipeline:=True)> _
Public Property InputObject() As Process()
    Get
        Return myInputObject
    End Get
    Set(ByVal value As Process())
        myInputObject = value
    End Set
End Property
Private myInputObject() As Process
```

Note also that this parameter has no alias.

### Declaring Parameters in Multiple Parameter Sets

Although there must be a unique parameter for each parameter set, parameters can belong to more than
one parameter set. In these cases, give the shared parameter a
[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)
attribute declaration for each set to which that the parameter belongs. If a parameter is in all
parameter sets, you only have to declare the parameter attribute once and do not need to specify the
parameter set name.

## Overriding an Input Processing Method

Every cmdlet must override an input processing method, most often this will be the
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
method. In this cmdlet, the
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
method is overridden so that the cmdlet can process any number of processes. It contains a Select
statement that calls a different method based on which parameter set the user has specified.

```csharp
protected override void ProcessRecord()
{
  switch (ParameterSetName)
  {
    case "ProcessName":
         ProcessByName();
         break;

    case "ProcessId":
         ProcessById();
         break;

    case "InputObject":
         foreach (Process process in inputObject)
         {
           SafeStopProcess(process);
         }
         break;

    default:
         throw new ArgumentException("Bad ParameterSet Name");
  } // switch (ParameterSetName...
} // ProcessRecord
```

```vb
Protected Overrides Sub ProcessRecord()
    Select Case ParameterSetName
        Case "ProcessName"
            ProcessByName()

        Case "ProcessId"
            ProcessById()

        Case "InputObject"
            Dim process As Process
            For Each process In myInputObject
                SafeStopProcess(process)
            Next process

        Case Else
            Throw New ArgumentException("Bad ParameterSet Name")
    End Select

End Sub 'ProcessRecord ' ProcessRecord
```

The Helper methods called by the Select statement are not described here, but you can see their
implementation in the complete code sample in the next section.

## Code Sample

For the complete C# sample code, see [StopProcessSample04 Sample](./stopprocesssample04-sample.md).

## Defining Object Types and Formatting

Windows PowerShell passes information between cmdlets using .NET objects. Consequently, a cmdlet
might need to define its own type, or the cmdlet might need to extend an existing type provided by
another cmdlet. For more information about defining new types or extending existing types, see
[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85)).

## Building the Cmdlet

After implementing a cmdlet, you must register it with Windows PowerShell through a Windows
PowerShell snap-in. For more information about registering cmdlets, see
[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85)).

## Testing the Cmdlet

When your cmdlet has been registered with Windows PowerShell, test it by running it on the command
line. Here are some tests that show how the `ProcessId` and `InputObject` parameters can be used to
test their parameter sets to stop a process.

- With Windows PowerShell started, run the Stop-Proc cmdlet with the `ProcessId` parameter set to
  stop a process based on its identifier. In this case, the cmdlet is using the `ProcessId`
  parameter set to stop the process.

  ```
  PS> stop-proc -Id 444
  Confirm
  Are you sure you want to perform this action?
  Performing operation "stop-proc" on Target "notepad (444)".
  [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
  ```

- With Windows PowerShell started, run the Stop-Proc cmdlet with the `InputObject` parameter set to
  stop processes on the Notepad object retrieved by the `Get-Process` command.

  ```
  PS> get-process notepad | stop-proc
  Confirm
  Are you sure you want to perform this action?
  Performing operation "stop-proc" on Target "notepad (444)".
  [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): N
  ```

## See Also

[Creating a Cmdlet that Modifies the System](./creating-a-cmdlet-that-modifies-the-system.md)

[How to Create a Windows PowerShell Cmdlet](/powershell/scripting/developer/cmdlet/writing-a-windows-powershell-cmdlet)

[Extending Object Types and Formatting](/previous-versions//ms714665(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85))

[Windows PowerShell SDK](../windows-powershell-reference.md)
