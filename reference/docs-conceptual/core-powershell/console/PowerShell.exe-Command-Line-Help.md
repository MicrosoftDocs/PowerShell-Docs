---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  PowerShell.exe Command Line Help
ms.assetid:  1ab7b93b-6785-42c6-a1c9-35ff686a958f
---

# PowerShell.exe Command-Line Help
Starts a Windows PowerShell session. You can use PowerShell.exe to start a Windows PowerShell session from the command line of another tool, such as Cmd.exe, or use it at the Windows PowerShell command line to start a new session. Use the parameters to customize the session.

## Syntax

```syntax
PowerShell[.exe]
       [-Command { - | <script-block> [-args <arg-array>]
                     | <string> [<CommandParameters>] } ]
       [-EncodedCommand <Base64EncodedCommand>]
       [-ExecutionPolicy <ExecutionPolicy>]
       [-File <FilePath> [<Args>]]
       [-InputFormat {Text | XML}] 
       [-Mta]
       [-NoExit]
       [-NoLogo]
       [-NonInteractive] 
       [-NoProfile] 
       [-OutputFormat {Text | XML}] 
       [-PSConsoleFile <FilePath> | -Version <Windows PowerShell version>]
       [-Sta]
       [-WindowStyle <style>]
        

PowerShell[.exe] -Help | -? | /?
```

## Parameters

### -EncodedCommand <Base64EncodedCommand>
Accepts a base-64-encoded string version of a command. Use this parameter to submit commands to Windows PowerShell that require complex quotation marks or curly braces.

### -ExecutionPolicy <ExecutionPolicy>
Sets the default execution policy for the current session and saves it in the $env:PSExecutionPolicyPreference environment variable. This parameter does not change the Windows PowerShell execution policy that is set in the registry. For information about Windows PowerShell execution policies, including a list of valid values, see about_Execution_Policies (http://go.microsoft.com/fwlink/?LinkID=135170).

### -File <FilePath> \[<Parameters>]
Runs the specified script in the local scope ("dot-sourced"), so that the functions and variables that the script creates are available in the current session. Enter the script file path and any parameters. **File** must be the last parameter in the command, because all characters typed after the **File** parameter name are interpreted as the script file path followed by the script parameters and their values.

You can include the parameters of a script, and parameter values, in the value of the **File** parameter. For example: `-File .\Get-Script.ps1 -Domain Central`
Note that parameters passed to the script are passed as literal strings (after interpretation by the current shell).
For example, if you are in cmd.exe and want to pass an environment variable value, you would use the cmd.exe syntax: `powershell -File .\test.ps1 -Sample %windir%`
If you were to use PowerShell syntax, then in this example your script would receive the literal "$env:windir" and not the value of that environmental variable: `powershell -File .\test.ps1 -Sample $env:windir`

Typically, the switch parameters of a script are either included or omitted. For example, the following command uses the **All** parameter of the Get-Script.ps1 script file: `-File .\Get-Script.ps1 -All`

### \-InputFormat {Text | XML}
Describes the format of data sent to Windows PowerShell. Valid values are "Text" (text strings) or "XML" (serialized CLIXML format).

### -Mta
Starts Windows PowerShell using a multi-threaded apartment. This parameter is introduced in Windows PowerShell 3.0. In Windows PowerShell 3.0, single-threaded apartment (STA) is the default. In Windows PowerShell 2.0, multi-threaded apartment (MTA) is the default.

### -NoExit
Does not exit after running startup commands.

### -NoLogo
Hides the copyright banner at startup.

### -NonInteractive
Does not present an interactive prompt to the user.

### -NoProfile
Does not load the Windows PowerShell profile.

### -OutputFormat {Text | XML}
Determines how output from Windows PowerShell is formatted. Valid values are "Text" (text strings) or "XML" (serialized CLIXML format).

### -PSConsoleFile <FilePath>
Loads the specified Windows PowerShell console file. Enter the path and name of the console file. To create a console file, use the [Export-Console](https://technet.microsoft.com/en-us/library/4bab1c02-9e61-4aaf-9957-11d1934ef4ef) cmdlet in Windows PowerShell.

### -Sta
Starts Windows PowerShell using a single-threaded apartment. In Windows PowerShell 3.0, single-threaded apartment (STA) is the default. In Windows PowerShell 2.0, multi-threaded apartment (MTA) is the default.

### -Version <Windows PowerShell Version>
Starts the specified version of Windows PowerShell. The version that you specify must be installed on the system. If Windows PowerShell 3.0 is installed on the computer, valid values are "2.0" and "3.0". The default value is "3.0".

If Windows PowerShell 3.0 is not installed, the only valid value is "2.0". Other values are ignored.

For more information, see "Installing Windows PowerShell" in the [Getting Started with Windows PowerShell [OLD MSDN]](https://technet.microsoft.com/en-us/library/69555d95-b481-43e1-86e7-b46d68b3e2dd).

### -WindowStyle <Window style>
Sets the window style for the session. Valid values are Normal, Minimized, Maximized and Hidden.

### -Command
Executes the specified commands (and any parameters) as though they were typed at the Windows PowerShell command prompt, and then exits, unless the NoExit parameter is specified.
Essentially, any text after `-Command` is sent as a single command line to PowerShell (this is different from how `-File` handles parameters sent to a script).

The value of Command can be "-", a string. or a script block. If the value of Command is "-", the command text is read from standard input.

Script blocks must be enclosed in braces ({}). You can specify a script block only when running PowerShell.exe in Windows PowerShell. The results of the script are returned to the parent shell as deserialized XML objects, not live objects.

If the value of Command is a string, **Command** must be the last parameter in the command, because any characters typed after the command are interpreted as the command arguments.

To write a string that runs a Windows PowerShell command, use the format:

```
"& {<command>}"
```

where the quotation marks indicate a string and the invoke operator (&) causes the command to be executed.

### -Help, -?, /?
Shows this message. If you are typing a PowerShell.exe command in Windows PowerShell, prepend the command parameters with a hyphen (-), not a forward slash (/). You can use either a hyphen or forward slash in Cmd.exe.

> [!NOTE]
> Troubleshooting Note: In Windows PowerShell 2.0, starting some programs in the Windows PowerShell console fails with a LastExitCode of 0xc0000142.

## EXAMPLES

```
# Create a new PowerShell session and load a saved console file
PowerShell -PSConsoleFile sqlsnapin.psc1

# Create a new PowerShell V2 session with text input, XML output, and no logo
PowerShell -Version 2.0 -NoLogo -InputFormat text -OutputFormat XML

# Execute a Powerhell Command in a session
PowerShell -Command "Get-EventLog -LogName security"

# Run a script block in a session
PowerShell -Command {Get-EventLog -LogName security}

# An alternate wayh to run a command in a new session
PowerShell -Command "& {Get-EventLog -LogName security}"

# To use the -EncodedCommand parameter:
$command = "dir 'c:\program files' "
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell.exe -encodedCommand $encodedCommand
```

