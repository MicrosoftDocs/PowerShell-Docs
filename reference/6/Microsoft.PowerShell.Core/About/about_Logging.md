---
ms.date:  2017-12-04
schema:  2.0.0
locale:  en-us
keywords:  powershell
title:  about_Logging
---

# About Logging

## Short Description

PowerShell logs details of PowerShell operations, such as starting
and stopping the program engine and starting and stopping PowerShell
providers.  it will also log details about PowerShell commands.

## Long Description

The location of PowerShell logs is dependent on the target platform.
On Windows, PowerShell logs to the event log, on Linux, PowerShell logs
to syslog, and on MacOS, the os_log logging system is used.

## Viewing the PowerShell event log on Windows

PowerShell logs can be viewed using the Event Viewer. The event log is
located in the Application and Services Logs group and is named PowerShellCore.
The associated ETW provider guid is `{f90714a8-5509-434a-bf6d-b1624c8a19a2}'

### Registering the PowerShell event provider on Windows

Unlike Linux or MacOS, Windows requires the event provider to be registered
before logged events can appear in the event log.  For PowerShell, this is
accomplished by running the `RegisterManifest.ps1` from an elevated
PowerShell prompt.

The script is located in the the install directory and should be run from that location.

### Unregistering the PowerShell event provider on Windows

Registering an event provider places a lock in the binary containing the data
needed to decode events. To update this binary, the provider must first be
unregistered to release this lock.

To unregister the PowerShell provider, run the `RegisterManifest.ps1` from an
elevated PowerShell prompt and specify the `-Unregister` switch.  Once the
upgrade of PowerShell has completed, run `RegisterManifest.ps1` a second time
to register the updated ETW provider.

## Viewing PowerShell log output on Linux

PowerShell logs the syslog on Linux and any of the tools commonly used to view
syslog contents may be used.

The format of the log entries uses the following template:

```
TIMESTAMP MACHINENAME powershell[PID]: (COMMITID:TID:CID) [EVENTID:TASK.OPCODE.LEVEL] MESSAGE
```

| Field       | Description
|-------------|---|
| `TIMESTAMP`   | A date/time when the log entry was produced.
| `MACHINENAME` | The name of the system where the log was produced.
| `PID`         | The process id of the process that wrote the log entry.
| `COMMITID`    | The git commit id or tag that was used to produce the build.
| `TID`         | The thread id of the thread that wrote the log entry.
| `CID`         | The hex channel identifier of the log entry.<br/>10 = Operational, 11 = Analytic
| `EVENTID`     | The event identifier of the log entry.
| `TASK` | The task identifier for the event entry
| `OPCODE` | The opcode for the event entry
| `LEVEL` | The log level for the event entry
| `MESSAGE` | The message associated with the event entry
|

* NOTE:EVENTID, TASK, OPCODE, and LEVEL are the same values as used when
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

`$IncludeCnofig /etc/rsyslog.d/*.conf`

If it does not, you will need to add an include statement manually.

* Ensure attributes and permissions are set appropriately

```
-rw-r--r-- 1 root root   67 Nov 28 12:51 40-powershell.conf
```

## Viewing PowerShell log output on MacOS

The easiest method for viewing PowerShell log output on MacOS is using the Console application.

* Search for the Console application and launch it
* Select the Machine name under Devices
* In the Search field, entry 'pwsh'; the PowerShell main binary.
* Change search filter from 'Any' to 'Process'
* Peform the operations.
* Optionally save the search for future use.

To filter on a specific process instance of PowerShell in the Console, teh variable $pid contains the process id.
* Entry the pid (Process Id) in the Search field.
* Change search filter PID
* Perform the operations.

### Viewing PowerShell log output from a command-line

The `log` command can be used to view PowerShell log entries from the command-line.

```
sudo log stream --predicate 'process == "pwsh"' --info
```