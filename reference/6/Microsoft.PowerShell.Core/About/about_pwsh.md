---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_PowerShell_exe
---
# About pwsh

## SHORT DESCRIPTION
Explains how to use the pwsh command-line tool. Displays the syntax and
describes the command-line switches.

pwsh starts a PowerShell session.

## LONG DESCRIPTION

## SYNTAX

```
pwsh[.exe]
[-Version]
[-ConfigurationName]
[-EncodedCommand <Base64EncodedCommand>]
[-ExecutionPolicy <ExecutionPolicy>]
[-InputFormat {Text | XML}]
[-NoExit]
[-NoLogo]
[-NonInteractive]
[-NoProfile]
[-OutputFormat {Text | XML}]
[-SettingsFile <SettingFilePath>]
[-WindowStyle <style>]
[-WorkingDirectory <DirectoryPath>]
[-File <FilePath> [<Args>]]
[-Command { - | <script-block> [-args <arg-array>]
| <string> [<CommandParameters>] } ]
pwsh[.exe] -Help | -? | /?
```

### PARAMETERS

#### -Version

Displays the version of PowerShell. Additional parameters are ignored.

#### -ConfigurationName <ConfigurationName>

Specifies a configuration endpoint in which PowerShell is run.
This can be any endpoint registered on the local machine including the default PowerShell
remoting endpoints or a custom endpoint having specific user role capabilities.

#### -EncodedCommand <Base64EncodedCommand>

Accepts a base-64-encoded string version of a command. Use this parameter to
submit commands to PowerShell that require complex quotation marks or curly
braces.

#### -ExecutionPolicy <ExecutionPolicy>

Sets the default execution policy for the current session and saves it in the
$env:PSExecutionPolicyPreference environment variable. This parameter does not
change the PowerShell execution policy that is set in the registry.

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

Describes the format of data sent to PowerShell. Valid values are "Text" (text
strings) or "XML" (serialized CLIXML format).

#### -NoExit

Does not exit after running startup commands.

#### -NoLogo

Hides the copyright banner at startup.

#### -NonInteractive

Does not present an interactive prompt to the user.

#### -NoProfile

Does not load the PowerShell profile.

#### -OutputFormat {Text | XML}

Determines how output from PowerShell is formatted. Valid values are "Text"
(text strings) or "XML" (serialized CLIXML format).

#### -SettingsFile <SettingsFilePath>

Overrides the system-wide `powershell.config.json` settings file for the session.
By default, system-wide settings are read from the `powershell.config.json`
in the `$PSHOME` directory.

Note that these settings are not used by the endpoint specified
by the `-ConfigurationName` argument.

#### -WindowStyle <Window style>

Sets the window style for the session. Valid values are Normal, Minimized,
Maximized and Hidden.

#### -WorkingDirectory <DirectoryPath>

Sets the initial working directory when starting PowerShell.  Any valid
PowerShell file path is supported.

To start PowerShell in your home directory, use: pwsh -WorkingDirectory ~

#### -Command

Executes the specified commands (and any parameters) as though they were typed
at the PowerShell command prompt, and then exits, unless the NoExit parameter
is specified.

The value of Command can be "-", a script block, or a string. If the value of
Command is "-", the command text is read from standard input.

Script blocks must be enclosed in braces ({}). You can specify a script block
only when running pwsh in PowerShell. If you want to use a script block when
running from another shell you must use the format:

"& {\<command\>}"

where the quotation marks indicate a string and the invoke operator (&) causes
the command to be executed.

If the value of Command is a string, Command must be the last parameter for
pwsh, because all arguments following it are interpreted as being part of the
command to execute.

The results are returned to the parent shell as deserialized XML objects, not
live objects.

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
```