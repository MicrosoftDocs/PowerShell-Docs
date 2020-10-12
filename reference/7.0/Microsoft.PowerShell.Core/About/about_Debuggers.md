---
description: Describes the PowerShell debugger. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 08/06/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_debuggers?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Debuggers
---
# About Debuggers

## SHORT DESCRIPTION
Describes the PowerShell debugger.

## LONG DESCRIPTION

Debugging is the process of examining a script while it is running to identify
and correct errors in the script instructions. The PowerShell debugger can help
you examine and identify errors and inefficiencies in your scripts, functions,
commands, PowerShell Desired State Configuration (DSC) configurations, or
expressions.

Starting in PowerShell 5.0, the PowerShell debugger has been updated to debug
scripts, functions, commands, configurations, or expressions that are running
in either the console or Windows PowerShell ISE on remote computers. You can
run `Enter-PSSession` to start an interactive remote PowerShell session in
which you can set breakpoints and debug script files and commands on the remote
computer. `Enter-PSSession` functionality has been updated to let you reconnect
to and enter a disconnected session that is running a script or command on a
remote computer. If the running script hits a breakpoint, your client session
automatically starts the debugger. If the disconnected session that is running
a script has already hit a breakpoint, and is stopped at the breakpoint,
`Enter-PSSession` automatically starts the command-line debugger, after you
reconnect to the session.

You can use the features of the PowerShell debugger to examine a PowerShell
script, function, command, or expression while it is running. The PowerShell
debugger includes a set of cmdlets that let you set breakpoints, manage
breakpoints, and view the call stack.

## Debugger Cmdlets

The PowerShell debugger includes the following set of cmdlets:

- `Set-PSBreakpoint`: Sets breakpoints on lines, variables, and commands.
- `Get-PSBreakpoint`: Gets breakpoints in the current session.
- `Disable-PSBreakpoint`: Turns off breakpoints in the current session.
- `Enable-PSBreakpoint`: Re-enables breakpoints in the current session.
- `Remove-PSBreakpoint`: Deletes breakpoints from the current session.
- `Get-PSCallStack`: Displays the current call stack.

## Starting and Stopping the Debugger

To start the debugger, set one or more breakpoints. Then, run the script,
command, or function that you want to debug.

When you reach a breakpoint, execution stops, and control is turned over to the
debugger.

To stop the debugger, run the script, command, or function until it is
complete. Or, type `stop` or `t`.

### Debugger Commands

When you use the debugger in the PowerShell console, use the following commands
to control the execution. In Windows PowerShell ISE, use commands on the Debug
menu.

Note: For information about how to use the debugger in other host applications,
see the host application documentation.

- `s`, `StepInto`: Executes the next statement and then stops.

- `v`, `StepOver`: Executes the next statement, but skips functions and
  invocations. The skipped statements are executed, but not stepped through.

- `Ctrl+Break`: (Break All in ISE) Breaks into a running script within either
  the PowerShell console, or Windows PowerShell ISE. Note that
  <kbd>Ctrl</kbd>+<kbd>Break</kbd> in Windows PowerShell 2.0, 3.0, and 4.0
  closes the program. Break All works on both local and remote
  interactively-running scripts.

- `o`, `StepOut`: Steps out of the current function; up one level if nested. If
  in the main body, it continues to the end or the next breakpoint. The skipped
  statements are executed, but not stepped through.

- `c`, `Continue`: Continues to run until the script is complete or until the
  next breakpoint is reached. The skipped statements are executed, but not
  stepped through.

- `l`, `List`: Displays the part of the script that is executing. By default,
  it displays the current line, five previous lines, and 10 subsequent lines.
  To continue listing the script, press ENTER.

- `l <m>`, `List`: Displays 16 lines of the script beginning with the line
  number specified by `<m>`.

- `l <m> <n>`, `List`: Displays `<n>` lines of the script, beginning with the
  line number specified by `<m>`.

- `q`, `Stop`, `Exit`: Stops executing the script, and exits the debugger. If
  you are debugging a job by running the `Debug-Job` cmdlet, the `Exit` command
  detaches the debugger, and allows the job to continue running.

- `k`, `Get-PsCallStack`: Displays the current call stack.

- `<Enter>`: Repeats the last command if it was Step (s), StepOver (v), or
  List (l). Otherwise, represents a submit action.

- `?`, `h`: Displays the debugger command Help.

To exit the debugger, you can use Stop (q).

Starting in PowerShell 5.0, you can run the Exit command to exit a
nested debugging session that you started by running either `Debug-Job` or
`Debug-Runspace`.

By using these debugger commands, you can run a script, stop on a point of
concern, examine the values of variables and the state of the system, and
continue running the script until you have identified a problem.

NOTE: If you step into a statement with a redirection operator, such as ">",
the PowerShell debugger steps over all remaining statements in the script.

Displaying the Values of script Variables

While you are in the debugger, you can also enter commands, display the value
of variables, use cmdlets, and run scripts at the command line.

You can display the current value of all variables in the script that is being
debugged, except for the following automatic variables:

```powershell
$_
$Args
$Input
$MyInvocation
$PSBoundParameters
```

If you try to display the value of any of these variables, you get the value of
that variable for in an internal pipeline the debugger uses, not the value of
the variable in the script.

To display the value these variables for the script that is being debugged, in
the script, assign the value of the automatic variable to a new variable. Then
you can display the value of the new variable.

For example,

```powershell
$scriptArgs = $Args
$scriptArgs
```

In the example in this topic, the value of the `$MyInvocation` variable is
reassigned as follows:

```powershell
$scriptname = $MyInvocation.MyCommand.Path
```

## The Debugger Environment

When you reach a breakpoint, you enter the debugger environment. The command
prompt changes so that it begins with "[DBG]:".

For more information about customizing the prompt, see [about_Prompts](about_prompts.md).

Also, in some host applications, such as the PowerShell console, (but not in
Windows PowerShell Integrated Scripting Environment [ISE]), a nested prompt
opens for debugging. You can detect the nested prompt by the repeating
greater-than characters (ASCII 62) that appear at the command prompt.

For example, the following is the default debugging prompt in the PowerShell
console:

```
[DBG]: PS (get-location)>>>
```

You can find the nesting level by using the `$NestedPromptLevel` automatic
variable.

Additionally, an automatic variable, `$PSDebugContext`, is defined in the local
scope. You can use the presence of the `$PsDebugContext` variable to determine
whether you are in the debugger.

For example:

```powershell
if ($PSDebugContext) {"Debugging"} else {"Not Debugging"}
```

You can use the value of the `$PSDebugContext` variable in your debugging.

```
[DBG]: PS>>> $PSDebugContext.InvocationInfo

Name   CommandLineParameters  UnboundArguments  Location
----   ---------------------  ----------------  --------
=      {}                     {}                C:\ps-test\vote.ps1 (1)
```

## Debugging and Scope

Breaking into the debugger does not change the scope in which you are
operating, but when you reach a breakpoint in a script, you move into the
script scope. The script scope is a child of the scope in which you ran the
debugger.

To find the variables and aliases that are defined in the script scope, use the
Scope parameter of the `Get-Alias` or `Get-Variable` cmdlets.

For example, the following command gets the variables in the local (script)
scope:

```powershell
Get-Variable -scope 0
```

You can abbreviate the command as:

```powershell
gv -s 0
```

This is a useful way to see only the variables that you defined in the script
and that you defined while debugging.

Debugging at the Command Line

When you set a variable breakpoint or a command breakpoint, you can set the
breakpoint only in a script file. However, by default, the breakpoint is set on
anything that runs in the current session.

For example, if you set a breakpoint on the `$name` variable, the debugger
breaks on any `$name` variable in any script, command, function, script cmdlet
or expression that you run until you disable or remove the breakpoint.

This allows you to debug your scripts in a more realistic context in which they
might be affected by functions, variables, and other scripts in the session and
in the user's profile.

Line breakpoints are specific to script files, so they are set only in script
files.

## Debugging Functions

When you set a breakpoint on a function that has `Begin`, `Process`, and `End`
sections, the debugger breaks at the first line of each section.

For example:

```powershell
function test-cmdlet {
    begin {
        write-output "Begin"
    }
    process {
        write-output "Process"
    }
    end {
        write-output "End"
    }
}

C:\PS> Set-PSBreakpoint -command test-cmdlet

C:\PS> test-cmdlet

Begin
Entering debug mode. Use h or ? for help.

Hit Command breakpoint on 'prompt:test-cmdlet'

test-cmdlet

[DBG]: C:\PS> c
Process
Entering debug mode. Use h or ? for help.

Hit Command breakpoint on 'prompt:test-cmdlet'

test-cmdlet

[DBG]: C:\PS> c
End
Entering debug mode. Use h or ? for help.

Hit Command breakpoint on 'prompt:test-cmdlet'

test-cmdlet

# [DBG]: C:\PS>
```

## Debugging Remote Scripts

Starting in PowerShell 5.0, you can run the PowerShell debugger in a
remote session, in either the console, or Windows PowerShell ISE.
`Enter-PSSession` functionality has been updated to let you reconnect to and
enter a disconnected session that is running on a remote computer, and
currently running a script. If the running script hits a breakpoint, your
client session automatically starts the debugger.

The following is an example that shows how this works, with breakpoints set in
a script at lines 6, 11, 22, and 25. Note that in the example, when the
debugger starts, there are two identifying prompts: the name of the computer on
which the session is running, and the DBG prompt that lets you know you are in
debugging mode.

```powershell
Enter-Pssession -Cn localhost
[localhost]: PS C:\psscripts> Set-PSBreakpoint .\ttest19.ps1 6,11,22,25

ID Script          Line     Command          Variable          Action
-- ------          ----     -------          --------          ------
0 ttest19.ps1          6
1 ttest19.ps1          11
2 ttest19.ps1          22
3 ttest19.ps1          25

[localhost]: PS C:\psscripts> .\ttest19.ps1
Hit Line breakpoint on 'C:\psscripts\ttest19.ps1:11'

At C:\psscripts\ttest19.ps1:11 char:1
+ $winRMName = "WinRM"
# + ~

[localhost]: [DBG]: PS C:\psscripts>> list

6:      1..5 | foreach { sleep 1; Write-Output "hello2day $_" }
7:  }
# 8:

9:  $count = 10
10:  $psName = "PowerShell"
11:* $winRMName = "WinRM"
12:  $myVar = 102
# 13:

14:  for ($i=0; $i -lt $count; $i++)
15:  {
16:      sleep 1
17:      Write-Output "Loop iteration is: $i"
18:      Write-Output "MyVar is $myVar"
# 19:

20:      hello2day
# 21:


[localhost]: [DBG]: PS C:\psscripts>> stepover
At C:\psscripts\ttest19.ps1:12 char:1
+ $myVar = 102
# + ~

[localhost]: [DBG]: PS C:\psscripts>> quit
[localhost]: PS C:\psscripts> Exit-PSSession
PS C:\psscripts>
```

## Examples

This test script detects the version of the operating system and displays a
system-appropriate message. It includes a function, a function call, and a
variable.

The following command displays the contents of the test script file:

```powershell
PS C:\PS-test>  Get-Content test.ps1

function psversion {
  "PowerShell " + $PSVersionTable.PSVersion
  if ($PSVersionTable.PSVersion.Major -lt 6) {
    "Upgrade to PowerShell 6.0!"
  }
  else {
    "Have you run a background job today (start-job)?"
  }
}

$scriptName = $MyInvocation.MyCommand.Path
psversion
"Done $scriptName."
```

To start, set a breakpoint at a point of interest in the script, such as a
line, command, variable, or function.

Start by creating a line breakpoint on the first line of the Test.ps1 script in
the current directory.

```powershell
PS C:\ps-test> Set-PSBreakpoint -line 1 -script test.ps1
```

You can abbreviate this command as:

```powershell
PS C:\ps-test> spb 1 -s test.ps1
```

The command returns a line-breakpoint object
(**System.Management.Automation.LineBreakpoint**).

```
Column     : 0
Line       : 1
Action     :
Enabled    : True
HitCount   : 0
Id         : 0
Script     : C:\ps-test\test.ps1
ScriptName : C:\ps-test\test.ps1
```

Now, start the script.

```powershell
PS C:\ps-test> .\test.ps1
```

When the script reaches the first breakpoint, the breakpoint message indicates
that the debugger is active. It describes the breakpoint and previews the first
line of the script, which is a function declaration. The command prompt also
changes to indicate that the debugger has control.

The preview line includes the script name and the line number of the previewed
command.

```powershell
Entering debug mode. Use h or ? for help.

Hit Line breakpoint on 'C:\ps-test\test.ps1:1'

test.ps1:1   function psversion {
# DBG>
```

Use the Step command (s) to execute the first statement in the script and to
preview the next statement. The next statement uses the `$MyInvocation`
automatic variable to set the value of the `$scriptName` variable to the path
and file name of the script file.

```powershell
DBG> s
test.ps1:11  $scriptName = $MyInvocation.MyCommand.Path
```

At this point, the `$scriptName` variable is not populated, but you can verify
the value of the variable by displaying its value. In this case, the value is
`$null`.

```powershell
DBG> $scriptname
# DBG>
```

Use another Step command (s) to execute the current statement and to preview
the next statement in the script. The next statement calls the PsVersion
function.

```powershell
DBG> s
test.ps1:12  psversion
```

At this point, the `$scriptName` variable is populated, but you verify the
value of the variable by displaying its value. In this case, the value is set
to the script path.

```powershell
DBG> $scriptName
C:\ps-test\test.ps1
```

Use another Step command to execute the function call. Press ENTER, or type "s"
for Step.

```powershell
DBG> s
test.ps1:2       "PowerShell " + $PSVersionTable.PSVersion
```

The debug message includes a preview of the statement in the function. To
execute this statement and to preview the next statement in the function, you
can use a `Step` command. But, in this case, use a StepOut command (o). It
completes the execution of the function (unless it reaches a breakpoint) and
steps to the next statement in the script.

```powershell
DBG> o
Windows PowerShell 2.0
Have you run a background job today (start-job)?
test.ps1:13  "Done $scriptName"
```

Because we are on the last statement in the script, the Step, StepOut, and
Continue commands have the same effect. In this case, use StepOut (o).

```powershell
Done C:\ps-test\test.ps1
PS C:\ps-test>
```

The StepOut command executes the last command. The standard command prompt
indicates that the debugger has exited and returned control to the command
processor.

Now, run the debugger again. First, to delete the current breakpoint, use the
`Get-PsBreakpoint` and `Remove-PsBreakpoint` cmdlets. (If you think you might
reuse the breakpoint, use the `Disable-PsBreakpoint` cmdlet instead of
`Remove-PsBreakpoint`.)

```powershell
PS C:\ps-test> Get-PSBreakpoint| Remove-PSBreakpoint
```

You can abbreviate this command as:

```powershell
PS C:\ps-test> gbp | rbp
```

Or, run the command by writing a function, such as the following
function:

```powershell
function delbr { gbp | rbp }
```

Now, create a breakpoint on the `$scriptname` variable.

```powershell
PS C:\ps-test> Set-PSBreakpoint -variable scriptname -script test.ps1
```

You can abbreviate the command as:

```powershell
PS C:\ps-test> sbp -v scriptname -s test.ps1
```

Now, start the script. The script reaches the variable breakpoint. The default
mode is Write, so execution stops just before the statement that changes the
value of the variable.

```powershell
PS C:\ps-test> .\test.ps1
Hit Variable breakpoint on 'C:\ps-test\test.ps1:$scriptName'
(Write access)

test.ps1:11  $scriptName = $MyInvocation.MyCommand.Path
# DBG>
```

Display the current value of the `$scriptName` variable, which is `$null`.

```powershell
DBG> $scriptName
# DBG>
```

Use a Step command (s) to execute the statement that populates the variable.
Then, display the new value of the `$scriptName` variable.

```powershell
DBG> $scriptName
C:\ps-test\test.ps1
```powershell

Use a Step command (s) to preview the next statement in the script.

```powershell
DBG> s
test.ps1:12  psversion
```

The next statement is a call to the PsVersion function. To skip the function
but still execute it, use a StepOver command (v). If you are already in the
function when you use StepOver, it is not effective. The function call is
displayed, but it is not executed.

```powershell
DBG> v
Windows PowerShell 2.0
Have you run a background job today (start-job)?
test.ps1:13  "Done $scriptName"
```

The StepOver command executes the function, and it previews the next statement
in the script, which prints the final line.

Use a Stop command (t) to exit the debugger. The command prompt reverts to the
standard command prompt.

```powershell
C:\ps-test>
```

To delete the breakpoints, use the `Get-PsBreakpoint` and `Remove-PsBreakpoint`
cmdlets.

```powershell
PS C:\ps-test> Get-PSBreakpoint| Remove-PSBreakpoint
```

Create a new command breakpoint on the PsVersion function.

```powershell
PS C:\ps-test> Set-PSBreakpoint -command psversion -script test.ps1
```

You can abbreviate this command to:

```powershell
PS C:\ps-test> sbp -c psversion -s test.ps1
```

Now, run the script.

```powershell
PS C:\ps-test> .\test.ps1
Hit Command breakpoint on 'C:\ps-test\test.ps1:psversion'

test.ps1:12  psversion
# DBG>
```

The script reaches the breakpoint at the function call. At this point, the
function has not yet been called. This gives you the opportunity to use the
Action parameter of `Set-PSBreakpoint` to set conditions for the execution of
the breakpoint or to perform preparatory or diagnostic tasks, such as starting
a log or invoking a diagnostic or security script.

To set an action, use a Continue command (c) to exit the script, and a
`Remove-PsBreakpoint` command to delete the current breakpoint. (Breakpoints
are read-only, so you cannot add an action to the current breakpoint.)

```powershell
DBG> c
Windows PowerShell 2.0
Have you run a background job today (start-job)?
Done C:\ps-test\test.ps1

PS C:\ps-test> Get-PSBreakpoint| Remove-PSBreakpoint
PS C:\ps-test>
```

Now, create a new command breakpoint with an action. The following command sets
a command breakpoint with an action that logs the value of the `$scriptName`
variable when the function is called. Because the Break keyword is not used in
the action, execution does not stop. (The backtick (`) is the line-continuation
character.)

```powershell
PS C:\ps-test> Set-PSBreakpoint -command psversion -script test.ps1  `
-action { add-content "The value of `$scriptName is $scriptName." `
-path action.log}
```

You can also add actions that set conditions for the breakpoint. In the
following command, the command breakpoint is executed only if the execution
policy is set to RemoteSigned, the most restrictive policy that still permits
you to run scripts. (The backtick (`) is the continuation character.)

```powershell
PS C:\ps-test> Set-PSBreakpoint -script test.ps1 -command psversion `
-action { if ((Get-ExecutionPolicy) -eq "RemoteSigned") { break }}
```

The Break keyword in the action directs the debugger to execute the breakpoint.
You can also use the Continue keyword to direct the debugger to execute without
breaking. Because the default keyword is Continue, you must specify Break to
stop execution.

Now, run the script.

```powershell
PS C:\ps-test> .\test.ps1
Hit Command breakpoint on 'C:\ps-test\test.ps1:psversion'

test.ps1:12  psversion
```

Because the execution policy is set to **RemoteSigned**, execution stops at the
function call.

At this point, you might want to check the call stack. Use the
`Get-PsCallStack` cmdlet or the `Get-PsCallStack` debugger command (k). The
following command gets the current call stack.

```powershell
DBG> k
2: prompt
1: .\test.ps1: $args=[]
0: prompt: $args=[]
```

This example demonstrates just a few of the many ways to use the PowerShell
debugger.

For more information about the debugger cmdlets, type the following command:

```powershell
help <cmdlet-name> -full
```

For example, type:

```powershell
help Set-PSBreakpoint -full
```

## Other Debugging Features in PowerShell

In addition to the PowerShell debugger, PowerShell includes several other
features that you can use to debug scripts and functions.

- Windows PowerShell ISE includes an interactive graphical debugger. For more
  information, start Windows PowerShell ISE and press F1.

- The `Set-PSDebug` cmdlet offers very basic script debugging features,
  including stepping and tracing.

- Use the `Set-StrictMode` cmdlet to detect references to uninitialized
  variables, to references to non-existent properties of an object, and to
  function syntax that is not valid.

- Add diagnostic statements to a script, such as statements that display the
  value of variables, statements that read input from the command line, or
  statements that report the current instruction. Use the cmdlets that contain
  the Write verb for this task, such as `Write-Host`, `Write-Debug`,
  `Write-Warning`, and `Write-Verbose`.

## SEE ALSO

- [Disable-PsBreakpoint](xref:Microsoft.PowerShell.Utility.Disable-PSBreakpoint)
- [Enable-PsBreakpoint](xref:Microsoft.PowerShell.Utility.Enable-PSBreakpoint)
- [Get-PsBreakpoint](xref:Microsoft.PowerShell.Utility.Get-PSBreakpoint)
- [Get-PsCallStack](xref:Microsoft.PowerShell.Utility.Get-PSCallStack)
- [Remove-PsBreakpoint](xref:Microsoft.PowerShell.Utility.Remove-PSBreakpoint)
- [Set-PSBreakpoint](xref:Microsoft.PowerShell.Utility.Set-PSBreakpoint)
- [Write-Debug](xref:Microsoft.PowerShell.Utility.Write-Debug)
- [Write-Verbose](xref:Microsoft.PowerShell.Utility.Write-Verbose)
