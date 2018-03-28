---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_PowerShell_exe
---

# About PowerShell.exe

## SHORT DESCRIPTION

Explains how to use the PowerShell.exe command-line tool. Displays the syntax
and describes the command-line switches.

PowerShell.exe starts a Windows PowerShell session. You can use it in Cmd.exe
and in Windows PowerShell.

## LONG DESCRIPTION

### SYNTAX

```
PowerShell[.exe]
[-EncodedCommand <Base64EncodedCommand>]
[-ExecutionPolicy <ExecutionPolicy>]
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
[-File <FilePath> [<Args>]]
[-Command { - | <script-block> [-args <arg-array>]
| <string> [<CommandParameters>] } ]
PowerShell[.exe] -Help | -? | /?
```

### PARAMETERS

#### -EncodedCommand <Base64EncodedCommand>

Accepts a base-64-encoded string version of a command. Use this parameter to
submit commands to Windows PowerShell that require complex quotation marks or
curly braces.

#### -ExecutionPolicy <ExecutionPolicy>

Sets the default execution policy for the current session and saves it in the
$env:PSExecutionPolicyPreference environment variable. This parameter does not
change the Windows PowerShell execution policy that is set in the registry.
For information about Windows PowerShell execution policies, including a list
of valid values, see [about_Execution_Policies](about_Execution_Policies.md).

#### -File <FilePath> [<Parameters>]

Runs the specified script in the local scope ("dot-sourced"), so that the
functions and variables that the script creates are available in the current
session. Enter the script file path and any parameters. File must be the last
parameter in the command, because all characters typed after the File
parameter name are interpreted as the script file path followed by the script
parameters.

You can include the parameters of a script, and parameter values, in the value
of the File parameter. For example: -File .\\Get-Script.ps1 -Domain Central

Typically, the switch parameters of a script are either included or omitted.
For example, the following command uses the All parameter of the
Get-Script.ps1 script file: -File .\\Get-Script.ps1 -All

In rare cases, you might need to provide a Boolean value for a switch
parameter. To provide a Boolean value for a switch parameter in the value of
the File parameter, enclose the parameter name and value in curly braces, such
as the following: -File .\\Get-Script.ps1 {-All:$False}.

#### -InputFormat {Text | XML}

Describes the format of data sent to Windows PowerShell. Valid values are
"Text" (text strings) or "XML" (serialized CLIXML format).

#### -Mta

Starts Windows PowerShell using a multi-threaded apartment. This parameter is
introduced in Windows PowerShell 3.0. In Windows PowerShell 2.0,
multi-threaded apartment (MTA) is the default. In Windows PowerShell 3.0,
single-threaded apartment (STA) is the default.

#### -NoExit

Does not exit after running startup commands.

#### -NoLogo

Hides the copyright banner at startup.

#### -NonInteractive

Does not present an interactive prompt to the user.

#### -NoProfile

Does not load the Windows PowerShell profile.

#### -OutputFormat {Text | XML}

Determines how output from Windows PowerShell is formatted. Valid values are
"Text" (text strings) or "XML" (serialized CLIXML format).

#### -PSConsoleFile <FilePath>

Loads the specified Windows PowerShell console file. Enter the path and name
of the console file. To create a console file, use the Export-Console cmdlet
in Windows PowerShell.

#### -Sta

Starts Windows PowerShell using a single-threaded apartment. In Windows
PowerShell 2.0, multi-threaded apartment (MTA) is the default. In Windows
PowerShell 3.0, single-threaded apartment (STA) is the default.

#### -Version <Windows PowerShell Version>

Starts the specified version of Windows PowerShell. Valid values are 2.0 and
3.0. The version that you specify must be installed on the system. If Windows
PowerShell 3.0 is installed on the computer, "3.0" is the default version.
Otherwise, "2.0" is the default version. For more information, see "Installing
Windows PowerShell" in the Windows PowerShell Getting Started Guide.

#### -WindowStyle <Window style>

Sets the window style for the session. Valid values are Normal, Minimized,
Maximized and Hidden.

#### -Command

Executes the specified commands (and any parameters) as though they were typed
at the Windows PowerShell command prompt, and then exits, unless the NoExit
parameter is specified.

The value of Command can be "-", a string. or a script block. If the value of
Command is "-", the command text is read from standard input.

Script blocks must be enclosed in braces ({}). You can specify a script block
only when running PowerShell.exe in Windows PowerShell. The results of the
script are returned to the parent shell as deserialized XML objects, not live
objects.

If the value of Command is a string, Command must be the last parameter in the
command , because any characters typed after the command are interpreted as
the command arguments.

To write a string that runs a Windows PowerShell command, use the
format:

"& {<command>}"

where the quotation marks indicate a string and the invoke operator (&) causes
the command to be executed.

#### -Help, -?, /?

Displays help for PowerShell.exe. If you are typing a PowerShell.exe command
in Windows PowerShell, prepend the command parameters with a hyphen (-), not a
forward slash (/). You can use either a hyphen or forward slash in Cmd.exe.

### REMARKS

Troubleshooting note: In Windows PowerShell 2.0, starting some programs from
the Windows PowerShell console fails with a LastExitCode of 0xc0000142.

### EXAMPLES

```powershell
PowerShell -PSConsoleFile sqlsnapin.psc1

PowerShell -Version 2.0 -NoLogo -InputFormat text -OutputFormat XML

PowerShell -Command {Get-EventLog -LogName security}

PowerShell -Command "& {Get-EventLog -LogName security}"
```