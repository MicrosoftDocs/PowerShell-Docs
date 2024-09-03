---
description: Describes the attribute that makes a function work like a compiled cmdlet.
Locale: en-US
ms.date: 07/02/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions_CmdletBindingAttribute
---
# about_Functions_CmdletBindingAttribute

## Short description
Describes the attribute that makes a function work like a compiled cmdlet.

## Long description

The `CmdletBinding` attribute is an attribute of functions that makes them
operate like compiled cmdlets written in C#. It provides access to the features
of cmdlets.

When you use the `CmdletBinding` attribute, PowerShell automatically adds the
Common Parameters. You can't create any parameters that use the same names as
the Common Parameters. For more information, see [about_CommonParameters][02].

PowerShell binds the parameters of functions that have the `CmdletBinding`
attribute in the same way that it binds the parameters of compiled cmdlets. The
`$PSCmdlet` automatic variable is available to functions with the
`CmdletBinding` attribute, but the `$Args` variable is not available.

In functions that have the `CmdletBinding` attribute, unknown parameters and
positional arguments that have no matching positional parameters cause
parameter binding to fail.

> [!NOTE]
> Compiled cmdlets use the required `Cmdlet` attribute, which is similar
> to the `CmdletBinding` attribute that is described in this topic.

## Syntax

The following example shows the format of a function that specifies all the
optional arguments of the `CmdletBinding` attribute. A brief description of
each argument follows this example.

```powershell
{
    [CmdletBinding(ConfirmImpact=<String>,
    DefaultParameterSetName=<String>,
    HelpURI=<URI>,
    SupportsPaging=<Boolean>,
    SupportsShouldProcess=<Boolean>,
    PositionalBinding=<Boolean>)]

    Param ($Parameter1)
    Begin{}
    Process{}
    End{}
}
```

The boolean argument types of the **CmdletBinding** attribute default to
**False** when omitted from the **CmdletBinding** attribute. Set the argument
value to `$true` or just list the argument by name. For example, the following
**CmdletBinding** attributes are equivalent.

```powershell
{
    [CmdletBinding(SupportsPaging=$true)]

    Param ($Parameter1)
    Begin{}
    Process{}
    End{}
}

# Boolean arguments can be defined using this shorthand syntax

{
    [CmdletBinding(SupportsPaging)]

    Param ($Parameter1)
    Begin{}
    Process{}
    End{}
}
```

## ConfirmImpact

The **ConfirmImpact** argument specifies when the action of the function should
be confirmed by a call to the **ShouldProcess** method. The call to the
**ShouldProcess** method displays a confirmation prompt only when the
**ConfirmImpact** argument is equal to or greater than the value of the
`$ConfirmPreference` preference variable. (The default value of the argument is
**Medium**.) Specify this argument only when the **SupportsShouldProcess**
argument is also specified.

For more information about confirmation requests, see
[Requesting Confirmation][01].

## DefaultParameterSetName

The **DefaultParameterSetName** argument specifies the name of the parameter
set that PowerShell will attempt to use when it cannot determine which
parameter set to use. You can avoid this issue by making the unique parameter
of each parameter set a mandatory parameter.

## HelpURI

The **HelpURI** argument specifies the internet address of the online version
of the help topic that describes the function. The value of the **HelpURI**
argument must begin with "http" or "https".

The **HelpURI** argument value is used for the value of the **HelpURI**
property of the **CommandInfo** object that `Get-Command` returns for the
function.

However, when help files are installed on the computer and the value of the
first link in the **RelatedLinks** section of the help file is a URI, or the
value of the first `.Link` directive in comment-based help is a URI, the URI in
the help file is used as the value of the **HelpUri** property of the function.

The `Get-Help` cmdlet uses the value of the **HelpURI** property to locate the
online version of the function help topic when the **Online** parameter of
`Get-Help` is specified in a command.

## SupportsPaging

The **SupportsPaging** argument adds the **First**, **Skip**, and
**IncludeTotalCount** parameters to the function. These parameters allow users
to select output from a very large result set. This argument is designed for
cmdlets and functions that return data from large data stores that support data
selection, such as an SQL database.

This argument was introduced in Windows PowerShell 3.0.

- **First**: Gets only the first 'n' objects.
- **Skip**:  Ignores the first 'n' objects and then gets the remaining objects.
- **IncludeTotalCount**: Reports the number of objects in the data set (an
  integer) followed by the objects. If the cmdlet cannot determine the total
  count, it returns "Unknown total count".

PowerShell includes **NewTotalCount**, a helper method that gets the total
count value to return and includes an estimate of the accuracy of the total
count value.

The following sample function shows how to add support for the paging
parameters to an advanced function.

```powershell
function Get-Numbers {
    [CmdletBinding(SupportsPaging)]
    param()

    $FirstNumber = [Math]::Min($PSCmdlet.PagingParameters.Skip, 100)
    $LastNumber = [Math]::Min($PSCmdlet.PagingParameters.First +
      $FirstNumber - 1, 100)

    if ($PSCmdlet.PagingParameters.IncludeTotalCount) {
        $TotalCountAccuracy = 1.0
        $TotalCount = $PSCmdlet.PagingParameters.NewTotalCount(100,
          $TotalCountAccuracy)
        Write-Output $TotalCount
    }
    $FirstNumber .. $LastNumber | Write-Output
}
```

## SupportsShouldProcess

The **SupportsShouldProcess** argument adds **Confirm** and **WhatIf**
parameters to the function. The **Confirm** parameter prompts the user before
it runs the command on each object in the pipeline. The **WhatIf** parameter
lists the changes that the command would make, instead of running the command.

## PositionalBinding

The **PositionalBinding** argument determines whether parameters in the
function are positional by default. The default value is `$True`. You can use
the **PositionalBinding** argument with a value of `$False` to disable
positional binding.

The **PositionalBinding** argument is introduced in Windows PowerShell 3.0.

When parameters are positional, the parameter name is optional.
PowerShell associates unnamed parameter values with the function parameters
according to the order or position of the unnamed parameter values in the
function command.

When parameters are not positional (they are "named"), the parameter
name (or an abbreviation or alias of the name) is required in the command.

When **PositionalBinding** is `$True`, function parameters are positional by
default. PowerShell assigns position number to the parameters in the order in
which they are declared in the function.

When **PositionalBinding** is `$False`, function parameters are not positional
by default. Unless the **Position** argument of the **Parameter** attribute is
declared on the parameter, the parameter name (or an alias or abbreviation)
must be included when the parameter is used in a function.

The **Position** argument of the **Parameter** attribute takes precedence over
the **PositionalBinding** default value. You can use the **Position** argument
to specify a position value for a parameter. For more information about the
**Position** argument, see
[about_Functions_Advanced_Parameters][04].

## Notes

The **SupportsTransactions** argument is not supported in advanced functions.

## Keywords

about_Functions_CmdletBinding_Attribute

## See also

- [about_Functions][07]
- [about_Functions_Advanced][05]
- [about_Functions_Advanced_Methods][03]
- [about_Functions_Advanced_Parameters][04]
- [about_Functions_OutputTypeAttribute][06]

<!-- link references -->
[01]: /powershell/scripting/developer/cmdlet/requesting-confirmation
[02]: about_CommonParameters.md
[03]: about_Functions_Advanced_Methods.md
[04]: about_Functions_Advanced_Parameters.md
[05]: about_Functions_Advanced.md
[06]: about_Functions_OutputTypeAttribute.md
[07]: about_Functions.md
