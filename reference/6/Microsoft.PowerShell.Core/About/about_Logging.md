---
ms.date:  08/21/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell
title:  about_Logging
---

# About Logging

## Short Description

PowerShell logs internal operations from the engine, providers, and
cmdlets.


## Long Description

PowerShell logs details of PowerShell operations, such as starting
and stopping the engine and starting and stopping providers. It will
also log details about PowerShell commands.

The location of PowerShell logs is dependent on the target platform.
On Windows, PowerShell logs to the event log, on Linux, PowerShell logs
to syslog, and on macOS, the os_log logging system is used.

## Viewing the PowerShell event log on Windows

PowerShell logs can be viewed using the Event Viewer. The event log is
located in the Application and Services Logs group and is named PowerShellCore.
The associated ETW provider guid is `{f90714a8-5509-434a-bf6d-b1624c8a19a2}`

### Registering the PowerShell event provider on Windows

Unlike Linux or macOS, Windows requires the event provider to be registered
before logged events can appear in the event log.  For PowerShell, this is
accomplished by running the `RegisterManifest.ps1` from an elevated
PowerShell prompt.

The script is located in the $PSHOME directory and should be run from
that location.

### Unregistering the PowerShell event provider on Windows

Registering an event provider places a lock in the binary containing the data
needed to decode events. To update this binary, the provider must first be
unregistered to release this lock.

To unregister the PowerShell provider, run the `RegisterManifest.ps1` from an
elevated PowerShell prompt and specify the `-Unregister` switch.  Once the
upgrade of PowerShell has completed, run `RegisterManifest.ps1` a second time
to register the updated ETW provider.

## Viewing PowerShell log output on Linux

PowerShell logs to syslog on Linux and any of the tools commonly used to view
syslog contents may be used.

The format of the log entries uses the following template:

```
TIMESTAMP MACHINENAME powershell[PID]: (COMMITID:TID:CID)
  [EVENTID:TASK.OPCODE.LEVEL] MESSAGE
```

|Field        |Description                                             |
|-------------|--------------------------------------------------------|
|`TIMESTAMP`  |A date/time when the log entry was produced.            |
|`MACHINENAME`|The name of the system where the log was produced.      |
|`PID`        |The process id of the process that wrote the log entry. |
|`COMMITID`   |The git commit id or tag used to produce the build.     |
|`TID`        |The thread id of the thread that wrote the log entry.   |
|`CID`        |The hex channel identifier of the log entry.            |
|             |10 = Operational, 11 = Analytic                         |
|`EVENTID`    |The event identifier of the log entry.                  |
|`TASK`       |The task identifier for the event entry                 |
|`OPCODE`     |The opcode for the event entry                          |
|`LEVEL`      |The log level for the event entry                       |
|`MESSAGE`    |The message associated with the event entry             |

* NOTE: EVENTID, TASK, OPCODE, and LEVEL are the same values as used when
logging to the windows event log.

### Filtering PowerShell log entries using rsyslog

By default, PowerShell log entries are written to the default location/file
for syslog.  However, it is possible to redirect the entries to a custom
file.

* Create a conf for PowerShell log configuration and provide a number that
is less than 50 (for `50-default.conf`), such as `40-powershell.conf`. The
file should be placed under `/etc/rsyslog.d`.

* Add the following entry to the file
```
:syslogtag, contains, "powershell[" /var/log/powershell.log
& stop
```
* Ensure `/etc/rsyslog.conf` includes the new file. Often, it will have
a generic include statement that looks like following:

`$IncludeConfig /etc/rsyslog.d/*.conf`

If it does not, you will need to add an include statement manually.

* Ensure attributes and permissions are set appropriately

  ```
  -rw-r--r-- 1 root root   67 Nov 28 12:51 40-powershell.conf
  ```

- Set ownership to root

  ```
  chown root:root /etc/rsyslog.d/40-powershell.conf
  ```

- Set access permissions - root has read/write, users have read.

  ```
  chmod 644 /etc/rsyslog.d/40-powershell.conf
  ```

## Viewing PowerShell log output on macOS

The easiest method for viewing PowerShell log output on macOS is using the
Console application.

* Search for the Console application and launch it
* Select the Machine name under Devices
* In the Search field, entry 'pwsh'; the PowerShell main binary.
* Change search filter from 'Any' to 'Process'
* Peform the operations
* Optionally save the search for future use.

To filter on a specific process instance of PowerShell in the Console, the
variable $pid contains the process id.
* Enter the pid (Process Id) in the Search field.
* Change search filter PID
* Perform the operations

### Viewing PowerShell log output from a command-line

The `log` command can be used to view PowerShell log entries from the
command-line.

```
sudo log stream --predicate 'process == "pwsh"' --info
```

### Persisting PowerShell log output

By default, PowerShell uses the default memory-only logging on macOS. This can
be changed to enable persistance using the `log config` command.

The following enables info level logging and persistence

```
log config --subsystem com.microsoft.powershell --mode=persist:info,level:info
```

The following command reverts PowerShell logging to the default state

```
log config --subsystem com.microsoft.powershell --mode=persist:default,level:default
```

Once persistence is enabled, the `log show` command can be used to export log
items. The command provides options for exporting the last N items, items
since a given time, or items within a given time span.

For example, the following command exports items since 9am on April 5th of 2018:

```
log show --info --start "2018-04-05 09:00:00" --predicate "process = 'pwsh'"
```

See ```log show --help``` for additional details.

> [!TIP]
> When executing any of the log commands from a PowerShell prompt or
> script, use double quotes around the entire predicate string and single
> quotes within. This avoids the need to escape double quote characters within
> the predicate string.

## Configuring Logging on non-Windows system

On Windows, logging is configured by creating ETW trace listeners or by using
the Event Viewer to enable Analytic logging. On Linux and macOS, logging is
configured using the file `powershell.config.json`. The rest of this section
will discuss configuring PowerShell logging on non-Windows system.

By default, PowerShell enables informational logging to the operational
channel. What this means is any log output produced by PowerShell that is
marked as operational and has a log (trace) level greater then informational
will be logged.  Occasionally, diagnoses may require additional log output,
such as verbose log output or enabling analytic log output.

The file `powershell.config.json` is a JSON formatted file residing in the
PowerShell $PSHOME directory. Each installation of PowerShell uses it's own
copy of this file. For normal operation, this file is left unchanged but it
can be useful for diagnosis or for distinguishing between multiple PowerShell
versions on the same system or even multiple copies of the same version
(See LogIdentity in the table below).

Here is an example configuration:

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
|LogIdentity|(string name) |The name to use when logging. By default,    |
|           |powershell*   |powershell is the identity. This value can be|
|           |              |used to distinguish between two instances of |
|           |              |a PowerShell installation, such as a release |
|           |              |and beta version. This value is also used to |
|           |              |redirect log output to a separate file on    |
|           |              |Linux. See the discussion of rsyslog above.  |
|LogChannels|Operational*  |The channels to enable. Seperate the values  |
|           |Analytic      |with a comma when specifying more than one.  |
|LogLevel   |Always        |Specify a single value. The value enables    |
|           |Critical      |itself as well as all values above it in the |
|           |Error         |list to the left.                            |
|           |Warning       |                                             |
|           |Informational*|                                             |
|           |Verbose       |                                             |
|           |Debug         |                                             |
|LogKeywords|Runspace      |Keywords provide the ability to limit logging|
|           |Pipeline      |to specific components within PowerShell. By |
|           |Protocol      |default, all keywords are enabled and change |
|           |Transport     |this value is generaly only useful for very  |
|           |Host          |specialized trouble shooting.                |
|           |Cmdlets       |                                             |
|           |Serializer    |                                             |
|           |Session       |                                             |
|           |ManagedPlugin |                                             |

## SEE ALSO

- syslog and rsyslog.conf man pages.
- os_log developer documentation
- Event Viewer
