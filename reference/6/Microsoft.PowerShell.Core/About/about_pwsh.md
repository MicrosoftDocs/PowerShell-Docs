---
ms.date:  05/02/2019
schema:  2.0.0
keywords:  powershell,cmdlet
title:  about_pwsh
---
# About pwsh

## SHORT DESCRIPTION
Explains how to use the **pwsh** command-line tool. Displays the syntax and
describes the command-line switches.

pwsh starts a PowerShell session.

## LONG DESCRIPTION

## SYNTAX

```
pwsh[.exe]
   [[-File] <filePath> [args]]
   [-Command - | { <script-block> [-args <arg-array>] }
               | { <string> [<CommandParameters>] } ]
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

### PARAMETERS

All parameters are case-insensitive.

#### -File | -f

If the value of **File** is "-", the command text is read from standard input.
Running `pwsh -File -` without redirected standard input starts a regular
session. This is the same as not specifying the **File** parameter at all.

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

In rare cases, you might need to provide a Boolean value for a switch
parameter. To provide a Boolean value for a switch parameter in the value of
the File parameter, enclose the parameter name and value in curly braces, such
as the following: `-File .\Get-Script.ps1 {-All:$False}.`

Parameters passed to the script are passed as literal strings, after
interpretation by the current shell. For example, if you are in **cmd.exe** and
want to pass an environment variable value, you would use the **cmd.exe**
syntax: `pwsh -File .\test.ps1 -TestParam %windir%`

In contrast, running `pwsh -File .\test.ps1 -TestParam $env:windir`
in **cmd.exe** results in the script receiving the literal string `$env:windir`
because it has no special meaning to the current **cmd.exe** shell. The
`$env:windir` style of environment variable reference _can_ be used inside a
**Command** parameter, since there it will be interpreted as PowerShell code.

#### -Command | -c

Executes the specified commands (and any parameters) as though they were typed
at the PowerShell command prompt, and then exits, unless the **NoExit**
parameter is specified.

The value of **Command** can be "-", a script block, or a string. If the value
of **Command** is "-", the command text is read from standard input.

The **Command** parameter only accepts a script block for execution when it can
recognize the value passed to **Command** as a **ScriptBlock** type. This is
_only_ possible when running **pwsh** from another PowerShell host. The
**ScriptBlock** type may be contained in an existing variable, returned from an
expression, or parsed by the PowerShell host as a literal script block enclosed
in curly braces `{}`, before being passed to **pwsh**.

In **cmd.exe**, there is no such thing as a script block (or **ScriptBlock**
type), so the value passed to **Command** will _always_ be a string. You can
write a script block inside the string, but instead of being executed it will
behave exactly as though you typed it at a typical PowerShell prompt, printing
the contents of the script block back out to you.

A string passed to **Command** will still be executed as PowerShell, so the
script block curly braces are often not required in the first place when
running from **cmd.exe**. To execute an inline script block defined inside a
string, the [call operator](about_operators.md#special-operators) `&` can be used:

```
pwsh -Command "& {Get-WinEvent -LogName security}"
```

If the value of **Command** is a string, **Command** must be the last parameter
for pwsh, because all arguments following it are interpreted as part of the
command to execute.

The results are returned to the parent shell as deserialized XML objects, not
live objects.

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

#### -ConfigurationName | -config

Specifies a configuration endpoint in which PowerShell is run. This can be any
endpoint registered on the local machine including the default PowerShell
remoting endpoints or a custom endpoint having specific user role capabilities.

Example: `pwsh -ConfigurationName AdminRoles`

#### -CustomPipeName

Specifies the name to use for an additional IPC server (named pipe) used for
debugging and other cross-process communication. This offers a predictable
mechanism for connecting to other PowerShell instances. Typically used with the
**CustomPipeName** parameter on `Enter-PSHostProcess`.

#### -EncodedCommand | -e | -ec

Accepts a base-64-encoded string version of a command. Use this parameter to
submit commands to PowerShell that require complex quotation marks or curly
braces. The string must be formatted using UTF-16 character encoding.

#### -ExecutionPolicy | -ex | -ep

Sets the default execution policy for the current session and saves it in the
$env:PSExecutionPolicyPreference environment variable. This parameter does not
change the PowerShell execution policy that is set in the registry.

#### -InputFormat | -in | -if

Describes the format of data sent to PowerShell. Valid values are "Text" (text
strings) or "XML" (serialized CLIXML format).

#### -Interactive | -i

Present an interactive prompt to the user. Inverse for NonInteractive
parameter.

#### -NoExit | -noe

Does not exit after running startup commands.

Example: `pwsh -NoExit -Command Get-Date`

#### -NoLogo | -nol

Hides the copyright banner at startup.

#### -NonInteractive | -noni

Does not present an interactive prompt to the user.

#### -NoProfile | -nop

Does not load the PowerShell profile.

#### -OutputFormat | -o | -of

Determines how output from PowerShell is formatted. Valid values are "Text"
(text strings) or "XML" (serialized CLIXML format).

Example: `pwsh -o XML -c Get-Date`

#### -SettingsFile | -settings

Overrides the system-wide `powershell.config.json` settings file for the
session. By default, system-wide settings are read from the
`powershell.config.json` in the `$PSHOME` directory.

Note that these settings are not used by the endpoint specified by the
`-ConfigurationName` argument.

Example: `pwsh -SettingsFile c:\myproject\powershell.config.json`

#### -Version | -v

Displays the version of PowerShell. Additional parameters are ignored.

#### -WindowStyle | -w

Sets the window style for the session. Valid values are Normal, Minimized,
Maximized and Hidden.

#### -WorkingDirectory | -wd

Sets the initial working directory when starting PowerShell.  Any valid
PowerShell file path is supported.

To start PowerShell in your home directory, use: `pwsh -WorkingDirectory ~`

#### -Help, -?, /?

Displays help for pwsh. If you are typing a pwsh command in PowerShell,
prepend the command parameters with a hyphen (-), not a forward slash (/). You
can use either a hyphen or forward slash in Cmd.exe.

## EXAMPLES

```powershell
pwsh -Version

# Example using a script block
pwsh -Command {Get-Command -Name Get-Item}

# Example using a string
pwsh -Command "Get-Command -Name Get-Item"
pwsh -Command "& {Get-Command -Name Get-Command}"

# Example using a command as the last parameter
pwsh -Command Get-Command -Name Get-Item

# Example starting in another working directory
pwsh -WorkingDirectory ~/Downloads

# Example specifying a custom settings file
pwsh -SettingsFile ~/powershell.config.json

# Example of specifying a configuration name
pwsh -ConfigurationName AdminRoles

# Example of specifying a custom pipe name
# PowerShell instance 1
pwsh -CustomPipeName mycustompipe
# PowerShell instance 2
Enter-PSHostProcess -CustomPipeName mycustompipe
```
