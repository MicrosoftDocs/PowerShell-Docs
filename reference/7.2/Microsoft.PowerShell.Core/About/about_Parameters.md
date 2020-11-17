---
description: Describes how to work with command parameters in PowerShell.
Locale: en-US
ms.date: 02/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameters?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Parameters
---
# About Parameters

## Short description
Describes how to work with command parameters in PowerShell.

## Long description

Most PowerShell commands, such as cmdlets, functions, and scripts,
rely on parameters to allow users to select options or provide input. The
parameters follow the command name and have the following form:

```
-<parameter_name> <parameter_value>
-<parameter_name>:<parameter_value>
```

The name of the parameter is preceded by a hyphen (-), which signals to PowerShell that the word
following the hyphen is a parameter name. The parameter name and value can be separated by a space
or a colon character. Some parameters do not require or accept a parameter value. Other parameters
require a value, but do not require the parameter name in the command.

The type of parameters and the requirements for those parameters vary. To find
information about the parameters of a command, use the `Get-Help` cmdlet. For
example, to find information about the parameters of the `Get-ChildItem` cmdlet,
type:

```powershell
Get-Help Get-ChildItem
```

To find information about the parameters of a script, use the full path to the
script file. For example:

```powershell
Get-Help $home\Documents\Scripts\Get-Function.ps1
```

The `Get-Help` cmdlet returns various details about the command, including a
description, the command syntax, information about the parameters, and
examples showing how to use the parameters in a command.

You can also use the Parameter parameter of the `Get-Help` cmdlet to find
information about a particular parameter. Or, you can use the **Parameter**
parameter with the wildcard character ( `*` ) value to find information about
all parameters of the command. For example, the following command gets
information about all parameters of the `Get-Member` cmdlet:

```powershell
Get-Help Get-Member -Parameter *
```

### Default parameter values

Optional parameters have a default value, which is the value that is used or
assumed when the parameter is not specified in the command.

For example, the default value of the **ComputerName** parameter of many
cmdlets is the name of the local computer. As a result, the local computer name
is used in the command unless the **ComputerName** parameter is specified.

To find the default parameter value, see help topic for the cmdlet. The
parameter description should include the default value.

You can also set a custom default value for any parameter of a cmdlet or
advanced function. For information about setting custom default values, see
[about_Parameters_Default_Values](about_Parameters_Default_Values.md).

### Parameter attribute table

When you use the **Full**, **Parameter**, or **Online** parameters of the
`Get-Help` cmdlet, `Get-Help` displays a parameter attribute table with
detailed information about the parameter.

This information includes the details you need to know to use the parameter.
For example, the help topic for the `Get-ChildItem` cmdlet includes the
following details about its Path parameter:

```
-path <string[]>
    Specifies a path of one or more locations. Wildcard characters are
    permitted. The default location is the current directory (.).

Required?                    false
Position?                    0
Default value                Current directory
Accept pipeline input?       true (ByValue, ByPropertyName)
Accept wildcard characters?  true
```

The parameter information includes the parameter syntax, a description of the
parameter, and the parameter attributes. The following sections describe the
parameter attributes.

#### Parameter Required

This setting indicates whether the parameter is mandatory, that is, whether
all commands that use this cmdlet must include this parameter. When the value
is **True** and the parameter is missing from the command, PowerShell
prompts you for a value for the parameter.

#### Parameter Position

If the `Position` setting is set to a positive integer, the parameter name is
not required. This type of parameter is referred to as a positional parameter,
and the number indicates the position in which the parameter must appear in
relation to other positional parameters. A named parameter can be listed in any
position after the cmdlet name. If you include the parameter name for a
positional parameter, the parameter can be listed in any position after the
cmdlet name.

For example, the `Get-ChildItem` cmdlet has Path and Exclude parameters. The
`Position` setting for **Path** is **0**, which means that it is a positional
parameter. The `Position` setting for **Exclude** is **named**.

This means that **Path** does not require the parameter name, but its parameter
value must be the first or only unnamed parameter value in the command.
However, because the Exclude parameter is a named parameter, you can place it
in any position in the command.

As a result of the `Position` settings for these two parameters, you can use
any of the following commands:

```powershell
Get-ChildItem -Path c:\techdocs -Exclude *.ppt
Get-ChildItem c:\techdocs -Exclude *.ppt
Get-ChildItem -Exclude *.ppt -Path c:\techdocs
Get-ChildItem -Exclude *.ppt c:\techdocs
```

If you were to include another positional parameter without including the
parameter name, that parameter must be placed in the order specified by the
`Position` setting.

#### Parameter Type

This setting specifies the Microsoft .NET Framework type of the parameter
value. For example, if the type is **Int32**, the parameter value must be an
integer. If the type is string, the parameter value must be a character
string. If the string contains spaces, the value must be enclosed in quotation
marks, or the spaces must be preceded by the escape character ( ` ).

#### Default Value

This setting specifies the value that the parameter will assume if no other
value is provided. For example, the default value of the Path parameter is
often the current directory. Required parameters never have a default value.
For many optional parameters, there is no default because the parameter has no
effect if it is not used.

#### Accepts Multiple Values

This setting indicates whether a parameter accepts multiple parameter values.
When a parameter accepts multiple values, you can type a comma-separated list
as the value of the parameter in the command, or save a comma-separated list
(an array) in a variable, and then specify the variable as the parameter
value.

For example, the ServiceName parameter of the `Get-Service` cmdlet accepts
multiple values. The following commands are both valid:

```powershell
Get-Service -servicename winrm, netlogon
```

```powershell
$s = "winrm", "netlogon"
Get-Service -servicename $s
```

#### Accepts Pipeline Input

This setting indicates whether you can use the pipeline operator ( `|` ) to
send a value to the parameter.

```
Value                    Description
-----                    -----------
False                    Indicates that you cannot pipe a value to the
                         parameter.

True (by Value)          Indicates that you can pipe any value to the
                         parameter, just so the value has the .NET
                         Framework type specified for the parameter or the
                         value can be converted to the specified .NET
                         Framework type.
```

When a parameter is "True (by Value)", PowerShell tries to associate
any piped values with that parameter before it tries other methods to
interpret the command.

```
True (by Property Name)  Indicates that you can pipe a value to the
                         parameter, but the .NET Framework type of the
                         parameter must include a property with the same
                         name as the parameter.
```

For example, you can pipe a value to a **Name** parameter only when the value
has a property called **Name**.

> [!NOTE]
> A typed parameter that accepts pipeline input (`by Value`) or
> (`by PropertyName`) enables use of **delay-bind** script blocks on the parameter.
>
> The **delay-bind** script block is run automatically during
> **ParameterBinding**. The result is bound to the parameter. Delay binding
> does **not** work for parameters defined as type `ScriptBlock` or
> `System.Object`, the script block is passed through
> **without** being invoked.
>
> You can read about **delay-bind** script blocks here [about_Script_Blocks.md](about_Script_Blocks.md)

#### Accepts Wildcard Characters

This setting indicates whether the parameter's value can contain wildcard
characters so that the parameter value can be matched to more than one
existing item in the target container.

#### Common Parameters

Common parameters are parameters that you can use with any cmdlet. For more
information about common parameters, see [about_CommonParameters](about_CommonParameters.md).

## See also

[about_Command_syntax](about_Command_syntax.md)

[about_Comment_Based_Help](about_Comment_Based_Help.md)

[about_Functions_Advanced](about_Functions_Advanced.md)

[about_Parameters_Default_Values](about_Parameters_Default_Values.md)

[about_Pipelines](about_Pipelines.md)

[about_Wildcards](about_Wildcards.md)

