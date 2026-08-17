---
description: Configuration files for PowerShell, replacing Registry configuration.
Locale: en-US
ms.date: 08/17/2026
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_powershell_config?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PowerShell_Config
---
# about_PowerShell_Config

## Short description

Configuration files for PowerShell, replacing Registry configuration.

## Long description

The `powershell.config.json` file contains configuration settings for
PowerShell. PowerShell loads this configuration at startup. The settings can
also be modified at runtime. Not all keys apply to all platforms.

> [!WARNING]
> Unrecognized keys or invalid values in the configuration file are ignored. If
> the `powershell.config.json` file contains invalid JSON, PowerShell can't
> start an interactive session. If this occurs, you must fix the configuration
> file.

## Summary of settings

The `powershell.config.json` file can contain the following keys:

- `DisableImplicitWinCompat`
- `WindowsPowerShellCompatibilityModuleDenyList`
- `WindowsPowerShellCompatibilityNoClobberModuleList`
- `ExperimentalFeatures`
- `LogChannels`
- `LogIdentity`
- `LogKeywords`
- `LogLevel`
- `Microsoft.PowerShell:ExecutionPolicy`
- `PSModulePath`
- `PowerShellPolicies`
  - `ExecutionPolicy`
  - `ConsoleSessionConfiguration`
  - `ModuleLogging`
  - `ProtectedEventLogging`
  - `ScriptBlockLogging`
  - `ScriptExecution`
  - `Transcription`
  - `UpdatableHelp`

## Configuration scope

Configuration settings can be defined for all users or at the individual user
level.

### Scope precedence

Except for a few special cases, settings defined at the **CurrentUser** level
take precedence over settings defined for the **AllUsers** level.

On Windows systems:

- Settings managed by Windows Group Policy take precedence over settings in the
  configuration files.
- Execution Policy support scope level settings.

On all platforms:

- The resulting value of `$env:PSModulePath` is a merge of the values of the
  `PSModulePath` key from both scopes.

### AllUsers (shared) configuration

A `powershell.config.json` file in the `$PSHOME` directory defines the
configuration for all PowerShell sessions running from that PowerShell
installation.

> [!NOTE]
> The `$PSHOME` location is defined as the same directory as the executing
> System.Management.Automation.dll assembly. This applies to hosted PowerShell
> SDK instances as well.

### CurrentUser (per-user) configurations

You can also configure PowerShell on a per-user basis by placing the file in
the user-scope configuration directory. The user configuration directory can be
found across platforms with the following command:

```powershell
Split-Path $PROFILE.CurrentUserCurrentHost
```

## Windows-specific settings

The following settings only apply to Windows platforms.

- `DisableImplicitWinCompat`
- `WindowsPowerShellCompatibilityModuleDenyList`
- `WindowsPowerShellCompatibilityNoClobberModuleList`
- `Microsoft.PowerShell:ExecutionPolicy`
- `PowerShellPolicies`
  - `ScriptExecution`

### DisableImplicitWinCompat

When set to `true`, this setting disables the Windows PowerShell Compatibility
feature. Windows PowerShell Compatibility allows PowerShell 7 to load Windows
PowerShell 5.1 modules in compatibility mode.

For more information, see [about_Windows_PowerShell_Compatibility][10].

### WindowsPowerShellCompatibilityModuleDenyList

This setting is an array of module names that you want to exclude from
participation in the Windows PowerShell Compatibility feature.

For more information, see [about_Windows_PowerShell_Compatibility][10].

### WindowsPowerShellCompatibilityNoClobberModuleList

This setting is an array of module names that shouldn't be clobbered by
loading the Windows PowerShell 5.1 version of the module.

For more information, see [about_Windows_PowerShell_Compatibility][10].

### Microsoft.PowerShell:ExecutionPolicy

Configures the execution policy for PowerShell sessions, determining what
scripts can be run. By default, PowerShell uses the existing execution policy.

For **AllUsers** configurations, this sets the **LocalMachine** execution
policy. For **CurrentUser** configurations, this sets the **CurrentUser**
execution policy.

The following example sets the execution policy of PowerShell to
`RemoteSigned`.

```json
{
  "Microsoft.PowerShell:ExecutionPolicy": "RemoteSigned"
}
```

For more information, see [about_Execution_Policies][01].

## Settings for non-Windows platforms

The following settings only apply to Linux and macOS platforms.

Use the following keys to configure PowerShell's logging for Linux and macOS.

- `LogChannels`
- `LogIdentity`
- `LogKeywords`
- `LogLevel`

For a full description of PowerShell logging for non-Windows systems, see
[about_Logging_Non-Windows][02].

## Common configuration settings

The following settings are available on all supported platforms.

- `ExperimentalFeatures`
- `PSModulePath`
- `PowerShellPolicies`

### ExperimentalFeatures

The names of the experimental features to enable in PowerShell. The default
value is an empty array.

The following example enables the **PSCommandNotFoundSuggestion** and
**PSSubsystemPluginModel** experimental features when PowerShell starts up.

Example:

```json
{
  "ExperimentalFeatures": [
    "PSCommandNotFoundSuggestion",
    "PSSubsystemPluginModel"
  ]
}
```

For more information on experimental features, see
[Using experimental features][05].

### PSModulePath

Overrides the `PSModulePath` settings for this PowerShell session. If the
configuration is for the current user, sets the **CurrentUser** module path. If
the configuration is for all users, sets the **AllUsers** module path.

> [!WARNING]
> Configuring an **AllUsers** or **CurrentUser** module path here doesn't
> change the scoped installation location for PowerShellGet cmdlets like
> [Install-Module][04]. These cmdlets always use the _default_ module paths.

If no value is set, PowerShell uses the default value for the respective module
path setting. For more information about these defaults, see
[about_PSModulePath][03].

This setting allows environment variables to be used by embedding them between
`%` characters, like `"%HOME%\Documents\PowerShell\Modules"`, in the same way
that the Windows Command Shell allows. This syntax also applies on Linux and
macOS. See below for examples.

This example shows a `PSModulePath` configuration for a Windows environment:

```json
{
  "PSModulePath": "C:\\Program Files\\PowerShell\\7\\Modules"
}
```

This example shows a `PSModulePath` configuration for a macOS or Linux
environment:

```json
{
  "PSModulePath": "/opt/powershell/6/Modules"
}
```

This example shows embedding an environment variable in a `PSModulePath`
configuration. Note that using the `HOME` environment variable and the `/`
directory separator, this syntax works on Windows, macOS, and Linux.

```json
{
  "PSModulePath": "%HOME%/Documents/PowerShell/Modules"
}
```

This example uses an environment variable that only works on macOS and Linux:

```json
{
  "PSModulePath": "%XDG_CONFIG_HOME%/powershell/Modules"
}
```

> [!NOTE]
> PowerShell variables can't be embedded in `PSModulePath` configurations.
> `PSModulePath` configurations on Linux and macOS are case-sensitive. A
> `PSModulePath` configuration must use valid directory separators for the
> platform. On macOS and Linux, this means `/`. On Windows, both `/` and `\`
> work.

### PowerShellPolicies

The `PowerShellPolicies` is a JSON object that contains key-value pairs for the
various settings. Except for the `ScriptExecution` setting, all settings can be
used on Windows, Linux, and macOS platforms.

`PowerShellPolicies` contains the following subkeys:

- `ConsoleSessionConfiguration`
- `ModuleLogging`
- `ProtectedEventLogging`
- `ScriptBlockLogging`
- `ScriptExecution`
- `Transcription`
- `UpdatableHelp`

On Windows, these settings can be managed by Windows Group Policy. Group Policy
settings take precedence. If a value isn't set by Group Policy, then PowerShell
applies the values in the JSON file in [scope precedence][07] order.

Group Policy is the recommended way to manage these settings on Windows
systems. For more information, see [about_Group_Policy_Settings][08].

#### ConsoleSessionConfiguration

This setting specifies the session configuration to be used for all PowerShell
sessions. This can be any endpoint registered on the local machine including
the default PowerShell remoting endpoints or a custom endpoint having specific
user role capabilities.

This key contains two subkeys:

- `EnableConsoleSessionConfiguration` - to enable session configurations, set
  the value to `true`. By default, this value is `false`.

- `ConsoleSessionConfigurationName` - Specifies the name of configuration
  endpoint in which PowerShell is run. By default, there is no session defined.

```json
{
  "ConsoleSessionConfiguration": {
    "EnableConsoleSessionConfiguration": false,
    "ConsoleSessionConfigurationName" : []
  }
}
```

For more information, see [about_Session_Configurations][09].

#### ModuleLogging

This setting controls the behavior of logging for PowerShell modules. The
setting contains two subkeys:

- `EnableModuleLogging` - to enable module logging, set the value to
  `true`. When enabled, pipeline execution events for members of the specified
  modules are recorded in the PowerShell log files.
- `ModuleNames` - Specifies the name of the modules that should be logged.

Example:

```json
{
  "ModuleLogging": {
    "EnableModuleLogging": true,
    "ModuleNames" : [
        "PSReadLine",
        "PowerShellGet"
    ]
  }
}
```

#### ProtectedEventLogging

This setting lets you configure Protected Event Logging. The setting contains
two subkeys:

- `EnableProtectedEventLogging` - If you enable this policy setting, components
  that support it use the certificate you supply to encrypt log data before
  writing it to the log. Data is encrypted using the Cryptographic Message
  Syntax (CMS) standard. You can use `Unprotect-CmsMessage` to decrypt these
  encrypted messages, if you have access to the private key of the certificate.
- `EncryptionCertificate` - Provides a list of name of certificates to be used
  for encryption.

Example:

```json
{
  "ProtectedEventLogging": {
    "EnableProtectedEventLogging": false,
    "EncryptionCertificate": [
      "Joe"
    ]
  }
}
```

#### ScriptBlockLogging

This setting controls logging of all PowerShell script input. This setting
contains two subkeys:

- `EnableScriptBlockLogging` - If you enable this policy setting, PowerShell
  logs the processing of commands, scriptblocks, functions, and scripts
  whether invoked interactively, or through automation.
- `EnableScriptBlockInvocationLogging` - enables logging of scriptblock start
  and stop events.

Example:

```json
"ScriptBlockLogging": {
  "EnableScriptBlockInvocationLogging": true,
  "EnableScriptBlockLogging": false
}
```

#### ScriptExecution

The `ScriptExecution` setting is used to set the PowerShell Execution Policy.
This takes precedence over the `Microsoft.PowrShell:ExecutionPolicy` setting
described previously.

Example:

```json
{
    "PowerShellPolicies": {
        "ScriptExecution": {
            "ExecutionPolicy": "RemoteSigned"
        }
    }
}
```

> [!NOTE]
> This is a Windows-only setting.

#### Transcription

This policy setting lets you capture the input and output of PowerShell
commands in text-based transcripts. If you enable this policy setting,
PowerShell enables transcription for all PowerShell sessions.

This setting controls how transcription works in PowerShell. This setting
contains three subkeys:

- `EnableTranscripting` - When this setting is enabled, PowerShell creates
  transcription log files in the configured location.
- `EnableInvocationHeader` - By default, PowerShell includes a header at the
  top of the transcription log file. You can disable the header using this
  setting.
- `OutputDirectory` - This setting allows you to collect transcription log
  files in a central location instead of the default location.

Example:

```json
{
    "Transcription": {
        "EnableTranscripting": true,
        "EnableInvocationHeader": true,
        "OutputDirectory": "C:\\tmp"
      }
}
```

For more information, see [Start-Transcript][11].

#### UpdatableHelp

This policy setting allows you to set the default value of the **SourcePath**
parameter on the `Update-Help` cmdlet. This default value can be overridden by
specifying a different value using the **SourcePath** parameter.

Example:

```json
{
    "UpdatableHelp": {
      "DefaultSourcePath": "F:\\temp"
    }
}
```

<!-- link references -->
[01]: ./about_Execution_Policies.md
[02]: ./about_Logging_Non-Windows.md
[03]: ./about_PSModulePath.md
[04]: /powershell/module/powershellget/install-module
[05]: /powershell/scripting/learn/experimental-features
[07]: #scope-precedence
[08]: about_Group_Policy_Settings.md
[09]: about_Session_Configurations.md
[10]: about_Windows_PowerShell_Compatibility.md
[11]: xref:Microsoft.PowerShell.Host.Start-Transcript
