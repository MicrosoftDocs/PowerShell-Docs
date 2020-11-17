---
description: Describes how functions that specify the `CmdletBinding` attribute can use the methods and properties that are available to compiled cmdlets.
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions_Advanced_Methods
---

# About Functions Advanced Methods

## Short description

Describes how functions that specify the `CmdletBinding` attribute can use the
methods and properties that are available to compiled cmdlets.

## Long description

Functions that specify the `CmdletBinding` attribute can access a number of
methods and properties through the `$PSCmdlet` variable. These methods include
the following methods:

- Input-processing methods that compiled cmdlets use to do their work.
- The `ShouldProcess` and `ShouldContinue` methods that are used to get user
  feedback before an action is performed.
- The `ThrowTerminatingError` method for generating error records.
- Several `Write` methods that return different types of output.

All the methods and properties of the **PSCmdlet** class are available to
advanced functions. For more information, see
[System.Management.Automation.PSCmdlet](/dotnet/api/system.management.automation.pscmdlet).

For more information about the `CmdletBinding` attribute, see
[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md).
For the **CmdletBindingAttribute** class, see
[System.Management.Automation.Cmdlet.CmdletBindingAttribute](/dotnet/api/system.management.automation.cmdletbindingattribute).

### Input processing methods

The methods described in this section are referred to as the input processing
methods. For functions, these three methods are represented by the `Begin`,
`Process`, and `End` blocks of the function. You aren't required to use any of
these blocks in your functions.

> [!NOTE]
> These blocks are also available to functions that don't use the
> `CmdletBinding` attribute.

#### Begin

This block is used to provide optional one-time preprocessing for the function.
The PowerShell runtime uses the code in this block once for each instance of
the function in the pipeline.

#### Process

This block is used to provide record-by-record processing for the function. You
can use a `Process` block without defining the other blocks. The number of
`Process` block executions depends on how you use the function and what input
the function receives.

The automatic variable `$_` or `$PSItem` contains the current object in the
pipeline for use in the `Process` block. The `$input` automatic variable
contains an enumerator that's only available to functions and script blocks.
For more information, see [about_Automatic_Variables](about_Automatic_Variables.md).

- Calling the function at the beginning, or outside of a pipeline, executes the
  `Process` block once.
- Within a pipeline, the `Process` block executes once for each input object
  that reaches the function.
- If the pipeline input that reaches the function is empty, the `Process` block
  **does not** execute.
  - The `Begin` and `End` blocks still execute.

> [!IMPORTANT]
> If a function parameter is set to accept pipeline input, and a `Process`
> block isn't defined, record-by-record processing will fail. In this case,
> your function will only execute once, regardless of the input.

#### End

This block is used to provide optional one-time post-processing for the
function.

The following example shows the outline of a function that contains a `Begin`
block for one-time preprocessing, a `Process` block for multiple record
processing, and an `End` block for one-time post-processing.

```powershell
Function Test-ScriptCmdlet
{
[CmdletBinding(SupportsShouldProcess=$True)]
    Param ($Parameter1)
    Begin{}
    Process{}
    End{}
}
```

> [!NOTE]
> Using either a `Begin` or `End` block requires that you define all three
> blocks. When using all three blocks, all PowerShell code must be inside one
> of the blocks.

### Confirmation methods

#### ShouldProcess

This method is called to request confirmation from the user before the function
performs an action that would change the system. The function can continue
based on the Boolean value returned by the method. This method can only be
called only from within the `Process{}` block of the function. The
`CmdletBinding` attribute must also declare that the function supports
`ShouldProcess` (as shown in the previous example).

For more information about this method, see
[System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/system.management.automation.cmdlet.shouldprocess).

For more information about how to request confirmation, see
[Requesting Confirmation](/powershell/scripting/developer/cmdlet/requesting-confirmation).

#### ShouldContinue

This method is called to request a second confirmation message. It should be
called when the `ShouldProcess` method returns `$true`. For more information
about this method, see
[System.Management.Automation.Cmdlet.ShouldContinue](/dotnet/api/system.management.automation.cmdlet.shouldcontinue).

### Error methods

Functions can call two different methods when errors occur. When a
non-terminating error occurs, the function should call the `WriteError` method,
which is described in the `Write` methods section. When a terminating error
occurs and the function can't continue, it should call the
`ThrowTerminatingError` method. You can also use the `Throw` statement for
terminating errors and the [Write-Error](xref:Microsoft.PowerShell.Utility.Write-Error)
cmdlet for non-terminating errors.

For more information, see
[System.Management.Automation.Cmdlet.ThrowTerminatingError](/dotnet/api/system.management.automation.cmdlet.throwterminatingerror).

### Write methods

A function can call the following methods to return different types of output.
Notice that not all the output goes to the next command in the pipeline. You
can also use the various `Write` cmdlets, such as `Write-Error`.

#### WriteCommandDetail

For information about the `WriteCommandDetails` method, see
[System.Management.Automation.Cmdlet.WriteCommandDetail](/dotnet/api/system.management.automation.cmdlet.writecommanddetail).

#### WriteDebug

To provide information that can be used to troubleshoot a function, make the
function call the `WriteDebug` method. The `WriteDebug` method displays debug
messages to the user. For more information, see
[System.Management.Automation.Cmdlet.WriteDebug](/dotnet/api/system.management.automation.cmdlet.writedebug).

#### WriteError

Functions should call this method when non-terminating errors occur and the
function is designed to continue processing records. For more information, see
[System.Management.Automation.Cmdlet.WriteError](/dotnet/api/system.management.automation.cmdlet.writeerror).

> [!NOTE]
> If a terminating error occurs, the function should call the
> [ThrowTerminatingError](/dotnet/api/system.management.automation.cmdlet.throwterminatingerror)
> method.

#### WriteObject

The `WriteObject` method allows the function to send an object to the next
command in the pipeline. In most cases, `WriteObject` is the method to use when
the function returns data. For more information, see
[System.Management.Automation.PSCmdlet.WriteObject](/dotnet/api/system.management.automation.cmdlet.writeobject).

#### WriteProgress

For functions with actions that take a long time to complete, this method
allows the function to call the `WriteProgress` method so that progress
information is displayed. For example, you can display the percent completed.
For more information, see
[System.Management.Automation.PSCmdlet.WriteProgress](/dotnet/api/system.management.automation.cmdlet.writeprogress).

#### WriteVerbose

To provide detailed information about what the function is doing, make the
function call the `WriteVerbose` method to display verbose messages to the
user. By default, verbose messages aren't displayed. For more information, see
[System.Management.Automation.PSCmdlet.WriteVerbose](/dotnet/api/system.management.automation.cmdlet.writeverbose).

#### WriteWarning

To provide information about conditions that may cause unexpected results, make
the function call the WriteWarning method to display warning messages to the
user. By default, warning messages are displayed. For more information, see
[System.Management.Automation.PSCmdlet.WriteWarning](/dotnet/api/system.management.automation.cmdlet.writewarning).

> [!NOTE]
> You can also display warning messages by configuring the `$WarningPreference`
> variable or by using the `Verbose` and `Debug` command-line options. for more
> information about the `$WarningPreference` variable, see [about_Preference_Variables](about_Preference_Variables.md).

### Other methods and properties

For information about the other methods and properties that can be accessed
through the `$PSCmdlet` variable, see
[System.Management.Automation.PSCmdlet](/dotnet/api/system.management.automation.pscmdlet).

For example, the
[ParameterSetName](/dotnet/api/system.management.automation.pscmdlet.parametersetname)
property allows you to see the parameter set that is being used. Parameter sets
allow you to create a function that performs different tasks based on the
parameters that are specified when the function is run.

## See also

[about_Automatic_Variables](about_Automatic_Variables.md)

[about_Functions](about_Functions.md)

[about_Functions_Advanced](about_Functions_Advanced.md)

[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)

[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md)

[about_Functions_OutputTypeAttribute](about_Functions_OutputTypeAttribute.md)

[about_Preference_Variables](about_Preference_Variables.md)

