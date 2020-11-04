---
ms.date: 09/13/2016
ms.topic: reference
title: Strongly Encouraged Development Guidelines
description: Strongly Encouraged Development Guidelines
---
# Strongly Encouraged Development Guidelines

This section describes guidelines that you should follow when you write your cmdlets. They are
separated into guidelines for designing cmdlets and guidelines for writing your cmdlet code. You
might find that these guidelines are not applicable for every scenario. However, if they do apply
and you do not follow these guidelines, your users might have a poor experience when they use your
cmdlets.

## Design Guidelines

The following guidelines should be followed when designing cmdlets to ensure a consistent user
experience between using your cmdlets and other cmdlets. When you find a Design guideline that
applies to your situation, be sure to look at the Code guidelines for similar guidelines.

### Use a Specific Noun for a Cmdlet Name (SD01)

Nouns used in cmdlet naming need to be very specific so that the user can discover your cmdlets.
Prefix generic nouns such as "server" with a shortened version of the product name. For example, if
a noun refers to a server that is running an instance of Microsoft SQL Server, use a noun such as
"SQLServer". The combination of specific nouns and the short list of approved verbs enable the user
to quickly discover and anticipate functionality while avoiding duplication among cmdlet names.

To enhance the user experience, the noun that you choose for a cmdlet name should be singular. For
example, use the name `Get-Process` instead of **Get-Processes**. It is best to follow this rule for
all cmdlet names, even when a cmdlet is likely to act upon more than one item.

### Use Pascal Case for Cmdlet Names (SD02)

Use Pascal case for parameter names. In other words, capitalize the first letter of verb and all
terms used in the noun. For example, "`Clear-ItemProperty`".

### Parameter Design Guidelines (SD03)

A cmdlet needs parameters that receive the data on which it must operate, and parameters that
indicate information that is used to determine the characteristics of the operation. For example, a
cmdlet might have a `Name` parameter that receives data from the pipeline, and the cmdlet might have
a `Force` parameter to indicate that the cmdlet can be forced to perform its operation. There is no
limit to the number of parameters that a cmdlet can define.

#### Use Standard Parameter Names

Your cmdlet should use standard parameter names so that the user can quickly determine what a
particular parameter means. If a more specific name is required, use a standard parameter name, and
then specify a more specific name as an alias. For example, the `Get-Service` cmdlet has a parameter
that has a generic name (`Name`) and a more specific alias (`ServiceName`). Both terms can be used
to specify the parameter.

For more information about parameter names and their data types, see
[Cmdlet Parameter Name and Functionality Guidelines](./standard-cmdlet-parameter-names-and-types.md).

#### Use Singular Parameter Names

Avoid using plural names for parameters whose value is a single element. This includes parameters
that take arrays or lists because the user might supply an array or list with only one element.

Plural parameter names should be used only in those cases where the value of the parameter is always
a multiple-element value. In these cases, the cmdlet should verify that multiple elements are
supplied, and the cmdlet should display a warning to the user if multiple elements are not supplied.

#### Use Pascal Case for Parameter Names

Use Pascal case for parameter names. In other words, capitalize the first letter of each word in the
parameter name, including the first letter of the name. For example, the parameter name
`ErrorAction` uses the correct capitalization. The following parameter names use incorrect
capitalization:

- `errorAction`
- `erroraction`

#### Parameters That Take a List of Options

There are two ways to create a parameter whose value can be selected from a set of options.

- Define an enumeration type (or use an existing enumeration type) that specifies the valid values.
  Then, use the enumeration type to create a parameter of that type.

- Add the **ValidateSet** attribute to the parameter declaration. For more information about this
  attribute, see [ValidateSet Attribute Declaration](./validateset-attribute-declaration.md).

#### Use Standard Types for Parameters

To ensure consistency with other cmdlets, use standard types for parameters where ever possible. For
more information about the types that should be used for different parameter, see
[Standard Cmdlet Parameter Names and Types](./standard-cmdlet-parameter-names-and-types.md). This
topic provides links to several topics that describe the names and .NET Framework types for groups
of standard parameters, such as the "activity parameters".

#### Use Strongly-Typed .NET Framework Types

Parameters should be defined as .NET Framework types to provide better parameter validation. For
example, parameters that are restricted to one value from a set of values should be defined as an
enumeration type. To support a Uniform Resource Identifier (URI) value, define the parameter as a
[System.Uri](/dotnet/api/System.Uri) type. Avoid basic string parameters for all but free-form text
properties.

#### Use Consistent Parameter Types

When the same parameter is used by multiple cmdlets, always use the same parameter type. For
example, if the `Process` parameter is an [System.Int16](/dotnet/api/System.Int16) type for one
cmdlet, do not make the `Process` parameter for another cmdlet a
[System.Uint16](/dotnet/api/System.UInt16) type.

#### Parameters That Take True and False

If your parameter takes only `true` and `false`, define the parameter as type
[System.Management.Automation.SwitchParameter](/dotnet/api/System.Management.Automation.SwitchParameter).
A switch parameter is treated as `true` when it is specified in a command. If the parameter is not
included in a command, Windows PowerShell considers the value of the parameter to be `false`. Do not
define Boolean parameters.

If your parameter needs to differentiate between 3 values: $true, $false and "unspecified", then
define a parameter of type Nullable\<bool>. The need for a 3rd, "unspecified" value typically occurs
when the cmdlet can modify a Boolean property of an object. In this case "unspecified" means to not
change the current value of the property.

#### Support Arrays for Parameters

Frequently, users must perform the same operation against multiple arguments. For these users, a
cmdlet should accept an array as parameter input so that a user can pass the arguments into the
parameter as a Windows PowerShell variable. For example, the
[Get-Process](/powershell/module/Microsoft.PowerShell.Management/Get-Process) cmdlet uses an array
for the strings that identify the names of the processes to retrieve.

#### Support the PassThru Parameter

By default, many cmdlets that modify the system, such as the
[Stop-Process](/powershell/module/Microsoft.PowerShell.Management/Stop-Process) cmdlet, act as
"sinks" for objects and do not return a result. These cmdlet should implement the `PassThru`
parameter to force the cmdlet to return an object. When the `PassThru` parameter is specified, the
cmdlet returns an object by using a call to the
[System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)
method. For example, the following command stops the Calc process and passes the resultant process
to the pipeline.

```powershell
Stop-Process calc -passthru
```

In most cases, Add, Set, and New cmdlets should support a `PassThru` parameter.

#### Support Parameter Sets

A cmdlet is intended to accomplish a single purpose. However, there is frequently more than one way
to describe the operation or the operation target. For example, a process might be identified by its
name, by its identifier, or by a process object. The cmdlet should support all the reasonable
representations of its targets. Normally, the cmdlet satisfies this requirement by specifying sets
of parameters (referred to as parameter sets) that operate together. A single parameter can belong
to any number of parameter sets. For more information about parameter sets, see
[Cmdlet Parameter Sets](./cmdlet-parameter-sets.md).

When you specify parameter sets, set only one parameter in the set to ValueFromPipeline. For more
information about how to declare the **Parameter** attribute, see
[ParameterAttribute Declaration](./parameter-attribute-declaration.md).

When parameter sets are used, the default parameter set is defined by the **Cmdlet** attribute. The
default parameter set should include the parameters most likely to be used in an interactive Windows
PowerShell session. For more information about how to declare the **Cmdlet** attribute, see
[CmdletAttribute Declaration](./cmdlet-attribute-declaration.md).

### Provide Feedback to the User (SD04)

Use the guidelines in this section to provide feedback to the user. This feedback allows the user to
be aware of what is occurring in the system and to make better administrative decisions.

The Windows PowerShell runtime allows a user to specify how to handle output from each call to the
`Write` method by setting a preference variable. The user can set several preference variables,
including a variable that determines whether the system should display information and a variable
that determines whether the system should query the user before taking further action.

#### Support the WriteWarning, WriteVerbose, and WriteDebug Methods

A cmdlet should call the
[System.Management.Automation.Cmdlet.WriteWarning](/dotnet/api/System.Management.Automation.Cmdlet.WriteWarning)
method when the cmdlet is about to perform an operation that might have an unintended result. For
example, a cmdlet should call this method if the cmdlet is about to overwrite a read-only file.

A cmdlet should call the
[System.Management.Automation.Cmdlet.WriteVerbose](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose)
method when the user requires some detail about what the cmdlet is doing. For example, a cmdlet
should call this information if the cmdlet author feels that there are scenarios that might require
more information about what the cmdlet is doing.

The cmdlet should call the
[System.Management.Automation.Cmdlet.WriteDebug](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug)
method when a developer or product support engineer must understand what has corrupted the cmdlet
operation. It is not necessary for the cmdlet to call the
[System.Management.Automation.Cmdlet.WriteDebug](/dotnet/api/System.Management.Automation.Cmdlet.WriteDebug)
method in the same code that calls the
[System.Management.Automation.Cmdlet.WriteVerbose](/dotnet/api/System.Management.Automation.Cmdlet.WriteVerbose)
method because the `Debug` parameter presents both sets of information.

#### Support WriteProgress for Operations that take a Long Time

Cmdlet operations that take a long time to complete and that cannot run in the background should
support progress reporting through periodic calls to the
[System.Management.Automation.Cmdlet.WriteProgress](/dotnet/api/System.Management.Automation.Cmdlet.WriteProgress)
method.

#### Use the Host Interfaces

Occasionally, a cmdlet must communicate directly with the user instead of by using the various Write
or Should methods supported by the
[System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) class. In
this case, the cmdlet should derive from the
[System.Management.Automation.PSCmdlet](/dotnet/api/System.Management.Automation.PSCmdlet) class and
use the
[System.Management.Automation.PSCmdlet.Host*](/dotnet/api/System.Management.Automation.PSCmdlet.Host)
property. This property supports different levels of communication type, including the
PromptForChoice, Prompt, and WriteLine/ReadLine types. At the most specific level, it also provides
ways to read and write individual keys and to deal with buffers.

Unless a cmdlet is specifically designed to generate a graphical user interface (GUI), it should not
bypass the host by using the
[System.Management.Automation.PSCmdlet.Host*](/dotnet/api/System.Management.Automation.PSCmdlet.Host)
property. An example of a cmdlet that is designed to generate a GUI is the
[Out-GridView](/powershell/module/Microsoft.PowerShell.Utility/Out-GridView) cmdlet.

> [!NOTE]
> Cmdlets should not use the [System.Console](/dotnet/api/System.Console) API.

### Create a Cmdlet Help File (SD05)

For each cmdlet assembly, create a Help.xml file that contains information about the cmdlet. This
information includes a description of the cmdlet, descriptions of the cmdlet's parameters, examples
of the cmdlet's use, and more.

## Code Guidelines

The following guidelines should be followed when coding cmdlets to ensure a consistent user
experience between using your cmdlets and other cmdlets. When you find a Code guideline that applies
to your situation, be sure to look at the Design guidelines for similar guidelines.

### Coding Parameters (SC01)

Define a parameter by declaring a public property of the cmdlet class that is decorated with the
**Parameter** attribute. Parameters do not have to be static members of the derived .NET Framework
class for the cmdlet. For more information about how to declare the **Parameter** attribute, see
[Parameter Attribute Declaration](./parameter-attribute-declaration.md).

#### Support Windows PowerShell Paths

The Windows PowerShell path is the mechanism for normalizing access to namespaces. When you assign a
Windows PowerShell path to a parameter in the cmdlet, the user can define a custom "drive" that acts
as a shortcut to a specific path. When a user designates such a drive, stored data, such as data in
the Registry, can be used in a consistent way.

If your cmdlet allows the user to specify a file or a data source, it should define a parameter of
type [System.String](/dotnet/api/System.String). If more than one drive is supported, the type
should be an array. The name of the parameter should be `Path`, with an alias of `PSPath`.
Additionally, the `Path` parameter should support wildcard characters. If support for wildcard
characters is not required, define a `LiteralPath` parameter.

If the data that the cmdlet reads or writes has to be a file, the cmdlet should accept Windows
PowerShell path input, and the cmdlet should use the
[System.Management.Automation.Sessionstate.Path](/dotnet/api/System.Management.Automation.SessionState.Path)
property to translate the Windows PowerShell paths into paths that the file system recognizes. The
specific mechanisms include the following methods:

- [System.Management.Automation.PSCmdlet.GetResolvedProviderPathFromPSPath](/dotnet/api/System.Management.Automation.PSCmdlet.GetResolvedProviderPathFromPSPath)
- [System.Management.Automation.PSCmdlet.GetUnresolvedProviderPathFromPSPath](/dotnet/api/System.Management.Automation.PSCmdlet.GetUnresolvedProviderPathFromPSPath)
- [System.Management.Automation.PathIntrinsics.GetResolvedProviderPathFromPSPath](/dotnet/api/System.Management.Automation.PathIntrinsics.GetResolvedProviderPathFromPSPath)
- [System.Management.Automation.PathIntrinsics.GetUnresolvedProviderPathFromPSPath](/dotnet/api/System.Management.Automation.PathIntrinsics.GetUnresolvedProviderPathFromPSPath)

If the data that the cmdlet reads or writes is only a set of strings instead of a file, the cmdlet
should use the provider content information (`Content` member) to read and write. This information
is obtained from the
[System.Management.Automation.Provider.CmdletProvider.InvokeProvider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider.InvokeProvider)
property. These mechanisms allow other data stores to participate in the reading and writing of
data.

#### Support Wildcard Characters

A cmdlet should support wildcard characters if possible. Support for wildcard characters occurs in
many places in a cmdlet (especially when a parameter takes a string to identify one object from a
set of objects). For example, the sample **Stop-Proc** cmdlet from the
[StopProc Tutorial](./stopproc-tutorial.md) defines a `Name` parameter to handle strings that
represent process names. This parameter supports wildcard characters so that the user can easily
specify the processes to stop.

When support for wildcard characters is available, a cmdlet operation usually produces an array.
Occasionally, it does not make sense to support an array because the user might use only a single
item at a time. For example, the
[Set-Location](/powershell/module/Microsoft.PowerShell.Management/Set-Location) cmdlet does not need
to support an array because the user is setting only a single location. In this instance, the cmdlet
still supports wildcard characters, but it forces resolution to a single location.

For more information about wildcard-character patterns, see
[Supporting Wildcard Characters in Cmdlet Parameters](./supporting-wildcard-characters-in-cmdlet-parameters.md).

#### Defining Objects

This section contains guidelines for defining objects for cmdlets and for extending existing
objects.

##### Define Standard Members

Define standard members to extend an object type in a custom Types.ps1xml file (use the Windows
PowerShell Types.ps1xml file as a template). Standard members are defined by a node with the name
PSStandardMembers. These definitions allow other cmdlets and the Windows PowerShell runtime to work
with your object in a consistent way.

##### Define ObjectMembers to Be Used as Parameters

If you are designing an object for a cmdlet, ensure that its members map directly to the parameters
of the cmdlets that will use it. This mapping allows the object to be easily sent to the pipeline
and to be passed from one cmdlet to another.

Preexisting .NET Framework objects that are returned by cmdlets are frequently missing some
important or convenient members that are needed by the script developer or user. These missing
members can be particularly important for display and for creating the correct member names so that
the object can be correctly passed to the pipeline. Create a custom Types.ps1xml file to document
these required members. When you create this file, we recommend the following naming convention:
*<Your_Product_Name>*.Types.ps1xml.

For example, you could add a `Mode` script property to the
[System.IO.FileInfo](/dotnet/api/System.IO.FileInfo) type to display the attributes of a file more
clearly. Additionally, you could add a `Count` alias property to the
[System.Array](/dotnet/api/System.Array) type to allow the consistent use of that property name
(instead of `Length`).

##### Implement the IComparable Interface

Implement a [System.IComparable](/dotnet/api/System.IComparable) interface on all output objects.
This allows the output objects to be easily piped to various sorting and analysis cmdlets.

##### Update Display Information

If the display for an object does not provide the expected results, create a custom
*\<YourProductName>*.Format.ps1xml file for that object.

### Support Well Defined Pipeline Input (SC02)

#### Implement for the Middle of a Pipeline

Implement a cmdlet assuming that it will be called from the middle of a pipeline (that is, other
cmdlets will produce its input or consume its output). For example, you might assume that the
`Get-Process` cmdlet, because it generates data, is used only as the first cmdlet in a pipeline.
However, because this cmdlet is designed for the middle of a pipeline, this cmdlet allows previous
cmdlets or data in the pipeline to specify the processes to retrieve.

#### Support Input from the Pipeline

In each parameter set for a cmdlet, include at least one parameter that supports input from the
pipeline. Support for pipeline input allows the user to retrieve data or objects, to send them to
the correct parameter set, and to pass the results directly to a cmdlet.

A parameter accepts input from the pipeline if the **Parameter** attribute includes the
`ValueFromPipeline` keyword, the `ValueFromPipelineByPropertyName` keyword attribute, or both
keywords in its declaration. If none of the parameters in a parameter set support the
`ValueFromPipeline` or `ValueFromPipelineByPropertyName` keywords, the cmdlet cannot meaningfully be
placed after another cmdlet because it will ignore any pipeline input.

#### Support the ProcessRecord Method

To accept all the records from the preceding cmdlet in the pipeline, your cmdlet must implement the
[System.Management.Automation.Cmdlet.ProcessRecord](/dotnet/api/System.Management.Automation.Cmdlet.ProcessRecord)
method. Windows PowerShell calls this method multiple times, once for every record that is sent to
your cmdlet.

### Write Single Records to the Pipeline (SC03)

When a cmdlet returns objects, the cmdlet should write the objects immediately as they are
generated. The cmdlet should not hold them in order to buffer them into a combined array. The
cmdlets that receive the objects as input will then be able to process, display, or process and
display the output objects without delay. A cmdlet that generates output objects one at a time
should call the
[System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)
method. A cmdlet that generates output objects in batches (for example, because an underlying API
returns an array of output objects) should call the
[System.Management.Automation.Cmdlet.WriteObject](/dotnet/api/System.Management.Automation.Cmdlet.WriteObject)
Method with its second parameter set to `true`.

### Make Cmdlets Case-Insensitive and Case-Preserving (SC04)

By default, Windows PowerShell itself is case-insensitive. However, because it deals with many
preexisting systems, Windows PowerShell does preserve case for ease of operation and compatibility.
In other words, if a character is supplied in uppercase letters, Windows PowerShell keeps it in
uppercase letters. For systems to work well, a cmdlet needs to follow this convention. If possible,
it should operate in a case-insensitive way. It should, however, preserve the original case for
cmdlets that occur later in a command or in the pipeline.

## See Also

[Required Development Guidelines](./required-development-guidelines.md)

[Advisory Development Guidelines](./advisory-development-guidelines.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
