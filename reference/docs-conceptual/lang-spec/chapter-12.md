---
description: An attribute object associates predefined system information with a target element, which can be a param block or a parameter.
ms.date: 05/19/2021
title: Attributes
---
# 12. Attributes

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

An *attribute* object associates predefined system information with a *target element*, which can be
a param block or a parameter ([§8.10][§8.10]). Each attribute object has an *attribute type*.

Information provided by an attribute is also known as *metadata*. Metadata can be examined by the
command or the execution environment to control how the command processes data or before run time by
external tools to control how the command itself is processed or maintained.

Multiple attributes can be applied to the same target element.

## 12.1 Attribute specification

> [!TIP]
> The `~opt~` notation in the syntax definitions indicates that the lexical entity is optional in
> the syntax.

```Syntax
attribute-list:
    attribute
    attribute-list new-lines~opt~ attribute

attribute:
    [ new-lines~opt~ attribute-name ( attribute-arguments new-lines~opt~ ) new-lines~opt~ ]
    type-literal

attribute-name:
    type-spec

attribute-arguments:
    attribute-argument
    attribute-argument new-lines~opt~ ,
    attribute-arguments

attribute-argument:
    new-lines~opt~ expression
    new-lines~opt~ simple-name
    new-lines~opt~ simple-name = new-lines~opt~ expression
```

An attribute consists of an *attribute-name* and an optional list of positional and named arguments.
The positional arguments (if any) precede the named arguments. A named argument consists of a
*simple-name*, optionally followed by an equal sign and followed by an *expression*. If the
expression is omitted, the value `$true` is assumed.

The *attribute-name* is a reserved attribute type ([§12.3][§12.3]) or some implementation-defined
attribute type.

## 12.2 Attribute instances

An attribute instance is an object of an attribute type. The instance represents an attribute at
run-time.

To create an object of some attribute type *A*, use the notation `A()`. An attribute is declared by
enclosing its instance inside `[]`, as in `[A()]`. Some attribute types have positional and named
parameters ([§8.14][§8.14]), just like functions and cmdlets. For example,

`[A(10,IgnoreCase=$true)]`

shows an instance of type *A* being created using a positional parameter whose argument value is 10,
and a named parameter, **IgnoreCase**, whose argument value is `$true`.

## 12.3 Reserved attributes

The attributes described in the following sections can be used to augment or modify the behavior of
PowerShell functions, filters, scripts, and cmdlets.

### 12.3.1 The Alias attribute

This attribute is used in a *script-parameter* to specify an alternate name for a parameter. A
parameter may have multiple aliases, and each alias name must be unique within a *parameter-list*.
One possible use is to have different names for a parameter in different parameter sets (see
**ParameterSetName**).

The attribute argument has type string[].

Consider a function call `Test1` that has the following param block, and which is called as shown:

```powershell
param (
    [Parameter(Mandatory = $true)]
    [Alias("CN")]
    [Alias("name", "system")]
    [string[]] $ComputerName
)

Test1 "Mars", "Saturn"                # pass argument by position
Test1 -ComputerName "Mars", "Saturn"  # pass argument by name
Test1 -CN "Mars", "Saturn"            # pass argument using first alias
Test1 -name "Mars", "Saturn"          # pass argument using second alias
Test1 -sys "Mars", "Saturn"           # pass argument using third alias
```

Consider a function call `Test2` that has the following param block, and which is called as shown:

```powershell
param (
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('PSPath')]
    [string] $LiteralPath
)

Get-ChildItem "E:\*.txt" | Test2 -LiteralPath { $_ ; "`n`t";
    $_.FullName + ".bak" }
Get-ChildItem "E:\*.txt" | Test2
```

Cmdlet `Get-ChildItem` (alias `Dir`) adds to the object it returns a new **NoteProperty** of type
`string`, called **PSPath**.

### 12.3.2 The AllowEmptyCollection attribute

This attribute is used in a *script-parameter* to allow an empty collection as the argument of a
mandatory parameter.

Consider a function call `Test` that has the following param block, and which is called as shown:

```powershell
param (
    [parameter(Mandatory = $true)]
    [AllowEmptyCollection()]
    [string[]] $ComputerName
)

Test "Red", "Green" # $computerName has Length 2
Test "Red" # $computerName has Length 1
Test -comp @() # $computerName has Length 0
```

### 12.3.3 The AllowEmptyString attribute

This attribute is used in a *script-parameter* to allow an empty string as the argument of a
mandatory parameter.

Consider a function call `Test` that has the following param block, and which is called as shown:

```powershell
param (
    [parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string] $ComputerName
)

Test "Red" # $computerName is "Red"
Test "" # empty string is permitted
Test -comp "" # empty string is permitted
```

### 12.3.4 The AllowNull attribute

This attribute is used in a *script-parameter* to allow $null as the argument of a mandatory
parameter for which no implicit conversion is available.

Consider a function call Test that has the following param block, and which is called as shown:

```powershell
param (
    [parameter(Mandatory = $true)]
    [AllowNull()]
    [int[]] $Values
)

Test 10, 20, 30     # $values has Length 3, values 10, 20, 30
Test 10, $null, 30  # $values has Length 3, values 10, 0, 30
Test -val $null     # $values has value $null
```

Note that the second case above does not need this attribute; there is already an implicit
conversion from `$null` to int.

### 12.3.5 The CmdletBinding attribute

This attribute is used in the *attribute-list* of *param-block* of a function to indicate that
function acts similar to a cmdlet. Specifically, it allows functions to access a number of methods
and properties through the $PsCmdlet variable by using begin, process, and end named blocks
([§8.10.7][§8.10.7]).

When this attribute is present, positional arguments that have no matching positional parameters
cause parameter binding to fail and $args is not defined. (Without this attribute $args would take
on any unmatched positional argument values.)

The following arguments are used to define the characteristics of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>SupportsShouldProcess (named)</td>
<td><p>Type: bool; Default value: $false</p>
<p>Specifies whether the function supports calls to the ShouldProcess method, which is used to prompt the user for feedback before the function makes a change to the system. A value of $true indicates that it does. A value of $false indicates that it doesn't.</p></td>
</tr>
<tr class="even">
<td>ConfirmImpact (named)</td>
<td><p>Type: string; Default value: "Medium"</p>
<p>Specifies the impact level of the action performed. The call to the ShouldProcess method displays a confirmation prompt only when the ConfirmImpact argument is greater than or equal to the value of the $ConfirmPreference preference variable.</p>
<p>The possible values of this argument are:</p>
<p>None: Suppress all requests for confirmation.</p>
<p>Low: The action performed has a low risk of losing data.</p>
<p>Medium: The action performed has a medium risk of losing data.</p>
<p>High: The action performed has a high risk of losing data.</p>
<p>The value of $ConfirmPreference can be set so that only cmdlets with an equal or higher impact level can request confirmation before they perform their operation. For example, if $ConfirmPreference is set to Medium, cmdlets with a Medium or High impact level can request confirmation. Requests from cmdlets with a low impact level are suppressed.</p></td>
</tr>
<tr class="odd">
<td>DefaultParameterSetName (named)</td>
<td><p>Type: string; Default value: "__AllParameterSets"</p>
<p>Specifies the parameter set to use if that cannot be determined from the arguments. See the named argument ParameterSetName in the attribute Parameter ([§12.3.7][§12.3.7]).</p></td>
</tr>
<tr class="even">
<td>PositionalBinding (named)</td>
<td><p>Type: bool; Default value: $true</p>
<p>Specifies whether positional binding is supported or not. The value of this argument is ignored if any parameters specify non-default values for either the named argument Position or the named argument ParameterSetName in the attribute Parameter ([§12.3.7][§12.3.7]). Otherwise, if the argument is $false then no parameters are positional, otherwise parameters are assigned a position based on the order the parameters are specified.</p></td>
</tr>
</tbody>
</table>

Here's is an example of the framework for using this attribute:

```powershell
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
param ( ... )

begin { ... }
Get-process { ... }
end { ... }
```

### 12.3.6 The OutputType attribute

This attribute is used in the *attribute-list* of *param-block* to specify the types returned. The
following arguments are used to define the characteristics of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Type (position 0)</td>
<td><p>Type: string[] or array of type literals</p>
<p>A list of the types of the values that are returned.</p></td>
</tr>
<tr class="even">
<td>ParameterSetName (named)</td>
<td><p>Type: string[]</p>
<p>Specifies the parameter sets that return the types indicated by the corresponding elements of the Type parameter.</p></td>
</tr>
</tbody>
</table>

Here are several examples of this attribute's use:

```powershell
[OutputType([int])] param ( ... )
[OutputType("double")] param ( ... )
[OutputType("string","string")] param ( ... )
```


### 12.3.7 The Parameter attribute

This attribute is used in a *script-parameter*. The following named arguments are used to define the
characteristics of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>HelpMessage (named)</td>
<td><p>Type: string</p>
<p>This argument specifies a message that is intended to contain a short description of the parameter. This message is used in an implementation-defined manner when the function or cmdlet is run yet a mandatory parameter having a HelpMessage does not have a corresponding argument.</p>
<p>The following example shows a parameter declaration that provides a description of the parameter.</p>
<p>param ( [Parameter(Mandatory = $true,<br />
HelpMessage = "An array of computer names.")]<br />
[string[]] $ComputerName )</p>
<p>Windows PowerShell: If a required parameter is not provided the runtime prompts the user for a parameter value. The prompt dialog box includes the HelpMessage text.</p></td>
</tr>
<tr class="even">
<td>Mandatory (named)</td>
<td><p>Type: bool; Default value: $false</p>
<p>This argument specifies whether the parameter is required within the given parameter set (see ParameterSetName argument below). A value of $true indicates that it is. A value of $false indicates that it isn't.</p>
<p>param ( [Parameter(Mandatory = $true)]<br />
[string[]] $ComputerName )</p>
<p>Windows PowerShell: If a required parameter is not provided the runtime prompts the user for a parameter value. The prompt dialog box includes the HelpMessage text, if any.</p></td>
</tr>
<tr class="odd">
<td>ParameterSetName (named)</td>
<td><p>Type: string; Default value: "__AllParameterSets"</p>
<p>It is possible to write a single function or cmdlet that can perform different actions for different scenarios. It does this by exposing different groups of parameters depending on the action it wants to take. Such parameter groupings are called <em>parameter sets</em>.</p>
<p>The argument ParameterSetName specifies the parameter set to which a parameter belongs. This behavior means that each parameter set must have one unique parameter that is not a member of any other parameter set.</p>
<p>For parameters that belong to multiple parameter sets, add a Parameter attribute for each parameter set. This allows the parameter to be defined differently for each parameter set.</p>
<p>A parameter set that contains multiple positional parameters must define unique positions for each parameter. No two positional parameters can specify the same position.</p>
<p>If no parameter set is specified for a parameter, the parameter belongs to all parameter sets.</p>
<p>When multiple parameter sets are defined, the named argument DefaultParameterSetName of the attribute CmdletBinding ([§12.3.5][§12.3.5]) is used to specify the default parameter set. The runtime uses the default parameter set if it cannot determine the parameter set to use based on the information provided by the command, or raises an exception if no default parameter set has been specified.</p>
<p>The following example shows a function Test with a parameter declaration of two parameters that belong to two different parameter sets, and a third parameter that belongs to both sets:</p>
<p>param ( [Parameter(Mandatory = $true,<br />
ParameterSetName = "Computer")]<br />
[string[]] $ComputerName,</p>
<p>[Parameter(Mandatory = $true,<br />
ParameterSetName = "User")]<br />
[string[]] $UserName,</p>
<p>[Parameter(Mandatory = $true,<br />
ParameterSetName = "Computer")]<br />
[Parameter(ParameterSetName = "User")]<br />
[int] $SharedParam = 5 )</p>
<p>if ($PsCmdlet.ParameterSetName -eq "Computer")<br />
{<br />
# handle "Computer" parameter set<br />
}</p>
<p>elseif ($PsCmdlet.ParameterSetName -eq "User")<br />
{<br />
# handle "User" parameter set<br />
}<br />
…<br />
}</p>
<p>Test -ComputerName "Mars","Venus" -SharedParam 10<br />
Test -UserName "Mary","Jack"<br />
Test -UserName "Mary","Jack" -SharedParam 20</p></td>
</tr>
<tr class="even">
<td>Position (named)</td>
<td><p>Type: int</p>
<p>This argument specifies the position of the parameter in the argument list. If this argument is not specified, the parameter name or its alias must be specified explicitly when the parameter is set. If none of the parameters of a function has positions, positions are assigned to each parameter based on the order in which they are received.</p>
<p>The following example shows the declaration of a parameter whose value must be specified as the first argument when the function is called.</p>
<p>param ( [Parameter(Position = 0)]<br />
[string[]] $ComputerName )</p></td>
</tr>
<tr class="odd">
<td>ValueFromPipeline (named)</td>
<td><p>Type: bool; Default value: $false</p>
<p>This argument specifies whether the parameter accepts input from a pipeline object. A value of $true indicates that it does. A value of $false indicates that it does not.</p>
<p>Specify $true if the function or cmdlet accesses the complete object, not just a property of the object.</p>
<p>Only one parameter in a parameter set can declare ValueFromPipeline as $true.</p>
<p>The following example shows the parameter declaration of a mandatory parameter, $ComputerName, that accepts the input object that is passed to the function from the pipeline.</p>
<p>param ( [Parameter(Mandatory = $true,<br />
ValueFromPipeline=$true)]<br />
[string[]] $ComputerName )</p>
<p>For an example of using this parameter in conjunction with the Alias attribute see [§12.3.1][§12.3.1]. </p></td>
</tr>
<tr class="even">
<td>ValueFromPipelineByPropertyName (named)</td>
<td><p>Type: bool; Default value: $false</p>
<p>This argument specifies whether the parameter takes its value from a property of a pipeline object that has either the same name or the same alias as this parameter. A value of $true indicates that it does. A value of $false indicates that it does not.</p>
<p>Specify $true if the following conditions are true: the parameter accesses a property of the piped object, and the property has the same name as the parameter, or the property has the same alias as the parameter.</p>
<p>A parameter having ValueFromPipelineByPropertyName set to $true need not have a parameter in the same set with ValueFromPipeline set to $true.</p>
<p>If a function has a parameter $ComputerName, and the piped object has a ComputerName property, the value of the ComputerName property is assigned to the $ComputerName parameter of the function:</p>
<p>param ( [parameter(Mandatory = $true,<br />
ValueFromPipelineByPropertyName = $true)]<br />
[string[]] $ComputerName )</p>
<p>Multiple parameters in a parameter set can define the ValueFromPipelineByPropertyName as $true. Although, a single input object cannot be bound to multiple parameters, different properties in that input object may be bound to different parameters.</p>
<p>When binding a parameter with a property of an input object, the runtime environment first looks for a property with the same name as the parameter.  If such a property does not exist, the runtime environment looks for aliases to that parameter, in their declaration order, picking the first such alias for which a property exists.</p>
<p>function Process-Date<br />
{<br />
param(<br />
[Parameter(ValueFromPipelineByPropertyName=$true)]<br />
[int]$Year,</p>
<p>[Parameter(ValueFromPipelineByPropertyName=$true)]<br />
[int]$Month,</p>
<p>[Parameter(ValueFromPipelineByPropertyName=$true)]<br />
[int]$Day<br />
)</p>
<p>process { … }<br />
}<br />
<br />
Get-Date | Process-Date</p></td>
</tr>
<tr class="odd">
<td>ValueFromRemainingArguments (named)</td>
<td><p>Type: bool; Default value: $false</p>
<p>This argument specifies whether the parameter accepts all of the remaining arguments that are not bound to the parameters of the function. A value of $true indicates that it does. A value of $false indicates that it does not.</p>
<p>The following example shows a parameter $others that accepts all the remaining arguments of the input object that is passed to the function Test:</p>
<p>param ( [parameter(Mandatory = $true)][int] $p1,<br />
[parameter(Mandatory = $true)][int] $p2,<br />
[parameter(ValueFromRemainingArguments = $true)]<br />
[string[]] $others )</p>
<p>Test 10 20 # $others has Length 0<br />
Test 10 20 30 40 # $others has Length 2, value 30,40</p></td>
</tr>
</tbody>
</table>

An implementation may define other attributes as well.

The following attributes are provided as well:

- **HelpMessageBaseName**: Specifies the location where resource identifiers reside. For example,
  this parameter could specify a resource assembly that contains Help messages that are to be
  localized.
- **HelpMessageResourceId**: Specifies the resource identifier for a Help message.

### 12.3.8 The PSDefaultValue attribute

This attribute is used in a *script-parameter* to provide additional information about the
parameter. The attribute is used in an implementation defined manner. The following arguments are
used to define the characteristics of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Help (named)</td>
<td><p>Type: string</p>
<p>This argument specifies a message that is intended to contain a short description of the default value of a parameter. This message is used in an implementation-defined manner.</p>
<p>Windows PowerShell: The message is used as part of the description of the parameter for the help topic displayed by the [Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) cmdlet.</p></td>
</tr>
<tr class="even">
<td>Value (named)</td>
<td><p>Type: object</p>
<p>This argument specifies a value that is intended to be the default value of a parameter. The value is used in an implementation-defined manner.</p>
<p>Windows PowerShell: The value is used as part of the description of the parameter for the help topic displayed by the [Get-Help](xref:Microsoft.PowerShell.Core.Get-Help)cmdlet when the Help property is not specified.</p></td>
</tr>
</tbody>
</table>

### 12.3.9 The SupportsWildcards attribute

This attribute is used in a *script-parameter* to provide additional information about the
parameter. The attribute is used in an implementation defined manner.

This attribute is used as part of the description of the parameter for the help topic displayed by
the [Get-Help](xref:Microsoft.PowerShell.Core.Get-Help) cmdlet.

### 12.3.10 The ValidateCount attribute

This attribute is used in a *script-parameter* to specify the minimum and maximum number of argument
values that the parameter can accept. The following arguments are used to define the characteristics
of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>MinLength (position 0)</td>
<td><p>Type: int</p>
<p>This argument specifies the minimum number of argument values allowed.</p></td>
</tr>
<tr class="even">
<td>MaxLength (position 1)</td>
<td><p>Type: int</p>
<p>This argument specifies the maximum number of argument values allowed.</p></td>
</tr>
</tbody>
</table>

In the absence of this attribute, the parameter's corresponding argument value list can be of any
length.

Consider a function call Test that has the following param block, and which is called as shown:

```powershell
param (
    [ValidateCount(2, 5)]
    [int[]] $Values
)

Temp 10, 20, 30
Temp 10                         # too few argument values
Temp 10, 20, 30, 40, 50, 60     # too many argument values

[ValidateCount(3, 4)]$Array = 1..3
$Array = 10                     # too few argument values
$Array = 1..100                 # too many argument values
```

### 12.3.11 The ValidateLength attribute

This attribute is used in a *script-parameter* or *variable* to specify the minimum and maximum
length of the parameter's argument, which must have type string. The following arguments are used to
define the characteristics of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>MinLength (position 0)</td>
<td><p>Type: int</p>
<p>This argument specifies the minimum number of characters allowed.</p></td>
</tr>
<tr class="even">
<td>MaxLength (position 1)</td>
<td><p>Type: int</p>
<p>This argument specifies the maximum number of characters allowed.</p></td>
</tr>
</tbody>
</table>

In the absence of this attribute, the parameter's corresponding argument can be of any length.

Consider a function call Test that has the following param block, and which is called as shown:

```powershell
param ( [parameter(Mandatory = $true)]
[ValidateLength(3,6)]
[string[]] $ComputerName )

Test "Thor","Mars"     # length is ok
Test "Io","Mars"       # "Io" is too short
Test "Thor","Jupiter"  # "Jupiter" is too long
```

### 12.3.12 The ValidateNotNull attribute

This attribute is used in a *script-parameter* or *variable* to specify that the argument of the
parameter cannot be `$null` or be a collection containing a null-valued element.

Consider a function call `Test` that has the following param block, and which is called as `shown:

```powershell
param (
    [ValidateNotNull()]
    [string[]] $Names
)

Test "Jack", "Jill"     # ok
Test "Jane", $null      # $null array element value not allowed
Test $null              # null array not allowed

[ValidateNotNull()]$Name = "Jack" # ok
$Name = $null           # null value not allowed
```

### 12.3.13 The ValidateNotNullOrEmpty attribute

This attribute is used in a *script-parameter* or *variable* to specify that the argument if the
parameter cannot be $null, an empty string, or an empty array, or be a collection containing a
$null-valued or empty string element.

Consider a function call `Test` that has the following param block, and which is called as shown:

```powershell
param (
    [ValidateNotNullOrEmpty()]
    [string[]] $Names
)

Test "Jack", "Jill"    # ok
Test "Mary", ""        # empty string not allowed
Test "Jane", $null     # $null array element value not allowed
Test $null             # null array not allowed
Test @()               # empty array not allowed

[ValidateNotNullOrEmpty()]$Name = "Jack" # ok
$Name = ""             # empty string not allowed
$Name = $null          # null value not allowed
```

### 12.3.14 The ValidatePattern attribute

This attribute is used in a *script-parameter* or *variable* to specify a regular expression for
matching the pattern of the parameter's argument. The following arguments are used to define the
characteristics of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>RegexString (position 0)</td>
<td><p>Type: String</p>
<p>A regular expression that is used to validate the parameter's argument</p></td>
</tr>
<tr class="even">
<td>Options (named)</td>
<td><p>Type: Regular-Expression-Option</p>
<p>See [§4.2.6.4][§4.2.6.4] for the allowed values.</p></td>
</tr>
</tbody>
</table>

If the argument is a collection, each element in the collection must match the pattern.

Consider a function call `Test` that has the following param block, and which is called as shown:

```powershell
param (
    [ValidatePattern('\^[A-Z][1-5][0-9]$')]
    [string] $Code,

    [ValidatePattern('\^(0x|0X)([A-F]|[a-f]|[0-9])([A-F]|[a-f]|[0-9])$')]
    [string] $HexNum,

    [ValidatePattern('\^[+|-]?[1-9]$')]
    [int] $Minimum
)

Test -c A12 # matches pattern
Test -c A63 # does not match pattern

Test -h 0x4f # matches pattern
Test -h "0XB2" # matches pattern
Test -h 0xK3 # does not match pattern

Test -m -4 # matches pattern
Test -m "+7" # matches pattern
Test -m -12 # matches pattern, but is too long

[ValidatePattern('\^[a-z][a-z0-9]\*$')]$ident = "abc"
$ident = "123" # does not match pattern
```

### 12.3.15 The ValidateRange attribute

This attribute is used in a *script-parameter* or *variable* to specify the minimum and maximum
values of the parameter's argument. The following arguments are used to define the characteristics
of the parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>MinRange (position 0)</td>
<td><p>Type: object</p>
<p>This argument specifies the minimum value allowed.</p></td>
</tr>
<tr class="even">
<td>MaxRange (position 1)</td>
<td><p>Type: object</p>
<p>This argument specifies the maximum value allowed.</p></td>
</tr>
</tbody>
</table>

In the absence of this attribute, there is no range restriction.

Consider a function call `Test1` that has the following param block, and which is called as shown:

```powershell
param (
    [parameter(Mandatory = $true)]
    [ValidateRange(1, 10)]
    [int] $StartValue
)

Test1 2
Test1 -st 7
Test1 -3 # value is too small
Test1 12 # value is too large
```

Consider a function call Test2 that has the following param block and calls:

```powershell
param (
    [parameter(Mandatory = $true)]
    [ValidateRange("b", "f")]
    [string] $Name
)

Test2 "Bravo" # ok
Test2 "Alpha" # value compares less than the minimum
Test2 "Hotel" # value compares greater than the maximum
```

Consider a function call `Test3` that has the following param block, and which is called as shown:

```powershell
param (
    [parameter(Mandatory = $true)]
    [ValidateRange(0.002, 0.003)]
    [double] $Distance
)

Test3 0.002
Test3 0.0019    # value is too small
Test3 "0.005"   # value is too large

[ValidateRange(13, 19)]$teenager = 15
$teenager = 20  # value is too large
```

### 12.3.16 The ValidateScript attribute

This attribute is used in a *script-parameter* or *variable* to specify a script that is to be used
to validate the parameter's argument.

The argument in position 1 is a *script-block-expression*.

Consider a function call `Test` that has the following param block, and which is called as shown:

```powershell
param (
    [Parameter(Mandatory = $true)]
    [ValidateScript( { ($_ -ge 1 -and $_ -le 3) -or ($_ -ge 20) })]
    [int] $Count
)

Test 2 # ok, valid value
Test 25 # ok, valid value
Test 5 # invalid value
Test 0 # invalid value

[ValidateScript({$_.Length --gt 7})]$password = "password" # ok
$password = "abc123" # invalid value
```

### 12.3.17 The ValidateSet attribute

This attribute is used in a *script-parameter* or *variable* to specify a set of valid values for
the argument of the parameter. The following arguments are used to define the characteristics of the
parameter:

<table>
<thead>
<tr class="header">
<th><strong>Parameter Name</strong></th>
<th><strong>Purpose</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>ValidValues (position 0)</td>
<td><p>Type: string[]</p>
<p>The set of valid values.</p></td>
</tr>
<tr class="even">
<td>IgnoreCase (named)</td>
<td><p>Type: bool; Default value: $true</p>
<p>Specifies whether case should be ignored for parameters of type string.</p></td>
</tr>
</tbody>
</table>

If the parameter has an array type, every element of the corresponding argument array must match an
element of the value set.

Consider a function call `Test` that has the following param block, and which is called as shown:

```powershell
param ( [ValidateSet("Red", "Green", "Blue")]
    [string] $Color,

    [ValidateSet("up", "down", "left", "right", IgnoreCase =
        $false)]
    [string] $Direction

)

Test -col "RED"    # case is ignored, is a member of the set
Test -col "white"  # case is ignored, is not a member of the set

Test -dir "up"     # case is not ignored, is a member of the set
Test -dir "Up"     # case is not ignored, is not a member of the set

[ValidateSet(("Red", "Green", "Blue")]$color = "RED" # ok, case is ignored
$color = "Purple"  # case is ignored, is not a member of the set
```

<!-- reference links -->
[§12.3.1]: chapter-12.md#1231-the-alias-attribute
[§12.3.5]: chapter-12.md#1235-the-cmdletbinding-attribute
[§12.3.7]: chapter-12.md#1237-the-parameter-attribute
[§12.3]: chapter-12.md#123-reserved-attributes
[§4.2.6.4]: chapter-04.md#4264-regularexpressionoption-type
[§8.10.7]: chapter-08.md#8107-named-blocks
[§8.10]: chapter-08.md#810-function-definitions
[§8.14]: chapter-08.md#814-parameter-binding
