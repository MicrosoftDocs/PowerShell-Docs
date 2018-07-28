---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Functions_Advanced_Methods
---

# About Functions Advanced Methods

## SHORT DESCRIPTION

Describes how functions that specify the `CmdletBinding` attribute can use the
methods and properties that are available to compiled cmdlets.

# LONG DESCRIPTION

Functions that specify the `CmdletBinding` attribute can access a number of
methods and properties through the `$pscmdlet` variable. These methods include
the following methods:

- Input-processing methods that compiled cmdlets use to do their work.
- The `ShouldProcess` and `ShouldContinue` methods that are used to get
  user feedback before an action is performed.
- The `ThrowTerminatingError` method for generating error records.
- Several Write methods that return different types of output.

All the methods and properties of the `PSCmdlet` class are available to
advanced functions. For more information about these methods and properties,
see [`System.Management.Automation.PSCmdlet`](http://go.microsoft.com/fwlink/?LinkId=142139) in the MSDN library.

### Input Processing Methods

The methods described in this section are referred to as the input processing
methods. For functions, these three methods are represented by the `Begin`,
`Process`, and `End` blocks of the function. Each function must include one or
more of these blocks. The Windows PowerShell runtime uses the code within
these blocks when it is running a function. (These blocks are also available
to functions that do not use the `CmdletBinding` attribute.)

#### Begin

This block is used to provide optional one-time preprocessing for the
function. The Windows PowerShell runtime uses the code in this block one time
for each instance of the function in the pipeline.

#### Process

This block is used to provide record-by-record processing for the function.
This block might be used any number of times, or not at all, depending on the
input to the function. For example, if the function is the first command in
the pipeline, the `Process` block will be used one time. If the function is
not the first command in the pipeline, the `Process` block is used one time
for every input that the function receives from the pipeline. If there is no
pipeline input, the `Process` block is not used.

This block must be defined if a function parameter is set to accept pipeline
input. If this block is not defined and the parameter accepts input from the
pipeline, the function will miss the values that are passed to the function
through the pipeline.

Also, when the function supports confirmation requests (when the
`SupportsShouldProcess` parameter of the Parameter attribute is set to
`$True`), the call to the `ShouldProcess` method must be made from within the
Process block.

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

### Confirmation Methods

#### ShouldProcess

This method is called to request confirmation from the user before the
function performs an action that would change the system. The function can
continue based on the Boolean value returned by the method. This method can be
called only from within the `Process{}` block of the function. And, the
`CmdletBinding` attribute must declare that the function supports
`ShouldProcess` (as shown in the previous example).

For more information about this method, see
[`System.Management.Automation.Cmdlet.ShouldProcess`](http://go.microsoft.com/fwlink/?LinkId=142142)
in the MSDN library.

For more information about how to request confirmation, see
[Requesting Confirmation](http://go.microsoft.com/fwlink/?LinkID=136658)
in the MSDN library.

#### ShouldContinue

This method is called to request a second confirmation message. It should be
called when the `ShouldProcess` method returns `$true`. For more information
about this method, see `System.Management.Automation.Cmdlet.ShouldContinue` in
the MSDN library at http://go.microsoft.com/fwlink/?LinkId=142143.

### Error Methods

Functions can call two different methods when errors occur. When a
nonterminating error occurs, the function should call the `WriteError` method,
which is described in the "Write Methods" section. When a terminating error
occurs and the function cannot continue, it should call the
`ThrowTerminatingError` method. You can also use the `Throw` statement for
terminating errors and the `Write-Error` cmdlet for nonterminating errors.

For more information, see
[`System.Management.Automation.Cmdlet.ThrowTerminatingError`](http://go.microsoft.com/fwlink/?LinkId=142144)
in the MSDN libray.

### Write Methods

A function can call the following methods to return different types of output.
Notice that not all the output goes to the next command in the pipeline. You
can also use the various Write cmdlets, such as Write-Error.

#### WriteCommandDetail

For information about the `WriteCommandDetails` method, see
[`System.Management.Automation.Cmdlet.WriteCommandDetail`](http://go.microsoft.com/fwlink/?LinkId=142155)
in the MSDN library.

#### WriteDebug

To provide information that can be used to troubleshoot a function, make the
function call the `WriteDebug` method. This displays debug messages to the
user. For more information, see
[`System.Management.Automation.Cmdlet.WriteDebug`](http://go.microsoft.com/fwlink/?LinkId=142156)
in the MSDN library.

#### WriteError

Functions should call this method when nonterminating errors occur and the
function is designed to continue processing records. For more information, see
[`System.Management.Automation.Cmdlet.WriteError`](http://go.microsoft.com/fwlink/?LinkId=142157)
in the MSDN library.

Note: If a terminating error occurs, the function should call the
`ThrowTerminatingError` method.

#### WriteObject

This method allows the function to send an object to the next command in the
pipeline. In most cases, this is the method to use when the function returns
data. For more information, see
[`System.Management.Automation.PSCmdlet.WriteObject`](http://go.microsoft.com/fwlink/?LinkId=142158)
in the MSDN library.

#### WriteProgress

For functions whose actions take a long time to complete, this method allows
the function to call the `WriteProgress` method so that progress information
is displayed. For example, you can display the percent completed. For more
information, see [`System.Management.Automation.PSCmdlet.WriteProgress`](http://go.microsoft.com/fwlink/?LinkId=142160)
in the MSDN library.

#### WriteVerbose

To provide detailed information about what the function is doing, make the
function call the `WriteVerbose` method to display verbose messages to the
user. By default, verbose messages are not displayed. For more information,
see
[`System.Management.Automation.PSCmdlet.WriteVerbose`](http://go.microsoft.com/fwlink/?LinkId=142162)
in the MSDN library.

#### WriteWarning

To provide information about conditions that may cause unexpected results,
make the function call the WriteWarning method to display warning messages to
the user. By default, warning messages are displayed. For more information,
see [`System.Management.Automation.PSCmdlet.WriteWarning`](http://go.microsoft.com/fwlink/?LinkId=142164)
in the MSDN library.

Note: You can also display warning messages by configuring the
`WarningPreference` variable or by using the `Verbose` and `Debug`
command-line options.

### Other Methods and Properties

For information about the other methods and properties that can be
accessed through the `$PSCmdlet` variable, see
[`System.Management.Automation.PSCmdlet`](http://go.microsoft.com/fwlink/?LinkId=142139)
in the MSDN library.

For example, the `ParameterSetName` property allows you to see the parameter
set that is being used. Parameter sets allow you to create a function that
performs different tasks based on the parameters that are specified when the
function is run.

## SEE ALSO

[about_Functions](about_Functions.md)

[about_Functions_Advanced](about_Functions_Advanced.md)

[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)

[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md)

[about_Functions_OutputTypeAttribute](about_Functions_OutputTypeAttribute.md)