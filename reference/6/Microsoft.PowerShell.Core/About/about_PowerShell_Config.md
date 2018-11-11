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

## Configuration settings

### ExecutionPolicy

Configures the execution policy for PowerShell sessions,
determining what scripts can be run.
See [About Execution Policies](./about_Execution_Policies.md).

```Schema
"<shell-id>:ExecutionPolicy": "<execution-policy>"
```

Where:

- `<shell-id>` refers to the ID of the current PowerShell host.
  For normal PowerShell Core, this is `"Microsoft.PowerShell"`.
  In any PowerShell session, you can discover it with `$ShellId`.
  See also [About Automatic Variables](./about_Automatic_Variables.md).
- `<execution-policy>` refers to a valid execution policy name,
  as described in [About Execution Policies](./about_Execution_Policies.md).

#### Default setting

Uses the existing execution policy for the platform.
See [About Execution Policies](./about_Execution_Policies.md).

#### Example

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

```json
{
  "PSModulePath": "C:\\Users\\Bruce McNamara\\PowerShell\\Modules"
}
```

```json
{
  "PSModulePath": "/home/me/.local/share/powershell/Modules"
}
```

> [!NOTE]
> You can use `/` or `\` as a directory separator for this value
> just like you would for the `$env:PSModulePath` environment variable.

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

```json
{
  "ExperimentalFeatures": [
    "PSImplicitRemotingBatching",
    "PSUseAbbreviationExpansion"
  ]
}
```

### LogIdentity

> [!IMPORTANT]
> This setting can only be used in macOS and Linux.

Sets the identity name used to write to [syslog](https://en.wikipedia.org/wiki/Syslog).

```Schema
"LogIdentity": "<log-identity>"
```

Where:

- `<log=identity>` is the string identity that PowerShell should use
  for writing to syslog.

#### Default setting

```
"powershell"
```

#### Example

```json
{
  "LogIdentity": "dev-powershell"
}
```

### Example Configurations