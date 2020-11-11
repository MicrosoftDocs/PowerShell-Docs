---
ms.date: 09/13/2016
ms.topic: reference
title: Adding Parameters That Process Command-Line Input
description: Adding Parameters That Process Command-Line Input
---
# Adding Parameters That Process Command-Line Input

One source of input for a cmdlet is the command line. This topic describes how to add a parameter to
the `Get-Proc` cmdlet (which is described in
[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md)) so that the cmdlet can
process input from the local computer based on explicit objects passed to the cmdlet. The
`Get-Proc` cmdlet described here retrieves processes based on their names, and then displays
information about the processes at a command prompt.

## Defining the Cmdlet Class

The first step in cmdlet creation is cmdlet naming and the declaration of the .NET Framework class
that implements the cmdlet. This cmdlet retrieves process information, so the verb name chosen here
is "Get." (Almost any sort of cmdlet that is capable of retrieving information can process
command-line input.) For more information about approved cmdlet verbs, see
[Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md).

Here's the class declaration for the `Get-Proc` cmdlet. Details about this definition are provided
in [Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md).

```csharp
[Cmdlet(VerbsCommon.Get, "proc")]
public class GetProcCommand: Cmdlet
```

```vb
<Cmdlet(VerbsCommon.Get, "Proc")> _
Public Class GetProcCommand
    Inherits Cmdlet
```

## Declaring Parameters

A cmdlet parameter enables the user to provide input to the cmdlet. In the following example,
`Get-Proc` and `Get-Member` are the names of pipelined cmdlets, and `MemberType` is a parameter
for the `Get-Member` cmdlet. The parameter has the argument "property."

**PS> get-proc ; `get-member` -membertype property**

To declare parameters for a cmdlet, you must first define the properties that represent the
parameters. In the `Get-Proc` cmdlet, the only parameter is `Name`, which in this case represents
the name of the .NET Framework process object to retrieve. Therefore, the cmdlet class defines a
property of type string to accept an array of names.

Here's the parameter declaration for the `Name` parameter of the `Get-Proc` cmdlet.

```csharp
/// <summary>
/// Specify the cmdlet Name parameter.
/// </summary>
  [Parameter(Position = 0)]
  [ValidateNotNullOrEmpty]
  public string[] Name
  {
    get { return processNames; }
    set { processNames = value; }
  }
  private string[] processNames;

  #endregion Parameters
```

```vb
<Parameter(Position:=0), ValidateNotNullOrEmpty()> _
Public Property Name() As String()
    Get
        Return processNames
    End Get

    Set(ByVal value As String())
        processNames = value
    End Set

End Property
```

To inform the Windows PowerShell runtime that this property is the `Name` parameter, a
[System.Management.Automation.Parameterattribute](/dotnet/api/System.Management.Automation.ParameterAttribute)
attribute is added to the property definition. The basic syntax for declaring this attribute is
`[Parameter()]`.

> [!NOTE]
> A parameter must be explicitly marked as public. Parameters that are not marked as public default
> to internal and are not found by the Windows PowerShell runtime.

This cmdlet uses an array of strings for the `Name` parameter. If possible, your cmdlet should also
define a parameter as an array, because this allows the cmdlet to accept more than one item.

#### Things to Remember About Parameter Definitions

- Predefined Windows PowerShell parameter names and data types should be reused as much as possible
  to ensure that your cmdlet is compatible with Windows PowerShell cmdlets. For example, if all
  cmdlets use the predefined `Id` parameter name to identify a resource, user will easily understand
  the meaning of the parameter, regardless of what cmdlet they are using. Basically, parameter names
  follow the same rules as those used for variable names in the common language runtime (CLR). For
  more information about parameter naming, see
  [Cmdlet Parameter Names](/previous-versions/ms714468(v=vs.85)).

- Windows PowerShell reserves a few parameter names to provide a consistent user experience. Do not
  use these parameter names: `WhatIf`, `Confirm`, `Verbose`, `Debug`, `Warn`, `ErrorAction`,
  `ErrorVariable`, `OutVariable`, and `OutBuffer`. Additionally, the following aliases for these
  parameter names are reserved: `vb`, `db`, `ea`, `ev`, `ov`, and `ob`.

- `Name` is a simple and common parameter name, recommended for use in your cmdlets. It is better to
  choose a parameter name like this than a complex name that is unique to a specific cmdlet and hard
  to remember.

- Parameters are case-insensitive in Windows PowerShell, although by default the shell preserves
  case. Case-sensitivity of the arguments depends on the operation of the cmdlet. Arguments are
  passed to a parameter as specified at the command line.

- For examples of other parameter declarations, see [Cmdlet Parameters](./cmdlet-parameters.md).

## Declaring Parameters as Positional or Named

A cmdlet must set each parameter as either a positional or named parameter. Both kinds of parameters
accept single arguments, multiple arguments separated by commas, and Boolean settings. A Boolean
parameter, also called a *switch*, handles only Boolean settings. The switch is used to determine
the presence of the parameter. The recommended default is `false`.

The sample `Get-Proc` cmdlet defines the `Name` parameter as a positional parameter with position
0. This means that the first argument the user enters on the command line is automatically inserted
for this parameter. If you want to define a named parameter, for which the user must specify the
parameter name from the command line, leave the `Position` keyword out of the attribute declaration.

> [!NOTE]
> Unless parameters must be named, we recommend that you make the most-used parameters positional so
> that users will not have to type the parameter name.

## Declaring Parameters as Mandatory or Optional

A cmdlet must set each parameter as either an optional or a mandatory parameter. In the sample
`Get-Proc` cmdlet, the `Name` parameter is defined as optional because the `Mandatory` keyword is
not set in the attribute declaration.

## Supporting Parameter Validation

The sample `Get-Proc` cmdlet adds an input validation attribute,
[System.Management.Automation.Validatenotnulloremptyattribute](/dotnet/api/System.Management.Automation.ValidateNotNullOrEmptyAttribute),
to the `Name` parameter to enable validation that the input is neither `null` nor empty. This
attribute is one of several validation attributes provided by Windows PowerShell. For examples of
other validation attributes, see [Validating Parameter Input](./validating-parameter-input.md).

```
[Parameter(Position = 0)]
[ValidateNotNullOrEmpty]
public string[] Name
```

## Overriding an Input Processing Method

If your cmdlet is to handle command-line input, it must override the appropriate input processing
methods. The basic input processing methods are introduced in
[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md).

The `Get-Proc` cmdlet overrides the
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
method to handle the `Name` parameter input provided by the user or a script. This method gets the
processes for each requested process name, or all for processes if no name is provided. Notice that
in
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord),
the call to
[System.Management.Automation.Cmdlet.WriteObject%28System.Object%2CSystem.Boolean%29](/dotnet/api/system.management.automation.cmdlet.writeobject#System_Management_Automation_Cmdlet_WriteObject_System_Object_System_Boolean_)
is the output mechanism for sending output objects to the pipeline. The second parameter of this
call, `enumerateCollection`, is set to `true` to inform the Windows PowerShell runtime to enumerate
the output array of process objects and write one process at a time to the command line.

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
    }
  }
}
```

```vb
Protected Overrides Sub ProcessRecord()

    '/ If no process names are passed to the cmdlet, get all processes.
    If processNames Is Nothing Then
        Dim processes As Process()
        processes = Process.GetProcesses()
    End If

    '/ If process names are specified, write the processes to the
    '/ pipeline to display them or make them available to the next cmdlet.

    For Each name As String In processNames
        '/ The second parameter of this call tells PowerShell to enumerate the
        '/ array, and send one process at a time to the pipeline.
        WriteObject(Process.GetProcessesByName(name), True)
    Next

End Sub 'ProcessRecord
```

## Code Sample

For the complete C# sample code, see [GetProcessSample02 Sample](./getprocesssample02-sample.md).

## Defining Object Types and Formatting

Windows PowerShell passes information between cmdlets by using .NET Framework objects. Consequently,
a cmdlet might need to define its own type, or a cmdlet might need to extend an existing type
provided by another cmdlet. For more information about defining new types or extending existing
types, see
[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85)).

## Building the Cmdlet

After you implement a cmdlet, you must register it with Windows PowerShell by using a Windows
PowerShell snap-in. For more information about registering cmdlets, see
[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85)).

## Testing the Cmdlet

When your cmdlet is registered with Windows PowerShell, you can test it by running it on the command
line. Here are two ways to test the code for the sample cmdlet. For more information about using
cmdlets from the command line, see
[Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell).

- At the Windows PowerShell prompt, use the following command to list the Internet Explorer process,
  which is named "IEXPLORE."

  ```powershell
  get-proc -name iexplore
  ```

  The following output appears.

  ```Output
  Handles  NPM(K)  PM(K)   WS(K)  VS(M)  CPU(s)   Id   ProcessName
  -------  ------  -----   -----  -----   ------ --   -----------
      354      11  10036   18992    85   0.67   3284   iexplore
  ```

- To list the Internet Explorer, Outlook, and Notepad processes named "IEXPLORE," "OUTLOOK," and
  "NOTEPAD," use the following command. If there are multiple processes, all of them are displayed.

  ```powershell
  get-proc -name iexplore, outlook, notepad
  ```

  The following output appears.

  ```
  Handles  NPM(K)  PM(K)   WS(K)  VS(M)  CPU(s)   Id   ProcessName
  -------  ------  -----   -----  -----  ------   --   -----------
      732      21  24696    5000    138   2.25  2288   iexplore
      715      19  20556   14116    136   1.78  3860   iexplore
     3917      62  74096   58112    468 191.56  1848   OUTLOOK
       39       2   1024    3280     30   0.09  1444   notepad
       39       2   1024     356     30   0.08  3396   notepad
  ```

## See Also

[Adding Parameters that Process Pipeline Input](./adding-parameters-that-process-pipeline-input.md)

[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md)

[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell Reference](../windows-powershell-reference.md)

[Cmdlet Samples](./cmdlet-samples.md)
