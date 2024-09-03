---
description: Describes the keywords in the PowerShell scripting language.
Locale: en-US
ms.date: 05/20/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_keywords?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Language_Keywords
---
# about_Language_Keywords

## Short description
Describes the keywords in the PowerShell scripting language.

## Long description

PowerShell has the following language keywords. For more information, see the
about topic for the keyword and the information that follows the table.

|    Keyword     |                             Reference                              |
| -------------- | ------------------------------------------------------------------ |
| `begin`        | [about_Functions][14], [about_Functions_Advanced][13]              |
| `break`        | [about_Break][03], [about_Trap][21]                                |
| `catch`        | [about_Try_Catch_Finally][22]                                      |
| `class`        | [about_Classes][04]                                                |
| `clean`        | [about_Functions][14], [about_Functions_Advanced_Methods][11]      |
| `continue`     | [about_Continue][05], [about_Trap][21]                             |
| `data`         | [about_Data_Sections][06]                                          |
| `define`       | Reserved for future use                                            |
| `do`           | [about_Do][07], [about_While][24]                                  |
| `dynamicparam` | [about_Functions_Advanced_Parameters][12]                          |
| `else`         | [about_If][16]                                                     |
| `elseif`       | [about_If][16]                                                     |
| `end`          | [about_Functions][14], [about_Functions_Advanced_Methods][11]      |
| `enum`         | [about_Enum][08]                                                   |
| `exit`         | [Described in this topic][02]                                      |
| `filter`       | [about_Functions][14]                                              |
| `finally`      | [about_Try_Catch_Finally][22]                                      |
| `for`          | [about_For][09]                                                    |
| `foreach`      | [about_ForEach][10]                                                |
| `from`         | Reserved for future use                                            |
| `function`     | [about_Functions][14], [about_Functions_Advanced][13]              |
| `hidden`       | [about_Hidden][15]                                                 |
| `if`           | [about_If][16]                                                     |
| `in`           | [about_ForEach][10]                                                |
| `param`        | [about_Functions][14]                                              |
| `process`      | [about_Functions][14], [about_Functions_Advanced][13]              |
| `return`       | [about_Return][17]                                                 |
| `static`       | [about_Classes][04]                                                |
| `switch`       | [about_Switch][19]                                                 |
| `throw`        | [about_Throw][20], [about_Functions_Advanced_Methods][11]          |
| `trap`         | [about_Trap][21], [about_Break][03], [about_Try_Catch_Finally][22] |
| `try`          | [about_Try_Catch_Finally][22]                                      |
| `until`        | [about_Do][07]                                                     |
| `using`        | [about_Using][23], [about_Classes][04]                             |
| `var`          | Reserved for future use                                            |
| `while`        | [about_While][24], [about_Do][07]                                  |

The following keywords are used by PowerShell workflows:

- `inlinescript`
- `parallel`
- `sequence`
- `workflow`

PowerShell workflows are only supported in PowerShell 5.1. For more information
about workflows, see [Running PowerShell Commands in a Workflow][01].

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

## `clean`

The `clean` keyword was added in PowerShell 7.3. The keyword defines a block of
code that's guaranteed to run after the `begin`, `process` and `end` blocks of
a function. Unlike the `end` block, the `clean` block is always executed, even
when there is a terminating error in one of the other blocks.

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

In the following example, the user sets the error level variable value to `4`
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

Allows you to indicate which namespaces are used in the session. Type names,
classes, and members require less typing to reference them. You can also
include classes from modules.

Namespace syntax:

```Syntax
using namespace <.Net-namespace>
```

Module syntax:

```Syntax
using module <module-name>
```

Assembly syntax:

```Syntax
using assembly <.NET-assembly-path>
```

For more information, see [about_Using][23].

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

- [about_Special_Characters][18]
- [about_Wildcards][25]

<!-- link references -->
[01]: /previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574197(v=ws.11)
[02]: #exit
[03]: about_Break.md
[04]: about_Classes.md
[05]: about_Continue.md
[06]: about_Data_Sections.md
[07]: about_Do.md
[08]: about_Enum.md
[09]: about_For.md
[10]: about_ForEach.md
[11]: about_Functions_Advanced_Methods.md
[12]: about_Functions_Advanced_Parameters.md
[13]: about_Functions_Advanced.md
[14]: about_Functions.md
[15]: about_Hidden.md
[16]: about_If.md
[17]: about_Return.md
[18]: about_Special_Characters.md
[19]: about_Switch.md
[20]: about_Throw.md
[21]: about_Trap.md
[22]: about_Try_Catch_Finally.md
[23]: about_Using.md
[24]: about_While.md
[25]: about_Wildcards.md
