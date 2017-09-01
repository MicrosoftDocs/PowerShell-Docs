---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Starting the Windows PowerShell 2.0 Engine
ms.assetid:  edafc2fa-7576-49c2-bbba-9336f4bcfc28
---

# Starting the Windows PowerShell 2.0 Engine
This section explains how to start the Windows PowerShell 2.0 Engine on Windows 8.1, Windows Server 2012 R2, Windows 8, and Windows Server 2012, which include the Windows PowerShell 2.0 Engine, and on other systems on which Windows PowerShell 2.0, Windows PowerShell 3.0, and Windows PowerShell 4.0 are installed.

Windows PowerShell 4.0 and Windows PowerShell 3.0 are designed to be backwards compatible with Windows PowerShell 2.0. Cmdlets, providers, snap-ins, modules, and scripts written for Windows PowerShell 2.0 run unchanged in Windows PowerShell 4.0 and Windows PowerShell 3.0. However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, Windows PowerShell host programs that were written for Windows PowerShell 2.0 and compiled with Common Language Runtime (CLR) 2.0 cannot run without modification in Windows PowerShell 3.0 or Windows PowerShell 4.0, which are compiled with CLR 4.0. The Windows PowerShell 2.0 Engine is intended to be used only when an existing script or host program cannot run because it is incompatible with Windows PowerShell 4.0, Windows PowerShell 3.0, or Microsoft .NET Framework 4. Such cases are expected to be rare.

Many programs that require the Windows PowerShell 2.0 Engine start it automatically. These instructions are included for the rare situations in which you need to start the engine manually.

## Installing and Enabling Required Programs
Before starting the Windows PowerShell 2.0 Engine, enable the Windows PowerShell 2.0 Engine and Microsoft .NET Framework 3.5 with Service Pack 1. For instructions, see [Installing Windows PowerShell](Installing-Windows-PowerShell.md).

Systems on which [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881) or Windows Management Framework 3.0 are installed have all of the required components. No further configuration is necessary. For information about installing [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881) or Windows Management Framework 3.0, see [Installing Windows PowerShell](Installing-Windows-PowerShell.md).

## How to start the Windows PowerShell 2.0 Engine
When you start Windows PowerShell the newest version starts by default. To start Windows PowerShell with the Windows PowerShell 2.0 Engine, use the Version parameter of PowerShell.exe. You can run the command at any command prompt, including Windows PowerShell and Cmd.exe.

```
PowerShell.exe -Version 2
```

## How to start a remote session with the Windows PowerShell 2.0 Engine
To run the Windows PowerShell 2.0 Engine in a remote session, create a session configuration (also known as an "endpoint") on the remote computer that loads the Windows PowerShell 2.0 Engine. The session configuration is saved on the remote computer and can be used by any authorized user to create  sessions that use the Windows PowerShell 2.0 Engine.

This is an advanced task that is typically performed by a system administrator.

The following procedure uses the **PSVersion** parameter of the [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/e9152ae2-bd6d-4056-9bc7-dc1893aa29ea) cmdlet to create a session configuration that uses the Windows PowerShell 2.0 Engine. You can also use the **PowerShellVersion** parameter of the [New-PSSessionConfigurationFile](https://technet.microsoft.com/en-us/library/5f3e3633-6e90-479c-aea9-ba45a1954866) cmdlet to create a session configuration file for a session that loads the Windows PowerShell 2.0 Engine and you can use the **PSVersion** parameter of the [Set-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/b21fbad3-1759-4260-b206-dcb8431cd6ea) parameter to change a session configuration to use the Windows PowerShell 2.0 Engine.

For more information about session configuration files, see [about_Session_Configuration_Files](https://technet.microsoft.com/en-us/library/c7217447-1ebf-477b-a8ef-4dbe9a1473b8).For information about session configurations, including setup and security, see [about_Session_Configurations [v4]](https://technet.microsoft.com/en-us/library/a2fbe12a-350c-4d04-be50-24102824e3ab).

#### To start a remote Windows PowerShell 2.0 session

1. To create a session configuration that requires the Windows PowerShell 2.0 Engine, use the **PSVersion** parameter of the [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/e9152ae2-bd6d-4056-9bc7-dc1893aa29ea) cmdlet with a value of "2.0". Run this command on the computer at the "server side" or receiving end of the connection.

    The following sample command creates the PS2 session configuration on the Server01 computer. To run this command, start Windows PowerShell 4.0 or Windows PowerShell 3.0 with the **Run as administrator** option.

    ```
    Register-PSSessionConfiguration -Name PS2 -PSVersion 2.0
    ```

2. To create a session on the Server01 computer that uses the PS2 session configuration, use the **ConfigurationName** parameter of cmdlets that create a remote session, such as the [New-PSSession](https://technet.microsoft.com/en-us/library/76f6628c-054c-4eda-ba7a-a6f28daaa26f) cmdlet.

    When a session that uses the session configuration starts, the Windows PowerShell 2.0 Engine is automatically loaded into the session.

    The following command starts a session on the Server01 computer that uses the PS2 session configuration. The command saves the session in the $s variable.

    ```
    $s = New-PSSession -ComputerName Server01 -ConfigurationName PS2
    ```

## How to start a background job with the Windows PowerShell 2.0 Engine
To start a background job with the Windows PowerShell 2.0 Engine, use the **PSVersion** parameter of the [Start-Job](https://technet.microsoft.com/en-us/library/2bc04935-0deb-4ec0-b856-d7290cca6442) cmdlet.

The following command starts a background job with the Windows PowerShell 2.0 Engine

```
Start-Job {Get-Process} -PSVersion 2.0
```

For more information about background jobs, see [about_Jobs [v4]](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_jobs?view=powershell-4.0).

