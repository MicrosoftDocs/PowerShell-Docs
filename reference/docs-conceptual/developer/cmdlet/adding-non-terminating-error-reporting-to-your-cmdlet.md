---
ms.date: 09/13/2016
ms.topic: reference
title: Adding Non-Terminating Error Reporting to Your Cmdlet
description: Adding Non-Terminating Error Reporting to Your Cmdlet
---
# Adding Non-Terminating Error Reporting to Your Cmdlet

Cmdlets can report nonterminating errors by calling the
[System.Management.Automation.Cmdlet.WriteError][] method and still continue to operate on the
current input object or on further incoming pipeline objects. This section explains how to create a
cmdlet that reports nonterminating errors from its input processing methods.

For nonterminating errors (as well as terminating errors), the cmdlet must pass an
[System.Management.Automation.ErrorRecord][] object identifying the error. Each error record is
identified by a unique string called the "error identifier". In addition to the identifier, the
category of each error is specified by constants defined by a
[System.Management.Automation.ErrorCategory][] enumeration. The user can view errors based on their
category by setting the `$ErrorView` variable to "CategoryView".

For more information about error records, see
[Windows PowerShell Error Records](./windows-powershell-error-records.md).

## Defining the Cmdlet

The first step in cmdlet creation is always naming the cmdlet and declaring the .NET class that
implements the cmdlet. This cmdlet retrieves process information, so the verb name chosen here is
"Get". (Almost any sort of cmdlet that is capable of retrieving information can process command-line
input.) For more information about approved cmdlet verbs, see
[Cmdlet Verb Names](approved-verbs-for-windows-powershell-commands.md).

The following is the definition for this `Get-Proc` cmdlet. Details of this definition are given in
[Creating Your First Cmdlet](creating-a-cmdlet-without-parameters.md).

```csharp
[Cmdlet(VerbsCommon.Get, "proc")]
public class GetProcCommand: Cmdlet
```

```vb
<Cmdlet(VerbsCommon.Get, "Proc")> _
Public Class GetProcCommand
    Inherits Cmdlet
```

## Defining Parameters

If necessary, your cmdlet must define parameters for processing input. This Get-Proc cmdlet defines
a **Name** parameter as described in
[Adding Parameters that Process Command-Line Input](adding-parameters-that-process-command-line-input.md).

Here is the parameter declaration for the **Name** parameter of this Get-Proc cmdlet.

```csharp
[Parameter(
           Position = 0,
           ValueFromPipeline = true,
           ValueFromPipelineByPropertyName = true
)]
[ValidateNotNullOrEmpty]
public string[] Name
{
  get { return processNames; }
  set { processNames = value; }
}
private string[] processNames;
```

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

## Overriding Input Processing Methods

All cmdlets must override at least one of the input processing methods provided by the
[System.Management.Automation.Cmdlet][] class. These methods are discussed in
[Creating Your First Cmdlet](creating-a-cmdlet-without-parameters.md).

> [!NOTE]
> Your cmdlet should handle each record as independently as possible.

This Get-Proc cmdlet overrides the [System.Management.Automation.Cmdlet.ProcessRecord][] method to
handle the **Name** parameter for input provided by the user or a script. This method will get the
processes for each requested process name or all processes if no name is provided. Details of this
override are given in [Creating Your First Cmdlet](creating-a-cmdlet-without-parameters.md).

### Things to Remember When Reporting Errors

The [System.Management.Automation.ErrorRecord][] object that the cmdlet passes when writing an error
requires an exception at its core. Follow the .NET guidelines when determining the exception to use.
Basically, if the error is semantically the same as an existing exception, the cmdlet should use or
derive from that exception. Otherwise, it should derive a new exception or exception hierarchy
directly from the [System.Exception][] class.

When creating error identifiers (accessed through the FullyQualifiedErrorId property of the
ErrorRecord class) keep the following in mind.

- Use strings that are targeted for diagnostic purposes so that when inspecting the fully qualified
  identifier you can determine what the error is and where the error came from.

- A well formed fully qualified error identifier might be as follows.

  `CommandNotFoundException,Microsoft.PowerShell.Commands.GetCommandCommand`

Notice that in the previous example, the error identifier (the first token) designates what the
error is and the remaining part indicates where the error came from.

- For more complex scenarios, the error identifier can be a dot separated token that can be parsed
  on inspection. This allows you too branch on the parts of the error identifier as well as the
  error identifier and error category.

The cmdlet should assign specific error identifiers to different code paths. Keep the following
information in mind for assignment of error identifiers:

- An error identifier should remain constant throughout the cmdlet life cycle. Do not change the
  semantics of an error identifier between cmdlet versions.
- Use text for an error identifier that tersely corresponds to the error being reported. Do not use
  white space or punctuation.
- Have your cmdlet generate only error identifiers that are reproducible. For example, it should not
  generate an identifier that includes a process identifier. Error identifiers are useful to a user
  only when they correspond to identifiers that are seen by other users experiencing the same
  problem.

Unhandled exceptions are not caught by PowerShell in the following conditions:

- If a cmdlet creates a new thread and code running in that thread throws an unhandled exception,
  PowerShell will not catch the error and will terminate the process.
- If an object has code in its destructor or Dispose methods that causes an unhandled exception,
  PowerShell will not catch the error and will terminate the process.

## Reporting Nonterminating Errors

Any one of the input processing methods can report a nonterminating error to the output stream using
the [System.Management.Automation.Cmdlet.WriteError][] method.

Here is a code example from this Get-Proc cmdlet that illustrates the call to
[System.Management.Automation.Cmdlet.WriteError][] from within the override of the
[System.Management.Automation.Cmdlet.ProcessRecord][] method. In this case, the call is made if the
cmdlet cannot find a process for a specified process identifier.

```csharp
protected override void ProcessRecord()
{
  // If no name parameter passed to cmdlet, get all processes.
  if (processNames == null)
  {
    WriteObject(Process.GetProcesses(), true);
  }
    else
    {
      // If a name parameter is passed to cmdlet, get and write
      // the associated processes.
      // Write a nonterminating error for failure to retrieve
      // a process.
      foreach (string name in processNames)
      {
        Process[] processes;

        try
        {
          processes = Process.GetProcessesByName(name);
        }
        catch (InvalidOperationException ex)
        {
          WriteError(new ErrorRecord(
                     ex,
                     "NameNotFound",
                     ErrorCategory.InvalidOperation,
                     name));
          continue;
        }

        WriteObject(processes, true);
      } // foreach (...
    } // else
  }
```

### Things to Remember About Writing Nonterminating Errors

For a nonterminating error, the cmdlet must generate a specific error identifier for each specific
input object.

A cmdlet frequently needs to modify the PowerShell action produced by a nonterminating error. It can
do this by defining the `ErrorAction` and `ErrorVariable` parameters. If defining the `ErrorAction`
parameter, the cmdlet presents the user options [System.Management.Automation.ActionPreference][],
you can also directly influence the action by setting the `$ErrorActionPreference` variable.

The cmdlet can save nonterminating errors to a variable using the `ErrorVariable` parameter, which
is not affected by the setting of `ErrorAction`. Failures can be appended to an existing error
variable by adding a plus sign (+) to the front of the variable name.

## Code Sample

For the complete C# sample code, see [GetProcessSample04 Sample](./getprocesssample04-sample.md).

## Define Object Types and Formatting

PowerShell passes information between cmdlets using .NET objects. Consequently, a cmdlet might need
to define its own type, or the cmdlet might need to extend an existing type provided by another
cmdlet. For more information about defining new types or extending existing types, see
[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85)).

## Building the Cmdlet

After implementing a cmdlet, you must register it with Windows PowerShell through a Windows
PowerShell snap-in. For more information about registering cmdlets, see
[How to Register Cmdlets, Providers, and Host Applications](/previous-versions//ms714644(v=vs.85)).

## Testing the Cmdlet

When your cmdlet has been registered with PowerShell, you can test it by running it on the command
line. Let's test the sample Get-Proc cmdlet to see whether it reports an error:

- Start PowerShell, and use the Get-Proc cmdlet to retrieve the processes named "TEST".

  ```powershell
  get-proc -name test
  ```

  The following output appears.

  ```
  get-proc : Operation is not valid due to the current state of the object.
  At line:1 char:9
  + get-proc  <<<< -name test
  ```

## See Also

[Adding Parameters that Process Pipeline Input](./adding-parameters-that-process-pipeline-input.md)

[Adding Parameters that Process Command-Line Input](./adding-parameters-that-process-command-line-input.md)

[Creating Your First Cmdlet](./creating-a-cmdlet-without-parameters.md)

[Extending Object Types and Formatting](/previous-versions/ms714665(v=vs.85))

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell Reference](../windows-powershell-reference.md)

[Cmdlet Samples](./cmdlet-samples.md)

[System.Exception]: /dotnet/api/System.Exception
[System.Management.Automation.ActionPreference]: /dotnet/api/System.Management.Automation.ActionPreference
[System.Management.Automation.Cmdlet.ProcessRecord]: /dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord
[System.Management.Automation.Cmdlet.WriteError]: /dotnet/api/System.Management.Automation.Cmdlet.WriteError
[System.Management.Automation.Cmdlet]: /dotnet/api/System.Management.Automation.Cmdlet
[System.Management.Automation.ErrorCategory]: /dotnet/api/System.Management.Automation.ErrorCategory
[System.Management.Automation.ErrorRecord]: /dotnet/api/System.Management.Automation.ErrorRecord
