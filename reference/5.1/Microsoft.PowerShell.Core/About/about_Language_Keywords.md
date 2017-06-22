---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Language_Keywords
---

# About Language Keywords
## about_Language_Keywords



# SHORT DESCRIPTION

Describes the keywords in the Windows PowerShell scripting language.

# LONG DESCRIPTION

Windows PowerShell has the following language keywords. For more
information, see the about topic for the keyword and the information that
follows the table.

Keyword     |       Reference
-------     |       ---------
Begin       | about\_Functions, about\_Functions\_Advanced
Break       | about\_Break, about\_Trap
Catch       | about\_Try\_Catch\_Finally
Class       | about\_Classes
Continue    | about\_Continue, about\_Trap
Data        | about\_Data\_Sections
Do          | about\_Do, about\_While
DynamicParam| about\_Functions\_Advanced\_Parameters
Else        | about\_If
Elseif      | about\_If
End         | about\_Functions, about\_Functions\_Advanced\_Methods
Enum        | about\_Enums
Exit        | Described in this topic.
Filter      | about\_Functions
Finally     | about\_Try\_Catch\_Finally
For         | about\_For
ForEach     | about\_ForEach
From        | Reserved for future use.
Function    | about\_Functions, about\_Functions\_Advanced
If          | about\_If
In          | about\_ForEach
InlineScript| about\_InlineScript
Hidden      | about\_Hidden
Parallel    | about\_Parallel, about\_ForEach-Parallel
Param       | about\_Functions
Process     | about\_Functions, about\_Functions\_Advanced
Return      | about\_Return
Sequence    | about\_Sequence
Static      | about\_Classes
Switch      | about\_Switch
Throw       | about\_Throw, about\_Functions\_Advanced\_Methods
Trap        | about\_Trap, about\_Break, about\_Try\_Catch\_Finally
Try         | about\_Try\_Catch\_Finally
Until       | about\_Do
Using       | about\_Using, about\_Classes
While       | about\_While, about\_Do
Workflow    | about\_Workflows

Language Keywords

**Begin**
-----

Specifies one part of the body of a function, along with the
DynamicParam, Process, and End keywords. The Begin statement list runs
one time before any objects are received from the pipeline.

Syntax:
```
function <name> {
DynamicParam {<statement list>}
begin {<statement list>}
process {<statement list>}
end {<statement list>}
}
```

**Break**
-----

Causes a script to exit a loop.

Syntax:
```
while (<condition>) {
   <statements>
   ...

   break
   ...

   <statements>
}
```

**Catch**
-----

Specifies a statement list to run if an error occurs in the
accompanying Try statement list. An error type requires brackets. The
second pair of brackets indicates that the error type is optional.

Syntax:
```
try {<statement list>}
catch [[<error type>]] {<statement list>}
```

**Class**
-----

Specifies a new class in PowerShell.

Syntax:
```
class <class-name> {
    [[hidden] [static] <property-definition> ...]
    [<class-name>([argument-list>]) {<constructor-statement-list>} ...]
    [[hidden] [static] <method-definition> ...]
}
```

**Continue**
--------

Causes a script to stop running a loop and to go back to the condition.
If the condition is met, the script begins the loop again.

Syntax:
```
while (<condition>) {
   <statements>
   ...

   continue
   ...

   <statements>
}
```

**Data**
----

In a script, defines a section that isolates data from the script logic.
Can also include If statements and some limited commands.

Syntax:
```
data <variable> [-supportedCommand <cmdlet-name>] {<permitted content>}
```

**Do**
--

Used with the While or Until keyword as a looping construct. Windows
PowerShell runs the statement list at least one time, unlike a loop that
uses While.

Syntax for _While_:
```
do {<statement list>} while (<condition>)
```

Syntax for _Until_:
```
do {<statement list>} until (<condition>)
```

**DynamicParam**
------------

Specifies one part of the body of a function, along with the Begin,
Process, and End keywords. Dynamic parameters are added at run time.

Syntax:
```
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

**Else**
----

Used with the If keyword to specify the default statement list.

Syntax:
```
if (<condition>) {<statement list>}
else {<statement list>}
```

**Elseif**
------

Used with the If and Else keywords to specify additional conditionals.
The Else keyword is optional.

Syntax:
```
if (<condition>) {<statement list>}
elseif (<condition>) {<statement list>}
else {<statement list>}
```

**End**
---

Specifies one part of the body of a function, along with the
DynamicParam, Begin, and End keywords. The End statement list runs one
time after all the objects have been received from the pipeline.

Syntax:
```
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

**Enum**
----

`enum` is used to declare an enumeration;
a distinct type that consists of a set of named labels called the
enumerator list.

Syntax:
```
enum <enum-name> {
    <label> [= <int-value>]
    ...
}
```

**Exit**
----

Causes Windows PowerShell to exit a script or a Windows PowerShell
instance.

When you run 'powershell.exe -File <path to a script>', you can only
set the %ERRORLEVEL% variable to a value other than zero by using the
exit statement. In the following example, the user sets the error level
variable value to 4 by adding 'exit 4' to the script file _test.ps1_.

```
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

When you use powershell.exe with the File parameter, the .ps1 (script)
file itself should include instructions for handling any errors or
exceptions that occur while the script is running. You should only use
the exit statement to indicate the post-execution status of the script.

Syntax:
```
exit
exit <exit code>
```

**Filter**
------

Specifies a function in which the statement list runs one time for each
input object. It has the same effect as a function that contains only a
Process block.

Syntax:
```
filter <name> {<statement list>}
```

**Finally**
-------

Defines a statement list that runs after statements that are associated
with Try and Catch. A Finally statement list runs even if you press
CTRL+C to leave a script or if you use the Exit keyword in the script.

Syntax:
```
try {<statement list>}
catch [<error type] {<statement list>}
finally {<statement list>}
```

**For**
---

Defines a loop by using a condition.

Syntax:
```
for (<initialize>; <condition>; <iterate>) { <statement list> }
```

**ForEach**
-------

Defines a loop by using each member of a collection.

Syntax:
```
ForEach (<item> in <collection>) { <statement list> }
```

**From**
-----

Reserved for future use.

**Function**
--------

Creates a named statement list of reusable code. You can name the scope a
function belongs to. And, you can specify one or more named parameters by
using the Param keyword. Within the function statement list, you can
include DynamicParam, Begin, Process, and End statement lists.

Syntax:
```
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
```
function [<scope:>]<name> [([type]<$pname1>, [[type]<$pname2>])] {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

**If**
--

Defines a conditional.

Syntax:
```
if (<condition>) {<statement list>}
```

**Hidden**
------

Hides class members from the default results of the Get-Member cmdlet, and
from IntelliSense and tab completion results.

Syntax:
```
Hidden [data type] $member_name
```

**In**
--

Used in a ForEach statement to create a loop that uses each member of a
collection.

Syntax:
```
ForEach (<item> in <collection>){<statement list>}
```

**InlineScript**
------------
Runs workflow commands in a shared Windows PowerShell session.
This keyword is valid only in a Windows PowerShell Workflow.

Syntax:
```
workflow <verb>-<noun>
{
   InlineScript
   {
      <Command/Expression>
      ...

   }
}
```

The InlineScript keyword indicates an InlineScript activity,
which runs commands in a shared standard (non-workflow)
session. You can use the InlineScript keyword to run commands
that are not otherwise valid in a workflow, and to run commands
that share data. By default, the commands in an InlineScript
script block run in a separate process.

For more information, see about_InlineScript and
[Running Windows PowerShell Commands in a Workflow](http://technet.microsoft.com/library/jj574197.aspx).

**Param**
-----

Defines the parameters in a function.

Syntax:
```
function [<scope:>]<name> {
   param ([type]<$pname1>[, [[type]<$pname2>]])
   <statement list>
}
```

**Parallel**
--------
Runs workflow commands concurrently and in an undefined order.
This keyword is valid only in a Windows PowerShell Workflow.

The Parallel keyword indicates a Parallel script block. The
commands in a Parallel script block can run at the same time and
in any order. This feature significantly improves the performance
of a workflow.

Syntax:
```
workflow <verb>-<noun>
{
   Parallel
   {
      <Activity>
      <Activity>
      …

   }
}
```

The Parallel parameter of the ForEach keyword processes the
items in a collection in parallel. The activities in the script
block run sequentially on each item, but the script block can
run on multiple items at the same time and the items are
processed in an undefined order.

Syntax:
```
workflow <verb>-<noun>
{
   ForEach -Parallel (<item> in <collection>)
   {
      <Activity>
      <Activity>
      ...

   }
}
```

For more information, see: [about_Parallel](../../psworkflow/about/about_parallel.md),
[about_ForEach-Parallel](../../psworkflow/about/about_foreach-parallel.md)

**Process**
-------

Specifies a part of the body of a function, along with the DynamicParam,
Begin, and End keywords. When a Process statement list receives input
from the pipeline, the Process statement list runs one time for each
element from the pipeline. If the pipeline provides no objects, the
Process statement list does not run. If the command is the first command
in the pipeline, the Process statement list runs one time.

Syntax:
```
function <name> {
   DynamicParam {<statement list>}
   begin {<statement list>}
   process {<statement list>}
   end {<statement list>}
}
```

**Return**
------

Causes Windows PowerShell to leave the current scope, such as a script or
function, and writes the optional expression to the output.

Syntax:
```
return [<expression>]
```

**Sequence**
--------

Runs workflow commands sequentially in a Parallel script block.
This keyword is valid only in a Windows PowerShell Workflow.

Syntax:
```
workflow <verb>-<noun>
{
   Parallel
   {
      Sequence
      {
         <Activity>
      }
   }
}
```

The Sequence keyword creates a sequence block within a Parallel
script block. The commands in the Sequence script block run
sequentially and in the order defined.

For more information, see: [about_Sequence](../../psworkflow/about/about_sequence.md)

**Static**
--------

Specifies the property or method defined is common to all instances
of the class in which is defined.

See, in this topic, **Class**  for usage examples.

**Switch**
------

To check multiple conditions, use a Switch statement.
The Switch statement is equivalent to a series of If statements,
but it is simpler.

The Switch statement lists each condition and an optional action.
If a condition obtains, the action is performed.

Syntax 1:
```
switch [-regex|-wildcard|-exact][-casesensitive] ( <value> )
{
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   ...

   default {<statement list>}
}
```

Syntax 2:
```
switch [-regex|-wildcard|-exact][-casesensitive] -file <filename>
{
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   <string>|<number>|<variable>|{ <expression> } {<statement list>}
   ...

   default {<statement list>}
}
```

**Throw**
-----

Throws an object as an error.

Syntax:
```
throw [<object>]
```

**Trap**
----

Defines a statement list to be run if an error is encountered. An error
type requires brackets. The second pair of brackets indicates that the
error type is optional.

Syntax:
```
trap [[<error type>]] {<statement list>}
```

**Try**
---

Defines a statement list to be checked for errors while the statements
run. If an error occurs, Windows PowerShell continues running in a Catch
or Finally statement. An error type requires brackets. The second pair of
brackets indicates that the error type is optional.

Syntax:
```
try {<statement list>}
catch [[<error type]] {<statement list>}
finally {<statement list>}
```

**Until**
-----

Used in a Do statement as a looping construct where the statement list is
executed at least one time.

Syntax:
```
do {<statement list>} until (<condition>)
```

**Using**
-----

Allows to indicate which namespaces are used in the session.
Classes and members require less typing to mention them.
You can also include classes from modules.

Syntax #1:
```
using namespace <.Net-framework-namespace>
```

Syntax #2:
```
using module <module-name>
```


**While**
-----

Used in a Do statement as a looping construct where the statement list is
executed at least one time.

Syntax:
```
do {<statement list>} while (<condition>)
```

**Workflow**
--------
Creates a script-based Windows PowerShell workflow, that
is, a workflow written in the Windows PowerShell language.

A Windows PowerShell workflow is a Windows PowerShell command
type that is supported by Windows PowerShell and Windows Workflow
Foundation. Workflows are designed for complex, long-running tasks
that affect multiple computers. Workflows can be recovered if
interrupted, such as by a network outage, and you can suspend and
resume them  without losing state or data.

Workflows can be written in XAML, the native language of
Windows Workflow Foundation, or in the Windows PowerShell
language.

The syntax of a script-based workflow is similar to the syntax
of a function. However, the unit of execution in a workflow is an
activity, instead of a command. Cmdlets (and other commands) that
are used in script-based workflows are implicitly converted to
activities.

Some language elements that are permitted in scripts and functions
are not permitted in workflows. Similarly, workflows can include
elements that are not found in scripts and functions, such as
"persistence points" (checkpoints), self-suspension, and parallel
processing. In addition, all workflows have a set of common
parameters that are added by Windows PowerShell when you use the
Workflow keyword.

Syntax:
```
workflow <verb-noun>
{
   param
   (
        [type]<$pname1>
        [, [type]<$pname2>]
    )
   <statement list>
}

workflow <verb-noun>
{
   [CmdletBinding(<Attributes>)]
   Param
   (
      [Parameter(<Arguments>)] $Param1
      ...
   )

   <statement list>
}
```

For more information about workflows, see [about_Workflows](../../psworkflow/about/about_workflows.md)
and "Getting Started with Windows PowerShell Workflow"
(http://go.microsoft.com/fwlink/?LinkID=252592) in the
TechNet Library.

# SEE ALSO

-  [about_Escape_Characters](about_Escape_Characters.md)

-  [about_Special_Characters](about_Special_Characters.md)

-  [about_Wildcards](about_Wildcards.md)

