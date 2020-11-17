---
description: Introduces advanced functions that are a way to create cmdlets using scripts.
Locale: en-US
ms.date: 06/11/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions_Advanced
---
# About Functions Advanced

## SHORT DESCRIPTION
Introduces advanced functions that are a way to create cmdlets using scripts.

## LONG DESCRIPTION

A cmdlet is a single command that participates in the pipeline semantics of
PowerShell. This includes binary cmdlets, advanced script functions, CDXML, and
Workflows.

Advanced functions allow you create cmdlets that are written as a PowerShell
function. Advanced functions make it easier to create cmdlets without having to
write and compile a binary cmdlet. Binary cmdlets are .NET classes that are
written in a .NET language such as C#.

Advanced functions use the `CmdletBinding` attribute to identify them as
functions that act like cmdlets. The `CmdletBinding` attribute is similar
to the Cmdlet attribute that is used in compiled cmdlet classes to identify the
class as a cmdlet. For more information about this attribute, see
[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md).

The following example shows a function that accepts a name and then prints a
greeting using the supplied name. Also notice that this function defines a name
that includes a verb (Send) and noun (Greeting) pair like the verb-noun pair of
a compiled cmdlet. However, functions are not required to have a verb-noun
name.

```powershell
function Send-Greeting
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Name
    )

    Process
    {
        Write-Host ("Hello " + $Name + "!")
    }
}
```

The parameters of the function are declared by using the Parameter attribute.
This attribute can be used alone, or it can be combined with the Alias
attribute or with several other parameter validation attributes. For more
information about how to declare parameters (including dynamic parameters that
are added at runtime), see
[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md).

The actual work of the previous function is performed in the Process block,
which is equivalent to the ProcessingRecord method that is used by compiled
cmdlets to process the data that is passed to the cmdlet. This block, along
with the Begin and End blocks, is described in the
[about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md) topic.

Advanced functions differ from compiled cmdlets in the following ways:

- Advanced function parameter binding does not throw an exception when an array
  of strings is bound to a Boolean parameter.
- The ValidateSet attribute and the ValidatePattern attribute cannot pass named
  parameters.
- Advanced functions cannot be used in transactions.

## SEE ALSO

[about_Functions](about_Functions.md)

[about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)

[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)

[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md)

[about_Functions_OutputTypeAttribute](about_Functions_OutputTypeAttribute.md)
