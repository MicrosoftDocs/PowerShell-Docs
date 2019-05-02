---
ms.date:  05/02/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_PowerShell_exe
---
# About PowerShell.exe

## SHORT DESCRIPTION

Explains how to use the **PowerShell.exe** command-line tool. Displays the
syntax and describes the command-line switches.

PowerShell.exe starts a PowerShell session. You can use it in
**Cmd.exe** and in PowerShell.

## LONG DESCRIPTION

### SYNTAX

```
PowerShell[.exe]
    [-PSConsoleFile <file> | -Version <version>]
    [-NoLogo]
    [-NoExit]
    [-Sta]
    [-Mta]
    [-NoProfile]
    [-NonInteractive]
    [-InputFormat {Text | XML}]
    [-OutputFormat {Text | XML}]
    [-WindowStyle <style>]
    [-EncodedCommand <Base64EncodedCommand>]
    [-ConfigurationName <string>]
    [-File - | <filePath> <args>]
    [-ExecutionPolicy <ExecutionPolicy>]
    [-Command - | { <script-block> [-args <arg-array>] }
                | { <string> [<CommandParameters>] } ]

PowerShell[.exe] -Help | -? | /?
```

### Parameters

#### -PSConsoleFile \<FilePath\>

Loads the specified PowerShell console file. Enter the path and name of
the console file. To create a console file, use the Export-Console cmdlet in
PowerShell.

#### -Version \<PowerShell Version\>

Starts the specified version of PowerShell. Valid values are 2.0 and
3.0. The version that you specify must be installed on the system. If Windows
PowerShell 3.0 is installed on the computer, "3.0" is the default version.
Otherwise, "2.0" is the default version. For more information, see [Installing PowerShell](/powershell/scripting/install/installing-windows-powershell.md).

#### -NoLogo

Hides the copyright banner at startup.

#### -NoExit

Does not exit after running startup commands.

#### -Sta

Starts PowerShell using a single-threaded apartment. In Windows
PowerShell 2.0, multi-threaded apartment (MTA) is the default. In Windows
PowerShell 3.0, single-threaded apartment (STA) is the default.

#### -Mta

Starts PowerShell using a multi-threaded apartment. This parameter is
introduced in PowerShell 3.0. In PowerShell 2.0, multi-threaded
apartment (MTA) is the default. In PowerShell 3.0, single-threaded
apartment (STA) is the default.

#### -NoProfile

Does not load the PowerShell profile.

#### -NonInteractive

Does not present an interactive prompt to the user.

#### -InputFormat {Text | XML}

Describes the format of data sent to PowerShell. Valid values are
"Text" (text strings) or "XML" (serialized CLIXML format).

#### -OutputFormat {Text | XML}

Determines how output from PowerShell is formatted. Valid values are
"Text" (text strings) or "XML" (serialized CLIXML format).

#### -WindowStyle \<Window style\>

Sets the window style for the session. Valid values are Normal, Minimized,
Maximized and Hidden.

#### -EncodedCommand \<Base64EncodedCommand\>

Accepts a base-64-encoded string version of a command. Use this parameter to
submit commands to PowerShell that require complex quotation marks or curly
braces. The string must be formatted using UTF-16 character encoding.

#### -ConfigurationName \<string\>

Specifies a configuration endpoint in which PowerShell is run. This can be any
endpoint registered on the local machine including the default PowerShell
remoting endpoints or a custom endpoint having specific user role capabilities.

#### -File - | \<filePath\> \<args\>

If the value of **File** is "-", the command text is read from standard input.
Running `powershell -File -` without redirected standard input starts a regular
session. This is the same as not specifying the **File** parameter at all.

If the value of **File** is a file path, the script runs in the local scope
("dot-sourced"), so that the functions and variables that the script creates
are available in the current session. Enter the script file path and any
parameters. **File** must be the last parameter in the command. All values
typed after the **File** parameter are interpreted as the script file path and
parameters passed to that script.

Parameters passed to the script are passed as literal strings, after
interpretation by the current shell. For example, if you are in **cmd.exe** and
want to pass an environment variable value, you would use the **cmd.exe**
syntax: `powershell.exe -File .\test.ps1 -TestParam %windir%`

In contrast, running `powershell.exe -File .\test.ps1 -TestParam $env:windir`
in **cmd.exe** results in the script receiving the literal string `$env:windir`
because it has no special meaning to the current **cmd.exe** shell. The
`$env:windir` style of environment variable reference _can_ be used inside a
**Command** parameter, since there it will be interpreted as PowerShell code.

When the value of **File** is a file path, **File** _must_ be the last
parameter specified because any characters typed after the command are
interpreted as the command arguments.

You can include the script parameters and values in the value of the **File**
parameter. For example: `-File .\Get-Script.ps1 -Domain Central`

Typically, the switch parameters of a script are either included or omitted.
For example, the following command uses the **All** parameter of the
`Get-Script.ps1` script file: `-File .\Get-Script.ps1 -All`

In rare cases, you might need to provide a **Boolean** value for a switch
parameter. To provide a **Boolean** value for a switch parameter in the value
of the File parameter, enclose the parameter name and value in curly braces,
such as the following: `-File .\Get-Script.ps1 {-All:$False}`.

#### -ExecutionPolicy \<ExecutionPolicy\>

Sets the default execution policy for the current session and saves it in the
`$env:PSExecutionPolicyPreference` environment variable. This parameter does
not change the PowerShell execution policy that is set in the registry. For
information about PowerShell execution policies, including a list of valid
values, see [about_Execution_Policies](about_Execution_Policies.md).

#### -Command

Executes the specified commands (with any parameters) as though they were typed
at the PowerShell command prompt. After execution, PowerShell exits unless the
**NoExit** parameter is specified. Any text after `-Command` is sent as a
single command line to PowerShell. This is different from how `-File` handles
parameters sent to a script.

The value of **Command** can be "-", a string, or a script block. The results
of the command are returned to the parent shell as deserialized XML objects,
not live objects.

If the value of **Command** is "-", the command text is read from standard
input. You must redirect standard input when using the **Command** parameter
with standard input. For example:

```powershell
@'
"in"

"hi" |
  % { "$_ there" }

"out"
'@ | powershell -NoProfile -Command -
```

This example produces the following output:

```Output
in
hi there
out
```

When the value of **Command** is a string, **Command** _must_ be the last
parameter specified because any characters typed after the command are
interpreted as the command arguments.

The **Command** parameter only accepts a script block for execution when it can
recognize the value passed to **Command** as a **ScriptBlock** type. This is
_only_ possible when running **PowerShell.exe** from another PowerShell host.
The **ScriptBlock** type may be contained in an existing variable, returned
from an expression, or parsed by the PowerShell host as a literal script block
enclosed in curly braces `{}`, before being passed to **PowerShell.exe**.

In **cmd.exe**, there is no such thing as a script block (or **ScriptBlock**
type), so the value passed to **Command** will _always_ be a string. You can
write a script block inside the string, but instead of being executed it will
behave exactly as though you typed it at a typical PowerShell prompt, printing
the contents of the script block back out to you.

A string passed to **Command** will still be executed as PowerShell, so the
script block curly braces are often not required in the first place when
running from **cmd.exe**. To execute an inline script block defined inside a
string, the [call operator](about_operators.md#special-operators)
`&` can be used:

```console
"& {<command>}"
```

#### -Help, -?, /?

Displays help for **PowerShell.exe**. If you are typing a **PowerShell.exe**
command in a PowerShell session, prepend the command parameters with a hyphen
(-), not a forward slash (/). You can use either a hyphen or forward slash in
**cmd.exe**.

### REMARKS

Troubleshooting note: In PowerShell 2.0, starting some programs from
the PowerShell console fails with a **LastExitCode** of 0xc0000142.

### EXAMPLES

```powershell
# Create a new PowerShell session and load a saved console file
PowerShell -PSConsoleFile sqlsnapin.psc1

# Create a new PowerShell V2 session with text input, XML output, and no logo
PowerShell -Version 2.0 -NoLogo -InputFormat text -OutputFormat XML

# Execute a PowerShell Command in a session
PowerShell -Command "Get-EventLog -LogName security"

# Run a script block in a session
PowerShell -Command {Get-EventLog -LogName security}

# An alternate way to run a command in a new session
PowerShell -Command "& {Get-EventLog -LogName security}"

# To use the -EncodedCommand parameter:
$command = "dir 'c:\program files' "
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell.exe -encodedCommand $encodedCommand
```
