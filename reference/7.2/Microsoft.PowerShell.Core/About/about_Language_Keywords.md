---
description: Describes the keywords in the PowerShell scripting language.
Locale: en-US
ms.date: 03/07/2022
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_keywords?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Language Keywords
---
# about_Language_Keywords

## Short description
Describes the keywords in the PowerShell scripting language.

## Long description

PowerShell has the following language keywords. For more information, see the
about topic for the keyword and the information that follows the table.

|   Keyword    |                                                     Reference                                                     |
| ------------ | ----------------------------------------------------------------------------------------------------------------- |
| `begin`        | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)                    |
| `break`        | [about_Break](about_Break.md), [about_Trap](about_Trap.md)                                                        |
| `catch`        | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)                                                             |
| `class`        | [about_Classes](about_Classes.md)                                                                                 |
| `continue`     | [about_Continue](about_Continue.md), [about_Trap](about_Trap.md)                                                  |
| `data`         | [about_Data_Sections](about_Data_Sections.md)                                                                     |
| `define`       | Reserved for future use                                                                                           |
| `do`           | [about_Do](about_Do.md), [about_While](about_While.md)                                                            |
| `dynamicparam` | [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)                                     |
| `else`         | [about_If](about_If.md)                                                                                           |
| `elseif`       | [about_If](about_If.md)                                                                                           |
| `end`          | [about_Functions](about_Functions.md), [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)    |
| `enum`         | [about_Enum](about_Enum.md)                                                                                       |
| `exit`         | [Described in this topic](#exit)                                                                                  |
| `filter`       | [about_Functions](about_Functions.md)                                                                             |
| `finally`      | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)                                                             |
| `for`          | [about_For](about_For.md)                                                                                         |
| `foreach`      | [about_ForEach](about_ForEach.md)                                                                                 |
| `from`         | Reserved for future use                                                                                           |
| `function`     | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)                    |
| `hidden`       | [about_Hidden](about_Hidden.md)                                                                                   |
| `if`           | [about_If](about_If.md)                                                                                           |
| `in`           | [about_ForEach](about_ForEach.md)                                                                                 |
| `param`        | [about_Functions](about_Functions.md)                                                                             |
| `process`      | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)                    |
| `return`       | [about_Return](about_Return.md)                                                                                   |
| `static`       | [about_Classes](about_Classes.md)                                                                                 |
| `switch`       | [about_Switch](about_Switch.md)                                                                                   |
| `throw`        | [about_Throw](about_Throw.md), [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)            |
| `trap`         | [about_Trap](about_Trap.md), [about_Break](about_Break.md), [about_Try_Catch_Finally](about_Try_Catch_Finally.md) |
| `try`          | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)                                                             |
| `until`        | [about_Do](about_Do.md)                                                                                           |
| `using`        | [about_Using](about_Using.md), [about_Classes](about_Classes.md)                                                  |
| `var`          | Reserved for future use                                                                                           |
| `while`        | [about_While](about_While.md), [about_Do](about_Do.md)                                                            |

The following keywords are used by PowerShell workflows:

- `inlinescript`
- `parallel`
- `sequence`
- `workflow`

PowerShell workflows are only supported in PowerShell 5.1. For more information
about workflows, see
[Running PowerShell Commands in a Workflow](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574197(v=ws.11)).

## `begin`

Specifies one part of the body of a function, along with the `dynamicparam`,
`process`, and `end` keywords. The `begin` statement list runs one time before
any objects are received from the pipeline.

Syntax:

```Syntax
function <name> {
    dynamicparam {<statement list>}
    begin {<statement list>}
    process {<statement list>}
    end {<statement list>}
}
```

## `break`

Causes a script to exit a loop.

Syntax:

```Syntax
while (<condition>) {
   <statements>
   ...

   break
   ...

   <statements>
}
```

## `catch`

Specifies a statement list to run if an error occurs in the accompanying `try`
statement list. An error type requires brackets. The second pair of brackets
indicates that the error type is optional.

Syntax:

```Syntax
try {<statement list>}
catch [[<error type>]] {<statement list>}
```

## `class`

Specifies a new class in PowerShell.

Syntax:

```Syntax
class <class-name> {
    [[hidden] [static] <property-definition> ...]
    [<class-name>([argument-list>]) {<constructor-statement-list>} ...]
    [[hidden] [static] <method-definition> ...]
}
```

## `continue`

Causes a script to stop running a loop and to go back to the condition. If the
condition is met, the script begins the loop again.

Syntax:

```Syntax
while (<condition>) {
   <statements>
   ...

   continue
   ...

   <statements>
}
```

## `data`

In a script, defines a section that isolates data from the script logic. Can
also include `if` statements and some limited commands.

Syntax:

```Syntax
data <variable> [-supportedCommand <cmdlet-name>] {<permitted content>}
```

## `do`

Used with the `while` or `until` keyword as a looping construct. PowerShell
runs the statement list at least one time, unlike a loop that uses `while`.

Syntax for `while`:

```Syntax
do {<statement list>} while (<condition>)
```

Syntax for `until`:

```Syntax
do {<statement list>} until (<condition>)
```

## `dynamicparam`

Specifies one part of the body of a function, along with the `begin`, `process`,
and `end` keywords. Dynamic parameters are added at runtime.

Syntax:

```Syntax
function <name> {
   dynamicparam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

## `else`

Used with the `if` keyword to specify the default statement list.

Syntax:

```Syntax
if (<condition>) {<statement list>}
else {<statement list>}
```

## `elseif`

Used with the `if` and `else` keywords to specify additional conditionals. The
`else` keyword is optional.

Syntax:

```Syntax
if (<condition>) {<statement list>}
elseif (<condition>) {<statement list>}
else {<statement list>}
```

## `end`

Specifies one part of the body of a function, along with the `dynamicparam`,
`begin`, and `end` keywords. The `end` statement list runs one time after all
the objects have been received from the pipeline.

Syntax:

```Syntax
function <name> {
   dynamicparam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

## `enum`

`enum` is used to declare an enumeration; a distinct type that consists of a
set of named labels called the enumerator list.

Syntax:

```Syntax
enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

## `exit`

Causes PowerShell to exit a script or a PowerShell instance.

Syntax:

```Syntax
exit
exit <exitcode>
```

When you use `pwsh` with the **File** parameter, the `.ps1` (script) file
itself should include instructions for handling any errors or exceptions that
occur while the script is running. You should only use the `exit` statement to
indicate the post-execution status of the script.

On Windows, any number between `[int]::MinValue` and `[int]::MaxValue` is
allowed.

On Unix, only positive numbers between `[byte]::MinValue` and
`[byte]::MaxValue` are allowed. A negative number in the range of `-1` through
`-255` is automatically translated into a positive number by adding 256. For
example, `-2` is transformed to `254`.

In PowerShell, the `exit` statement sets the value of the `$LASTEXITCODE`
variable. In the Windows Command Shell (`cmd.exe`), the exit statement sets the
value of the `%ERRORLEVEL%` environment variable.

Any argument that is non-numeric or outside the platform-specific range is
translated to the value of `0`.

In the following example, the user sets the error level variable value to **4**
by adding `exit 4` to the script file `test.ps1`.

```cmd
C:\scripts\test>type test.ps1
1
2
3
exit 4

C:\scripts\test>pwsh -file ./test.ps1
1
2
3

C:\scripts\test>echo %ERRORLEVEL%
4
```

When you run `pwsh.exe -File <path to a script>` and the script file terminates
with an `exit` command, the exit code is set to the numeric argument used with
the `exit` command. If the script has no `exit` statement, the exit code is
always `0` when the script completes without error or `1` when the script
terminates from an unhandled exception.

## `filter`

Specifies a function in which the statement list runs one time for each input
object. It has the same effect as a function that contains only a `process`
block.

Syntax:

```Syntax
filter <name> {<statement list>}
```

## `finally`

Defines a statement list that runs after statements that are associated with
`try` and `catch`. A `finally` statement list runs even if you press
<kbd>CTRL</kbd>+<kbd>C</kbd> to leave a script or if you use the `exit` keyword
in the script.

Syntax:

```Syntax
try {<statement list>}
catch [<error type>] {<statement list>}
finally {<statement list>}
```

## `for`

Defines a loop with a condition.

Syntax:

```Syntax
for (<initialize>; <condition>; <iterate>) { <statement list> }
```

## `foreach`

Defines a loop using each member of a collection.

Syntax:

```Syntax
foreach (<item> in <collection>) { <statement list> }
```

## `from`

Reserved for future use.

## `function`

Creates a named statement list of reusable code. You can name the scope a
function belongs to. You can also specify one or more named parameters by using
the `param` keyword. Within the function statement list, you can include
`dynamicparam`, `begin`, `process`, and `end` statement lists.

Syntax:

```Syntax
function [<scope:>]<name> {
   param ([type]<$pname1> [, [type]<$pname2>])
   dynamicparam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

You also have the option of defining one or more parameters outside the
statement list after the function name.

Syntax:

```Syntax
function [<scope:>]<name> [([type]<$pname1>, [[type]<$pname2>])] {
   dynamicparam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

## `if`

Defines a conditional.

Syntax:

```Syntax
if (<condition>) {<statement list>}
```

## `hidden`

Hides class members from the default results of the `Get-Member` cmdlet,
IntelliSense, and tab completion results.

Syntax:

```Syntax
hidden [data type] $member_name
```

## `in`

Used in a `foreach` statement to create a loop that uses each member of a
collection.

Syntax:

```Syntax
foreach (<item> in <collection>){<statement list>}
```

## `param`

Defines the parameters in a function.

Syntax:

```Syntax
function [<scope:>]<name> {
   param ([type]<$pname1>[, [[type]<$pname2>]])
   <statement list>
}
```

## `process`

Specifies a part of the body of a function, along with the `dynamicparam`,
`begin`, and `end` keywords. When a `process` statement list receives input
from the pipeline, the `process` statement list runs one time for each element
from the pipeline. If the pipeline provides no objects, the `process` statement
list does not run. If the command is the first command in the pipeline, the
`process` statement list runs one time.

Syntax:

```Syntax
function <name> {
   dynamicparam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

## `return`

Causes PowerShell to leave the current scope, such as a script or function, and
writes the optional expression to the output.

Syntax:

```Syntax
return [<expression>]
```

## `static`

Specifies the property or method defined is common to all instances of the
class in which it is defined.

See `class` for usage examples.

## `switch`

To check multiple conditions, use a `switch` statement. The `switch` statement
is equivalent to a series of `if` statements, but it is simpler.

The `switch` statement lists each condition and an optional action. If a
condition obtains, the action is performed.

Syntax 1:

```Syntax
switch [-regex|-wildcard|-exact][-casesensitive] ( <value> )
{
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   ...

   default {<statement list>}
}
```

Syntax 2:

```Syntax
switch [-regex|-wildcard|-exact][-casesensitive] -file <filename>
{
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   ...

   default {<statement list>}
}
```

## `throw`

Throws an object as an error.

Syntax:

```Syntax
throw [<object>]
```

## `trap`

Defines a statement list to be run if an error is encountered. An error type
requires brackets. The second pair of brackets indicates that the error type
is optional.

Syntax:

```Syntax
trap [[<error type>]] {<statement list>}
```

## `try`

Defines a statement list to be checked for errors while the statements run. If
an error occurs, PowerShell continues running in a `catch` or `finally`
statement. An error type requires brackets. The second pair of brackets
indicates that the error type is optional.

Syntax:

```Syntax
try {<statement list>}
catch [[<error type>]] {<statement list>}
finally {<statement list>}
```

## `until`

Used in a `do` statement as a looping construct where the statement list is
executed at least one time.

Syntax:

```Syntax
do {<statement list>} until (<condition>)
```

## `using`

Allows indicating which namespaces are used in the session. Classes and members
require less typing to mention them. You can also include classes from modules.

Syntax #1:

```Syntax
using namespace <.Net-framework-namespace>
```

Syntax #2:

```Syntax
using module <module-name>
```

## `while`

The `while` statement is a looping construct where the condition is tested
before the statements are executed. If the condition is false, then the
statements do not execute.

Statement syntax:

```Syntax
while (<condition>) {
   <statements>
 }
```

When used in a `do` statement, `while` is part of a looping construct where
the statement list is executed at least one time.

`do` loop Syntax:

```Syntax
do {<statement list>} while (<condition>)
```

## See also

- [about_Special_Characters](about_Special_Characters.md)
- [about_Wildcards](about_Wildcards.md)
