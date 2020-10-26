---
ms.date:  01/02/2020
title:  How to Debug Scripts in Windows PowerShell ISE
description: This article describes how to debug scripts on a local computer by using the Windows PowerShell ISE visual debugging features.
---

# How to Debug Scripts in Windows PowerShell ISE

This article describes how to debug scripts on a local computer by using the Windows PowerShell
Integrated Scripting Environment (ISE) visual debugging features.

## How to manage breakpoints

A breakpoint is a designated spot in a script where you would like operation to pause so that you
can examine the current state of the variables and the environment in which your script is running.
Once your script is paused by a breakpoint, you can run commands in the Console Pane to examine the
state of your script. You can output variables or run other commands. You can even modify the value
of any variables that are visible to the context of the currently running script. After you have
examined what you want to see, you can resume operation of the script.

You can set three types of breakpoints in the Windows PowerShell debugging environment:

1. **Line breakpoint**. The script pauses when the designated line is reached during the operation
   of the script

1. **Variable breakpoint.** The script pauses whenever the designated variable's value changes.

1. **Command breakpoint.** The script pauses whenever the designated command is about to be run
   during the operation of the script. It can include parameters to further filter the breakpoint to
   only the operation you want. The command can also be a function you created.

Of these, in the Windows PowerShell ISE debugging environment, only line breakpoints can be set by
using the menu or the keyboard shortcuts. The other two types of breakpoints can be set, but they
are set from the Console Pane by using the [Set-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Set-PSBreakpoint)
cmdlet. This section describes how you can perform debugging tasks in Windows PowerShell ISE by
using the menus where available, and perform a wider range of commands from the Console Pane by
using scripting.

### To set a breakpoint

A breakpoint can be set in a script only after it has been saved. Right-click the line where you
want to set a line breakpoint, and then click **Toggle Breakpoint**. Or, click the line where you
want to set a line breakpoint, and press <kbd>F9</kbd> or, on the **Debug** menu, click **Toggle Breakpoint**.

The following script is an example of how you can set a variable breakpoint from the Console Pane by
using the [Set-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Set-PSBreakpoint)
cmdlet.

```powershell
# This command sets a breakpoint on the Server variable in the Sample.ps1 script.
Set-PSBreakpoint -Script sample.ps1 -Variable Server
```

### List all breakpoints

Displays all breakpoints in the current Windows PowerShell session.

On the **Debug** menu, click **List Breakpoints**. The following script is an example of how you can
list all breakpoints from the Console Pane by using the [Get-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Get-PSBreakpoint)
cmdlet.

```powershell
# This command lists all breakpoints in the current session.
Get-PSBreakpoint
```

### Remove a breakpoint

Removing a breakpoint deletes it.

If you think you might want to use it again later, consider [Disable a Breakpoint](#disable-a-breakpoint)
it instead. Right-click the line where you want to remove a breakpoint, and then click **ToggleBreakpoint**.
Or, click the line where you want to remove a breakpoint, and on the **Debug** menu, click
**Toggle Breakpoint**. The following script is an example of how to remove a breakpoint with a
specified ID from the Console Pane by using the [Remove-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Remove-PSBreakpoint)
cmdlet.

```powershell
# This command deletes the breakpoint with breakpoint ID 2.
Remove-PSBreakpoint -Id 2
```

### Remove All Breakpoints

To remove all breakpoints defined in the current session, on the **Debug** menu, click **Remove All Breakpoints**.

The following script is an example of how to remove all breakpoints from the Console Pane by using
the [Remove-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Remove-PSBreakpoint)
cmdlet.

```powershell
# This command deletes all of the breakpoints in the current session.
Get-PSBreakpoint | Remove-PSBreakpoint
```

### Disable a Breakpoint

Disabling a breakpoint does not remove it; it turns it off until it is enabled. To disable a
specific line breakpoint, right-click the line where you want to disable a breakpoint, and then
click **Disable Breakpoint**. Or, click the line where you want to disable a breakpoint, and press
<kbd>F9</kbd> or, on the **Debug** menu, click **Disable Breakpoint**. The following script is an
example of how you can remove a breakpoint with a specified ID from the Console Pane by using the [Disable-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Disable-PSBreakpoint)
cmdlet.

```powershell
# This command disables the breakpoint with breakpoint ID 0.
Disable-PSBreakpoint -Id 0
```

### Disable All Breakpoints

Disabling a breakpoint does not remove it; it turns it off until it is enabled. To disable all
breakpoints in the current session, on the **Debug** menu, click **Disable all Breakpoints**. The
following script is an example of how you can disable all breakpoints from the Console Pane by using
the [Disable-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Disable-PSBreakpoint)
cmdlet.

```powershell
# This command disables all breakpoints in the current session.
# You can abbreviate this command as: "gbp | dbp".
Get-PSBreakpoint | Disable-PSBreakpoint
```

### Enable a Breakpoint

To enable a specific breakpoint, right-click the line where you want to enable a breakpoint, and
then click **Enable Breakpoint**. Or, click the line where you want to enable a breakpoint, and then
press <kbd>F9</kbd> or, on the **Debug** menu, click **Enable Breakpoint**. The following script is an
example of how you can enable specific breakpoints from the Console Pane by using the [Enable-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Enable-PSBreakpoint)
cmdlet.

```powershell
# This command enables breakpoints with breakpoint IDs 0, 1, and 5.
Enable-PSBreakpoint -Id 0, 1, 5
```

### Enable All Breakpoints

To enable all breakpoints defined in the current session, on the **Debug** menu, click **Enable all
Breakpoints**. The following script is an example of how you can enable all breakpoints from the
Console Pane by using the [Enable-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Enable-PSBreakpoint)
cmdlet.

```powershell
# This command enables all breakpoints in the current session.
# You can abbreviate the command by using their aliases: "gbp | ebp".
Get-PSBreakpoint | Enable-PSBreakpoint
```

## How to manage a debugging session

Before you start debugging, you must set one or more breakpoints. You cannot set a breakpoint unless
the script that you want to debug is saved. For directions on of how to set a breakpoint, see [How to manage breakpoints](#how-to-manage-breakpoints)
or [Set-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Set-PSBreakpoint).
After you start debugging, you cannot edit a script until you stop debugging. A script that has one
or more breakpoints set is automatically saved before it is run.

### To start debugging

Press <kbd>F5</kbd> or, on the toolbar, click the **Run Script** icon, or on the **Debug** menu
click **Run/Continue**. The script runs until it encounters the first breakpoint. It pauses
operation there and highlights the line on which it paused.

### To continue debugging

Press <kbd>F5</kbd> or, on the toolbar, click the **Run Script** icon, or on the **Debug** menu,
click **Run/Continue** or, in the Console Pane, type `C` and then press <kbd>ENTER</kbd>. This
causes the script to continue running to the next breakpoint or to the end of the script if no
further breakpoints are encountered.

### To view the call stack

The call stack displays the current run location in the script. If the script is running in a
function that was called by a different function, then that is represented in the display by
additional rows in the output. The bottom-most row displays the original script and the line in it
in which a function was called. The next line up shows that function and the line in it in which
another function might have been called. The top-most row shows the current context of the current
line on which the breakpoint is set.

While paused, to see the current call stack, press <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>D</kbd> or,
on the **Debug** menu, click **Display Call Stack** or, in the Console Pane, type `K` and then press
<kbd>ENTER</kbd>.

### To stop debugging

Press <kbd>SHIFT</kbd>+<kbd>F5</kbd> or, on the **Debug** menu, click **Stop Debugger**, or, in the
Console Pane, type `Q` and then press <kbd>ENTER</kbd>.

## How to step over, step into, and step out while debugging

Stepping is the process of running one statement at a time. You can stop on a line of code, and
examine the values of variables and the state of the system. The following table describes common
debugging tasks such as stepping over, stepping into, and stepping out.

| Debugging Task |                                                                                                                   Description                                                                                                                    |                                                      How to accomplish it in PowerShell ISE                                                       |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Step Into**  | Executes the current statement and then stops at the next statement. If the current statement is a function or script call, then the debugger steps into that function or script, otherwise it stops at the next statement.                      | Press <kbd>F11</kbd> or, on the **Debug** menu, click **Step Into**, or in the Console Pane, type `S` and press <kbd>ENTER</kbd>.                 |
| **Step Over**  | Executes the current statement and then stops at the next statement. If the current statement is a function or script call, then the debugger executes the whole function or script, and it stops at the next statement after the function call. | Press <kbd>F10</kbd> or, on the **Debug** menu, click **Step Over**, or in the Console Pane, type `V` and press <kbd>ENTER</kbd>.                 |
| **Step Out**   | Steps out of the current function and up one level if the function is nested. If in the main body, the script is executed to the end, or to the next breakpoint. The skipped statements are executed, but not stepped through.                   | Press <kbd>SHIFT</kbd>+<kbd>F11</kbd>, or on the **Debug** menu, click **Step Out**, or in the Console Pane, type `O` and press <kbd>ENTER</kbd>. |
| **Continue**   | Continues execution to the end, or to the next breakpoint. The skipped functions and invocations are executed, but not stepped through.                                                                                                          | Press <kbd>F5</kbd> or, on the **Debug** menu, click **Run/Continue**, or in the Console Pane, type `C` and press <kbd>ENTER</kbd>.               |

## How to display the values of variables while debugging

You can display the current values of variables in the script as you step through the code.

### To display the values of standard variables

Use one of the following methods:

- In the Script Pane, hover over the variable to display its value as a tool tip.

- In the Console Pane, type the variable name and press <kbd>ENTER</kbd>.

All panes in ISE are always in the same scope. Therefore, while you are debugging a script, the
commands that you type in the Console Pane run in script scope. This allows you to use the Console
Pane to find the values of variables and call functions that are defined only in the script.

### To display the values of automatic variables

You can use the preceding method to display the value of almost all variables while you are
debugging a script. However, these methods do not work for the following automatic variables.

- `$_`

- `$Input`

- `$MyInvocation`

- `$PSBoundParameters`

- `$Args`

If you try to display the value of any of these variables, you get the value of that variable for in
an internal pipeline the debugger uses, not the value of the variable in the script. You can work
around this for a few variables (`$_`, `$Input`, `$MyInvocation`, `$PSBoundParameters`, and `$Args`)
by using the following method:

1. In the script, assign the value of the automatic variable to a new variable.

1. Display the value of the new variable, either by hovering over the new variable in the Script
   Pane, or by typing the new variable in the Console Pane.

For example, to display the value of the `$MyInvocation` variable, in the script, assign the value
to a new variable, such as `$scriptName`, and then hover over or type the `$scriptName` variable to
display its value.

```powershell
# In C:\ps-test\MyScript.ps1
$scriptName = $MyInvocation.MyCommand.Path
```

```PowerShell
# In the Console Pane:
.\MyScript.ps1
$scriptName
```

```Output
C:\ps-test\MyScript.ps1
```

## See Also

[Exploring the Windows PowerShell ISE](exploring-the-windows-powershell-ise.md)
