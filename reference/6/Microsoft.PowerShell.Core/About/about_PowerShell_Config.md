---
ms.date:  11/02/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell
title:  about_PowerShell_Config
---

# About PowerShell Config

## SHORT DESCRIPTION

Cross-platform configuration files for PowerShell Core.

## LONG DESCRIPTION

A `powershell.config.json` is a JSON-format file allowing configuration of
installation-wide settings in PowerShell Core.
It is read in and used when PowerShell starts up,
but is also modified at runtime by PowerShell.
These settings were previously configured
in the Windows Registry in Windows PowerShell.

> [!WARNING]
> A `powershell.config.json` file that contains invalid JSON
> or unsupported keys or values will result in not being able
> to start an interactive PowerShell session.
> If this occurs, you will need to fix the configuration file
> from another application to run PowerShell.

### System-wide configuration

A `powershell.config.json` file in the `$PSHOME` directory will apply
to all PowerShell Core sessions running for that PowerShell Core
installation.

> [!NOTE]
> The system `powershell.config.json` location is defined as
> the same directory as the executing System.Management.Automation.dll
> assembly. This applies to hosted PowerShell SDK instances as well.

### User configurations

Configuration of PowerShell can also be provided on a per-user basis.
This applies configuration settings to a specific user.
For this, the configuration file can be found in the user-scope
configuration directory.
On Windows this is `$env:LocalAppData\Microsoft\powershell`,
on UNIX-like platforms this is `$HOME/.config/powershell/`.

> [!TIP]
> The user configuration directory can be found across platforms
> with the command `Split-Path $PROFILE`.

## General configuration settings

### ExecutionPolicy

Configures the execution policy for PowerShell sessions,
determining what scripts can be run.
See [About Execution Policies](./about_Execution_Policies.md).

> [!NOTE]
> The [`Set-ExecutionPolicy`](../../Microsoft.PowerShell.Security/Set-ExecutionPolicy.md)
> cmdlet will modify this setting in the configuration file.

```Schema
"<shell-id>:ExecutionPolicy": "<execution-policy>"
```

Where:

- `<shell-id>` refers to the ID of the current PowerShell host.
  For normal PowerShell Core, this is `Microsoft.PowerShell`.
  In any PowerShell session, you can discover it with `$ShellId`.
  See also [About Automatic Variables](./about_Automatic_Variables.md).
- `<execution-policy>` refers to a valid execution policy name,
  as described in [About Execution Policies](./about_Execution_Policies.md).

#### Default setting

Uses the existing execution policy for the platform.
See [About Execution Policies](./about_Execution_Policies.md).

#### Example

This sets the execution policy of PowerShell to `RemoteSigned`.

```json
{
  "Microsoft.PowerShell.ExecutionPolicy": "RemoteSigned"
}
```

#### Equivalent registry key in Windows PowerShell

```
HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
-AND-
HKCU\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
```

### ModulePath

Sets the **PSModulePath** environment variable when
PowerShell starts up.

```Schema
"PSModulePath": "<ps-module-path>"
```

Where:

- `<ps-module-path>` is the **PSModulePath**
  value you would use for `$env:PSModulePath`.

#### Default setting

```
$env:ProgramFiles/PowerShell/Modules
```

#### Examples

This is a simple PSModulePath configuration
in a Windows environment:

```json
{
  "PSModulePath": "C:\\Users\\Bruce McNamara\\PowerShell\\Modules;C:\\Program Files\\PowerShell\\6\\Modules"
}
```

This is a simple PSModulePath configuration
in a macOS or Linux environment:

```json
{
  "PSModulePath": "/home/me/.local/share/powershell/Modules:/opt/powershell/6/Modules"
}
```

> [!NOTE]
> When configuring the module path in this way,
> you should use the appropriate directory and path separator characters for the platform.
> You can discover these from PowerShell:
>
> - Directory separator character: `[System.IO.Path]::DirectorySeparatorChar`
> - Path separator character: `[System.IO.Path]::PathSeparator`

#### Equivalent registry key in Windows PowerShell

```
HKLM:\System\CurrentControlSet\Control\Session Manager\Environment
```

### ExperimentalFeatures

The names of the experimental features to enable in PowerShell.
Include experimental feature names here to ensure they are
in effect when PowerShell starts up.

For more information on experimental features,
see [PowerShell RFC 29](https://github.com/PowerShell/PowerShell-RFC/blob/master/5-Final/RFC0029-Support-Experimental-Features.md).

```Schema
"ExperimentalFeatures": ["<experimental-feature-name>", ...]
```

Where:

- `<experimental-feature-name>` is the name of an experimental feature to enable.

#### Default setting

An empty array (`[]`);
no experimental features are enabled in Powershell by default.

#### Example

This setting enables the `PSImplicitRemoting`
and `PSUseAbbreviationExpansion` experimental features
when PowerShell starts up.

```json
{
  "ExperimentalFeatures": [
    "PSImplicitRemotingBatching",
    "PSUseAbbreviationExpansion"
  ]
}
```

## Non-Windows logging configuration

> [!IMPORTANT]
> The configuration options in this section only apply to macOS and Linux.
> Logging configuration on Windows is handled by the ETW Event Viewer.

PowerShell's logging on macOS and Linux can be configured
in the PowerShell configuration file.
For a full description of logging in PowerShell, see [About Logging](./about_Logging.md).
More information on logging configuration on non-Windows platforms
can be found in [About Logging - Configuring Logging on non-Windows system](./about_Logging.md#configuring-logging-on-non-windows-system).

### LogIdentity

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

Sets the identity name used to write to the system log.

```Schema
"LogIdentity": "<log-identity>"
```

Where:

- `<log-identity>` is the string identity that PowerShell should use
  for writing to syslog.

#### Default setting

```
"powershell"
```

#### Example

```json
{
  "LogIdentity": "powershell-preview"
}
```

### LogLevel

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

Specifies the minimum severity level at which PowerShell should log.

```Schema
"LogLevel": "<log-level>|default"
```

Where:

- `<log-level>` is one of:
  - `Always`
  - `Critical`
  - `Error`
  - `Warning`
  - `Informational`
  - `Verbose`
  - `Debug`

> [!NOTE]
> Setting a given log level in the list
> will enable all log levels above it.

Setting this setting to `"default"` will be interpreted as the default value.

#### Default setting

```
"Informational"
```

#### Example

```json
{
  "LogLevel": "Verbose"
}
```

### LogChannels

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

Determines which logging channels are enabled.

```Schema
"LogChannels": "<log-channel>,..."
```

Where:

- `<log-channel>` is one of:
  - `Operational` (logs ordinary information about what PowerShell is doing)
  - `Analytic` (intended for more diagnostic usage)

Values for this field should be included in the same
string and separated by a comma (`,`).

#### Default setting

```
"Operational"
```

#### Example

```json
{
  "LogChannels": "Operational,Analytic"
}
```

### LogKeywords

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

> [!NOTE]
> It is generally advised to leave this value unset
> unless you are trying to diagnose a specific behavior
> in a known part of PowerShell's functionality.
> Setting this value can only decrease the amount of information logged.

Sets which log keywords should be enabled.
This allows control over which parts of PowerShell are logged and which are not.

```Schema
"LogKeywords": "<log-keyword>,..."
```

Where:

- `<log-keyword>` is one of:
  - `Runspace` (runspace management)
  - `Pipeline` (pipeline operations)
  - `Protocol` (communication protocol handling, such as PSRP)
  - `Transport` (transport layer support, such as SSH)
  - `Host` (PowerShell host functionality, for example console interaction)
  - `Cmdlets` (PowerShell builtin cmdlets)
  - `Serializer` (serialization logic)
  - `Session` (PowerShell session state)
  - `ManagedPlugin` (WSMan plugin)

Values for this field should be composed within the string with a comma (`,`).

#### Default value

The default value for this field is all keywords:

```
"Runspace,Pipeline,Protocol,Transport,Host,Cmdlets,Serializer,Session,ManagedPlugin"
```

#### Example

This setting will mean that only logging from
runspace operations, pipeline logic and cmdlet use
will be written to the logs.
All other logging will be omitted.

```json
"LogKeywords": "Runspace,Pipeline,Cmdlets"
```

<!--
## Group policy configuration

### ScriptExecution

### ScriptBlockLogging

### ProtectedEventLogging

### Transcription

### UpdateableHelp

### ConsoleSessionConfiguration

-->

### Example Configurations
