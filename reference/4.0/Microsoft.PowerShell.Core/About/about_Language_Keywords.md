ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Language_Keywords

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
Continue    | [about_Continue](about_Continue.md), [about_Trap](about_Trap.md)
Data        | [about_Data_Sections](about_Data_Sections.md)
Define      | Reserved for future use
Do          | [about_Do](about_Do.md), [about_While](about_While.md)
DynamicParam| [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)
Else        | [about_If](about_If.md)
Elseif      | [about_If](about_If.md)
End         | [about_Functions](about_Functions.md), [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)
Exit        | [Described in this topic](#exit)
Filter      | [about_Functions](about_Functions.md)
Finally     | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
For         | [about_For](about_For.md)
ForEach     | [about_ForEach](about_ForEach.md)
From        | Reserved for future use
Function    | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)
If          | [about_If](about_If.md)
In          | [about_ForEach](about_ForEach.md)
Param       | [about_Functions](about_Functions.md)
Process     | [about_Functions](about_Functions.md), [about_Functions_Advanced](about_Functions_Advanced.md)
Return      | [about_Return](about_Return.md)
Switch      | [about_Switch](about_Switch.md)
Throw       | [about_Throw](about_Throw.md), [about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)
Trap        | [about_Trap](about_Trap.md), [about_Break](about_Break.md), [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
Try         | [about_Try_Catch_Finally](about_Try_Catch_Finally.md)
Until       | [about_Do](about_Do.md)
Var         | Reserved for future use
While       | [about_While](about_While.md), [about_Do](about_Do.md)


Language Keywords

### Begin

Specifies one part of the body of a function, along with the DynamicParam,
Process, and End keywords. The Begin statement list runs one time before any
objects are received from the pipeline.

Syntax:

```powershell
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

```powershell
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

```powershell
try {<statement list>}
catch [[<error type>]] {<statement list>}
```

### Continue

Causes a script to stop running a loop and to go back to the condition. If the
condition is met, the script begins the loop again.

Syntax:

```powershell
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
also include If statements and some limited commands.

Syntax:

```powershell
data <variable> [-supportedCommand <cmdlet-name>] {<permitted content>}
```

### Do

Used with the While or Until keyword as a looping construct. Windows
PowerShell runs the statement list at least one time, unlike a loop that uses
While.

Syntax for _While_:

```powershell
do {<statement list>} while (<condition>)
```

Syntax for _Until_:

```powershell
do {<statement list>} until (<condition>)
```

### DynamicParam

Specifies one part of the body of a function, along with the Begin, Process,
and End keywords. Dynamic parameters are added at run time.

Syntax:

```powershell
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

### Else

Used with the If keyword to specify the default statement list.

Syntax:

```powershell
if (<condition>) {<statement list>}
else {<statement list>}
```

### Elseif

Used with the If and Else keywords to specify additional conditionals. The
Else keyword is optional.

Syntax:

```powershell
if (<condition>) {<statement list>}
elseif (<condition>) {<statement list>}
else {<statement list>}
```

### End

Specifies one part of the body of a function, along with the DynamicParam,
Begin, and End keywords. The End statement list runs one time after all the
objects have been received from the pipeline.

Syntax:

```powershell
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

### Exit

Causes PowerShell to exit a script or a PowerShell instance.

When you run `powershell.exe -File <path to a script>`, you can only set the
%ERRORLEVEL% variable to a value other than zero by using the exit statement.
In the following example, the user sets the error level variable value to 4 by
adding 'exit 4' to the script file _test.ps1_.

```powershell
C:\Users\bruce\documents\test>type test.ps1
1

2

3

exit 4

C:\Users\bruce\documents\test>powershell -file ./test.ps1
1

2

3

C:\Users\bruce\documents\test>echo %ERRORLEVEL%
4
```

When you use powershell.exe with the File parameter, the .ps1 (script) file
itself should include instructions for handling any errors or exceptions that
occur while the script is running. You should only use the exit statement to
indicate the post-execution status of the script.

Syntax:

```powershell
exit
exit <exitcode>
```

### Filter

Specifies a function in which the statement list runs one time for each input
object. It has the same effect as a function that contains only a Process
block.

Syntax:

```powershell
filter <name> {<statement list>}
```

### Finally

Defines a statement list that runs after statements that are associated with
Try and Catch. A Finally statement list runs even if you press CTRL+C to leave
a script or if you use the Exit keyword in the script.

Syntax:

```powershell
try {<statement list>}
catch [<error type] {<statement list>}
finally {<statement list>}
```

### For

Defines a loop by using a condition.

Syntax:

```powershell
for (<initialize>; <condition>; <iterate>) { <statement list> }
```

### ForEach

Defines a loop by using each member of a collection.

Syntax:

```powershell
ForEach (<item> in <collection>) { <statement list> }
```

### From

Reserved for future use.

### Function

Creates a named statement list of reusable code. You can name the scope a
function belongs to. And, you can specify one or more named parameters by
using the Param keyword. Within the function statement list, you can include
DynamicParam, Begin, Process, and End statement lists.

Syntax:

```powershell
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

```powershell
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

```powershell
if (<condition>) {<statement list>}
```

### In

Used in a ForEach statement to create a loop that uses each member of a
collection.

Syntax:

```powershell
ForEach (<item> in <collection>){<statement list>}
```

### InlineScript

Runs workflow commands in a shared PowerShell session. This keyword is valid
only in a PowerShell Workflow.

Syntax:

```powershell
workflow <verb>-<noun>
{
   InlineScript
   {
      <Command/Expression>
      ...

   }
}
```

The InlineScript keyword indicates an InlineScript activity, which runs
commands in a shared standard (non-workflow) session. You can use the
InlineScript keyword to run commands that are not otherwise valid in a
workflow, and to run commands that share data. By default, the commands in an
InlineScript script block run in a separate process.

For more information, see about_InlineScript and
[Running PowerShell Commands in a Workflow](http://technet.microsoft.com/library/jj574197.aspx).

### Param

Defines the parameters in a function.

Syntax:

```powershell
function [<scope:>]<name> {
   param ([type]<$pname1>[, [[type]<$pname2>]])
   <statement list>
}
```

### Process

Specifies a part of the body of a function, along with the DynamicParam,
Begin, and End keywords. When a Process statement list receives input from the
pipeline, the Process statement list runs one time for each element from the
pipeline. If the pipeline provides no objects, the Process statement list does
not run. If the command is the first command in the pipeline, the Process
statement list runs one time.

Syntax:

```powershell
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

```powershell
return [<expression>]
```

### Switch

To check multiple conditions, use a Switch statement. The Switch statement is
equivalent to a series of If statements, but it is simpler.

The Switch statement lists each condition and an optional action. If a
condition obtains, the action is performed.

Syntax 1:

```powershell
switch [-regex|-wildcard|-exact][-casesensitive] ( <value> )
{
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   ...

   default {<statement list>}
}
```

Syntax 2:

```powershell
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

```powershell
throw [<object>]
```

### Trap

Defines a statement list to be run if an error is encountered. An error type
requires brackets. The second pair of brackets indicates that the error type
is optional.

Syntax:

```powershell
trap [[<error type>]] {<statement list>}
```

### Try

Defines a statement list to be checked for errors while the statements run. If
an error occurs, PowerShell continues running in a Catch or Finally statement.
An error type requires brackets. The second pair of brackets indicates that
the error type is optional.

Syntax:

```powershell
try {<statement list>}
catch [[<error type]] {<statement list>}
finally {<statement list>}
```

### Until

Used in a Do statement as a looping construct where the statement list is
executed at least one time.

Syntax:

```powershell
do {<statement list>} until (<condition>)
```

### While

Used in a Do statement as a looping construct where the statement list is
executed at least one time.

Syntax:

```powershell
do {<statement list>} while (<condition>)
```

# SEE ALSO

- [about_Escape_Characters](about_Escape_Characters.md)
- [about_Special_Characters](about_Special_Characters.md)
- [about_Wildcards](about_Wildcards.md)
