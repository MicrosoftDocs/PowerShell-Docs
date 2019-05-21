---
ms.date:  11/28/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Functions_Advanced
---
# About Functions Advanced

## SHORT DESCRIPTION
Introduces advanced functions that act similar to cmdlets.

## LONG DESCRIPTION

Advanced functions allow you to write functions that can perform operations
that are similar to the operations you can perform with cmdlets. Advanced
functions are helpful when you want to quickly write a function without having
to write a compiled cmdlet using a Microsoft .NET Framework language. These
functions are also helpful when you want to restrict the functionality of a
compiled cmdlet or when you want to write a function that is similar to a
compiled cmdlet.

There is a difference between authoring a compiled cmdlet and an advanced
function. Compiled cmdlets are .NET Framework classes that must be written in a
.NET Framework language such as C#. In contrast, advanced functions are written
in the PowerShell script language in the same way that other functions or
script blocks are written.

Advanced functions use the CmdletBinding attribute to identify them as
functions that act similar to cmdlets. The CmdletBinding attribute is similar
to the Cmdlet attribute that is used in compiled cmdlet classes to identify the
class as a cmdlet. For more information about this attribute, see
[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md).

The following example shows a function that accepts a name and then prints a
greeting using the supplied name. Also notice that this function defines a name
that includes a verb (Send) and noun (Greeting) pair similar to the verb-noun
pair of a compiled cmdlet. However, functions are not required to have a
verb-noun name.

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
are added at runtime), see [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md).

The actual work of the previous function is performed in the Process block,
which is equivalent to the ProcessingRecord method that is used by compiled
cmdlets to process the data that is passed to the cmdlet. This block, along
with the Begin and End blocks, is described in the [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)
topic.

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