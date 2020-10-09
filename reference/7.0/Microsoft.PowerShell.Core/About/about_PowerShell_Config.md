---
description: Configuration files for PowerShell Core, replacing Registry configuration. 
keywords: powershell
Locale: en-US
ms.date: 11/02/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PowerShell_Config
---
# About PowerShell Config

## SHORT DESCRIPTION
Configuration files for PowerShell Core, replacing Registry configuration.

## LONG DESCRIPTION

The `powershell.config.json` file contains configuration settings for
PowerShell Core. PowerShell loads this configuration at startup. The settings
can also be modified at runtime. Previously, these settings were stored in the
Windows Registry for PowerShell, but are now contained in a file to
enable configuration on macOS and Linux.

> [!WARNING]
> If the `powershell.config.json` file contains invalid JSON
> PowerShell cannot start an interactive session.
> If this occurs, you must fix the configuration file.

> [!NOTE]
> Unrecognized keys or invalid values in the configuration file
> will be silently ignored.

### AllUsers (shared) configuration

A `powershell.config.json` file in the `$PSHOME` directory defines the
configuration for all PowerShell Core sessions running from that PowerShell
Core installation.

> [!NOTE]
> The `$PSHOME` location is defined as
> the same directory as the executing System.Management.Automation.dll
> assembly. This applies to hosted PowerShell SDK instances as well.

### CurrentUser (per-user) configurations

You can also configure PowerShell on a per-user basis by placing the file in
the user-scope configuration directory. The user configuration directory can
be found across platforms with the command
`Split-Path $PROFILE.CurrentUserCurrentHost`.

## General configuration settings

### ExecutionPolicy

> [!IMPORTANT]
> This configuration only applies on Windows platforms.

Configures the execution policy for PowerShell sessions, determining what
scripts can be run. By default, PowerShell uses the existing execution policy.

For AllUsers configurations, this sets the **LocalMachine** execution policy.
For CurrentUser configurations, this sets the **CurrentUser** execution policy.

> [!NOTE]
> The [`Set-ExecutionPolicy`](xref:Microsoft.PowerShell.Security.Set-ExecutionPolicy)
> cmdlet modifies this setting in the AllUsers configuration file
> when invoked with `-Scope LocalMachine`,
> and modifies this setting in the CurrentUser configuration file
> when invoked with `-Scope CurrentUser`.

```Schema
"<shell-id>:ExecutionPolicy": "<execution-policy>"
```

Where:

- `<shell-id>` refers to the ID of the current PowerShell host.
  For normal PowerShell Core, this is `Microsoft.PowerShell`.
  In any PowerShell session, you can discover it with `$ShellId`.
- `<execution-policy>` refers to a valid execution policy name.

The following example sets the execution policy of PowerShell to `RemoteSigned`.

```json
{
  "Microsoft.PowerShell.ExecutionPolicy": "RemoteSigned"
}
```

In Windows, the equivalent registry keys can be found in
`\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell` under
`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`.

### PSModulePath

Overrides a PSModulePath component for this PowerShell session. If the
configuration is for the current user, sets the CurrentUser module path. If
the configuration is for all users, sets the AllUser module path.

> [!WARNING]
> Configuring an AllUsers or CurrentUser module path here
> will not change the scoped installation location for PowerShellGet modules like [Install-Module](/powershell/module/powershellget/install-module).
> These cmdlets always use the *default* module paths.

If no value is set, the default value for the respective module path component
will be used. See
[about_Modules](./about_Modules.md#module-and-dsc-resource-locations-and-psmodulepath)
for more details on these defaults.

This setting allows environment variables to be used by embedding them between
`%` characters, like `"%HOME%\Documents\PowerShell\Modules"`, in the same way
as CMD allows. This syntax also applies on Linux and macOS. See below for
examples.

```Schema
"PSModulePath": "<ps-module-path>"
```

Where:

- `<ps-module-path>` is the absolute path to a module directory. For all user
  configurations, this is the AllUsers shared module directory. For current
  user configurations, this is CurrentUser module directory.

This example shows a PSModulePath configuration for a Windows environment:

```json
{
  "PSModulePath": "C:\\Program Files\\PowerShell\\6\\Modules"
}
```

This example shows a PSModulePath configuration for a macOS or Linux
environment:

```json
{
  "PSModulePath": "/opt/powershell/6/Modules"
}
```

This example shows embedding an environment variable in a PSModulePath
configuration. Note that using the `HOME` environment variable and the `/`
directory separator, this will work on Windows, macOS and Linux.

```json
{
  "PSModulePath": "%HOME%/Documents/PowerShell/Modules"
}
```

This example shows embedding an environment variable in a PSModulePath
configuration that will only work on macOS and Linux:

```json
{
  "PSModulePath": "%XDG_CONFIG_HOME%/powershell/Modules"
}
```

> [!NOTE]
> PowerShell variables cannot be embedded in PSModulePath configurations.
> PSModulePath configurations on Linux and macOS are case-sensitive. A
> PSModulePath configuration must use valid directory separators for the
> platform. On macOS and Linux, this means `/`. On Windows, both `/` and `\`
> will work.

### ExperimentalFeatures

The names of the experimental features to enable in PowerShell.
By default, no experimental features are enabled.
The default value is an empty array.

```Schema
"ExperimentalFeatures": ["<experimental-feature-name>", ...]
```

Where:

- `<experimental-feature-name>` is the name of an experimental feature to
  enable.

The following example enables the **PSImplicitRemoting**
and **PSUseAbbreviationExpansion** experimental features
when PowerShell starts up.

```json
{
  "ExperimentalFeatures": [
    "PSImplicitRemotingBatching",
    "PSUseAbbreviationExpansion"
  ]
}
```

For more information on experimental features, see [PowerShell RFC 29][RFC0029].

## Non-Windows logging configuration

> [!IMPORTANT]
> The configuration options in this section only apply to macOS and Linux.
> Logging for Windows is managed by the Windows Event Viewer.

PowerShell's logging on macOS and Linux can be configured in the PowerShell
configuration file. For a full description of PowerShell logging for
non-Windows systems, see [About Logging](./about_Logging_Non-Windows.md).

### LogIdentity

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

Sets the identity name used to write to the system log. The default value is
"powershell".

```Schema
"LogIdentity": "<log-identity>"
```

Where:

- `<log-identity>` is the string identity that PowerShell should use
  for writing to syslog.

> [!NOTE]
> You may want to have different **LogIdentity** values for each different
> instance of PowerShell you have installed.

In this example, we are configuring the **LogIdentity** for a preview
release of PowerShell.

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
  - Always
  - Critical
  - Error
  - Warning
  - Informational
  - Verbose
  - Debug

> [!NOTE]
> Setting a the log level enables all log levels above it.

Setting this setting to **default** will be interpreted as the default value.
The default value is **Informational**.

The following example sets the value to **Verbose**.

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
  - Operational - logs basic information about PowerShell activities
  - Analytic - logs more detailed diagnostic information

The default value is **Operational**. To enable both channels, include both
values as a single comma-separated string. For example:

```json
{
  "LogChannels": "Operational,Analytic"
}
```

### LogKeywords

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

Determines which parts of PowerShell are logged. By default, all log keywords
are enabled. To enable multiple keywords, list the values in a single
comma-separated string.

```Schema
"LogKeywords": "<log-keyword>,..."
```

Where:

- `<log-keyword>` is one of:
  - Runspace - runspace management
  - Pipeline - pipeline operations
  - Protocol - communication protocol handling, such as PSRP
  - Transport - transport layer support, such as SSH
  - Host - PowerShell host functionality, for example console interaction
  - Cmdlets -PowerShell builtin cmdlets
  - Serializer - serialization logic
  - Session - PowerShell session state
  - ManagedPlugin - WSMan plugin

> [!NOTE]
> It is generally advised to leave this value unset
> unless you are trying to diagnose a specific behavior
> in a known part of PowerShell.
> Changing this value only decreases the amount of information logged.

This example limits the logging to runspace operations, pipeline logic, and
cmdlet use. All other logging will be omitted.

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

## More example configurations

### Example Windows configuration

This configuration has more settings explicitly set:

- Execution policy for this PowerShell installation is `AllSigned`
- The CurrentUser module path is set to a module directory on a shared drive
- The `PSImplicitRemotingBatching` experimental feature is enabled

> [!NOTE]
> The `ExecutionPolicy` and `PSModulePath` settings here would only work on a
> Windows platform, since the module path uses `\` and `;` separator characters
> and the execution policy is not `Unrestricted` (the only policy allowed on
> UNIX-like platforms).

```json
{
  "Microsoft.PowerShell.ExecutionPolicy": "AllSigned",
  "PSModulePath": "Z:\\Marisol's Shared Drive\\Modules",
  "ExperimentalFeatures": ["PSImplicitRemotingBatching"],
}
```

### Example non-Windows configuration

This configuration sets a number of options that only work in macOS or Linux:

- The CurrentUser module path is set to a custom module directory in `$HOME`
- The **PSImplicitRemotingBatching** experimental feature is enabled
- The PowerShell logging level is set to **Verbose**, for more logging
- This PowerShell installation writes to the logs using the **home-powershell**
  identity.

```json
{
  "PSModulePath": "%HOME%/.powershell/Modules",
  "ExperimentalFeatures": ["PSImplicitRemotingBatching"],
  "LogLevel": "Verbose",
  "LogIdentity": "home-powershell"
}
```

## See also

[About Execution Policies](./about_Execution_Policies.md)

[About Automatic Variables](./about_Automatic_Variables.md)

[RFC0029]: https://github.com/PowerShell/PowerShell-RFC/blob/master/5-Final/RFC0029-Support-Experimental-Features.md
