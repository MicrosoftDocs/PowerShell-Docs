---
description: PowerShell provides a mechanism for programmers to document their scripts using special comment directives. The Get-Help cmdlet generates documentation from these directives.
ms.date: 05/19/2021
title: Comment-Based Help
---

# A. Comment-Based Help

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

PowerShell provides a mechanism for programmers to document their scripts using special comment
directives. Comments using such syntax are called *help comments*. The cmdlet
[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) generates documentation from these directives.

## A.1 Introduction

A help comment contains a *help directive* of the form .*name* followed on one or more subsequent
lines by the help content text. The help comment can be made up of a series of
*single-line-comment*s or a *delimited-comment* ([§2.2.3][§2.2.3]). The set of comments comprising the
documentation for a single entity is called a *help topic*.

For example,

```powershell
# <help-directive-1>
# <help-content-1>
...

# <help-directive-n>
# <help-content-n>
```

or

```powershell
<#
<help-directive-1>
<help-content-1>
...

<help-directive-n>
<help-content-n>
#>
```

All of the lines in a help topic must be contiguous. If a help topic follows a comment that is not
part of that topic, there must be at least one blank line between the two.

The directives can appear in any order, and some of the directives may appear multiple times.

Directive names are not case-sensitive.

When documenting a function, help topics may appear in one of three locations:

- Immediately before the function definition with no more than one blank line between the last line
  of the function help and the line containing the function statement.
- Inside the function's body immediately following the opening curly bracket.
- Inside the function's body immediately preceding the closing curly bracket.

When documenting a script file, help topics may appear in one of two locations:

- At the beginning of the script file, optionally preceded by comments and blank lines only. If the
  first item in the script after the help is a function definition, there must be at least two blank
  lines between the end of the script help and that function declaration. Otherwise, the help will
  be interpreted as applying to the function instead of the script file.
- At the end of the script file.

## A.2 Help directives

### A.2.1 .DESCRIPTION

Syntax:

```Syntax
.DESCRIPTION
```

Description:

This directive allows for a detailed description of the function or script. (The `.SYNOPSIS`
directive ([§A.2.11][§A.2.11]) is intended for a brief description.) This directive can be used only once
in each topic.

Examples:

```powershell
<#
.DESCRIPTION
Computes Base to the power Exponent. Supports non-negative integer
powers only.
#>
```

### A.2.2 .EXAMPLE

Syntax:

```Syntax
.EXAMPLE
```

Description:

This directive allows an example of command usage to be shown.

If this directive occurs multiple times, each associated help content block is displayed as a
separate example.

Examples:

```powershell
<#
.EXAMPLE
Get-Power 3 4
81

.EXAMPLE
Get-Power -Base 3 -Exponent 4
81
#>
```

### A.2.3 .EXTERNALHELP

Syntax:

```Syntax
.EXTERNALHELP <XMLHelpFilePath>
```

Description:

This directive specifies the path to an XML-based help file for the script or function.

Although comment-based help is easier to implement, XML-based Help is required if more precise
control is needed over help content or if help topics are to be translated into multiple languages.
The details of XML-based help are not defined by this specification.

Examples:

```powershell
<#
.ExternalHelp C:\MyScripts\Update-Month-Help.xml
#>
```

### A.2.4 .FORWARDHELPCATEGORY

Syntax:

```Syntax
.FORWARDHELPCATEGORY <Category>
```

Description:

Specifies the help category of the item in **ForwardHelpTargetName** ([§A.2.5][§A.2.5]). Valid values are
**Alias**, **All**, **Cmdlet**, **ExternalScript**, **FAQ**, **Filter**, **Function**, **General**,
**Glossary**, **HelpFile**, **Provider**, and **ScriptCommand**. Use this directive to avoid
conflicts when there are commands with the same name.

Examples:

See [§A.2.5][§A.2.5].

### A.2.5 .FORWARDHELPTARGETNAME

Syntax:

```Syntax
.FORWARDHELPTARGETNAME <Command-Name>
```

Description:

Redirects to the help topic specified by `<Command-Name>`.

Examples:

```powershell
function Help {
<#
.FORWARDHELPTARGETNAME Get-Help
.FORWARDHELPCATEGORY Cmdlet
#>
    ...
}
```

The command `Get-Help help` is treated as if it were `Get-Help Get-Help` instead.

### A.2.6 .INPUTS

Syntax:

```Syntax
.INPUTS
```

Description:

The pipeline can be used to pipe one or more objects to a script or function. This directive is used
to describe such objects and their types.

If this directive occurs multiple times, each associated help content block is collected in the one
documentation entry, in the directives' lexical order.

Examples:

```powershell
<#
.INPUTS
None. You cannot pipe objects to Get-Power.

.INPUTS
For the Value parameter, one or more objects of any kind can be written
to the pipeline. However, the object is converted to a string before it
is added to the item.
#>
function Process-Thing {
    param ( ...
        [Parameter(ValueFromPipeline=$true)]
        [object[]]$Value,
        ...
    )
    ...
}
```

### A.2.7 .LINK

Syntax:

```Syntax
.LINK
```

Description:

This directive specifies the name of a related topic.

If this directive occurs multiple times, each associated help content block is collected in the one
documentation entry, in the directives' lexical order.

The Link directive content can also include a URI to an online version of the same help topic. The
online version is opens when Get-Help is invoked with the Online parameter. The URI must begin with
"http" or "https".

Examples:

```powershell
<#
.LINK
Online version: http://www.acmecorp.com/widget.html

.LINK
Set-ProcedureName
#>
```

### A.2.8 .NOTES

Syntax:

```Syntax
.NOTES
```

Description:

This directive allows additional information about the function or script to be provided. This
directive can be used only once in each topic.

Examples:

```powershell
<#
.Notes
*arbitrary text goes here*
#>
```

### A.2.9 .OUTPUTS

Syntax:

```Syntax
.OUTPUTS
```

Description:

This directive is used to describe the objects output by a command.

If this directive occurs multiple times, each associated help content block is collected in the one
documentation entry, in the directives' lexical order.

Examples:

```powershell
<#
.OUTPUTS
double - Get-Power returns Base to the power Exponent.

.OUTPUTS
None unless the -PassThru switch parameter is used.
#>
```

### A.2.10 .PARAMETER

Syntax:

```Syntax
.PARAMETER <Parameter-Name>
```

Description:

This directive allows for a detailed description of the given parameter. This directive can be used
once for each parameter. Parameter directives can appear in any order in the comment block; however,
the order in which their corresponding parameters are actually defined in the source determines the
order in which the parameters and their descriptions appear in the resulting documentation.

An alternate format involves placing a parameter description comment immediately before the
declaration of the corresponding parameter variable's name. If the source contains both a parameter
description comment and a Parameter directive, the description associated with the Parameter
directive is used.

Examples:

```powershell
<#
.PARAMETER Base
The integer value to be raised to the Exponent-th power.

.PARAMETER Exponent
The integer exponent to which Base is to be raised.
#>

function Get-Power {
    param ([long]$Base, [int]$Exponent)
    ...
}

function Get-Power {
    param ([long]
        # The integer value to be raised to the Exponent-th power.
        $Base,
        [int]
        # The integer exponent to which Base is to be raised.
        $Exponent
    )
    ...
}
```

### A.2.11 .SYNOPSIS

Syntax:

```powershell
.SYNOPSIS
```

Description:

This directive allows for a brief description of the function or script. (The `.DESCRIPTION`
directive ([§A.2.1][§A.2.1]) is intended for a detailed description.) This directive can be used only once
in each topic.

Examples:

```powershell
<#
.SYNOPSIS
Computes Base to the power Exponent.
#>
```

<!-- reference links -->
[§2.2.3]: chapter-02.md#223-comments
[§A.2.1]: chapter-14.md#a21-description
[§A.2.11]: chapter-14.md#a211-synopsis
[§A.2.5]: chapter-14.md#a25-forwardhelptargetname
