---
keywords: powershell,cmdlet
ms.date: 10/05/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pwsh?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Pwsh
---
# About pwsh

## Short Description
Explains how to use the `pwsh` command-line interface. Displays the
command-line parameters and describes the syntax.

## Long Description

## Syntax

```
pwsh[.exe]
   [[-File] <filePath> [args]]
   [-Command { - | <script-block> [-args <arg-array>]
                 | <string> [<CommandParameters>] } ]
   [-ConfigurationName <string>]
   [-CustomPipeName <string>]
   [-EncodedCommand <Base64EncodedCommand>]
   [-ExecutionPolicy <ExecutionPolicy>]
   [-InputFormat {Text | XML}]
   [-Interactive]
   [-NoExit]
   [-NoLogo]
   [-NonInteractive]
   [-NoProfile]
   [-OutputFormat {Text | XML}]
   [-SettingsFile <SettingsFilePath>]
   [-Version]
   [-WindowStyle <style>]
   [-WorkingDirectory <directoryPath>]

pwsh[.exe] -h | -Help | -? | /?
```

## Parameters

All parameters are case-insensitive.

### -File | -f

If the value of `File` is `-`, the command text is read from standard input.
Running `pwsh -File -` without redirected standard input starts a regular
session. This is the same as not specifying the `File` parameter at all.

This is the default parameter if no parameters are present but values are
present in the command line. The specified script runs in the local scope
("dot-sourced"), so that the functions and variables that the script creates
are available in the current session. Enter the script file path and any
parameters. File must be the last parameter in the command, because all
characters typed after the File parameter name are interpreted as the script
file path followed by the script parameters.

Typically, the switch parameters of a script are either included or omitted.
For example, the following command uses the All parameter of the
Get-Script.ps1 script file: `-File .\Get-Script.ps1 -All`

In rare cases, you might need to provide a **Boolean** value for a switch
parameter. To provide a **Boolean** value for a switch parameter in the value
of the **File** parameter, Use the parameter normally followed immediately by a
colon and the boolean value, such as the following:
`-File .\Get-Script.ps1 -All:$False`.

Parameters passed to the script are passed as literal strings, after
interpretation by the current shell. For example, if you are in `cmd.exe` and
want to pass an environment variable value, you would use the `cmd.exe`
syntax: `pwsh -File .\test.ps1 -TestParam %windir%`

In contrast, running `pwsh -File .\test.ps1 -TestParam $env:windir` in
`cmd.exe` results in the script receiving the literal string `$env:windir`
because it has no special meaning to the current `cmd.exe` shell. The
`$env:windir` style of environment variable reference _can_ be used inside a
**Command** parameter, since there it is interpreted as PowerShell code.

Similarly, if you want to execute the same command from a _Batch script_, you
would use `%~dp0` instead of `.\` or `$PSScriptRoot` to represent the current
execution directory: `pwsh -File %~dp0test.ps1 -TestParam %windir%`. If you
instead used `.\test.ps1`, PowerShell would throw an error because it cannot
find the literal path `.\test.ps1`

When the script file terminates with an `exit` command, the process exit code
is set to the numeric argument used with the `exit` command. With normal
termination, the exit code is always `0`.

Similar to `-Command`, when a script-terminating error occurs, the exit code is
set to `1`. However, unlike with `-Command`, when the execution is interrupted
with <kbd>Ctrl</kbd>-<kbd>C</kbd> the exit code is `0`.

### -Command | -c

Executes the specified commands (and any parameters) as though they were typed
at the PowerShell command prompt, and then exits, unless the `NoExit`
parameter is specified.

The value of **Command** can be `-`, a script block, or a string. If the value
of **Command** is `-`, the command text is read from standard input.

The **Command** parameter only accepts a script block for execution when it can
recognize the value passed to **Command** as a **ScriptBlock** type. This is
_only_ possible when running `pwsh` from another PowerShell host. The
**ScriptBlock** type may be contained in an existing variable, returned from an
expression, or parsed by the PowerShell host as a literal script block enclosed
in curly braces (`{}`), before being passed to `pwsh`.

```powershell
pwsh -Command {Get-WinEvent -LogName security}
```

In `cmd.exe`, there is no such thing as a script block (or **ScriptBlock**
type), so the value passed to **Command** will _always_ be a string. You can
write a script block inside the string, but instead of being executed it will
behave exactly as though you typed it at a typical PowerShell prompt, printing
the contents of the script block back out to you.

A string passed to **Command** is still executed as PowerShell code, so the
script block curly braces are often not required in the first place when
running from `cmd.exe`. To execute an inline script block defined inside a
string, the [call operator](about_operators.md#special-operators) `&` can be
used:

```
pwsh -Command "& {Get-WinEvent -LogName security}"
```

If the value of **Command** is a string, **Command** must be the last parameter
for pwsh, because all arguments following it are interpreted as part of the
command to execute.

When called from within an existing PowerShell session, the results are
returned to the parent shell as deserialized XML objects, not live objects. For
other shells, the results are returned as strings.

If the value of **Command** is `-`, the command text is read from standard
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

The process exit code is determined by status of the last (executed) command
within the script block. The exit code is `0` when `$?` is `$true` or `1` when
`$?` is `$false`. If the last command is an external program or a PowerShell
script that explicitly sets an exit code other than `0` or `1`, that exit code
is converted to `1` for process exit code. To preserve the specific exit code,
add `exit $LASTEXITCODE` to your command string or script block.

Similarly, the value 1 is returned when a script-terminating
(runspace-terminating) error, such as a `throw` or `-ErrorAction Stop`, occurs
or when execution is interrupted with <kbd>Ctrl</kbd>-<kbd>C</kbd>.

### -ConfigurationName | -config

Specifies a configuration endpoint in which PowerShell is run. This can be any
endpoint registered on the local machine including the default PowerShell
remoting endpoints or a custom endpoint having specific user role capabilities.

Example: `pwsh -ConfigurationName AdminRoles`

### -CustomPipeName

Specifies the name to use for an additional IPC server (named pipe) used for
debugging and other cross-process communication. This offers a predictable
mechanism for connecting to other PowerShell instances. Typically used with the
**CustomPipeName** parameter on `Enter-PSHostProcess`.

This parameter was introduced in PowerShell 6.2.

For example:

```powershell
# PowerShell instance 1
pwsh -CustomPipeName mydebugpipe
# PowerShell instance 2
Enter-PSHostProcess -CustomPipeName mydebugpipe
```

### -EncodedCommand | -e | -ec

Accepts a Base64-encoded string version of a command. Use this parameter to
submit commands to PowerShell that require complex, nested quoting. The Base64
representation must be a UTF-16 encoded string.

For example:

```powershell
$command = 'dir "c:\program files" '
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
pwsh -encodedcommand $encodedCommand
```

### -ExecutionPolicy | -ex | -ep

Sets the default execution policy for the current session and saves it in the
`$env:PSExecutionPolicyPreference` environment variable. This parameter does
not change the persistently configured execution policies.

This parameter only applies to Windows computers. The
`$env:PSExecutionPolicyPreference` environment variable does not exist on
non-Windows platforms.

### -InputFormat | -in | -if

Describes the format of data sent to PowerShell. Valid values are "Text" (text
strings) or "XML" (serialized CLIXML format).

### -Interactive | -i

Present an interactive prompt to the user. Inverse for NonInteractive
parameter.

### -NoExit | -noe

Does not exit after running startup commands.

Example: `pwsh -NoExit -Command Get-Date`

### -NoLogo | -nol

Hides the copyright banner at startup of interactive sessions.

### -NonInteractive | -noni

Does not present an interactive prompt to the user. Any attempts to use
interactive features, like `Read-Host` or confirmation prompts, result in
statement-terminating errors.

### -NoProfile | -nop

Does not load the PowerShell profiles.

### -OutputFormat | -o | -of

Determines how output from PowerShell is formatted. Valid values are "Text"
(text strings) or "XML" (serialized CLIXML format).

Example: `pwsh -o XML -c Get-Date`

When called withing a PowerShell session, you get deserialized objects as
output rather plain strings. When called from other shells, the output is
string data formatted as CLIXML text.

### -SettingsFile | -settings

Overrides the system-wide `powershell.config.json` settings file for the
session. By default, system-wide settings are read from the
`powershell.config.json` in the `$PSHOME` directory.

Note that these settings are not used by the endpoint specified by the
`-ConfigurationName` argument.

Example: `pwsh -SettingsFile c:\myproject\powershell.config.json`

### -SSHServerMode | -sshs

Used in sshd_config for running PowerShell as an SSH subsystem. It is not
intended or supported for any other use.

### -Version | -v

Displays the version of PowerShell. Additional parameters are ignored.

### -WindowStyle | -w

Sets the window style for the session. Valid values are Normal, Minimized,
Maximized and Hidden.

### -WorkingDirectory | -wd

Sets the initial working directory by executing at startup. Any valid
PowerShell file path is supported.

To start PowerShell in your home directory, use: `pwsh -WorkingDirectory ~`

### -Help, -?, /?

Displays help for `pwsh`. If you are typing a pwsh command in PowerShell,
prepend the command parameters with a hyphen (`-`), not a forward slash (`/`).
