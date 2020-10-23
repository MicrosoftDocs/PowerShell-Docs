---
ms.date:  12/23/2019
keywords:  powershell,cmdlet
title:  Changing Computer State
description: This example shows how you can use external commands from PowerShell to manage the configuration of a computer.
---
# Changing Computer State

To reset a computer in PowerShell, use either a standard command-line tool, WMI, or a CIM class.
Although you are using PowerShell only to run the tool, learning how to change a computer's power
state in PowerShell illustrates some of the important details about working with external tools in
PowerShell.

## Locking a Computer

The only way to lock a computer directly with the standard available tools is to call the
**LockWorkstation()** function in **user32.dll**:

```powershell
rundll32.exe user32.dll,LockWorkStation
```

This command immediately locks the workstation. It uses **rundll32.exe**, which runs Windows DLLs
(and saves their libraries for repeated use) to run `user32.dll`, a library of Windows management
functions.

When you lock a workstation while Fast User Switching is enabled, such as on Windows XP, the
computer displays the user logon screen rather than starting the current user's screensaver.

To shut down particular sessions on a Terminal Server, use the **tsshutdn.exe** command-line tool.

## Logging Off the Current Session

You can use several different techniques to log off of a session on the local system. The simplest
way is to use the Remote Desktop/Terminal Services command-line tool, **logoff.exe** (For details,
at the PowerShell prompt, type `logoff /?`). To log off the current active session, type `logoff`
with no arguments.

You can also use the **shutdown.exe** tool with its logoff option:

```powershell
shutdown.exe -l
```

Another option is to use WMI. The **Win32_OperatingSystem** class has a **Shutdown** method.
Invoking the method with the 0 flag initiates logoff:

For more information about the **Shutdown** method, see
[Shutdown method of the Win32_OperatingSystem class](/windows/win32/cimwin32prov/shutdown-method-in-class-win32-operatingsystem)

```powershell
Get-CimInstance -Classname Win32_OperatingSystem | Invoke-CimMethod -MethodName Shutdown
```

## Shutting Down or Restarting a Computer

Shutting down and restarting computers are generally the same types of task. Tools that shut down a
computer will generally restart it as well—and vice versa. There are two straightforward options for
restarting a computer from PowerShell. Use either **tsshutdn.exe** or **shutdown.exe** with
appropriate arguments. You can get detailed usage information from `tsshutdn.exe /?` or
`shutdown.exe /?`.

You can also perform shutdown and restart operations directly from PowerShell as well.

To shut down the computer, use the Stop-Computer command

```powershell
Stop-Computer
```

To restart the operating system, use the Restart-Computer command

```powershell
Restart-Computer
```

To force an immediate restart of the computer, use the -Force parameter.

```powershell
Restart-Computer -Force
```
