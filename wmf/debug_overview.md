# Improvements in PowerShell Script Debugging

A number of improvements were made in PowerShell 5.0 to enhance the debugging experience:

## Break All

The PowerShell console and Windows PowerShell ISE now allow you to break into the debugger for running scripts. This works in both local and remote sessions.

In the console, press **Ctrl+Break**.

In ISE, press **Ctrl+B**, or use the **Debug -> Break All** menu command.

## Remote debugging and remote file editing in Windows PowerShell ISE

Windows PowerShell ISE now lets you open and edit files in a remote session by running the PSEdit command.
For example, you can open a file for editing from the command line in a remote session as follows:

```powershell
[RemoteComputer1]: PS C:\> PSEdit C:\DebugDemoScripts\Test-GetMutex.ps1
```

In addition, you can now edit and save changes in a remote file that is automatically opened in Windows PowerShell ISE when you hit a breakpoint.
Now, you can debug a script file that is running on a remote computer, edit the file to fix an error, and then rerun the modified script.

## Advanced Script Debugging

There are new, advanced debugging features that let you attach to any local computer process that has loaded Windows PowerShell, and debug arbitrary runspaces in that process.

### Runspace Debugging

New cmdlets have been added that let you list current runspaces in a process, and attach the Windows PowerShell console or ISE debugger to that runspace for script debugging:

-   Get-Runspace
-   Debug-Runspace
-   Enable-RunspaceDebug
-   Disable-RunspaceDebug
-   Get-RunspaceDebug

### Attach to Process hosting PowerShell

You can now attach to any computer process that has Windows PowerShell loaded. You do this by entering into an interactive session with the process, similarly to how you enter into an interactive remote session by running the Enter-PSSession cmdlet:

-   Enter-PSHostProcess
-   Exit-PSHostProcess