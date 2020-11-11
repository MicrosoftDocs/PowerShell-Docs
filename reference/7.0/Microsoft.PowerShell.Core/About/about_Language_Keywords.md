---
description: Describes the keywords in the PowerShell scripting language. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 10/06/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_keywords?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Language_Keywords
---
# About Language Keywords

## SHORT DESCRIPTION
Describes the keywords in the PowerShell scripting language.

## LONG DESCRIPTION

PowerShell has the following language keywords. For more
information, see the about topic for the keyword and the information that
follows the table.

Keyword     | Reference
---         | ---
Begin       | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)
Break       | [about_Break](about_Break.md), [about_Trap](about_Trap.md)
Catch       | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
Class       | [about_Classes](about_Classes.md)
Continue    | [about_Continue](about_Continue.md), [about_Trap](about_Trap.md)
Data        | [about_Data_Sections](about_Data_Sections.md)
Define      | Reserved for future use
Do          | [about_Do](about_Do.md), [about_While](about_While.md)
DynamicParam| [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)
Else        | [about_If](about_If.md)
Elseif      | [about_If](about_If.md)
End         | [about_Functions](about_Functions.md), [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)
Enum        | [about_Enum](about_Enum.md)
Exit        | [Described in this topic](#exit)
Filter      | [about_Functions](about_Functions.md)
Finally     | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
For         | [about_For](about_For.md)
ForEach     | [about_ForEach](about_ForEach.md)
From        | Reserved for future use
Function    | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)
Hidden      | [about_Hidden](about_Hidden.md)
If          | [about_If](about_If.md)
In          | [about_ForEach](about_ForEach.md)
Param       | [about_Functions](about_Functions.md)
Process     | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)
Return      | [about_Return](about_Return.md)
Static      | [about_Classes](about_Classes.md)
Switch      | [about_Switch](about_Switch.md)
Throw       | [about_Throw](about_Throw.md), [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)
Trap        | [about_Trap](about_Trap.md), [about_Break](about_Break.md), [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
Try         | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
Until       | [about_Do](about_Do.md)
Using       | [about_Using](about_Using.md), [about_Classes](about_Classes.md)
Var         | Reserved for future use
While       | [about_While](about_While.md), [about_Do](about_Do.md)

Language Keywords

### Begin

Specifies one part of the body of a function, along with the `DynamicParam`,
`Process`, and `End` keywords. The `Begin` statement list runs one time before any
objects are received from the pipeline.

Syntax:

```Syntax
function <name> {
    DynamicParam {<statement list>}
    begin {<statement list>}
    process {<statement list>}
    end {<statement list>}
}
```

### Break

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

### Catch

Specifies a statement list to run if an error occurs in the accompanying Try
statement list. An error type requires brackets. The second pair of brackets
indicates that the error type is optional.

Syntax:

```Syntax
try {<statement list>}
catch [[<error type>]] {<statement list>}
```

### Class

Specifies a new class in PowerShell.

Syntax:

```Syntax
class <class-name> {
    [[hidden] [static] <property-definition> ...]
    [<class-name>([argument-list>]) {<constructor-statement-list>} ...]
    [[hidden] [static] <method-definition> ...]
}
```

### Continue

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

### Data

In a script, defines a section that isolates data from the script logic. Can
also include `If` statements and some limited commands.

Syntax:

```Syntax
data <variable> [-supportedCommand <cmdlet-name>] {<permitted content>}
```

### Do

Used with the `While` or `Until` keyword as a looping construct. PowerShell
runs the statement list at least one time, unlike a loop that uses `While`.

Syntax for `While`:

```Syntax
do {<statement list>} while (<condition>)
```

Syntax for `Until`:

```Syntax
do {<statement list>} until (<condition>)
```

### DynamicParam

Specifies one part of the body of a function, along with the `Begin`, `Process`,
and `End` keywords. Dynamic parameters are added at run time.

Syntax:

```Syntax
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

### Else

Used with the `If` keyword to specify the default statement list.

Syntax:

```Syntax
if (<condition>) {<statement list>}
else {<statement list>}
```

### Elseif

Used with the `If` and `Else` keywords to specify additional conditionals. The
`Else` keyword is optional.

Syntax:

```Syntax
if (<condition>) {<statement list>}
elseif (<condition>) {<statement list>}
else {<statement list>}
```

### End

Specifies one part of the body of a function, along with the `DynamicParam`,
`Begin`, and `End` keywords. The `End` statement list runs one time after all the
objects have been received from the pipeline.

Syntax:

```Syntax
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

### Enum

`enum` is used to declare an enumeration; a distinct type that consists of
a set of named labels called the enumerator list.

Syntax:

```Syntax
enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

### Exit

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

On Windows, any number between `[int]::MinValue` and `[int]::MaxValue` is allowed.

On Unix, only positive numbers between `[byte]::MinValue` and
`[byte]::MaxValue` are allowed. A negative number in the range of `-1` through
`-255` is automatically translated into a positive number by adding 256. For
example, `-2` is transformed to `254`.

In PowerShell, the `exit` statement sets the value of the `$LASTEXITCODE`
variable. In the Windows Command Shell (cmd.exe), the exit statement sets the
value of the `%ERRORLEVEL%` environment variable.

Any argument that is non-numeric or outside the platform-specific range is
translated to the value of `0`.

In the following example, the user sets the error level variable value to 4 by
adding `exit 4` to the script file `test.ps1`.

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

### Filter

Specifies a function in which the statement list runs one time for each input
object. It has the same effect as a function that contains only a Process
block.

Syntax:

```Syntax
filter <name> {<statement list>}
```

### Finally

Defines a statement list that runs after statements that are associated with
Try and Catch. A `Finally` statement list runs even if you press `CTRL+C` to leave
a script or if you use the Exit keyword in the script.

Syntax:

```Syntax
try {<statement list>}
catch [<error type>] {<statement list>}
finally {<statement list>}
```

### For

Defines a loop by using a condition.

Syntax:

```Syntax
for (<initialize>; <condition>; <iterate>) { <statement list> }
```

### ForEach

Defines a loop by using each member of a collection.

Syntax:

```Syntax
ForEach (<item> in <collection>) { <statement list> }
```

### From

Reserved for future use.

### Function

Creates a named statement list of reusable code. You can name the scope a
function belongs to. And, you can specify one or more named parameters by
using the `Param` keyword. Within the function statement list, you can include
`DynamicParam`, `Begin`, `Process`, and `End` statement lists.

Syntax:

```Syntax
function [<scope:>]<name> {
   param ([type]<$pname1> [, [type]<$pname2>])
   DynamicParam {<statement list>}
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
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

### If

Defines a conditional.

Syntax:

```Syntax
if (<condition>) {<statement list>}
```

### Hidden

Hides class members from the default results of the `Get-Member` cmdlet, and
from IntelliSense and tab completion results.

Syntax:

```Syntax
Hidden [data type] $member_name
```

### In

Used in a `ForEach` statement to create a loop that uses each member of a
collection.

Syntax:

```Syntax
ForEach (<item> in <collection>){<statement list>}
```

### InlineScript

Runs workflow commands in a shared PowerShell session. This keyword is valid
only in a PowerShell Workflow.

Syntax:

```Syntax
workflow <verb>-<noun>
{
   InlineScript
   {
      <Command/Expression>
      ...

   }
}
```

The `InlineScript` keyword indicates an `InlineScript` activity, which runs
commands in a shared standard (non-workflow) session. You can use the
`InlineScript` keyword to run commands that are not otherwise valid in a
workflow, and to run commands that share data. By default, the commands in an
InlineScript script block run in a separate process.

For more information, see [Running PowerShell Commands in a Workflow](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574197(v=ws.11)).

### Param

Defines the parameters in a function.

Syntax:

```Syntax
function [<scope:>]<name> {
   param ([type]<$pname1>[, [[type]<$pname2>]])
   <statement list>
}
```

### Process

Specifies a part of the body of a function, along with the `DynamicParam`,
`Begin`, and `End` keywords. When a `Process` statement list receives input
from the pipeline, the `Process` statement list runs one time for each element
from the pipeline. If the pipeline provides no objects, the `Process`
statement list does not run. If the command is the first command in the
pipeline, the `Process` statement list runs one time.

Syntax:

```Syntax
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

### Return

Causes PowerShell to leave the current scope, such as a script or function,
and writes the optional expression to the output.

Syntax:

```Syntax
return [<expression>]
```

### Static

Specifies the property or method defined is common to all instances of the
class in which is defined.

See `Class` for usage examples.

### Switch

To check multiple conditions, use a `Switch` statement. The `Switch` statement is
equivalent to a series of `If` statements, but it is simpler.

The `Switch` statement lists each condition and an optional action. If a
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

### Throw

Throws an object as an error.

Syntax:

```Syntax
throw [<object>]
```

### Trap

Defines a statement list to be run if an error is encountered. An error type
requires brackets. The second pair of brackets indicates that the error type
is optional.

Syntax:

```Syntax
trap [[<error type>]] {<statement list>}
```

### Try

Defines a statement list to be checked for errors while the statements run. If
an error occurs, PowerShell continues running in a `Catch` or `Finally`
statement. An error type requires brackets. The second pair of brackets
indicates that the error type is optional.

Syntax:

```Syntax
try {<statement list>}
catch [[<error type>]] {<statement list>}
finally {<statement list>}
```

### Until

Used in a `Do` statement as a looping construct where the statement list is
executed at least one time.

Syntax:

```Syntax
do {<statement list>} until (<condition>)
```

### Using

Allows to indicate which namespaces are used in the session. Classes and
members require less typing to mention them. You can also include classes from
modules.

Syntax #1:

```Syntax
using namespace <.Net-framework-namespace>
```

Syntax #2:

```Syntax
using module <module-name>
```

### While

The `while` statement is a looping construct where the condition is tested
before the statements are executed. If the condition is FALSE, then the
statements do not execute.

Statement syntax:

```Syntax
while (<condition>) {
   <statements>
 }
```

When used in a `Do` statement, `while` is part of a looping construct where
the statement list is executed at least one time.

Do loop Syntax:

```Syntax
do {<statement list>} while (<condition>)
```

## SEE ALSO

- [about_Special_Characters](about_Special_Characters.md)
- [about_Wildcards](about_Wildcards.md)
