---
description:  Describes variables that store state information for PowerShell. These variables are created and maintained by PowerShell. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 08/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Automatic_Variables
---

# About Automatic Variables

## Short description

Describes variables that store state information for PowerShell. These
variables are created and maintained by PowerShell.

## Long description

Conceptually, these variables are considered to be read-only. Even though they
**can** be written to, for backward compatibility they **should not** be
written to.

Here is a list of the automatic variables in PowerShell:

### $$

Contains the last token in the last line received by the session.

### $?

Contains the execution status of the last command. It contains **True** if
the last command succeeded and **False** if it failed.

For cmdlets and advanced functions that are run at multiple stages in a
pipeline, for example in both `process` and `end` blocks, calling
`this.WriteError()` or `$PSCmdlet.WriteError()` respectively at any point will
set `$?` to **False**, as will `this.ThrowTerminatingError()` and
`$PSCmdlet.ThrowTerminatingError()`.

The `Write-Error` cmdlet always sets `$?` to **False** immediately after it is
executed, but will not set `$?` to **False** for a function calling it:

```powershell
function Test-WriteError
{
    Write-Error "Bad"
    $? # $false
}

Test-WriteError
$? # $true
```

For the latter purpose, `$PSCmdlet.WriteError()` should be used instead.

For native commands (executables), `$?` is set to **True** when `$LASTEXITCODE`
is 0, and set to **False** when `$LASTEXITCODE` is any other value.

> [!NOTE]
> Until PowerShell 7, containing a statement within parentheses `(...)`,
> subexpression syntax `$(...)` or array expression `@(...)` always reset
> `$?` to **True**, so that `(Write-Error)` shows `$?` as **True**.
> This has been changed in PowerShell 7, so that `$?` will always reflect
> the actual success of the last command run in these expressions.

### $^

Contains the first token in the last line received by the session.

### $_

Same as `$PSItem`. Contains the current object in the pipeline object. You
can use this variable in commands that perform an action on every object or
on selected objects in a pipeline.

### $args

Contains an array of values for undeclared parameters that are passed to a
function, script, or script block. When you create a function, you can declare
the parameters by using the `param` keyword or by adding a comma-separated list
of parameters in parentheses after the function name.

In an event action, the `$Args` variable contains objects that represent the
event arguments of the event that is being processed. This variable is
populated only within the `Action` block of an event registration command.
The value of this variable can also be found in the **SourceArgs** property of
the **PSEventArgs** object that `Get-Event` returns.

### $ConsoleFileName

Contains the path of the console file (`.psc1`) that was most recently used
in the session. This variable is populated when you start PowerShell with
the **PSConsoleFile** parameter or when you use the `Export-Console` cmdlet to
export snap-in names to a console file.

When you use the `Export-Console` cmdlet without parameters, it automatically
updates the console file that was most recently used in the session. You
can use this automatic variable to determine which file will be updated.

### $Error

Contains an array of error objects that represent the most recent errors.
The most recent error is the first error object in the array `$Error[0]`.

To prevent an error from being added to the `$Error` array, use the
**ErrorAction** common parameter with a value of **Ignore**. For more
information, see [about_CommonParameters](about_CommonParameters.md).

### $Event

Contains a **PSEventArgs** object that represents the event that is being
processed. This variable is populated only within the `Action` block of an
event registration command, such as `Register-ObjectEvent`. The value of this
variable is the same object that the `Get-Event` cmdlet returns. Therefore,
you can use the properties of the `Event` variable, such as
`$Event.TimeGenerated`, in an `Action` script block.

### $EventArgs

Contains an object that represents the first event argument that derives
from **EventArgs** of the event that is being processed. This variable is
populated only within the `Action` block of an event registration command.
The value of this variable can also be found in the **SourceEventArgs**
property of the **PSEventArgs** object that `Get-Event` returns.

### $EventSubscriber

Contains a **PSEventSubscriber** object that represents the event subscriber of
the event that is being processed. This variable is populated only within
the `Action` block of an event registration command. The value of this
variable is the same object that the `Get-EventSubscriber` cmdlet returns.

### $ExecutionContext

Contains an **EngineIntrinsics** object that represents the execution context
of the PowerShell host. You can use this variable to find the execution
objects that are available to cmdlets.

### $false

Contains **False**. You can use this variable to represent **False** in
commands and scripts instead of using the string "false". The string can be
interpreted as **True** if it's converted to a non-empty string or to a
non-zero integer.

### $foreach

Contains the enumerator (not the resulting values) of a
[ForEach](about_ForEach.md) loop. The `$ForEach` variable exists only while
the `ForEach` loop is running; it's deleted after the loop is completed.

Enumerators contain properties and methods you can use to retrieve loop values
and change the current loop iteration. For more information, see
[Using Enumerators](#using-enumerators).

### $HOME

Contains the full path of the user's home directory. This variable is the
equivalent of the `"$env:homedrive$env:homepath"` Windows environment variables,
typically `C:\Users\<UserName>`.

### $Host

Contains an object that represents the current host application for
PowerShell. You can use this variable to represent the current host in
commands or to display or change the properties of the host, such as
`$Host.version` or `$Host.CurrentCulture`, or
`$host.ui.rawui.setbackgroundcolor("Red")`.

### $input

Contains an enumerator that enumerates all input that is passed to a
function. The `$input` variable is available only to functions and script
blocks (which are unnamed functions).

- In a function without a `Begin`, `Process`, or `End` block, the `$input`
  variable enumerates the collection of all input to the function.

- In the `Begin` block, the `$input` variable contains no data.

- In the `Process` block, the `$input` variable contains the
  object that is currently in the pipeline.

- In the `End` block, the `$input` variable enumerates the collection of all
  input to the function.

  > [!NOTE]
  > You cannot use the `$input` variable inside both the Process block and the
  > End block in the same function or script block.

Since `$input` is an enumerator, accessing any of it's properties causes
`$input` to no longer be available. You can store `$input` in another variable to
reuse the `$input` properties.

Enumerators contain properties and methods you can use to retrieve loop values
and change the current loop iteration. For more information, see
[Using Enumerators](#using-enumerators).

### $IsCoreCLR

Contains `$True` if the current session is running on the .NET Core Runtime
(CoreCLR). Otherwise contains `$False`.

### $IsLinux

Contains `$True` if the current session is running on a Linux operating system.
Otherwise contains `$False`.

### $IsMacOS

Contains `$True` if the current session is running on a MacOS operating system.
Otherwise contains `$False`.

### $IsWindows

Contains `$TRUE` if the current session is running on a Windows operating
system. Otherwise contains `$FALSE`.

### $LastExitCode

Contains the exit code of the last Windows-based program that was run.

### $Matches

The `Matches` variable works with the `-match` and `-notmatch` operators.
When you submit scalar input to the `-match` or `-notmatch` operator, and
either one detects a match, they return a Boolean value and populate the
`$Matches` automatic variable with a hash table of any string values that
were matched. The `$Matches` hash table can also be populated with captures
when you use regular expressions with the `-match` operator.

For more information about the `-match` operator, see
[about_Comparison_Operators](about_comparison_operators.md). For more
information on regular expressions, see [about_Regular_Expressions](about_Regular_Expressions.md).

### $MyInvocation

Contains information about the current command, such as the name, parameters,
parameter values, and information about how the command was started, called, or
invoked, such as the name of the script that called the current command.

`$MyInvocation` is populated only for scripts, function, and script blocks. You
can use the information in the **System.Management.Automation.InvocationInfo**
object that `$MyInvocation` returns in the current script, such as the path and
file name of the script (`$MyInvocation.MyCommand.Path`) or the name of a
function (`$MyInvocation.MyCommand.Name`) to identify the current command. This
is particularly useful for finding the name of the current script.

Beginning in PowerShell 3.0, `MyInvocation` has the following new
properties.

| Property      | Description                                         |
| ------------- | --------------------------------------------------- |
| **PSScriptRoot**  | Contains the full path to the script that invoked   |
|               | the current command. The value of this property is  |
|               | populated only when the caller is a script.         |
| **PSCommandPath** | Contains the full path and file name of the script  |
|               | that invoked the current command. The value of this |
|               | property is populated only when the caller is a     |
|               | script.                                             |

Unlike the `$PSScriptRoot` and `$PSCommandPath` automatic variables, the
**PSScriptRoot** and **PSCommandPath** properties of the `$MyInvocation`
automatic variable contain information about the invoker or calling script,
not the current script.

### $NestedPromptLevel

Contains the current prompt level. A value of 0 indicates the original
prompt level. The value is incremented when you enter a nested level and
decremented when you exit it.

For example, PowerShell presents a nested command prompt when you use the
`$Host.EnterNestedPrompt` method. PowerShell also presents a nested command
prompt when you reach a breakpoint in the PowerShell debugger.

When you enter a nested prompt, PowerShell pauses the current command,
saves the execution context, and increments the value of the
`$NestedPromptLevel` variable. To create additional nested command prompts
(up to 128 levels) or to return to the original command prompt, complete
the command, or type `exit`.

The `$NestedPromptLevel` variable helps you track the prompt level. You can
create an alternative PowerShell command prompt that includes this value so
that it's always visible.

### $null

`$null` is an automatic variable that contains a **null** or empty value. You
can use this variable to represent an absent or undefined value in commands and
scripts.

PowerShell treats `$null` as an object with a value, that is, as an explicit
placeholder, so you can use `$null` to represent an empty value in a series
of values.

For example, when `$null` is included in a collection, it's counted as one
of the objects.

```powershell
$a = "one", $null, "three"
$a.count
```

```Output
3
```

If you pipe the `$null` variable to the `ForEach-Object` cmdlet, it generates a
value for `$null`, just as it does for the other objects

```powershell
"one", $null, "three" | ForEach-Object { "Hello " + $_}
```

```Output
Hello one
Hello
Hello three
```

As a result, you can't use `$null` to mean **no parameter value**. A parameter
value of `$null` overrides the default parameter value.

However, because PowerShell treats the `$null` variable as a placeholder, you
can use it in scripts like the following one, which wouldn't work if `$null`
were ignored.

```powershell
$calendar = @($null, $null, "Meeting", $null, $null, "Team Lunch", $null)
$days = "Sunday","Monday","Tuesday","Wednesday","Thursday",
        "Friday","Saturday"
$currentDay = 0
foreach($day in $calendar)
{
    if($day -ne $null)
    {
        "Appointment on $($days[$currentDay]): $day"
    }

    $currentDay++
}
```

```Output
Appointment on Tuesday: Meeting
Appointment on Friday: Team lunch
```

### $PID

Contains the process identifier (PID) of the process that is hosting the
current PowerShell session.

### $PROFILE

Contains the full path of the PowerShell profile for the current user and
the current host application. You can use this variable to represent the
profile in commands. For example, you can use it in a command to determine
whether a profile has been created:

```powershell
Test-Path $PROFILE
```

Or, you can use it in a command to create a profile:

```powershell
New-Item -ItemType file -Path $PROFILE -Force
```

You can use it in a command to open the profile in **notepad.exe**:

```powershell
notepad.exe $PROFILE
```

### $PSBoundParameters

Contains a dictionary of the parameters that are passed to a script or
function and their current values. This variable has a value only in a
scope where parameters are declared, such as a script or function. You can
use it to display or change the current values of parameters or to pass
parameter values to another script or function.

In this example, the **Test2** function passes the `$PSBoundParameters` to the
**Test1** function. The `$PSBoundParameters` are displayed in the format of
**Key** and **Value**.

```powershell
function Test1 {
   param($a, $b)

   # Display the parameters in dictionary format.
   $PSBoundParameters
}

function Test2 {
   param($a, $b)

   # Run the Test1 function with $a and $b.
   Test1 @PSBoundParameters
}
```

```powershell
Test2 -a Power -b Shell
```

```Output
Key   Value
---   -----
a     Power
b     Shell
```

### $PSCmdlet

Contains an object that represents the cmdlet or advanced function that's
being run.

You can use the properties and methods of the object in your cmdlet or
function code to respond to the conditions of use. For example, the
**ParameterSetName** property contains the name of the parameter set that's
being used, and the **ShouldProcess** method adds the **WhatIf** and
**Confirm** parameters to the cmdlet dynamically.

For more information about the `$PSCmdlet` automatic variable, see
[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md)
and [about_Functions_Advanced](about_Functions_Advanced.md).

### $PSCommandPath

Contains the full path and file name of the script that's being run. This
variable is valid in all scripts.

### $PSCulture

Beginning in PowerShell 7, `$PSCulture` reflects the culture of the current
PowerShell runspace (session). If the culture is changed in a PowerShell
runspace, the `$PSCulture` value for that runspace is updated.

The culture determines the display format of items such as numbers, currency,
and dates, and is stored in a **System.Globalization.CultureInfo** object. Use
`Get-Culture` to display the computer's culture. `$PSCulture` contains the
**Name** property's value.

### $PSDebugContext

While debugging, this variable contains information about the debugging
environment. Otherwise, it contains a **null** value. As a result, you can use
it to indicate whether the debugger has control. When populated, it contains a
**PsDebugContext** object that has **Breakpoints** and **InvocationInfo**
properties. The **InvocationInfo** property has several useful properties,
including the **Location** property. The **Location** property indicates the
path of the script that is being debugged.

### $PSHOME

Contains the full path of the installation directory for PowerShell,
typically, `$env:windir\System32\PowerShell\v1.0` in Windows systems. You can
use this variable in the paths of PowerShell files. For example, the
following command searches the conceptual Help topics for the word
**variable**:

```powershell
Select-String -Pattern Variable -Path $pshome\*.txt
```

### $PSItem

Same as `$_`. Contains the current object in the pipeline object. You can use
this variable in commands that perform an action on every object or on
selected objects in a pipeline.

### $PSScriptRoot

Contains the directory from which a script is being run.

In PowerShell 2.0, this variable is valid only in script modules (`.psm1`).
Beginning in PowerShell 3.0, it's valid in all scripts.

### $PSSenderInfo

Contains information about the user who started the PSSession, including
the user identity and the time zone of the originating computer. This
variable is available only in PSSessions.

The `$PSSenderInfo` variable includes a user-configurable property,
**ApplicationArguments**, that by default, contains only the `$PSVersionTable`
from the originating session. To add data to the **ApplicationArguments**
property, use the **ApplicationArguments** parameter of the
`New-PSSessionOption` cmdlet.

### $PSUICulture

Contains the name of the user interface (UI) culture that's currently in use
in the operating system. The UI culture determines which text strings are used
for user interface elements, such as menus and messages. This is the value of
the **System.Globalization.CultureInfo.CurrentUICulture.Name** property of the
system. To get the **System.Globalization.CultureInfo** object for the system,
use the `Get-UICulture` cmdlet.

### $PSVersionTable

Contains a read-only hash table that displays details about the version of
PowerShell that is running in the current session. The table includes the
following items:

| Property                  | Description                                   |
| ------------------------- | --------------------------------------------- |
| **PSVersion**             | The PowerShell version number                 |
| **PSEdition**             | This property has the value of 'Desktop' for  |
|                           | PowerShell 4 and below as well as PowerShell  |
|                           | 5.1 on full-featured Windows editions.        |
|                           | This property has the value of 'Core' for     |
|                           | PowerShell 6 and above as well as PowerShell  |
|                           | PowerShell 5.1 on reduced-footprint editions  |
|                           | like Windows Nano Server or Windows IoT.      |
| **GitCommitId**           | The commit Id of the source files, in GitHub, |
| **OS**                    | Description of the operating system that      |
|                           | PowerShell is running on.                     |
| **Platform**              | Platform that the operating system is running |
|                           | on. The value on Linux and macOS is **Unix**. |
|                           | See `$IsMacOs` and `$IsLinux`.                |
| **PSCompatibleVersions**  | Versions of PowerShell that are compatible    |
|                           | with the current version                      |
| **PSRemotingProtocolVersion** | The version of the PowerShell remote      |
|                           | management protocol.                          |
| **SerializationVersion**  | The version of the serialization method       |
| **WSManStackVersion**     | The version number of the WS-Management stack |

### $PWD

Contains a path object that represents the full path of the current directory.

### $Sender

Contains the object that generated this event. This variable is populated
only within the Action block of an event registration command. The value of
this variable can also be found in the Sender property of the **PSEventArgs**
object that `Get-Event` returns.

### $ShellId

Contains the identifier of the current shell.

### $StackTrace

Contains a stack trace for the most recent error.

### $switch

Contains the enumerator not the resulting values of a `Switch` statement. The
`$switch` variable exists only while the `Switch` statement is running; it's
deleted when the `switch` statement completes execution. For more information,
see [about_Switch](about_Switch.md).

Enumerators contain properties and methods you can use to retrieve loop values
and change the current loop iteration. For more information, see
[Using Enumerators](#using-enumerators).

### $this

In a script block that defines a script property or script method, the
`$this` variable refers to the object that is being extended.

In a custom class, the `$this` variable refers to the class object itself
allowing access to properties and methods defined in the class.

### $true

Contains **True**. You can use this variable to represent **True** in commands
and scripts.

## Using Enumerators

The `$input`, `$foreach`, and `$switch` variables are all enumerators used
to iterate through the values processed by their containing code block.

An enumerator contains properties and methods you can use to advance or reset
iteration, or retrieve iteration values. Directly manipulating enumerators
isn't considered best practice.

- Within loops, flow control keywords [break](about_Break.md) and [continue](about_Continue.md)
  should be preferred.
- Within functions that accept pipeline input, it's best practice to use
  Parameters with the **ValueFromPipeline** or
  **ValueFromPipelineByPropertyName** attributes.

  For more information, see [about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md).

### MoveNext

The [MoveNext](/dotnet/api/system.collections.ienumerator.movenext) method
advances the enumerator to the next element of the collection. **MoveNext**
returns **True** if the enumerator was successfully advanced, **False** if
the enumerator has passed the end of the collection.

> [!NOTE]
> The **Boolean** value returned my **MoveNext** is sent to the output stream.
> You can suppress the output by typecasting it to `[void]` or piping it to
> [Out-Null](xref:Microsoft.PowerShell.Core.Out-Null).
>
> ```powershell
> $input.MoveNext() | Out-Null
> ```
>
> ```powershell
> [void]$input.MoveNext()
> ```

### Reset

The [Reset](/dotnet/api/system.collections.ienumerator.reset) method sets
the enumerator to its initial position, which is **before** the first element
in the collection.

### Current

The [Current](/dotnet/api/system.collections.ienumerator.current) property
gets the element in the collection, or pipeline, at the current position of
the enumerator.

The **Current** property continues to return the same property until
**MoveNext** is called.

## Examples

### Example 1: Using the $input variable

In the following example, accessing the `$input` variable clears the variable
until the next time the process block executes. Using the **Reset** method
resets the `$input` variable to the current pipeline value.

```powershell
function Test
{
    begin
    {
        $i = 0
    }

    process
    {
        "Iteration: $i"
        $i++
        "`tInput: $input"
        "`tAccess Again: $input"
        $input.Reset()
        "`tAfter Reset: $input"
    }
}

"one","two" | Test
```

```Output
Iteration: 0
    Input: one
    Access Again:
    After Reset: one
Iteration: 1
    Input: two
    Access Again:
    After Reset: two
```

The process block automatically advances the `$input` variable even if you
don't access it.

```powershell
$skip = $true
function Skip
{
    begin
    {
        $i = 0
    }

    process
    {
        "Iteration: $i"
        $i++
        if ($skip)
        {
            "`tSkipping"
            $skip = $false
        }
        else
        {
            "`tInput: $input"
        }
    }
}

"one","two" | Skip
```

```Output
Iteration: 0
    Skipping
Iteration: 1
    Input: two
```

### Example 2: Using $input outside the process block

Outside of the process block the `$input` variable represents all the values
piped into the function.

- Accessing the `$input` variable clears all values.
- The **Reset** method resets the entire collection.
- The **Current** property is never populated.
- The **MoveNext** method returns false because the collection can't be
  advanced.
  - Calling **MoveNext** clears out the `$input` variable.

```powershell
Function All
{
    "All Values: $input"
    "Access Again: $input"
    $input.Reset()
    "After Reset: $input"
    $input.MoveNext() | Out-Null
    "After MoveNext: $input"
}

"one","two","three" | All
```

```Output
All Values: one two three
Access Again:
After Reset: one two three
After MoveNext:
```

### Example 3: Using the $input.Current property

By using the **Current** property, the current pipeline value can be accessed
multiple times without using the **Reset** method. The process block doesn't
automatically call the **MoveNext** method.

The **Current** property will never be populated unless you explicitly call
**MoveNext**. The **Current** property can be accessed multiple times inside
the process block without clearing its value.

```powershell
function Current
{
    begin
    {
        $i = 0
    }

    process
    {
        "Iteration: $i"
        $i++
        "`tBefore MoveNext: $($input.Current)"
        $input.MoveNext() | Out-Null
        "`tAfter MoveNext: $($input.Current)"
        "`tAccess Again: $($input.Current)"
    }
}

"one","two" | Current
```

```Output
Iteration: 0
    Before MoveNext:
    After MoveNext: one
    Access Again: one
Iteration: 1
    Before MoveNext:
    After MoveNext: two
    Access Again: two
```

### Example 4: Using the $foreach variable

Unlike the `$input` variable, the `$foreach` variable always represents all
items in the collection when accessed directly. Use the **Current** property
to access the current collection element, and the **Reset** and **MoveNext**
methods to change its value.

> [!NOTE]
> Each iteration of the `foreach` loop will automatically call the **MoveNext**
> method.

The following loop only executes twice. In the second iteration, the collection
is moved to the third element before the iteration is complete. After the second
iteration, there are now no more values to iterate, and the loop terminates.

The **MoveNext** property doesn't affect the variable chosen to iterate through
the collection (`$Num`).

```powershell
$i = 0
foreach ($num in ("one","two","three"))
{
    "Iteration: $i"
    $i++
    "`tNum: $num"
    "`tCurrent: $($foreach.Current)"

    if ($foreach.Current -eq "two")
    {
        "Before MoveNext (Current): $($foreach.Current)"
        $foreach.MoveNext() | Out-Null
        "After MoveNext (Current): $($foreach.Current)"
        "Num has not changed: $num"
    }
}
```

```Output
Iteration: 0
        Num: one
        Current: one
Iteration: 1
        Num: two
        Current: two
Before MoveNext (Current): two
After MoveNext (Current): three
Num has not changed: two
```

Using the **Reset** method resets the current element in the collection. The
following example loops through the first two elements **twice** because the
**Reset** method is called. After the first two loops, the `if` statement
fails and the loop iterates through all three elements normally.

> [!IMPORTANT]
> This could result in an infinite loop.

```powershell
$stopLoop = 0
foreach ($num in ("one","two", "three"))
{
    ("`t" * $stopLoop) + "Current: $($foreach.Current)"

    if ($num -eq "two" -and $stopLoop -lt 2)
    {
        $foreach.Reset() | Out-Null
        ("`t" * $stopLoop) + "Reset Loop: $stopLoop"
        $stopLoop++
    }
}
```

```Output
Current: one
Current: two
Reset Loop: 0
        Current: one
        Current: two
        Reset Loop: 1
                Current: one
                Current: two
                Current: three
```

### Example 5: Using the $switch variable

The `$switch` variable has the exact same rules as the `$foreach` variable.
The following example demonstrates all the enumerator concepts.

> [!NOTE]
> Note how the **NotEvaluated** case is never executed, even though there's
> no `break` statement after the **MoveNext** method.

```powershell
$values = "Start", "MoveNext", "NotEvaluated", "Reset", "End"
$stopInfinite = $false
switch ($values)
{
    "MoveNext" {
        "`tMoveNext"
        $switch.MoveNext() | Out-Null
        "`tAfter MoveNext: $($switch.Current)"
    }
    # This case is never evaluated.
    "NotEvaluated" {
        "`tAfterMoveNext: $($switch.Current)"
    }

    "Reset" {
        if (!$stopInfinite)
        {
            "`tReset"
            $switch.Reset()
            $stopInfinite = $true
        }
    }

    default {
        "Default (Current): $($switch.Current)"
    }
}
```

```Output
Default (Current): Start
    MoveNext
    After MoveNext: NotEvaluated
    Reset
Default (Current): Start
    MoveNext
    After MoveNext: NotEvaluated
Default (Current): End
```

## See also

[about_Functions](about_Functions.md)

[about_Functions_Advanced](about_Functions_Advanced.md)

[about_Functions_Advanced_Methods](about_Functions_Advanced_Methods.md)

[about_Functions_Advanced_Parameters](about_Functions_Advanced_Parameters.md)

[about_Functions_OutputTypeAttribute](about_Functions_OutputTypeAttribute.md)

[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md)

[about_Hash_Tables](about_Hash_Tables.md)

[about_Preference_Variables](about_Preference_Variables.md)

[about_Splatting](about_Splatting.md)

[about_Variables](about_Variables.md)
