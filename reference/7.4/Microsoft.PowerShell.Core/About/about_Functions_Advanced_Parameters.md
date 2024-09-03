---
description: Explains how to add parameters to advanced functions.
Locale: en-US
ms.date: 07/02/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions_Advanced_Parameters
---

# about_Functions_Advanced_Parameters

## Short description

Explains how to add parameters to advanced functions.

## Long description

You can add parameters to the advanced functions that you write, and use
parameter attributes and arguments to limit the parameter values that function
users submit with the parameter.

When you use the `CmdletBinding` attribute, PowerShell automatically adds the
Common Parameters. You can't create any parameters that use the same names as
the Common Parameters. For more information, see [about_CommonParameters][06].

Beginning in PowerShell 3.0, you can use splatting with `@Args` to represent
the parameters in a command. Splatting is valid on simple and advanced
functions. For more information, see [about_Functions][14] and
[about_Splatting][17].

## Type conversion of parameter values

When you supply strings as arguments to parameters that expect a different
type, PowerShell implicitly converts the strings to the parameter target type.
Advanced functions perform culture-invariant parsing of parameter values.

By contrast, a culture-sensitive conversion is performed during parameter
binding for compiled cmdlets.

In this example, we create a cmdlet and a script function that take a
`[datetime]` parameter. The current culture is changed to use German settings.
A German-formatted date is passed to the parameter.

```powershell
# Create a cmdlet that accepts a [datetime] argument.
Add-Type @'
  using System;
  using System.Management.Automation;
  [Cmdlet("Get", "Date_Cmdlet")]
  public class GetFooCmdlet : Cmdlet {

    [Parameter(Position=0)]
    public DateTime Date { get; set; }

    protected override void ProcessRecord() {
      WriteObject(Date);
    }
  }
'@ -PassThru | % Assembly | Import-Module

[cultureinfo]::CurrentCulture = 'de-DE'
$dateStr = '19-06-2018'

Get-Date_Cmdlet $dateStr
```

```Output
Dienstag, 19. Juni 2018 00:00:00
```

As shown above, cmdlets use culture-sensitive parsing to convert the string.

```powershell
# Define an equivalent function.
function Get-Date_Func {
  param(
    [DateTime] $Date
  )
  process {
    $Date
  }
}

[CultureInfo]::CurrentCulture = 'de-DE'

# This German-format date string doesn't work with the invariant culture.
# E.g., [datetime] '19-06-2018' breaks.
$dateStr = '19-06-2018'

Get-Date_Func $dateStr
```

Advanced functions use culture-invariant parsing, which results in the
following error.

```Output
Get-Date_Func: Cannot process argument transformation on parameter 'Date'.
Cannot convert value "19-06-2018" to type "System.DateTime". Error:
"String '19-06-2018' was not recognized as a valid DateTime."
```

## Static parameters

Static parameters are parameters that are always available in the function.
Most parameters in PowerShell cmdlets and scripts are static parameters.

The following example shows the declaration of a **ComputerName** parameter
that has the following characteristics:

- It's mandatory (required).
- It takes input from the pipeline.
- It takes an array of strings as input.

```powershell
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [string[]]$ComputerName
)
```

## Switch parameters

Switch parameters are parameters that take no parameter value. Instead, they
convey a Boolean true-or-false value through their presence or absence, so that
when a switch parameter is present it has a **true** value and when absent it
has a **false** value.

For example, the **Recurse** parameter of `Get-ChildItem` is a switch
parameter.

To create a switch parameter in a function, specify the `switch` type in the
parameter definition.

For example, your function may have an option to output data as a byte array:

```powershell
param([switch]$AsByteArray)
```

Switch parameters are easy to use and are preferred over Boolean parameters,
which have a less natural syntax for PowerShell.

For example, to use a switch parameter, the user types the parameter in the
command.

`-IncludeAll`

To use a Boolean parameter, the user types the parameter and a Boolean value.

`-IncludeAll $true`

When creating switch parameters, choose the parameter name carefully. Be sure
that the parameter name communicates the effect of the parameter to the user.
Avoid ambiguous terms, such as **Filter** or **Maximum** that might imply a
value is required.

### Switch parameter design considerations

- Switch parameters shouldn't be given default values. They should always
  default to false.
- Switch parameters are excluded from positional parameters by default. Even
  when other parameters are implicitly positional, switch parameters aren't.
  You _can_ override that in the Parameter attribute, but it will confuse
  users.
- Switch parameters should be designed so that setting them moves a command
  from its default behavior to a less common or more complicated mode. The
  simplest behavior of a command should be the default behavior that doesn't
  require the use of switch parameters.
- Switch parameters shouldn't be mandatory. The only case where it's necessary
  to make a switch parameter mandatory is when it's needed to differentiate a
  parameter set.
- Explicitly setting a switch from a boolean can be done with
  `-MySwitch:$boolValue` and in splatting with
  `$params = @{ MySwitch = $boolValue }`.
- Switch parameters are of type `SwitchParameter`, which implicitly converts to
  Boolean. The parameter variable can be used directly in a conditional
  expression. For example:

  `if ($MySwitch) { ... }`

  There's no need to write `if ($MySwitch.IsPresent) { ... }`

## Dynamic parameters

Dynamic parameters are parameters of a cmdlet, function, or script that are
available only under certain conditions.

For example, several provider cmdlets have parameters that are available only
when the cmdlet is used in the provider drive, or in a particular path of the
provider drive. For example, the **Encoding** parameter is available on the
`Add-Content`, `Get-Content`, and `Set-Content` cmdlets only when it's used in
a file system drive.

You can also create a parameter that appears only when another parameter is
used in the function command or when another parameter has a certain value.

Dynamic parameters can be useful, but use them only when necessary, because
they can be difficult for users to discover. To find a dynamic parameter, the
user must be in the provider path, use the **ArgumentList** parameter of the
`Get-Command` cmdlet, or use the **Path** parameter of `Get-Help`.

To create a dynamic parameter for a function or script, use the `dynamicparam`
keyword.

The syntax is as follows:

`dynamicparam {<statement-list>}`

In the statement list, use an `if` statement to specify the conditions under
which the parameter is available in the function.

The following example shows a function with standard parameters named **Name**
and **Path**, and an optional dynamic parameter named **KeyCount**. The
**KeyCount** parameter is in the `ByRegistryPath` parameter set and has a type
of `Int32`. The **KeyCount** parameter is available in the `Get-Sample`
function only when the value of the **Path** parameter starts with `HKLM:`,
indicating that it's being used in the `HKEY_LOCAL_MACHINE` registry drive.

```powershell
function Get-Sample {
  [CmdletBinding()]
  param([string]$Name, [string]$Path)

  dynamicparam
  {
    if ($Path.StartsWith("HKLM:"))
    {
      $parameterAttribute = [System.Management.Automation.ParameterAttribute]@{
          ParameterSetName = "ByRegistryPath"
          Mandatory = $false
      }

      $attributeCollection = [System.Collections.ObjectModel.Collection[System.Attribute]]::new()
      $attributeCollection.Add($parameterAttribute)

      $dynParam1 = [System.Management.Automation.RuntimeDefinedParameter]::new(
        'KeyCount', [Int32], $attributeCollection
      )

      $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()
      $paramDictionary.Add('KeyCount', $dynParam1)
      return $paramDictionary
    }
  }
}
```

For more information, see the documentation for the
[RuntimeDefinedParameter][02] type.

## Attributes of parameters

This section describes the attributes that you can add to function parameters.

All attributes are optional. However, if you omit the **CmdletBinding**
attribute, then to be recognized as an advanced function, the function must
include the **Parameter** attribute.

You can add one or multiple attributes in each parameter declaration. There's
no limit to the number of attributes that you can add to a parameter
declaration.

### Parameter attribute

The **Parameter** attribute is used to declare the attributes of function
parameters.

The **Parameter** attribute is optional, and you can omit it if none of the
parameters of your functions need attributes. But, to be recognized as an
advanced function, rather than a simple function, a function must have either
the **CmdletBinding** attribute or the **Parameter** attribute, or both.

The **Parameter** attribute has arguments that define the characteristics of
the parameter, such as whether the parameter is mandatory or optional.

Use the following syntax to declare the **Parameter** attribute, an argument,
and an argument value. The parentheses that enclose the argument and its value
must follow **Parameter** with no intervening space.

```powershell
param(
    [Parameter(Argument=value)]
    $ParameterName
)
```

Use commas to separate arguments within the parentheses. Use the following
syntax to declare two arguments of the **Parameter** attribute.

```powershell
param(
    [Parameter(Argument1=value1, Argument2=value2)]
    $ParameterName
)
```

The boolean argument types of the **Parameter** attribute default to **False**
when omitted from the **Parameter** attribute. Set the argument value to
`$true` or just list the argument by name. For example, the following
**Parameter** attributes are equivalent.

```powershell
param(
    [Parameter(Mandatory=$true)]
)

# Boolean arguments can be defined using this shorthand syntax

param(
    [Parameter(Mandatory)]
)
```

If you use the **Parameter** attribute without arguments, as an alternative to
using the **CmdletBinding** attribute, the parentheses that follow the
attribute name are still required.

```powershell
param(
    [Parameter()]
    $ParameterName
)
```

#### Mandatory argument

The `Mandatory` argument indicates that the parameter is required. If this
argument isn't specified, the parameter is optional.

The following example declares the **ComputerName** parameter. It uses the
`Mandatory` argument to make the parameter mandatory.

```powershell
param(
    [Parameter(Mandatory)]
    [string[]]$ComputerName
)
```

#### Position argument

The `Position` argument determines whether the parameter name is required when
the parameter is used in a command. When a parameter declaration includes the
`Position` argument, the parameter name can be omitted and PowerShell
identifies the unnamed parameter value by its position, or order, in the list
of unnamed parameter values in the command.

If the `Position` argument isn't specified, the parameter name, or a parameter
name alias or abbreviation, must precede the parameter value whenever the
parameter is used in a command.

By default, all function parameters are positional. PowerShell assigns position
numbers to parameters in the order the parameters are declared in the function.
To disable this feature, set the value of the `PositionalBinding` argument of
the **CmdletBinding** attribute to `$False`. The `Position` argument takes
precedence over the value of the `PositionalBinding` argument of the
**CmdletBinding** attribute. For more information, see `PositionalBinding` in
[about_Functions_CmdletBindingAttribute][12].

The value of the `Position` argument is specified as an integer. A position
value of **0** represents the first position in the command, a position value
of **1** represents the second position in the command, and so on.

If a function has no positional parameters, PowerShell assigns positions to
each parameter based on the order the parameters are declared. However, as a
best practice, don't rely on this assignment. When you want parameters to be
positional, use the `Position` argument.

The following example declares the **ComputerName** parameter. It uses the
`Position` argument with a value of **0**. As a result, when `-ComputerName` is
omitted from command, its value must be the first or only unnamed parameter
value in the command.

```powershell
param(
    [Parameter(Position=0)]
    [string[]]$ComputerName
)
```

#### ParameterSetName argument

The `ParameterSetName` argument specifies the parameter set a parameter belongs
to. If no parameter set is specified, the parameter belongs to all the
parameter sets defined by the function. To be unique, each parameter set must
have at least one parameter that isn't a member of any other parameter set.

> [!NOTE]
> For a cmdlet or function, there is a limit of 32 parameter sets.

The following example declares a **ComputerName** parameter in the `Computer`
parameter set, a **UserName** parameter in the `User` parameter set, and a
**Summary** parameter in both parameter sets.

```powershell
param(
    [Parameter(Mandatory, ParameterSetName="Computer")]
    [string[]]$ComputerName,

    [Parameter(Mandatory, ParameterSetName="User")]
    [string[]]$UserName,

    [Parameter()]
    [switch]$Summary
)
```

You can specify only one `ParameterSetName` value in each argument and only one
`ParameterSetName` argument in each **Parameter** attribute. To include a
parameter in more than one parameter set, add additional **Parameter**
attributes.

The following example explicitly adds the **Summary** parameter to the
`Computer` and `User` parameter sets. The **Summary** parameter is optional in
the `Computer` parameter set and mandatory in the `User` parameter set.

```powershell
param(
    [Parameter(Mandatory, ParameterSetName="Computer")]
    [string[]]$ComputerName,

    [Parameter(Mandatory, ParameterSetName="User")]
    [string[]]$UserName,

    [Parameter(ParameterSetName="Computer")]
    [Parameter(Mandatory, ParameterSetName="User")]
    [switch]$Summary
)
```

For more information about parameter sets, see [About Parameter Sets][15].

#### ValueFromPipeline argument

The `ValueFromPipeline` argument indicates that the parameter accepts input
from a pipeline object. Specify this argument if the function accepts the
entire object, not just a property of the object.

The following example declares a **ComputerName** parameter that's mandatory
and accepts an object that's passed to the function from the pipeline.

```powershell
param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [string[]]$ComputerName
)
```

#### ValueFromPipelineByPropertyName argument

The `ValueFromPipelineByPropertyName` argument indicates that the parameter
accepts input from a property of a pipeline object. The object property must
have the same name or alias as the parameter.

For example, if the function has a **ComputerName** parameter, and the piped
object has a **ComputerName** property, the value of the **ComputerName**
property is assigned to the function's **ComputerName** parameter.

The following example declares a **ComputerName** parameter that's mandatory
and accepts input from the object's **ComputerName** property that's passed to
the function through the pipeline.

```powershell
param(
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [string[]]$ComputerName
)
```

Consider an implementation of a function using this argument:

```powershell
function Test-ValueFromPipelineByPropertyName{
  param(
      [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
      [string[]]$ComputerName
  )
  Write-Output -InputObject "Saw that ComputerName was '$ComputerName'"
}
```

Then a demonstration of piping an object with the **ComputerName** property
would be:

```powershell
[pscustomobject]@{ ComputerName = "HelloWorld" } |
    Test-ValueFromPipelineByPropertyName
```

```Output
Saw that ComputerName was 'HelloWorld'
```

> [!NOTE]
> A typed parameter that accepts pipeline input (`by Value`) or
> (`by PropertyName`) enables use of _delay-bind_ script blocks on the
> parameter.
>
> The _delay-bind_ script block is run automatically during
> **ParameterBinding**. The result is bound to the parameter. Delay binding
> doesn't work for parameters defined as type **ScriptBlock** or
> **System.Object**. The script block is passed through _without_ being
> invoked. For more information about _delay-bind_ script blocks, see
> [about_Script_Blocks][16].

#### ValueFromRemainingArguments argument

The `ValueFromRemainingArguments` argument indicates that the parameter accepts
all the parameter's values in the command that aren't assigned to other
parameters of the function.

The following example declares a **Value** parameter that's mandatory and a
**Remaining** parameter that accepts all the remaining parameter values that
are submitted to the function.

```powershell
function Test-Remainder {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]$Value,

        [Parameter(Position=1, ValueFromRemainingArguments)]
        [string[]]$Remaining
    )

    "Found $($Remaining.Count) elements"

    for ($i = 0; $i -lt $Remaining.Count; $i++) {
        "${i}: $($Remaining[$i])"
    }
}
Test-Remainder first one,two
```

```Output
Found 2 elements
0: one
1: two
```

#### HelpMessage argument

The `HelpMessage` argument specifies a string that contains a brief description
of the parameter or its value. If you run the command without the mandatory
parameter, PowerShell prompts you for input. To see the help message, type `!?`
at the prompt and hit <kbd>Enter</kbd>.

The following example declares a mandatory **ComputerName** parameter and a
help message that explains the expected parameter value.

```powershell
param(
    [Parameter(Mandatory,
    HelpMessage="Enter one or more computer names separated by commas.")]
    [string[]]$ComputerName
)
```

Example output:

```Output
cmdlet  at command pipeline position 1
Supply values for the following parameters:
(Type !? for Help.)
ComputerName[0]: !?
Enter one or more computer names separated by commas.
ComputerName[0]: localhost
ComputerName[1]:
```

If there is no [comment-based help][01] for the function then this message is
displayed in the `Get-Help -Full` output.

This argument has no effect on optional parameters.

### Alias attribute

The **Alias** attribute establishes an alternate name for the parameter.
There's no limit to the number of aliases that you can assign to a parameter.

The following example shows a parameter declaration that adds the **CN** and
**MachineName** aliases to the mandatory **ComputerName** parameter.

```powershell
param(
    [Parameter(Mandatory)]
    [Alias("CN","MachineName")]
    [string[]]$ComputerName
)
```

### Credential attribute

The **Credential** attribute is used to indicate that the parameter accepts
credentials. The following example shows a parameter declaration that uses the
**Credential** attribute.

```powershell
param(
    [Parameter()]
    [System.Management.Automation.Credential()]
    [PSCredential]$Credential
)
```

### Experimental attribute

Use the **Experimental** attribute to declare some code as experimental. For a
full description of the attribute, see [about_Experimental_Features][07].

### PSDefaultValue attribute

The **PSDefaultValue** specifies the default value of a command parameter in a
script. This information is displayed by the `Get-Help` cmdlet. To see the
default value information, the function must include comment-based help. For
example:

```powershell
<#
    .SYNOPSIS
     This is a test script that has a parameter with a default value.
#>
function TestDefaultValue {
    param(
        [PSDefaultValue(Help='Current directory')]
        [string]$Name = $PWD.Path
    )

    $Name
}
```

Use `Get-Help` to see the default value information.

```powershell
Get-Help TestDefaultValue -Parameter name
```

```Output
-Name <String>

    Required?                    false
    Position?                    1
    Default value                Current directory
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

#### PSDefaultValue attribute arguments

The **PSDefaultValue** attribute has two arguments:

- **Help** - A string that describes the default value. This information is
  displayed by the `Get-Help` cmdlet.
- **Value** - The default value of the parameter.

Both arguments are optional. If you don't specify any arguments, then
`Get-Help` shows the value assigned to the parameter.

### PSTypeName attribute

You can't use extended type names in a type declaration. The *PSTypeName**
attribute allows you to restrict the type of the parameter to the extended
type.

In this example, the `Test-Connection` cmdlet returns an extended type. You can
use the **PSTypeName** attribute to restrict the type of the parameter to the
extended type.

```powershell
function TestType {
    param(
        [PSTypeName('Microsoft.PowerShell.Commands.TestConnectionCommand+PingMtuStatus')]
        [psobject]$MtuStatus
    )

    $MtuStatus
}

$mtu = Test-Connection -TargetName bing.com -MtuSize
TestType $mtu
```

### System.Obsolete attribute

Use the **System.Obsolete** attribute to mark parameters that are no longer
supported. This can be useful when you want to remove a parameter from a
function but you don't want to break existing scripts that use the function.

For example, consider a function that has a **NoTypeInformation** switch
parameter that controls whether type information is included in the output. You
want to make that behavior the default and remove the parameter from the
function. However, you don't want to break existing scripts that use the
function. You can mark the parameter as obsolete and add a message that
explains the change.

```powershell
param(
    [System.Obsolete("The NoTypeInformation parameter is obsolete.")]
    [SwitchParameter]$NoTypeInformation
)
```

### SupportsWildcards attribute

The **SupportsWildcards** attribute is used to indicate that the parameter
accepts wildcard values. The following example shows a parameter declaration
for a mandatory **Path** parameter that supports wildcard values.

```powershell
param(
    [Parameter(Mandatory)]
    [SupportsWildcards()]
    [string[]]$Path
)
```

Using this attribute doesn't automatically enable wildcard support. The cmdlet
developer must implement the code to handle the wildcard input. The wildcards
supported can vary according to the underlying API or PowerShell provider. For
more information, see [about_Wildcards][19].

## Argument completion attributes

### ArgumentCompletions attribute

The **ArgumentCompletions** attribute allows you to add tab completion values
to a specific parameter. An **ArgumentCompletions** attribute must be defined
for each parameter that needs tab completion. The **ArgumentCompletions**
attribute is similar to **ValidateSet**. Both attributes take a list of values
to be presented when the user presses <kbd>Tab</kbd> after the parameter name.
However, unlike **ValidateSet**, the values aren't validated.

This attribute was introduced in PowerShell 6.0.

For more information, see [about_Functions_Argument_Completion][11].

### ArgumentCompleter attribute

The **ArgumentCompleter** attribute allows you to add tab completion values to
a specific parameter. An **ArgumentCompleter** attribute must be defined for
each parameter that needs tab completion. Like **dynamicparameters**, the
available values are calculated at runtime when the user presses <kbd>Tab</kbd>
after the parameter name.

For more information, see [about_Functions_Argument_Completion][10].

## Parameter and variable validation attributes

Validation attributes direct PowerShell to test the parameter values that users
submit when they call the advanced function. If the parameter values fail the
test, an error is generated and the function isn't called. Parameter validation
is only applied to the input provided and any other values like default values
aren't validated.

You can also use the validation attributes to restrict the values that users
can specify for variables.

```powershell
[AllowNull()] [int]$number = 7
```

Validation attributes can be applied to any variable, not just parameters. You
can define validation for any variable within a script.

> [!NOTE]
> When using any attributes with a typed variable, it's best practice to
> declare the attribute before the type.
>
> If you declare a type with a line break before the attribute and variable
> name, the type is treated as its own statement.
>
> ```powershell
> [string]
> [ValidateLength(1,5)] $Text = 'Okay'
> ```
>
> ```Output
> IsPublic IsSerial Name                                     BaseType
> -------- -------- ----                                     --------
> True     True     String                                   System.Object
> ```
>
> If you declare a validation attribute after a type, the value being assigned
> is validated before type conversion, which can lead to unexpected validation
> failures.
>
> ```powershell
> [string] [ValidateLength(1,5)]$TicketIDFromInt        = 43
> [string] [ValidateLength(1,5)]$TicketIDFromString     = '43'
> [ValidateLength(1,5)] [string]$TicketIDAttributeFirst = 43
> ```
>
> ```Output
> MetadataError: The attribute cannot be added because variable
> TicketIDFromInt with value 43 would no longer be valid.
> ```

### AllowNull validation attribute

The **AllowNull** attribute allows the value of a mandatory parameter to be
`$null`. The following example declares a hashtable **ComputerInfo** parameter
that can have a **null** value.

```powershell
param(
    [Parameter(Mandatory)]
    [AllowNull()]
    [hashtable]$ComputerInfo
)
```

> [!NOTE]
> The **AllowNull** attribute doesn't work if the type converter is set to
> string as the string type won't accept a null value. You can use the
> **AllowEmptyString** attribute for this scenario.

### AllowEmptyString validation attribute

The **AllowEmptyString** attribute allows the value of a mandatory parameter to
be an empty string (`""`). The following example declares a **ComputerName**
parameter that can have an empty string value.

```powershell
param(
    [Parameter(Mandatory)]
    [AllowEmptyString()]
    [string]$ComputerName
)
```

### AllowEmptyCollection validation attribute

The **AllowEmptyCollection** attribute allows the value of a mandatory
parameter to be an empty collection `@()`. The following example declares a
**ComputerName** parameter that can have an empty collection value.

```powershell
param(
    [Parameter(Mandatory)]
    [AllowEmptyCollection()]
    [string[]]$ComputerName
)
```

### ValidateCount validation attribute

The **ValidateCount** attribute specifies the minimum and maximum number of
parameter values that a parameter accepts. PowerShell generates an error if the
number of parameter values in the command that calls the function is outside
that range.

The following parameter declaration creates a **ComputerName** parameter that
takes one to five parameter values.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateCount(1,5)]
    [string[]]$ComputerName
)
```

### ValidateLength validation attribute

The **ValidateLength** attribute specifies the minimum and maximum number of
characters in a parameter or variable value. PowerShell generates an error if
the length of a value specified for a parameter or a variable is outside of the
range.

In the following example, each computer name must have one to ten characters.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateLength(1,10)]
    [string[]]$ComputerName
)
```

In the following example, the value of the variable `$text` must be a minimum
of one character in length, and a maximum of ten characters.

```powershell
[ValidateLength(1,10)] [string] $text = 'valid'
```

### ValidatePattern validation attribute

The **ValidatePattern** attribute specifies a regular expression that's
compared to the parameter or variable value. PowerShell generates an error if
the value doesn't match the regular expression pattern.

In the following example, the parameter value must contain a four-digit number,
and each digit must be a number zero to nine.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidatePattern("[0-9]{4}")]
    [string[]]$ComputerName
)
```

In the following example, the value of the variable `$ticketID` must be exactly
a four-digit number, and each digit must be a number zero to nine.

```powershell
[ValidatePattern("^[0-9]{4}$")] [string]$ticketID = 1111
```

### ValidateRange validation attribute

The **ValidateRange** attribute specifies a numeric range or a
**ValidateRangeKind** enum value for each parameter or variable value.
PowerShell generates an error if any value is outside that range.

The **ValidateRangeKind** enum allows for the following values:

- `Positive` - A number greater than zero.
- `Negative` - A number less than zero.
- `NonPositive` - A number less than or equal to zero.
- `NonNegative` - A number greater than or equal to zero.

In the following example, the value of the **Attempts** parameter must be
between zero and ten.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateRange(0,10)]
    [Int]$Attempts
)
```

In the following example, the value of the variable `$number` must be between
zero and ten.

```powershell
[ValidateRange(0,10)] [int]$number = 5
```

In the following example, the value of the variable `$number` must be greater
than zero.

```powershell
[ValidateRange("Positive")] [int]$number = 1
```

### ValidateScript validation attribute

The **ValidateScript** attribute specifies a script that's used to validate a
parameter or variable value. PowerShell pipes the value to the script, and
generates an error if the script returns `$false` or if the script throws an
exception.

When you use the **ValidateScript** attribute, the value that's being validated
is mapped to the `$_` variable. You can use the `$_` variable to refer to the
value in the script.

In the following example, the value of the **EventDate** parameter must be
greater than or equal to the current date.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateScript({$_ -ge (Get-Date)})]
    [DateTime]$EventDate
)
```

In the following example, the value of the variable `$date` must be less than
or equal to the current date and time.

```powershell
[ValidateScript({$_ -le (Get-Date)})] [DateTime]$date = (Get-Date)
```

> [!NOTE]
> If you use **ValidateScript**, you can't pass a `$null` value to the
> parameter. When you pass a null value **ValidateScript** can't validate the
> argument.

#### Overriding the default error message

Starting in PowerShell 6, you can override the default error message generated
when a specified value is invalid with the `ErrorMessage` argument. Specify a
[composite format string][03]. The `0` index component uses the input value.
The `1` index component uses the **ScriptBlock** used to validate the input
value.

In the following example, the value of the **EventDate** parameter must be
greater than or equal to the current date and time. If the value is invalid,
the error message reports that the specified date and time is too old.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateScript(
        {$_ -ge (Get-Date)},
        ErrorMessage = "{0} isn't a future date. Specify a later date."
    )]
    [DateTime]$EventDate
)
```

When the specified value is a past date, the custom error message is returned.

```Output
Cannot validate argument on parameter 'EventDate'. 1/1/1999 12:00:00 AM
isn't a future date. Specify a later date.
```

You can apply further formatting in the string with optional
[format string components][04].

In the following example, the value of the **EventDate** parameter must be
greater than or equal to the current date and time. If the value is invalid,
the error message reports that the specified date is too old.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateScript(
        {$_ -ge (Get-Date).Date},
        ErrorMessage = "{0:d} isn't a future date. Specify a later date."
    )]
    [DateTime]$EventDate
)
```

When the specified value is a past date, the custom error message is returned.

```Output
Cannot validate argument on parameter 'EventDate'. 1/1/1999 isn't a future
date. Specify a later date.
```

### ValidateSet attribute

The **ValidateSet** attribute specifies a set of valid values for a parameter
or variable and enables tab completion. PowerShell generates an error if a
parameter or variable value doesn't match a value in the set. In the following
example, the value of the **Detail** parameter can only be Low, Average, or
High.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateSet("Low", "Average", "High")]
    [string[]]$Detail
)
```

In the following example, the value of the variable `$flavor` must be either
Chocolate, Strawberry, or Vanilla.

```powershell
[ValidateSet("Chocolate", "Strawberry", "Vanilla")]
[string]$flavor = "Strawberry"
```

The validation occurs whenever that variable is assigned even within the
script. For example, the following results in an error at runtime:

```powershell
param(
    [ValidateSet("hello", "world")]
    [string]$Message
)

$Message = "bye"
```

This example returns the following error at runtime:

```Output
MetadataError: The attribute cannot be added because variable Message with
value bye would no longer be valid.
```

Using `ValidateSet` also enable tab expansion of values for that parameter. For
more information, see [about_Tab_Expansion][18].

#### Dynamic ValidateSet values using classes

You can use a **Class** to dynamically generate the values for **ValidateSet**
at runtime. In the following example, the valid values for the variable
`$Sound` are generated via a **Class** named **SoundNames** that checks three
filesystem paths for available sound files:

```powershell
Class SoundNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $SoundPaths = '/System/Library/Sounds/',
            '/Library/Sounds','~/Library/Sounds'
        $SoundNames = ForEach ($SoundPath in $SoundPaths) {
            If (Test-Path $SoundPath) {
                (Get-ChildItem $SoundPath).BaseName
            }
        }
        return [string[]] $SoundNames
    }
}
```

The `[SoundNames]` class is then implemented as a dynamic **ValidateSet** value
as follows:

```powershell
param(
    [ValidateSet([SoundNames])]
    [string]$Sound
)
```

> [!NOTE]
> The `IValidateSetValuesGenerator` class was introduced in PowerShell 6.0

### ValidateNotNull validation attribute

The **ValidateNotNull** attribute specifies that the parameter value can't be
`$null`. When the value is `$null`, PowerShell raises an exception.

The **ValidateNotNull** attribute is designed to be used when the parameter is
optional and the type is undefined or has a type converter that can't
implicitly convert a null value like **object**. If you specify a type that
that implicitly converts a null value, such as a **string**, the null value is
converted to an empty string even when using the **ValidateNotNull** attribute.
For this scenario use the **ValidateNotNullOrEmpty** attribute.

In the following example, the value of the **ID** parameter can't be `$null`.

```powershell
param(
    [Parameter()]
    [ValidateNotNull()]
    $ID
)
```

### ValidateNotNullOrEmpty validation attribute

The **ValidateNotNullOrEmpty** attribute specifies that the assigned value
can't be any of the following values:

- `$null`
- an empty string (`""`)
- an empty array (`@()`)

When the value is invalid, PowerShell raises an exception.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]]$UserName
)
```

### ValidateNotNullOrWhiteSpace validation attribute

The **ValidateNotNullOrWhiteSpace** attribute specifies that the assigned value
can't be any of the following values:

- `$null`
- an empty string (`""`)
- an empty array `@()`
- a string that contains only whitespace characters, like tabs, spaces,
  carriage returns, and newlines
- an array that contains any strings that are empty or contain only whitespace
  characters

When the value is invalid, PowerShell raises an exception.

```powershell
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrWhiteSpace()]
    [string[]]$UserName
)
```

### ValidateDrive validation attribute

The **ValidateDrive** attribute specifies that the parameter value must
represent the path, that's referring to allowed drives only. PowerShell
generates an error if the parameter value refers to drives other than the
allowed. Existence of the path, except for the drive itself, isn't verified.

If you use relative path, the current drive must be in the allowed drive list.

```powershell
param(
    [ValidateDrive("C", "D", "Variable", "Function")]
    [string]$Path
)
```

### ValidateUserDrive validation attribute

The **ValidateUserDrive** attribute specifies that the parameter value must
represent in the `User` drive. PowerShell generates an error if the path refers
to a different drive. The validation attribute only tests for the existence of
the drive prefix of the path.

If you use relative path, the current drive must be `User`.

```powershell
function Test-UserDrivePath{
    [OutputType([bool])]
    param(
        [Parameter(Mandatory, Position=0)]
        [ValidateUserDrive()]
        [string]$Path
    )
    $True
}

Test-UserDrivePath -Path C:\
```

```Output
Test-UserDrivePath: Cannot validate argument on parameter 'Path'. The path
argument drive C does not belong to the set of approved drives: User.
Supply a path argument with an approved drive.
```

```powershell
Test-UserDrivePath -Path 'User:\A_folder_that_does_not_exist'
```

```Output
Test-UserDrivePath: Cannot validate argument on parameter 'Path'. Cannot
find drive. A drive with the name 'User' does not exist.
```

You can define `User` drive in Just Enough Administration (JEA) session
configurations. For this example, we create the User: drive.

```powershell
New-PSDrive -Name 'User' -PSProvider FileSystem -Root $env:HOMEPATH
```

```Output
Name           Used (GB)     Free (GB) Provider      Root
----           ---------     --------- --------      ----
User               75.76         24.24 FileSystem    C:\Users\ExampleUser
```

```powershell
Test-UserDrivePath -Path 'User:\A_folder_that_does_not_exist'
```

```Output
True
```

### ValidateTrustedData validation attribute

This attribute was added in PowerShell 6.1.1.

At this time, the attribute is used internally by PowerShell itself and isn't
intended for external usage.

## See also

- [about_Automatic_Variables][05]
- [about_Functions][14]
- [about_Functions_Advanced][09]
- [about_Functions_Advanced_Methods][08]
- [about_Functions_CmdletBindingAttribute][12]
- [about_Functions_OutputTypeAttribute][13]

<!-- link references -->
[01]: about_comment_based_help.md
[02]: /dotnet/api/system.management.automation.runtimedefinedparameter
[03]: /dotnet/standard/base-types/composite-formatting#composite-format-string
[04]: /dotnet/standard/base-types/composite-formatting#format-string-component
[05]: about_Automatic_Variables.md
[06]: about_CommonParameters.md
[07]: about_Experimental_Features.md
[08]: about_Functions_Advanced_Methods.md
[09]: about_Functions_Advanced.md
[10]: about_Functions_Argument_Completion.md#argumentcompleter-attribute
[11]: about_Functions_Argument_Completion.md#argumentcompletions-attribute
[12]: about_Functions_CmdletBindingAttribute.md
[13]: about_Functions_OutputTypeAttribute.md
[14]: about_Functions.md
[15]: about_parameter_sets.md
[16]: about_Script_Blocks.md#using-delay-bind-script-blocks-with-parameters
[17]: about_Splatting.md
[18]: about_Tab_Expansion.md
[19]: about_Wildcards.md
