---
description: PowerShell logs internal operations from the engine, providers, and cmdlets.
Locale: en-US
ms.date: 08/29/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_logging_non-windows?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Logging_Non-Windows
---

# about_Logging_Non-Windows

## Short description

PowerShell logs internal operations from the engine, providers, and cmdlets.

## Long description

PowerShell logs details of PowerShell operations, such as starting and stopping
the engine and starting and stopping providers. It also logs details about
PowerShell commands.

For information about logging in Windows PowerShell 5.1, see
[about_Logging][02].

The location of PowerShell logs is dependent on the target platform.

- On Linux, PowerShell logs to the **systemd journal** that can forward to a
  **syslog** server. For more information, see the `man` pages for your Linux
  distribution.
- On macOS, Apple's unified logging system is used. For more information, see
  [Apple's developer documentation on logging][07].

PowerShell supports configuring two categories of logging:

- Module logging - Record the pipeline execution events for members of
  specified modules. Module logging must be enabled for both the session and
  specific modules. For more information about configuring this logging, see
  [about_PowerShell_Config][05].

  If module logging is enabled through configuration, you can enable and
  disable logging for specific modules in a session by setting the value of the
  **LogPipelineExecutionDetails** property of the module.

  For example, to enable module logging for the **PSReadLine** module:

  ```powershell
  $psrl = Get-Module PSReadLine
  $psrl.LogPipelineExecutionDetails = $true
  Get-Module PSReadLine | Select-Object Name, LogPipelineExecutionDetails
  ```

  ```Output
  Name       LogPipelineExecutionDetails
  ----       ---------------------------
  PSReadLine                        True
  ```

- Script block logging - Record the processing of commands, script blocks,
  functions, and scripts whether invoked interactively, or through automation.

  When you enable Script Block Logging, PowerShell records the content of all
  script blocks that it processes. Once enabled, any new PowerShell session
  logs this information.

  > [!NOTE]
  > It's recommended to enable Protected Event Logging, when using Script Block
  > Logging for anything other than diagnostics purposes. For more information,
  > see [about_PowerShell_Config][06].

## Configuring logging on Linux or macOS

The configuration for logging on Linux and macOS is stored in the
`powershell.config.json` file. The `powershell.config.json` file is a **JSON**
formatted file residing in the PowerShell `$PSHOME` directory. If this
configuration file doesn't exist, you'll need to create it to change the
default settings. Each installation of PowerShell uses its own copy of this
file.

By default, PowerShell enables `Informational` logging to the `Operational`
channel. You can change the configuration if you require additional log output,
such as verbose or enabling analytic log output.

The following code is an example configuration:

```json
{
    "ModuleLogging": {
        "EnableModuleLogging": false,
        "ModuleNames": [
            "PSReadLine",
            "PowerShellGet"
        ]
    },
    "ScriptBlockLogging": {
        "EnableScriptBlockInvocationLogging": true,
        "EnableScriptBlockLogging": true
    },
    "LogLevel": "verbose"
}
```

The following is a list of properties for configuring PowerShell logging. If
the property isn't listed in the configuration, PowerShell uses the default
value.

- **LogIdentity**
  - Values: `<string name>`, `powershell`
  - Description: The name to use when logging. The default identity is
    `powershell`. This value can be used to tell the difference between two
    instances of a PowerShell installation, such as a release and beta version.
    This value is also used to redirect log output to a separate file.
- **LogChannels**
  - Values: `Operational`, `Analytic`
  - Description: The channels to enable. Separate the values with a comma when
    specifying more than one. The default value is `Operational`.
- **LogLevel**
  - Values: `Always`, `Critical`, `Error`, `Warning`, `Informational`,
    `Verbose`, `Debug`
  - Description: Specify a single value. The values are listed in increasing
    order of verbosity. The value you choose enables itself and all the values
    before it. The default value is `Informational`.
- **LogKeywords**
  - Values: `Runspace`, `Pipeline`, `Protocol`, `Transport`, `Host`, `Cmdlets`,
    `Serializer`, `Session`, `ManagedPlugin`
  - Description: Keywords provide the ability to limit logging to specific
    components within PowerShell. By default, all keywords are enabled and
    change this value is only useful for specialized troubleshooting.
- **PowerShellPolicies**
  - Description: The **PowerShellPolicies** setting contains the
    **ModuleLogging**, **ProtectedEventLogging**, and **ScriptBlockLogging**
    options. For more information, see [Common configuration settings][04].

## Viewing PowerShell log data in journald on Linux

PowerShell logs to the **systemd journal** using the **journald** daemon on
Linux distributions such as Ubuntu and Red Hat Enterprise Linux (RHEL).

The **journald** daemon stores log messages in a binary format. Use the
`journalctl` utility to query the journal log for PowerShell entries.

```bash
journalctl --grep powershell
```

The **journald** daemon can forward log messages to a System Logging Protocol
(syslog) server. Enable the `ForwardToSysLog` option in the
`/etc/systemd/journald.conf` **journald** configuration file if you want to
use **syslog** logging on your Linux system. This is the default configuration
for many Linux distributions.

## Viewing PowerShell log data in syslog on Linux

Use the package manager for your Linux distribution to install a **syslog**
server such as **rsyslog** if you want to use syslog logging on your Linux
system. Some Linux distributions such as Ubuntu preinstall **rsyslog**.

The syslog protocol stores log messages in a standardized text format. You
can use any text processing utility to query or view **syslog** content.

By default, **syslog** writes log entries to the following location:

- On Debian-based distributions, including Ubuntu: `/var/log/syslog`
- On RHEL-based distributions: `/var/log/messages`

The following example uses the `cat` command to query for PowerShell **syslog**
entries on Ubuntu.

```bash
cat /var/log/syslog | grep -i powershell
```

### Syslog message format

Syslog messages have the following format:

```Syntax
TIMESTAMP MACHINENAME powershell[PID]: (COMMITID:TID:CID)
  [EVENTID:TASK.OPCODE.LEVEL] MESSAGE
```

- **TIMESTAMP** - A date/time when the log entry was produced.
- **MACHINENAME** - The name of the system where the log was produced.
- **PID** - The process ID of the process that wrote the log entry.
- **COMMITID** - The **git commit** ID or tag used to produce the build.
- **TID** - The thread ID of the thread that wrote the log entry.
- **CID** - The hex channel identifier of the log entry.
  - 0x10 = Operational
  - 0x11 = Analytic
- **EVENTID** - The event identifier of the log entry.
- **TASK** - The task identifier for the event entry
- **OPCODE** - The opcode for the event entry
- **LEVEL** - The log level for the event entry
- **MESSAGE** - The message associated with the event entry

**EVENTID**, **TASK**, **OPCODE**, and **LEVEL** are the same values as used
when logging to the Windows event log.

### Write PowerShell log message to a separate file

It's also possible to redirect the PowerShell log entries to a separate file.
When the PowerShell log entries are redirected to a separate file, they're no
longer logged to the default syslog file.

The following steps configure PowerShell log entries on Ubuntu to write to a
log file named `powershell.log`.

1. Create a config (`conf`) file for the PowerShell log configuration in the
   `/etc/rsyslog.d` directory using a text file editor such as `nano`. Prefix
   the filename with a number that's less than the default. For example,
   `40-powershell.conf` where the default is `50-default.conf`.

   ```bash
   sudo nano /etc/rsyslog.d/40-powershell.conf
   ```

1. Add the following information to the `40-powershell.conf` file:

   ```text
   :syslogtag, contains, "powershell[" /var/log/powershell.log
   & stop
   ```

1. Verify that `/etc/rsyslog.conf` has an include statement for the new file.
   It may have a generic statement that includes it, such as:

   ```text
   $IncludeConfig /etc/rsyslog.d/*.conf
   ```

   If it doesn't, you'll need to add an include statement manually.

1. Verify the attributes and permissions are set appropriately.

   ```bash
   ls -l /etc/rsyslog.d/40-powershell.conf
   ```

   ```Output
   -rw-r--r-- 1 root root   67 Nov 28 12:51 40-powershell.conf
   ```

   If your `40-powershell.conf` file has different ownership or permissions,
   complete the following steps:

   1. Set ownership to **root**.

      ```bash
      sudo chown root:root /etc/rsyslog.d/40-powershell.conf
      ```

   1. Set access permissions: **root** has read/write, **users** have read.

      ```bash
      sudo chmod 644 /etc/rsyslog.d/40-powershell.conf
      ```

1. Restart the **rsyslog** service.

   ```bash
   sudo systemctl restart rsyslog.service
   ```

1. Run `pwsh` to generate PowerShell information to log.

   ```bash
   pwsh
   ```

   > [!NOTE]
   > The `/var/log/powershell.log` file isn't created until the **rsyslog**
   > service is restarted and PowerShell generates information to log.

1. Query the `powershell.log` file to verify PowerShell information is being
   logged to the new file.

   ```powershell
   cat /var/log/powershell.log
   ```

## Viewing PowerShell log data on macOS

PowerShell logs to Apple's unified logging system, a feature of macOS that
allows for the collection and storage of system and application logs in a
single centralized location.

Apple's unified logging system stores log messages in binary format. You must
use the `log` tool to query the unified logging system for PowerShell log
events. The PowerShell log events don't appear in the **Console** application
on macOS. Console app is designed for the older _syslog-based_ logging that
predates the unified logging system.

### Viewing PowerShell log data from the command line on macOS

To view PowerShell log data from a command line on macOS, use the `log` command
in the **Terminal** or other shell host application. These commands can be run
from **PowerShell**, **Z Shell**, or **Bash**.

In the following example, the `log` command is used to show the log data on your
system as it's occurring in realtime. The **process** parameter filters the log
data for only the `pwsh` process. If you have more than one instance of `pwsh`
running, the **process** parameter also accepts a process ID as its value. The
**level** parameter shows messages at the specified level and below.

```powershell
log stream --predicate "subsystem == 'com.microsoft.powershell'" --level info
```

The `log show` command can be used to export log items. The `log show` command
provides options for exporting the last `N` items, items since a given time, or
items within a given time span.

For example, the following command exports items since
`9am on April 5, 2022`:

```powershell
log show --start "2022-04-05 09:00:00" --predicate "subsystem == 'com.microsoft.powershell'"
```

For more information, run `log show --help` to view the help for the `log show`
command.

You can also output the log data in JSON format, which allows you to convert
the event data to PowerShell objects. The following example outputs the events
in JSON format. The `ConvertFrom-Json` cmdlet is used to convert the JSON data
to PowerShell objects are get stored in the `$logRecord` variable.

```powershell
log show --predicate "subsystem == 'com.microsoft.powershell'" --style json |
    ConvertFrom-Json | Set-Variable logRecord
```

You may also want to consider saving the logs to a more secure location such as
[Security Information and Event Management (SIEM)][08] aggregator. Using
Microsoft Defender for Cloud Apps, you can set up SIEM in Azure. For more
information, see [Generic SIEM integration][01].

### Modes and levels of PowerShell log data on macOS

By default, the PowerShell subsystem logs info level messages to memory (mode)
and default level messages to disk (persistence) on macOS. This behavior can be
changed to enable a different mode and level of logging using the `log config`
command.

The following example enables info level logging and persistence for the
PowerShell subsystem:

```powershell
sudo log config --subsystem com.microsoft.powershell --mode level:info,persist:info
```

Use the **reset** parameter to revert the log settings to the defaults for the
PowerShell subsystem:

```powershell
sudo log config --subsystem com.microsoft.powershell --reset
```

## See also

- For Linux **syslog** and **rsyslog.conf** information, refer to the Linux
  computer's local `man` pages
- For macOS **logging** information, see
  [Apple's developer documentation on logging][07]
- For Windows, see [about_Logging_Windows][03]
- [Generic SIEM integration][01]

<!-- link references -->
[01]: /defender-cloud-apps/siem
[02]: /powershell/module/microsoft.powershell.core/about/about_logging?view=powershell-5.1&preserve-view=true
[03]: about_Logging_Windows.md
[04]: about_PowerShell_Config.md#common-configuration-settings
[05]: about_PowerShell_Config.md#modulelogging
[06]: about_PowerShell_Config.md#protectedeventlogging
[07]: https://developer.apple.com/documentation/os/logging
[08]: https://wikipedia.org/wiki/Security_information_and_event_management
