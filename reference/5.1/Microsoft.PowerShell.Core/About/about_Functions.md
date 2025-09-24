---
description: Describes how to create and use functions in PowerShell.
Locale: en-US
ms.date: 07/16/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Functions
---

# about_Functions

## SHORT DESCRIPTION

Describes how to create and use functions in PowerShell.

## LONG DESCRIPTION

A function is a list of PowerShell statements that has a name that you assign.
When you run a function, you type the function name.

PowerShell defines two kinds of functions:

- A **function** is a block of code that can be called by name. It can take
  input and return output. Functions are defined using the `function` keyword.
- A **filter** is a type of function designed to process data from the
  pipeline. Filters are defined using the `filter` keyword.

You can group the statements in a function into one of four different
predefined script blocks. These script blocks are named using the keywords
`begin`, `process`, and `end`. If you don't use these keywords, PowerShell puts
the statements in the appropriate code block.

Functions can also act like cmdlets. You can create a function that works just
like a cmdlet without using `C#` programming. For more information, see
[about_Functions_Advanced][10].

> [!IMPORTANT]
> Within script files and script-based modules, functions must be defined
> before they can be called.

## FUNCTION SYNTAX

Functions are defined using the following syntax:

```Syntax
function [<scope:>]<name> {
  param([type]$Parameter1 [,[type]$Parameter2])
  dynamicparam {<statement list>}
  begin {<statement list>}
  process {<statement list>}
  end {<statement list>}
}
```

A function includes the following items:

- A `function` keyword
- A scope (optional)
- A name that you select
- Any number of named parameters (optional), including dynamic parameters
- One or more PowerShell statements enclosed in braces `{}`

If you don't use one of the keywords (`begin`, `process`, `end`) in a
`function` definition, PowerShell puts the statements in the `end` block.

For more information about the `dynamicparam` keyword and dynamic parameters in
functions, see [about_Functions_Advanced_Parameters][09].

A function can be as simple as:

```powershell
function Get-PowerShellProcess { Get-Process powershell }
```

Once a function is defined, you can use it like the built-in cmdlets. For
example, to call the newly defined `Get-PowerShellProcess` function:

```powershell
Get-PowerShellProcess
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
    110    78.72     172.39      10.62   10936   1 powershell
```

A function can also be as complex as a cmdlet.

Functions can return values that can be displayed, assigned to variables, or
passed to other functions or cmdlets. You can use the `return` keyword to
return output. The `return` keyword doesn't affect or suppress other output
returned from your function. However, the `return` keyword exits the function
at that line. For more information, see [about_Return][15].

## FILTER SYNTAX

The intent of the `filter` function is to provide a shorthand way of defining a
function that runs on each object in the pipeline.

The syntax of a filter is as follows:

```Syntax
filter [<scope:>]<name> {<statement list>}
```

To simplify the syntax for `filter` functions, omit the script block keyword
(`begin`, `process`, `end`). PowerShell puts the statements in the `process`
block. You can use any of the other blocks in a filter function, but the intent
was to provide a shorthand way of defining a function that has the sole purpose
of processing each object in the pipeline.

The following filter takes log entries from the pipeline and then displays
either the whole entry or only the message portion of the entry:

```powershell
filter Get-EventMessage ([switch]$MessageOnly) {
  if ($MessageOnly) { Out-Host -InputObject $_.Message }
  else { $_ }
}
```

It can be used as follows:

```powershell
Get-WinEvent -LogName System -MaxEvents 100 | Get-EventMessage -MessageOnly
```

## INPUT PROCESSING METHODS

The methods described in this section are referred to as the input processing
methods. For functions, these three methods named using the `begin`,
`process`, and `end` blocks of the function.

You aren't required to use any of these blocks in your functions. If you don't
use a named block, then PowerShell puts the code in the `end` block of the
function. However, if you use any of these named blocks, or define a
`dynamicparam` block, you must put all code in a named block.

The following example shows the outline of a function that contains a `begin`
block for one-time preprocessing, a `process` block data from the pipeline, and
an `end` block for one-time post-processing.

```powershell
Function Test-ScriptCmdlet {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param ($Parameter1)
    begin{}
    process{}
    end{}
}
```

### `begin`

This block is used to provide optional one-time preprocessing for the function.
The PowerShell runtime uses the code in this block once for each instance of
the function in the pipeline.

### `process`

This block is used to provide record-by-record processing for the function. You
can use a `process` block without defining the other blocks. The number of
`process` block executions depends on how you use the function and what input
the function receives.

The automatic variable `$_` or `$PSItem` contains the current object in the
pipeline for use in the `process` block. The `$input` automatic variable
contains an enumerator that's only available to functions and script blocks.
For more information, see [about_Automatic_Variables][04].

- If the function is invoked without pipeline input, PowerShell executes the
  `process` block only once.
- Within a pipeline, the `process` block executes once for each input object
  that reaches the function.
- If the pipeline input that reaches the function is empty, the `process` block
  doesn't execute.
  - The `begin` and `end` blocks still execute.

> [!IMPORTANT]
> If a function parameter accepts pipeline input, and a `process` block isn't
> defined, record-by-record processing fails. In this case, your function only
> executes once, regardless of the input.

### `end`

Use this block to provide optional one-time post-processing for the function.


## SIMPLE FUNCTIONS

Functions don't have to be complicated to be useful. The simplest functions
have the following format:

```Syntax
function <function-name> { statements }
```

For example, the following function starts PowerShell with the **Run as
Administrator** option.

```powershell
function Start-PSAdmin { Start-Process PowerShell -Verb RunAs }
```

To use the function, type: `Start-PSAdmin`

To add statements to the function, type each statement on a separate line, or
use a semicolon (`;`) to separate the statements.

For example, the following function finds all `.jpg` files in the current
user's directories that were changed after the start date.

```powershell
function Get-NewPicture {
  $start = Get-Date -Month 1 -Day 1 -Year 2010
  $allPics = Get-ChildItem -Path $Env:USERPROFILE\*.jpg -Recurse
  $allPics | Where-Object {$_.LastWriteTime -gt $Start}
}
```

You can create a toolbox of useful small functions. Add these functions to your
PowerShell profile, as described in [about_Profiles][14] and later in this
article.

## FUNCTION NAMES

You can assign any name to a function. However, for functions that you share
with others, you should follow the standard PowerShell naming rules.

- Names should consist of a verb-noun pair where the verb identifies
  the action that the function performs and the noun identifies the item on
  which the cmdlet performs the action.
- Names should use the approved verbs for all PowerShell commands. Using
  approved verbs creates consistency for users.

For more information about the standard PowerShell verbs, see
[Approved Verbs][02].

## FUNCTIONS WITH PARAMETERS

You can use parameters with functions, including named parameters, positional
parameters, switch parameters, and dynamic parameters. For more information
about dynamic parameters in functions, see
[about_Functions_Advanced_Parameters][09].

### Named parameters

You can define any number of named parameters. You can include a default value
for named parameters, as described later in this article.

You can define parameters inside the braces using the `param` keyword, as shown
in the following sample syntax:

```Syntax
function <name> {
  param ([type]$Parameter1 [,[type]$Parameter2])
  <statement list>
}
```

You can also define parameters outside the braces without the `param` keyword,
as shown in the following sample syntax:

```Syntax
function <name> [([type]$Parameter1[,[type]$Parameter2])] {
  <statement list>
}
```

For example, the following function uses the alternative syntax to define two
parameters:

```powershell
function Add-Numbers([int]$One, [int]$Two) {
    $One + $Two
}
```

While the first method is preferred, there's no difference between these two
methods.

When you run the function, the value you supply for a parameter is assigned to
a variable that contains the parameter name. The value of that variable can be
used in the function.

The following example is a function called `Get-SmallFiles`. This function has
a `$Size` parameter. The function displays all the files that are smaller than
the value of the `$Size` parameter, and it excludes directories:

```powershell
function Get-SmallFiles {
  param ($Size)
  Get-ChildItem $HOME | Where-Object {
    $_.Length -lt $Size -and !$_.PSIsContainer
  }
}
```

In the function, you can use the `$Size` variable, which is the name defined
for the parameter.

To use this function, type the following command:

```powershell
Get-SmallFiles -Size 50
```

You can also enter a value for a named parameter without the parameter name.
For example, the following command gives the same result as a command that
names the **Size** parameter:

```powershell
Get-SmallFiles 50
```

To define a default value for a parameter, type an equal sign and the value
after the parameter name, as shown in the following variation of the
`Get-SmallFiles` example:

```powershell
function Get-SmallFiles ($Size = 100) {
  Get-ChildItem $HOME | Where-Object {
    $_.Length -lt $Size -and !$_.PSIsContainer
  }
}
```

If you type `Get-SmallFiles` without a value, the function assigns 100 to
`$size`. If you provide a value, the function uses that value.

Optionally, you can provide a brief help string that describes the default
value of your parameter, by adding the **PSDefaultValue** attribute to the
description of your parameter, and specifying the **Help** property of
**PSDefaultValue**. To provide a help string that describes the default value
(100) of the **Size** parameter in the `Get-SmallFiles` function, add the
**PSDefaultValue** attribute as shown in the following example.

```powershell
function Get-SmallFiles {
  param (
      [PSDefaultValue(Help = '100')]
      $Size = 100
  )
  Get-ChildItem $HOME | Where-Object {
    $_.Length -lt $Size -and !$_.PSIsContainer
  }
}
```

For more information about the **PSDefaultValue** attribute class, see
[PSDefaultValue Attribute Members][01].

### Positional parameters

A positional parameter is a parameter without a parameter name. PowerShell uses
the parameter value order to associate each parameter value with a parameter in
the function.

When you use positional parameters, type one or more values after the function
name. Positional parameter values are assigned to the `$args` array variable.
The value that follows the function name is assigned to the first position in
the `$args` array, `$args[0]`.

The following `Get-Extension` function adds the `.txt` filename extension to a
filename that you supply:

```powershell
function Get-Extension {
  $name = $args[0] + ".txt"
  $name
}
```

```powershell
Get-Extension myTextFile
```

```Output
myTextFile.txt
```

### Switch parameters

A switch is a parameter that doesn't require a value. Instead, you type the
function name followed by the name of the switch parameter.

To define a switch parameter, specify the type `[switch]` before the parameter
name, as shown in the following example:

```powershell
function Switch-Item {
  param ([switch]$On)
  if ($On) { "Switch on" }
  else { "Switch off" }
}
```

When you type the `On` switch parameter after the function name, the function
displays `Switch on`. Without the switch parameter, it displays `Switch off`.

```powershell
Switch-Item -On
```

```Output
Switch on
```

```powershell
Switch-Item
```

```Output
Switch off
```

You can also assign a **Boolean** value to a switch when you run the function,
as shown in the following example:

```powershell
Switch-Item -On:$true
```

```Output
Switch on
```

```powershell
Switch-Item -On:$false
```

```Output
Switch off
```

## USE SPLATTING TO PASS PARAMETER VALUES

You can use splatting to represent the parameters of a command. This feature is
introduced in Windows PowerShell 3.0.

Use this technique in functions that call commands in the session. You don't
need to declare or enumerate the command parameters, or change the function
when command parameters change.

The following sample function calls the `Get-Command` cmdlet. The command uses
`@args` to represent the parameters of `Get-Command`.

```powershell
function Get-MyCommand { Get-Command @args }
```

You can use all the parameters of `Get-Command` when you call the
`Get-MyCommand` function. The parameters and parameter values are passed to the
command using `@args`.

```powershell
Get-MyCommand -Name Get-ChildItem
```

```Output
CommandType     Name                ModuleName
-----------     ----                ----------
Cmdlet          Get-ChildItem       Microsoft.PowerShell.Management
```

The `@args` feature uses the `$args` automatic parameter, which represents
undeclared cmdlet parameters and values from remaining arguments.

For more information, see [about_Splatting][18].

## PIPING OBJECTS TO FUNCTIONS

Any function can take input from the pipeline. You can control how a function
processes input from the pipeline using `begin`, `process`, `end`, and `clean`
keywords. The following sample syntax shows these keywords:

The `process` statement list runs one time for each object in the pipeline.
While the `process` block is running, each pipeline object is assigned to the
`$_` automatic variable, one pipeline object at a time.

The following function uses the `process` keyword. The function displays
values from the pipeline:

```powershell
function Get-Pipeline
{
  process {"The value is: $_"}
}

1, 2, 4 | Get-Pipeline
```

```Output
The value is: 1
The value is: 2
The value is: 4
```

If you want a function that can take pipeline input or input from a parameter,
then the `process` block needs to handle both cases. For example:

```powershell
function Get-SumOfNumbers {
    param (
        [int[]]$Numbers
    )

    begin { $retValue = 0 }

    process {
        if ($MyInvocation.ExpectingInput) {
           "Pipeline input: $_"
           $retValue += $_
        } else {
           foreach ($n in $Numbers) {
               "Command line input: $n"
               $retValue += $n
           }
        }
    }

    end { "Sum = $retValue" }
}


PS> 1,2,3,4 | Get-SumOfNumbers
Pipeline input: 1
Pipeline input: 2
Pipeline input: 3
Pipeline input: 4
Sum = 10
PS> Get-SumOfNumbers 1,2,3,4
Command line input: 1
Command line input: 2
Command line input: 3
Command line input: 4
Sum = 10
```

When you use a function in a pipeline, the objects piped to the function are
assigned to the `$input` automatic variable. The function runs statements with
the `begin` script block before any objects come from the pipeline. The
function runs statements with the `end` script block when there are no more
objects in the pipeline.

The following example shows the `$input` automatic variable used int the
`begin` and `end` script blocks.

```powershell
function Get-PipelineBeginEnd {
    begin   { "Begin: The input is $input" }
    end     { "End:   The input is $input" }
}
```

When you run the function with pipeline input, it displays the following
results:

```powershell
1, 2, 4 | Get-PipelineBeginEnd
```

```Output
Begin: The input is
End:   The input is 1 2 4
```

When the `begin` statement runs, the function doesn't have the input from the
pipeline. The `end` statement runs after the function has the values.

If the function has a `process` keyword, each object in `$input` is removed
from `$input` and assigned to `$_`. The following example has a `process`
statement list:

```powershell
function Get-PipelineInput
{
    process {"Processing:  $_ " }
    end     {"End:   The input is: $input" }
}
```

In this example, each object piped to the function is sent to the `process`
statement list. The `process` statements run on each object, one object at a
time. The `$input` automatic variable is empty when the function reaches the
`end` keyword.

```powershell
1, 2, 4 | Get-PipelineInput
```

```Output
Processing:  1
Processing:  2
Processing:  4
End:   The input is:
```

For more information, see [Using Enumerators][05]

## FUNCTION SCOPE

A function exists in the scope in which you create it.

If a function is part of a script, the function is available to statements
within that script. By default, a function in a script isn't available outside
of that script.

You can specify the scope of a function. For example, the function is added to
the global scope in the following example:

```powershell
function Global:Get-DependentSvs {
  Get-Service | Where-Object {$_.DependentServices}
}
```

When a function is in the global scope, you can use the function in scripts,
in functions, and at the command line.

Functions create a new scope. The items created in a function, such as
variables, exist only in the function scope.

For more information, see [about_Scopes][16].

## FIND AND MANAGE FUNCTIONS USING THE `FUNCTION:` DRIVE

All the functions and filters in PowerShell are automatically stored in the
`Function:` drive. This drive is exposed by the PowerShell **Function**
provider.

When referring to the `Function:` drive, type a colon after **Function**, just
as you would do when referencing the `C` or `D` drive of a computer.

The following command displays all the functions in the current session of
PowerShell:

```powershell
Get-ChildItem Function:
```

The commands in the function are stored as a script block in the definition
property of the function. For example, to display the commands in the Help
function that comes with PowerShell, type:

```powershell
(Get-ChildItem Function:help).Definition
```

You can also use the following syntax.

```powershell
$Function:help
```

For more information, see
[about_Function_Provider][07].

## REUSE FUNCTIONS IN NEW SESSIONS

When you type a function at the PowerShell command prompt, the function becomes
part of the current session. The function is available until the session ends.

To use your function in all PowerShell sessions, add the function to your
PowerShell profile. For more information about profiles, see
[about_Profiles][14].

You can also save your function in a PowerShell script file. Type your function
in a text file, and then save the file with the `.ps1` filename extension.

## CREATE HELP FOR FUNCTIONS

The `Get-Help` cmdlet gets help for functions, cmdlets, providers, and scripts.
To get help for a function, type `Get-Help` followed by the function name.

For example, to get help for the `Get-MyDisks` function, type:

```powershell
Get-Help Get-MyDisks
```

You can write help for a function using either of the two following methods:

- Comment-Based Help for Functions

  Create help using special keywords in the comments. To create comment-based
  help for a function, the comments must be placed at the beginning, end, or
  within the body of the function. For more information about comment-based
  help, see [about_Comment_Based_Help][06].

- XML-Based Help for Functions

  XML-based help is required if you need to localize help content into multiple
  languages. To associate the function with the XML-based help file, use the
  `.EXTERNALHELP` comment-based help keyword. Without this keyword, `Get-Help`
  can't find the function help file and only returns the autogenerated help.

  For more information about the `.EXTERNALHELP` keyword, see
  [about_Comment_Based_Help][06]. For more information about XML-based help,
  see [How to Write Cmdlet Help][03].

## SEE ALSO

- [about_Automatic_Variables][04]
- [about_Comment_Based_Help][06]
- [about_Function_Provider][07]
- [about_Functions_Advanced][10]
- [about_Functions_Advanced_Methods][08]
- [about_Functions_Advanced_Parameters][09]
- [about_Functions_CmdletBindingAttribute][11]
- [about_Functions_OutputTypeAttribute][12]
- [about_Parameters][13]
- [about_Profiles][14]
- [about_Scopes][16]
- [about_Script_Blocks][17]

<!-- link references -->
[01]: /dotnet/api/system.management.automation.psdefaultvalueattribute
[02]: /powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
[03]: /powershell/scripting/developer/help/writing-help-for-windows-powershell-cmdlets
[04]: about_Automatic_Variables.md
[05]: about_Automatic_Variables.md#using-enumerators
[06]: about_Comment_Based_Help.md
[07]: about_Function_Provider.md
[08]: about_Functions_Advanced_Methods.md
[09]: about_Functions_Advanced_Parameters.md
[10]: about_Functions_Advanced.md
[11]: about_Functions_CmdletBindingAttribute.md
[12]: about_Functions_OutputTypeAttribute.md
[13]: about_Parameters.md
[14]: about_Profiles.md
[15]: about_Return.md
[16]: about_Scopes.md
[17]: about_Script_Blocks.md
[18]: about_Splatting.md
