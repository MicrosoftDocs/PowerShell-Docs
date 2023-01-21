---
description: PowerShell logs internal operations from the engine, providers, and cmdlets.
Locale: en-US
ms.date: 01/18/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_logging_non-windows?view=powershell-7.3&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Logging Non-Windows
---

# about_Logging_Non-Windows

## Short description
PowerShell logs internal operations from the engine, providers, and cmdlets.

## Long description

PowerShell logs details of PowerShell operations, such as starting and stopping
the engine and starting and stopping providers. It also logs details about
PowerShell commands.

The location of PowerShell logs is dependent on the target platform. On **Linux**,
PowerShell logs to the **systemd journal** that can forward to a **syslog**
server. For more information, see the `man` pages for your Linux distribution.
On **macOS**, the **os_log** logging system is used. For more information, see
[os_log developer documentation](https://developer.apple.com/documentation/os/os_log).

## Viewing PowerShell log output on Linux

PowerShell logs to the systemd journal in binary format using the journald daemon
on Linux distributions such as Ubuntu and Red Hat. The logs can also be forwarded
to a syslog server by the journald daemon and is the default configuration for
many Linux distributions.

### Journald

Unlike text based logs, tools for querying journal logs on Linux must be
designed for reading their binary format.

In the following example, the `journalctl` utility is used to query the journal log
for PowerShell entries.

```
journalctl --grep powershell
```

The main configuration file for journald is `/etc/systemd/journald.conf`.
Other configuration files for journald may exist. The `ForwardToSysLog` option
to forward journald log messages to syslog is located in the journald
configuration file.For more information, see the `man` pages for your Linux
distribution.

### Syslog

Linux distributions such as Ubuntu and Red Hat preinstall the rsyslog System
Logging Protocol (syslog) server by default. Syslog stores log messages in a
standardized text format as shown in the following template. Any text file
utility or tool commonly used to view syslog content can be used to read the logs.

```Syntax
TIMESTAMP MACHINENAME powershell[PID]: (COMMITID:TID:CID)
  [EVENTID:TASK.OPCODE.LEVEL] MESSAGE
```

- **TIMESTAMP** - A date/time when the log entry was produced.
- **MACHINENAME** - The name of the system where the log was produced.
- **PID** - The process ID of the process that wrote the log entry.
- **COMMITID** - The **git commit** ID or tag used to produce the build.
- **TID** - The thread ID of the thread that wrote the log entry.
- **CID** - The hex channel identifier of the log entry. 10 = Operational, 11 =
  Analytic
- **EVENTID** - The event identifier of the log entry.
- **TASK** - The task identifier for the event entry
- **OPCODE** - The opcode for the event entry
- **LEVEL** - The log level for the event entry
- **MESSAGE** - The message associated with the event entry

**EVENTID**, **TASK**, **OPCODE**, and **LEVEL** are the same values as used when
logging to the Windows event log.

By default, PowerShell log entries are written to following default location for
syslog messages:

- `/var/log/syslog` for Debian based distributions including Ubuntu
- `/var/log/messages` for Red Hat based distributions

In the following example, use the `cat` Linux command in a terminal to query the
**syslog** on Ubuntu for PowerShell entries.

```
cat /var/log/syslog | grep -i powershell
```

It's also possible to redirect the PowerShell log entries to a separate file.
When the PowerShell log entries are redirected to a separate file, they're no
longer logged to the default syslog.

The following steps configure PowerShell log entries on Ubuntu to write to a
log file named `powershell.log`.

1. Create a config (`conf`) file for the PowerShell log configuration in the
   `/etc/rsyslog.d` directory using a text file editor such as `nano`. Prefix
   the filename with a number that's less than the default. For example,
   `40-powershell.conf` where the default is `50-default.conf`.

   ```
   sudo nano /etc/rsyslog.d/40-powershell.conf
   ```

1. Add the following information to the `40-powershell.conf` file:

   ```
   :syslogtag, contains, "powershell[" /var/log/powershell.log
   & stop
   ```

1. Verify that `/etc/rsyslog.conf` has an include statement for the new file.
   It may have a generic statement that includes it, such as:

   `$IncludeConfig /etc/rsyslog.d/*.conf`

   If it doesn't, you'll need to add an include statement manually.

1. Verify the attributes and permissions are set appropriately.

   ```
   ls -l /etc/rsyslog.d/40-powershell.conf
   ```

   ```Output
   -rw-r--r-- 1 root root   67 Nov 28 12:51 40-powershell.conf
   ```

   If your `40-powershell.conf` file has different ownership or permissions,
   complete the following steps:

   1. Set ownership to **root**.

      ```
      sudo chown root:root /etc/rsyslog.d/40-powershell.conf
      ```

   1. Set access permissions: **root** has read/write, **users** have read.

      ```
      sudo chmod 644 /etc/rsyslog.d/40-powershell.conf
      ```

1. Restart the **rsyslog** service.

   ```
   sudo systemctl restart rsyslog.service
   ```

1. Run `pwsh` to generate PowerShell information to log.

   ```
   pwsh
   ```

> [!NOTE]
> The `/var/log/powershell.log` file isn't created until the rsyslog
> service is restarted and PowerShell generates information to log.

1. Query the `powershell.log` file to verify PowerShell information is being
   logged to the new file.

   ```
   cat /var/log/powershell.log
   ```

## Viewing PowerShell log output on macOS

The easiest method for viewing PowerShell log output on macOS is using the
**Console** application.

1. Search for the **Console** application and launch it.
1. Select the Machine name under **Devices**.
1. In the **Search** field, enter `pwsh` for the PowerShell main binary.
1. Change the search filter from `Any` to `Process`.
1. Perform the operations.
1. Optionally, save the search for future use.

To filter on a specific process instance of PowerShell in the **Console**, the
variable `$pid` contains the process ID.

1. Enter the **pid** (Process ID) in the **Search** field.
1. Change the search filter to `PID`.
1. Perform the operations.

### Viewing PowerShell log output from a command line

The `log` command can be used to view PowerShell log entries from the command
line.

```
sudo log stream --predicate 'process == "pwsh"' --info
```

### Persisting PowerShell log output

By default, PowerShell uses the default memory-only logging on macOS. This
behavior can be changed to enable persistence using the `log config` command.

The following script enables info level logging and persistence:

```
log config --subsystem com.microsoft.powershell --mode=persist:info,level:info
```

The following command reverts PowerShell logging to the default state:

```
log config --subsystem com.microsoft.powershell --mode=persist:default,level:default
```

After persistence is enabled, the `log show` command can be used to export log
items. The command provides options for exporting the last N items, items since
a given time, or items within a given time span.

For example, the following command exports items since
`9am on April 5 of 2018`:

```
log show --info --start "2018-04-05 09:00:00" --predicate "process = 'pwsh'"
```

You can get help for `log` by running `log show --help` for additional details.

> [!TIP]
> When executing any of the log commands from a PowerShell prompt or script,
> use double quotes around the entire predicate string and single quotes
> within. This avoids the need to escape double quote characters within the
> predicate string.

You may also want to consider saving the event logs to a more secure location
such as a central event log collector, or [SIEM][SIEM] aggregator. You can set up
SIEM in Azure. For more information, see
[Generic SIEM integration](/cloud-app-security/siem).

## Configuring logging on a non-Windows system

On Windows, logging is configured by creating ETW trace listeners or by using
the Event Viewer to enable Analytic logging. On Linux and macOS, logging is
configured using the file `powershell.config.json`. The rest of this section
discusses configuring PowerShell logging on a non-Windows system.

By default, PowerShell enables informational logging to the operational
channel. This means that any PowerShell log output that's marked as operational
and has a log (trace) level greater than informational is logged. Occasionally,
diagnoses may require additional log output, such as verbose log output or
enabling analytic log output.

The file `powershell.config.json` is a **JSON** formatted file residing in the
PowerShell `$PSHOME` directory. Each installation of PowerShell uses its own
copy of this file. For normal operation, this file is left unchanged. Although
it can be useful, to change some of the settings in the file, for diagnosis or
for distinguishing between multiple PowerShell versions on the same system or
even multiple copies of the same version (See `LogIdentity` in the table
below).

The following code is an example configuration:

```json
{
  "Microsoft.PowerShell:ExecutionPolicy": "RemoteSigned",
  "PowerShellPolicies": {
    "ScriptExecution": {
      "ExecutionPolicy": "RemoteSigned",
      "EnableScripts": true
    },
    "ScriptBlockLogging": {
      "EnableScriptBlockInvocationLogging": true,
      "EnableScriptBlockLogging": true
    },
    "ModuleLogging": {
      "EnableModuleLogging": false,
      "ModuleNames": [
        "PSReadline",
        "PowerShellGet"
      ]
    },
    "ProtectedEventLogging": {
      "EnableProtectedEventLogging": false,
      "EncryptionCertificate": [
        "Joe"
      ]
    },
    "Transcription": {
      "EnableTranscripting": true,
      "EnableInvocationHeader": true,
      "OutputDirectory": "F:\\tmp\\new"
    },
    "UpdatableHelp": {
      "DefaultSourcePath": "f:\\temp"
    },
    "ConsoleSessionConfiguration": {
      "EnableConsoleSessionConfiguration": false,
      "ConsoleSessionConfigurationName": "name"
    }
  },
  "LogLevel": "verbose"
}
```

The following is a list of properties for configuring PowerShell logging.
Values marked with an asterisk, such as `Operational*`, indicate the default
value when no value is provided in the file.

- **LogIdentity**
  - Values: `<string name>`, `powershell*`
  - Description: The name to use when logging. The default identity is
    `powershell`. This value can be used to tell the difference between two
    instances of a PowerShell installation, such as a release and beta version.
    This value is also used to redirect log output to a separate file on Linux.
    See the discussion of **rsyslog** above.
- **LogChannels**
  - Values: `Operational*`, `Analytic`
  - Description: The channels to enable. Separate the values with a comma when
    specifying more than one.
- **LogLevel**
  - Values: `Always`, `Critical`, `Error`, `Warning`, `Informational*`, `Verbose`, `Debug`
  - Description: Specify a single value. The value enables itself and all
    values above it.
- **LogKeywords**
  - Values: `Runspace`, `Pipeline`, `Protocol`, `Transport`, `Host`, `Cmdlets`, `Serializer`,
    `Session`, `ManagedPlugin`
  - Description: Keywords provide the ability to limit logging to specific
    components within PowerShell. By default, all keywords are enabled and
    change this value is only useful for very specialized troubleshooting.

## See also

- For Linux **syslog** and **rsyslog.conf** information, refer to the Linux
  computer's local `man` pages.
- For macOS **os_log** information, see
  [os_log developer documentation](https://developer.apple.com/documentation/os/os_log).
- [about_Logging_Windows](about_Logging_Windows.md)
- [Generic SIEM integration](/cloud-app-security/siem)

<!-- link references -->
[SIEM]: https://wikipedia.org/wiki/Security_information_and_event_management
