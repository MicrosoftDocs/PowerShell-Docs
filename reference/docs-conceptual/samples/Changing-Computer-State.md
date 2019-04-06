---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Changing Computer State
ms.assetid:  8093268b-27f8-4a49-8871-142c5cc33f01
---
# Changing Computer State

To reset a computer in Windows PowerShell, use either a standard command-line tool or a WMI class. Although you are using Windows PowerShell only to run the tool, learning how to change a computer's power state in Windows PowerShell illustrates some of the important details about working with external tools in Windows PowerShell.

## Locking a Computer

The only way to lock a computer directly with the standard available tools is to call the **LockWorkstation()** function in **user32.dll**:

```
rundll32.exe user32.dll,LockWorkStation
```

This command immediately locks the workstation. It uses *rundll32.exe*, which runs Windows DLLs (and saves their libraries for repeated use) to run user32.dll, a library of Windows management functions.

When you lock a workstation while Fast User Switching is enabled, such as on Windows XP, the computer displays the user logon screen rather than starting the current user's screensaver.

To shut down particular sessions on a Terminal Server, use the **tsshutdn.exe** command-line tool.

## Logging Off the Current Session

You can use several different techniques to log off of a session on the local system. The simplest way is to use the Remote Desktop/Terminal Services command-line tool, **logoff.exe** (For details, at the Windows PowerShell prompt, type **logoff /?**). To log off the current active session, type **logoff** with no arguments.

You can also use the **shutdown.exe** tool with its logoff option:

```
shutdown.exe -l
```

A third option is to use WMI. The Win32_OperatingSystem class has a Win32Shutdown method. Invoking the method with the 0 flag initiates logoff:

```powershell
(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(0)
```

For more information, and to find other features of the Win32Shutdown method, see "Win32Shutdown Method of the Win32_OperatingSystem Class" in MSDN.

## Shutting Down or Restarting a Computer

Shutting down and restarting computers are generally the same types of task. Tools that shut down a computer will generally restart it as well—and vice versa. There are two straightforward options for restarting a computer from Windows PowerShell. Use either Tsshutdn.exe or Shutdown.exe with appropriate arguments. You can get detailed usage information from **tsshutdn.exe /?** or **shutdown.exe /?**.

You can also perform shutdown and restart operations directly from Windows PowerShell as well.

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
