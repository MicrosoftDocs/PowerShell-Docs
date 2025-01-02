---
description: Introduces advanced functions that are a way to create cmdlets using scripts.
Locale: en-US
ms.date: 01/02/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions_Advanced
---
# about_Functions_Advanced

## Short description
Introduces advanced functions that are a way to create cmdlets using scripts.

## Long description

A cmdlet is a single command that participates in the pipeline semantics of
PowerShell. This includes binary cmdlets, PowerShell advanced functions, and
CDXML cmdlets.

Advanced functions allow you create cmdlets that are written as a PowerShell
function. Advanced functions make it easier to create cmdlets without having to
write and compile a binary cmdlet. Binary cmdlets are .NET classes that are
written in a .NET language such as C#.

Advanced functions use the `CmdletBinding` attribute to identify them as
functions that act like cmdlets. The `CmdletBinding` attribute is similar to
the Cmdlet attribute that's used in compiled cmdlet classes to identify the
class as a cmdlet. For more information about this attribute, see
[about_Functions_CmdletBindingAttribute][03].

The parameters of the function are variables declared in the `param()`
statement. You can use the optional `[Parameter()]` attribute alone or in
combination with the `[Alias()]` attribute or any of the parameter validation
attributes. For more information about how to declare parameters, see
[about_Functions_Advanced_Parameters][02].

The following example shows a function that accepts a name and then prints a
greeting using the supplied name. Also notice that this function defines a name
that includes a verb (Send) and noun (Greeting) pair like the verb-noun pair of
a compiled cmdlet. However, functions aren't required to have a verb-noun name.

```powershell
function Send-Greeting
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $Name
    )

    process
    {
        Write-Host ("Hello " + $Name + "!")
    }
}
```

This function performs the work in the `process` block, which is equivalent to
the **ProcessingRecord** method used in compiled cmdlets. The `process` block
and the other named blocks are described in
[about_Functions_Advanced_Methods][01].

Advanced functions differ from compiled cmdlets in the following ways:

- Advanced function parameter binding doesn't throw an exception when an array
  of strings is bound to a **Boolean** parameter.
- The `ValidateSet` attribute and the `ValidatePattern` attribute can't pass
  named parameters.
- Advanced functions can't be used in transactions.

## See also

- [about_Functions][05]
- [about_Functions_Advanced_Methods][01]
- [about_Functions_Advanced_Parameters][02]
- [about_Functions_CmdletBindingAttribute][03]
- [about_Functions_OutputTypeAttribute][04]
- [about_Variables][06]

<!-- link references -->
[01]: about_Functions_Advanced_Methods.md
[02]: about_Functions_Advanced_Parameters.md
[03]: about_Functions_CmdletBindingAttribute.md
[04]: about_Functions_OutputTypeAttribute.md
[05]: about_Functions.md
[06]: about_Variables.md
