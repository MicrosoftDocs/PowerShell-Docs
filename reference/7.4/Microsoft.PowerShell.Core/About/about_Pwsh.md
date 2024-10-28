---
description: Explains how to use the `pwsh` command-line interface. Displays the command-line parameters and describes the syntax.
Locale: en-US
ms.date: 09/02/2024
no-loc: [-File, -f, -Command, -c, -CommandWithArgs, -cwa, -ConfigurationName, -config, -CustomPipeName, -EncodedCommand, -e, -ec, -ExecutionPolicy, -ex, -ep, -InputFormat, -inp, -if, -Interactive, -i, -Login, -l, -MTA, -NoExit, -noe, -NoLogo, -nol, -NonInteractive, -noni, -NoProfile, -nop, -OutputFormat, -o, -of, -SettingsFile, -settings, -SSHServerMode, -sshs, -STA, -Version, -v, -WindowStyle, -w, -WorkingDirectory, -wd, -Help]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pwsh?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Pwsh
---
# about_Pwsh

## Short description
Explains how to use the `pwsh` command-line interface. Displays the
command-line parameters and describes the syntax.

## Long description

For information about the command-line options for Windows PowerShell 5.1, see
[about_PowerShell_exe][01].

## Syntax

```
Usage: pwsh[.exe]
    [-Login]
    [[-File] <filePath> [args]]
    [-Command { - | <script-block> [-args <arg-array>]
                  | <string> [<CommandParameters>] } ]
    [[-CommandWithArgs <string>] [<CommandParameters>]]
    [-ConfigurationFile <filePath>]
    [-ConfigurationName <string>]
    [-CustomPipeName <string>]
    [-EncodedCommand <Base64EncodedCommand>]
    [-ExecutionPolicy <ExecutionPolicy>]
    [-InputFormat {Text | XML}]
    [-Interactive]
    [-MTA]
    [-NoExit]
    [-NoLogo]
    [-NonInteractive]
    [-NoProfile]
    [-NoProfileLoadTime]
    [-OutputFormat {Text | XML}]
    [-SettingsFile <filePath>]
    [-SSHServerMode]
    [-STA]
    [-Version]
    [-WindowStyle <style>]
    [-WorkingDirectory <directoryPath>]

pwsh[.exe] -h | -Help | -? | /?
```

## Parameters

All parameters are case-insensitive.

### -File | -f

The value of **File** can be `-` or a filepath and optional parameters. If the
value of **File** is `-`, then commands are read from standard input.

This is the default parameter if no parameters are present but values are
present in the command line. The specified script runs in the local scope
("dot-sourced") of the new session, so that the functions and variables that
the script creates are available in at new session. Enter the script filepath
and any parameters. File must be the last parameter in the command, because all
characters typed after the File parameter name are interpreted as the script
filepath followed by the script parameters.

Typically, the switch parameters of a script are either included or omitted.
For example, the following command uses the **All** parameter of the
`Get-Script.ps1` script file: `-File .\Get-Script.ps1 -All`

In rare cases, you might need to provide a **Boolean** value for a switch
parameter. To provide a **Boolean** value for a switch parameter in the value
of the **File** parameter, Use the parameter normally followed immediately by a
colon and the boolean value, such as the following:
`-File .\Get-Script.ps1 -All:$False`.

Parameters passed to the script are passed as literal strings, after
interpretation by the current shell. For example, if you are in `cmd.exe` and
want to pass an environment variable value, you would use the `cmd.exe` syntax:
`pwsh -File .\test.ps1 -TestParam %windir%`

In contrast, running `pwsh -File .\test.ps1 -TestParam $env:windir` in
`cmd.exe` results in the script receiving the literal string `$env:windir`
because it has no special meaning to the current `cmd.exe` shell. The
`$env:windir` style of environment variable reference _can_ be used inside a
**Command** parameter, since there it's interpreted as PowerShell code.

Similarly, if you want to execute the same command from a _Batch script_, you
would use `%~dp0` instead of `.\` or `$PSScriptRoot` to represent the current
execution directory: `pwsh -File %~dp0test.ps1 -TestParam %windir%`. If you
use `.\test.ps1` instead, PowerShell throws an error because it can't find the
literal path `.\test.ps1`

> [!NOTE]
> The **File** parameter can't support scripts using a parameter that expects
> an array of argument values. This, unfortunately, is a limitation of how a
> native command gets argument values. When you call a native executable (such
> as `powershell` or `pwsh`), it doesn't know what to do with an array, so
> it's passed as a string.

If the value of **File** is `-`, then commands are read from standard input.
Running `pwsh -File -` without redirected standard input starts a regular
session. This is the same as not specifying the `File` parameter at all. When
reading from standard input, the input statements are executed one statement at
a time as though they were typed at the PowerShell command prompt. If a
statement doesn't parse correctly, the statement isn't executed. The process exit code is
determined by status of the last (executed) command within the input. With
normal termination, the exit code is always `0`. When the script file
terminates with an `exit` command, the process exit code is set to the numeric
argument used with the `exit` command.

Similar to `-Command`, when a script-terminating error occurs, the exit code is
set to `1`. However, unlike with `-Command`, when the execution is interrupted
with <kbd>Ctrl</kbd>+<kbd>C</kbd> the exit code is `0`. For more information,
see `$LASTEXITCODE` in [about_Automatic_Variables][02].

> [!NOTE]
> As of PowerShell 7.2, the **File** parameter only accepts `.ps1` files on
> Windows. If another file type is provided an error is thrown. This behavior
> is Windows specific. On other platforms, PowerShell attempts to run other
> file types.

### -Command | -c

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
type), so the value passed to **Command** is _always_ a string. You can write a
script block inside the string, but instead of being executed it behaves
exactly as though you typed it at a typical PowerShell prompt, printing the
contents of the script block back out to you.

A string passed to **Command** is still executed as PowerShell code, so the
script block curly braces are often not required in the first place when
running from `cmd.exe`. To execute an inline script block defined inside a
string, the [call operator][03] `&` can be used:

```
pwsh -Command "& {Get-WinEvent -LogName security}"
```

If the value of **Command** is a string, **Command** must be the last parameter
for pwsh, because all arguments following it are interpreted as part of the
command to execute.

When called from within an existing PowerShell session, the results are
returned to the parent shell as deserialized XML objects, not live objects. For
other shells, the results are returned as strings.

If the value of **Command** is `-`, the commands are read from standard
input. You must redirect standard input when using the **Command** parameter
with standard input. For example:

```powershell
@'
"in"

"hi" |
  % { "$_ there" }

"out"
'@ | pwsh -NoProfile -Command -
```

This example produces the following output:

```Output
in
hi there
out
```

When reading from standard input, the input is parsed and executed one
statement at a time, as though they were typed at the PowerShell command
prompt. If the input code doesn't parse correctly, the statement isn't
executed. Unless you use the `-NoExit` parameter, the PowerShell session exits
when there is no more input to read from standard input.

The process exit code is determined by status of the last (executed) command
within the input. The exit code is `0` when `$?` is `$true` or `1` when `$?` is
`$false`. If the last command is an external program or a PowerShell script
that explicitly sets an exit code other than `0` or `1`, that exit code is
converted to `1` for process exit code. Similarly, the value 1 is returned when
a script-terminating (runspace-terminating) error, such as a `throw` or
`-ErrorAction Stop`, occurs or when execution is interrupted with
<kbd>Ctrl</kbd>+<kbd>C</kbd>.

To preserve the specific exit code, add `exit $LASTEXITCODE` to your command
string or script block. For more information, see `$LASTEXITCODE` in
[about_Automatic_Variables][02].

### -CommandWithArgs | -cwa

This is an experimental feature added in 7.4.

Executes a PowerShell command with arguments. Unlike `-Command`, this parameter
populates the `$args` built-in variable that can be used by the command.

The first string is the command. Additional strings delimited by whitespace
are the arguments.

For example:

```powershell
pwsh -CommandWithArgs '$args | % { "arg: $_" }' arg1 arg2
```

This example produces the following output:

```Output
arg: arg1
arg: arg2
```

> [!NOTE]
> [Argument parsing with quotes][05] causes the example to fail if run from
> `cmd.exe` or `powershell.exe`. To run from those, you can use

```Cmd
REM Quoting required when run from cmd.exe
pwsh -CommandWithArgs "$args | % { ""arg: $_"" }" arg1 arg2
```

```powershell
# Quoting required when run from powershell.exe
pwsh -CommandWithArgs '"$args | % { ""arg: $_"" }"' arg1 arg2
```

### -ConfigurationName | -config

Specifies a configuration endpoint in which PowerShell is run. This can be any
endpoint registered on the local machine including the default PowerShell
remoting endpoints or a custom endpoint having specific user role capabilities.

Example: `pwsh -ConfigurationName AdminRoles`

### -ConfigurationFile

Specifies a session configuration (`.pssc`) file path. The configuration
contained in the configuration file will be applied to the PowerShell session.

Example: `pwsh -ConfigurationFile "C:\ProgramData\PowerShell\MyConfig.pssc"`

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
representation must be a UTF-16LE encoded string.

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

This parameter only applies to Windows computers. On non-Windows platforms, the
parameter and the value provided are ignored.

### -InputFormat | -inp | -if

Describes the format of data sent to PowerShell. Valid values are "Text" (text
strings) or "XML" (serialized CLIXML format).

### -Interactive | -i

Present an interactive prompt to the user. Inverse for NonInteractive
parameter.

### -Login | -l

On Linux and macOS, starts PowerShell as a login shell,
using /bin/sh to execute login profiles such as /etc/profile and ~/.profile.
On Windows, this switch does nothing.

> [!IMPORTANT]
> This parameter must come first to start PowerShell as a login shell. This
> parameter is ignored if it is passed in another position.

To set up `pwsh` as the login shell on UNIX-like operating systems:

- Verify that the full absolute path to `pwsh` is listed under `/etc/shells`
  - This path is usually something like `/usr/bin/pwsh` on Linux or
    `/usr/local/bin/pwsh` on macOS
  - With some installation methods, this entry will be added automatically at installation time
  - If `pwsh` isn't present in `/etc/shells`, use an editor to append the path
    to `pwsh` on the last line. This requires elevated privileges to edit.
- Use the [chsh][04] utility to set your current
  user's shell to `pwsh`:

  ```sh
  chsh -s /usr/bin/pwsh
  ```

> [!WARNING]
> Setting `pwsh` as the login shell is currently not supported on Windows
> Subsystem for Linux (WSL), and attempting to set `pwsh` as the login shell
> there may lead to being unable to start WSL interactively.

### -MTA

Start PowerShell using a multi-threaded apartment. This switch is only
available on Windows. Using this parameter on non-Windows platforms results in
an error.

### -NoExit | -noe

Doesn't exit after running startup commands.

Example: `pwsh -NoExit -Command Get-Date`

### -NoLogo | -nol

Hides the banner at startup of interactive sessions.

### -NonInteractive | -noni

This switch is used to create sessions that shouldn't require user input. This
is useful for scripts that run in scheduled tasks or CI/CD pipelines. Any
attempts to use interactive features, like `Read-Host` or confirmation prompts,
result in statement terminating errors rather than hanging.

### -NoProfile | -nop

Doesn't load the PowerShell profiles.

### -NoProfileLoadTime

Hides the PowerShell profile load time text shown at startup when the load time
exceeds 500 milliseconds.

### -OutputFormat | -o | -of

Determines how output from PowerShell is formatted. Valid values are "Text"
(text strings) or "XML" (serialized CLIXML format).

Example: `pwsh -o XML -c Get-Date`

When called within a PowerShell session, you get deserialized objects as
output rather plain strings. When called from other shells, the output is
string data formatted as CLIXML text.

### -SettingsFile | -settings

Overrides the system-wide `powershell.config.json` settings file for the
session. By default, system-wide settings are read from the
`powershell.config.json` in the `$PSHOME` directory.

Note that these settings aren't used by the endpoint specified by the
`-ConfigurationName` argument.

Example: `pwsh -SettingsFile c:\myproject\powershell.config.json`

### -SSHServerMode | -sshs

Used in sshd_config for running PowerShell as an SSH subsystem. It isn't
intended or supported for any other use.

### -STA

Start PowerShell using a single-threaded apartment. This is the default. This
switch is only available on the Windows platform. Using this parameter on
non-Windows platforms results in an error.

### -Version | -v

Displays the version of this PowerShell executable. Additional parameters are ignored.

### -WindowStyle | -w

Sets the window style for the session. Valid values are Normal, Minimized,
Maximized and Hidden. This parameter only applies to Windows. Using this
parameter on non-Windows platforms results in an error.

### -WorkingDirectory | -wd | -wo

Sets the initial working directory by executing at startup. Any valid
PowerShell file path is supported.

To start PowerShell in your home directory, use: `pwsh -WorkingDirectory ~`

### -Help, -?, /?

Displays help for `pwsh`. If you are typing a pwsh command in PowerShell,
prepend the command parameters with a hyphen (`-`), not a forward slash (`/`).

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_powershell_exe?view=powershell-5.1&preserve-view=true
[02]: about_Automatic_Variables.md#lastexitcode
[03]: about_operators.md#special-operators
[04]: https://linux.die.net/man/1/chsh
[05]: about_Parsing.md#passing-arguments-that-contain-quote-characters
