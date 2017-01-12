---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  about_Functions_OutputTypeAttribute
ms.technology:  powershell
---

# About Functions OutputTypeAttribute
## about_Functions_OutputTypeAttribute


# SHORT DESCRIPTION

Describes an attribute that reports the type of object that the function
returns.

# LONG DESCRIPTION

The OutputType attribute lists the .NET types of objects that the functions
returns. You can use its optional ParameterSetName parameter to list different
output types for each parameter set.

The OutputType attribute is supported on simple and advanced functions. It is
independent of the CmdletBinding attribute.

The OutputType attribute provides the value of the OutputType property of the
System.Management.Automation.FunctionInfo object that the Get-Command cmdlet
returns.

The OutputType attribute value is only a documentation note. It is not derived
from the function code or compared to the actual function output. As such, the
value might be inaccurate.

# SYNTAX

The OutputType attribute of functions has the following syntax:

[OutputType([<TypeLiteral>], ParameterSetName="<Name>")]
[OutputType("<TypeNameString>", ParameterSetName="<Name>")]

The ParameterSetName parameter is optional.

You can list multiple types in the OutputType attribute.

[OutputType([<Type1>],[<Type2>],[<Type3>])]

You can use the ParameterSetName parameter to indicate that different
parameter sets return different types.

[OutputType([<Type1>], ParameterSetName="<Set1>","<Set2>")]
[OutputType([<Type2>], ParameterSetName="<Set3>")]

Place the OutputType attribute statements in the attributes list that precedes
the Param statement.

The following example shows the placement of the OutputType attribute in a
simple function.

function SimpleFunction2
{
[OutputType([<Type>])]
Param ($Parameter1)

<function body>
}

The following example shows the placement of the OutputType attribute in
advanced functions.

function AdvancedFunction1
{
[OutputType([<Type>])]
Param (
[parameter(Mandatory=$true)]
[String[]]
$Parameter1
# )


<function body>
}

function AdvancedFunction2
{
[CmdletBinding(SupportsShouldProcess=<Boolean>)]
[OutputType([<Type>])]
Param (
[parameter(Mandatory=$true)]
[String[]]
$Parameter1
# )


<function body>
}

# EXAMPLES


The following function uses the OutputType attribute to indicate that it returns
a string value.

function Send-Greeting
{
[OutputType([String])]
Param ($Name)

Hello, $Name
}

To see the resulting output type property, use the Get-Command cmdlet.

PS C:> (Get-Command Send-Greeting).OutputType

Name                                               Type
----                                               ----
System.String                                      System.String

The following advanced function uses the OutputType attribute to indicate that
the function returns different types depending on the parameter set used in the
function command.

function Get-User
{
[CmdletBinding(DefaultParameterSetName="ID")]

[OutputType("System.Int32", ParameterSetName="ID")]
[OutputType([String], ParameterSetName="Name")]

Param (
[parameter(Mandatory=$true, ParameterSetName="ID")]
[Int[]]
$UserID,

[parameter(Mandatory=$true, ParameterSetName="Name")]
[String[]]
$UserName
# )


<function body>
}

The following example demonstrates that the output type property value
displays the value of the OutputType attribute, even when it is inaccurate.

The Get-Time function returns a string that contains the short form of
the time in any DateTime object. However, the OutputType attribute reports
that it returns a System.DateTime object.

function Get-Time
{
[OutputType([DateTime])]
Param
# (

[parameter(Mandatory=$true)]
[Datetime]$DateTime
# )

$DateTime.ToShortTimeString()
}

The Get-Type method confirms that the function returns a string.

PS C:> (Get-Time -DateTime (Get-Date)).Gettype().FullName
System.String

However, the OutputType property, which gets its value from the OutputType
attribute, reports that the function returns a DateTime object.

PS C:> (Get-Command Get-Time).OutputType

Name                                      Type
----                                      ----
System.DateTime                           System.DateTime

# NOTES

The value of the OutputType property of a FunctionInfo object is an array of
System.Management.Automation.PSTypeName objects, each of which have Name and
Type properties.

To get only the name of each output type, use a command with the following
format.

(Get-Command Get-Time).OutputType | ForEach {$_.Name}

The value of the OutputType property can be null. Use a null value when
the output is a not a .NET type, such as a WMI object or a formatted view
of an object.

# SEE ALSO

about_Functions
about_Functions_Advanced
about_Functions_Advanced_Methods
about_Functions_Advanced_Parameters
about_Functions_CmdletBindingAttribute

