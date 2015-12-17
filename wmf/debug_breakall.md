### Break into Debugger from Running Scripts

The Windows PowerShell console and Windows PowerShell ISE now allow you to break into the debugger for running scripts. This works in both local and remote sessions.

In the console, press **Ctrl+Break**.

In ISE, press **Ctrl+B**, or use the **Debug-&gt;Break All** menu command.

### Remote debugging and remote file editing in Windows PowerShell ISE

Windows PowerShell ISE now lets you open and edit files in a remote session by running the PSEdit command.

For example, you can open a file for editing from the command line in a remote session as follows:

\[RemoteComputer1\]: PS C:\\&gt; PSEdit C:\\DebugDemoScripts\\Test-GetMutex.ps1

In addition, you can now edit and save changes in a remote file that is automatically opened in Windows PowerShell ISE when you hit a breakpoint.

Now, you can debug a script file that is running on a remote computer, edit the file to fix an error, and then rerun the modified script.