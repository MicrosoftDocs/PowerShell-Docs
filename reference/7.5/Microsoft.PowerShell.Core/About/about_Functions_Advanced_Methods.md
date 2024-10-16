---
description: Describes how functions that specify the `CmdletBinding` attribute can use the methods and properties that are available to compiled cmdlets.
Locale: en-US
ms.date: 10/16/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_methods?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions_Advanced_Methods
---

# about_Functions_Advanced_Methods

## Short description

Describes how functions that specify the `CmdletBinding` attribute can use the
methods and properties that are available to compiled cmdlets.

## Long description

Functions that specify the `CmdletBinding` attribute can access additional
methods and properties through the `$PSCmdlet` variable. These methods include
the following methods:

- The same input-processing methods available to all functions.
- The `ShouldProcess` and `ShouldContinue` methods that are used to get user
  feedback before an action is performed.
- The `ThrowTerminatingError` method for generating error records.
- Several `Write` methods that return different types of output.

All the methods and properties of the **PSCmdlet** class are available to
advanced functions. For more information, see
[System.Management.Automation.PSCmdlet][12].

For more information about the `CmdletBinding` attribute, see
[about_Functions_CmdletBindingAttribute][18]. For the
**CmdletBindingAttribute** class, see
[System.Management.Automation.Cmdlet.CmdletBindingAttribute][11].

## Input processing methods

The methods described in this section are referred to as the input processing
methods. For functions, these three methods are represented by the `begin`,
`process`, and `end` blocks of the function. PowerShell 7.3 adds a `clean`
block process method.

You aren't required to use any of these blocks in your functions. If you don't
use a named block, then PowerShell puts the code in the `end` block of the
function. However, if you use any of these named blocks, or define a
`dynamicparam` block, you must put all code in a named block.

The following example shows the outline of a function that contains a `begin`
block for one-time preprocessing, a `process` block for multiple record
processing, and an `end` block for one-time post-processing.

```powershell
Function Test-ScriptCmdlet
{
[CmdletBinding(SupportsShouldProcess=$True)]
    param ($Parameter1)
    begin{}
    process{}
    end{}
    clean{}
}
```

> [!NOTE]
> These blocks apply to all functions, not just functions that use the
> `CmdletBinding` attribute.

### `begin`

This block is used to provide optional one-time preprocessing for the function.
The PowerShell runtime uses the code in this block once for each instance of
the function in the pipeline.

### `process`

This block is used to provide record-by-record processing for the function. You
can use a `process` block without defining the other blocks. The number of
`process` block executions depends on how you use the function and what input
the function receives.

The automatic variable `$_` or `$PSItem` contains the current object in the
pipeline for use in the `process` block. The `$input` automatic variable
contains an enumerator that's only available to functions and script blocks.
For more information, see [about_Automatic_Variables][15].

- Calling the function at the beginning, or outside of a pipeline, executes the
  `process` block once.
- Within a pipeline, the `process` block executes once for each input object
  that reaches the function.
- If the pipeline input that reaches the function is empty, the `process` block
  **does not** execute.
  - The `begin`, `end`, and `clean` blocks still execute.

> [!IMPORTANT]
> If a function parameter is set to accept pipeline input, and a `process`
> block isn't defined, record-by-record processing will fail. In this case,
> your function will only execute once, regardless of the input.

When you create a function that accepts pipeline input and uses
`CmdletBinding`, the `process` block should use the parameter variable you
defined for pipeline input instead of `$_` or `$PSItem`. For example:

```powershell
function Get-SumOfNumbers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [int[]]$Numbers
    )

    begin { $retValue = 0 }

    process {
       foreach ($n in $Numbers) {
           $retValue += $n
       }
    }

    end { $retValue }
}

PS> Get-SumOfNumbers 1,2,3,4
10
PS> 1,2,3,4 | Get-SumOfNumbers
10
```

### `end`

This block is used to provide optional one-time post-processing for the
function.

### `clean`

The `clean` block was added in PowerShell 7.3.

The `clean` block is a convenient way for users to clean up resources that span
across the `begin`, `process`, and `end` blocks. It's semantically similar to a
`finally` block that covers all other named blocks of a script function or a
script cmdlet. Resource cleanup is enforced for the following scenarios:

1. when the pipeline execution finishes normally without terminating error
1. when the pipeline execution is interrupted due to terminating error
1. when the pipeline is halted by `Select-Object -First`
1. when the pipeline is being stopped by <kbd>Ctrl+c</kbd> or
   `StopProcessing()`

The clean block discards any output that's written to the **Success** stream.

> [!CAUTION]
> Adding the `clean` block is a breaking change. Because `clean` is parsed as a
> keyword, it prevents users from directly calling a command named `clean` as
> the first statement in a script block. However, it's not likely to be a
> problem. The command can still be invoked using the call operator
> (`& clean`).

## Confirmation methods

### ShouldProcess

This method is called to request confirmation from the user before the function
performs an action that would change the system. The function can continue
based on the Boolean value returned by the method. This method can only be
called only from within the `Process{}` block of the function. The
`CmdletBinding` attribute must also declare that the function supports
`ShouldProcess` (as shown in the previous example).

For more information about this method, see
[System.Management.Automation.Cmdlet.ShouldProcess][02].

For more information about how to request confirmation, see
[Requesting Confirmation][14].

### ShouldContinue

This method is called to request a second confirmation message. It should be
called when the `ShouldProcess` method returns `$true`. For more information
about this method, see
[System.Management.Automation.Cmdlet.ShouldContinue][01].

## Error methods

Functions can call two different methods when errors occur. When a
non-terminating error occurs, the function should call the `WriteError` method,
which is described in the `Write` methods section. When a terminating error
occurs and the function can't continue, it should call the
`ThrowTerminatingError` method. You can also use the `Throw` statement for
terminating errors and the [Write-Error][22] cmdlet for non-terminating errors.

For more information, see
[System.Management.Automation.Cmdlet.ThrowTerminatingError][03].

## Write methods

A function can call the following methods to return different types of output.
Notice that not all the output goes to the next command in the pipeline. You
can also use the various `Write` cmdlets, such as `Write-Error`.

### WriteCommandDetail

For information about the `WriteCommandDetails` method, see
[System.Management.Automation.Cmdlet.WriteCommandDetail][04].

### WriteDebug

To provide information that can be used to troubleshoot a function, make the
function call the `WriteDebug` method. The `WriteDebug` method displays debug
messages to the user. For more information, see
[System.Management.Automation.Cmdlet.WriteDebug][05].

### WriteError

Functions should call this method when non-terminating errors occur and the
function is designed to continue processing records. For more information, see
[System.Management.Automation.Cmdlet.WriteError][06].

> [!NOTE]
> If a terminating error occurs, the function should call the
> [ThrowTerminatingError][03] method.

### WriteObject

The `WriteObject` method allows the function to send an object to the next
command in the pipeline. In most cases, `WriteObject` is the method to use when
the function returns data. For more information, see
[System.Management.Automation.PSCmdlet.WriteObject][07].

### WriteProgress

For functions with actions that take a long time to complete, this method
allows the function to call the `WriteProgress` method so that progress
information is displayed. For example, you can display the percent completed.
For more information, see
[System.Management.Automation.PSCmdlet.WriteProgress][08].

### WriteVerbose

To provide detailed information about what the function is doing, make the
function call the `WriteVerbose` method to display verbose messages to the
user. By default, verbose messages aren't displayed. For more information, see
[System.Management.Automation.PSCmdlet.WriteVerbose][09].

### WriteWarning

To provide information about conditions that may cause unexpected results, make
the function call the WriteWarning method to display warning messages to the
user. By default, warning messages are displayed. For more information, see
[System.Management.Automation.PSCmdlet.WriteWarning][10].

> [!NOTE]
> You can also display warning messages by configuring the `$WarningPreference`
> variable or by using the `Verbose` and `Debug` command-line options. for more
> information about the `$WarningPreference` variable, see
> [about_Preference_Variables][21].

## Other methods and properties

For information about the other methods and properties that can be accessed
through the `$PSCmdlet` variable, see
[System.Management.Automation.PSCmdlet][12].

For example, the [ParameterSetName][13] property allows you to see the
parameter set that's being used. Parameter sets allow you to create a function
that performs different tasks based on the parameters that are specified when
the function is run.

## See also

- [about_Automatic_Variables][15]
- [about_Functions][20]
- [about_Functions_Advanced][17]
- [about_Functions_Advanced_Parameters][16]
- [about_Functions_CmdletBindingAttribute][18]
- [about_Functions_OutputTypeAttribute][19]
- [about_Preference_Variables][21]

<!-- link references -->
[01]: /dotnet/api/system.management.automation.cmdlet.shouldcontinue
[02]: /dotnet/api/system.management.automation.cmdlet.shouldprocess
[03]: /dotnet/api/system.management.automation.cmdlet.throwterminatingerror
[04]: /dotnet/api/system.management.automation.cmdlet.writecommanddetail
[05]: /dotnet/api/system.management.automation.cmdlet.writedebug
[06]: /dotnet/api/system.management.automation.cmdlet.writeerror
[07]: /dotnet/api/system.management.automation.cmdlet.writeobject
[08]: /dotnet/api/system.management.automation.cmdlet.writeprogress
[09]: /dotnet/api/system.management.automation.cmdlet.writeverbose
[10]: /dotnet/api/system.management.automation.cmdlet.writewarning
[11]: /dotnet/api/system.management.automation.cmdletbindingattribute
[12]: /dotnet/api/system.management.automation.pscmdlet
[13]: /dotnet/api/system.management.automation.pscmdlet.parametersetname
[14]: /powershell/scripting/developer/cmdlet/requesting-confirmation
[15]: about_Automatic_Variables.md
[16]: about_Functions_Advanced_Parameters.md
[17]: about_Functions_Advanced.md
[18]: about_Functions_CmdletBindingAttribute.md
[19]: about_Functions_OutputTypeAttribute.md
[20]: about_Functions.md
[21]: about_Preference_Variables.md
[22]: xref:Microsoft.PowerShell.Utility.Write-Error
