---
description:  PowerShell logs internal operations from the engine, providers, and cmdlets.
keywords: powershell
Locale: en-US
ms.date: 03/30/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_logging_non-windows?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Logging_Non-Windows
---

# About Logging Non-Windows

## Short description
PowerShell logs internal operations from the engine, providers, and cmdlets.

## Long description

PowerShell logs details of PowerShell operations. For example, PowerShell will
log operations such as starting and stopping the engine and starting and
stopping providers. It will also log details about PowerShell commands.

The location of PowerShell logs is dependent on the target platform. On
**Linux**, PowerShell logs to **syslog** and **rsyslog.conf** can be used. For
more information, refer to the Linux computer's local `man` pages. On
**macOS**, the **os_log** logging system is used. For more information, see
[os_log developer documentation](https://developer.apple.com/documentation/os/os_log).

## Viewing PowerShell log output on Linux

PowerShell logs to **syslog** on Linux and any of the tools commonly used to
view **syslog** contents may be used.

The format of the log entries uses the following template:

```
TIMESTAMP MACHINENAME powershell[PID]: (COMMITID:TID:CID)
  [EVENTID:TASK.OPCODE.LEVEL] MESSAGE
```

|Field        |Description                                             |
|-------------|--------------------------------------------------------|
|`TIMESTAMP`  |A date/time when the log entry was produced.            |
|`MACHINENAME`|The name of the system where the log was produced.      |
|`PID`        |The process ID of the process that wrote the log entry. |
|`COMMITID`   |The `git commit` ID or tag used to produce the build.   |
|`TID`        |The thread ID of the thread that wrote the log entry.   |
|`CID`        |The hex channel identifier of the log entry.            |
|             |10 = Operational, 11 = Analytic                         |
|`EVENTID`    |The event identifier of the log entry.                  |
|`TASK`       |The task identifier for the event entry                 |
|`OPCODE`     |The opcode for the event entry                          |
|`LEVEL`      |The log level for the event entry                       |
|`MESSAGE`    |The message associated with the event entry             |

> [!NOTE]
> `EVENTID`, `TASK`, `OPCODE`, and `LEVEL` are the same values as used when
> logging to the Windows event log.

### Filtering PowerShell log entries using rsyslog

Normally, PowerShell log entries are written to the default `location/file` for
**syslog**. However, it's possible to redirect the entries to a custom file.

1. Create a conf for PowerShell log configuration and provide a number that's
   less than 50 (for `50-default.conf`), such as `40-powershell.conf`. The file
   should be placed under `/etc/rsyslog.d`.

1. Add the following entry to the file:

   ```
   :syslogtag, contains, "powershell[" /var/log/powershell.log
   & stop
   ```

1. Make sure `/etc/rsyslog.conf` includes the new file. Often, it will have a
   generic include statement that looks like following configuration:

   `$IncludeConfig /etc/rsyslog.d/*.conf`

   If it doesn't, you'll need to add an include statement manually.

1. Make sure attributes and permissions are set appropriately.

   ```
   -rw-r--r-- 1 root root   67 Nov 28 12:51 40-powershell.conf
   ```

1. Set ownership to **root**.

   ```
   chown root:root /etc/rsyslog.d/40-powershell.conf
   ```

1. Set access permissions: **root** has read/write, **users** have read.

   ```
   chmod 644 /etc/rsyslog.d/40-powershell.conf
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
such as a central event log collector, or [SIEM][] aggregator. You can set up
SIEM in Azure. For more information, see
[Generic SIEM integration](/cloud-app-security/siem).

## Configuring logging on a non-Windows system

On Windows, logging is configured by creating ETW trace listeners or by using
the Event Viewer to enable Analytic logging. On Linux and macOS, logging is
configured using the file `powershell.config.json`. The rest of this section
will discuss configuring PowerShell logging on a non-Windows system.

By default, PowerShell enables informational logging to the operational
channel. What this means is any log output produced by PowerShell that is
marked as operational and has a log (trace) level greater than informational
will be logged. Occasionally, diagnoses may require additional log output, such
as verbose log output or enabling analytic log output.

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

The properties for configuring PowerShell logging are listed in the following
table. Values marked with an asterisk, such as `Operational*`, indicate the
default value when no value is provided in the file.

|Property   |Values        |Description                                  |
|-----------|--------------|---------------------------------------------|
|`LogIdentity`|(string name) |The name to use when logging. By default,  |
|           |powershell*   |powershell is the identity. This value can be|
|           |              |used to tell the difference between two      |
|           |              |instances of a PowerShell installation, such |
|           |              |as a release and beta version. This value is |
|           |              |also used to redirect log output to a        |
|           |              |separate file on Linux. See the discussion of|
|           |              |**rsyslog** above.                           |
|`LogChannels`|Operational*  |The channels to enable. Separate the values|
|           |Analytic      |with a comma when specifying more than one.  |
|`LogLevel`   |Always        |Specify a single value. The value enables  |
|           |Critical      |itself and all values above it in the        |
|           |Error         |list to the left.                            |
|           |Warning       |                                             |
|           |Informational*|                                             |
|           |Verbose       |                                             |
|           |Debug         |                                             |
|`LogKeywords`|Runspace      |Keywords provide the ability to limit logging|
|           |Pipeline      |to specific components within PowerShell. By |
|           |Protocol      |default, all keywords are enabled and change |
|           |Transport     |this value is only useful for very           |
|           |Host          |specialized troubleshooting.                |
|           |Cmdlets       |                                             |
|           |Serializer    |                                             |
|           |Session       |                                             |
|           |ManagedPlugin |                                             |

## See also

For Linux **syslog** and **rsyslog.conf** information, refer to the Linux
computer's local `man` pages.

For macOS **os_log** information, see
[os_log developer documentation](https://developer.apple.com/documentation/os/os_log).

[about_Logging_Windows](about_Logging_Windows.md)

[Generic SIEM integration](/cloud-app-security/siem)

<!-- link references -->
[SIEM]: https://wikipedia.org/wiki/Security_information_and_event_management
