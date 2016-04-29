---
title: Starting the Windows PowerShell 2.0 Engine
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: edafc2fa-7576-49c2-bbba-9336f4bcfc28
---
# Starting the Windows PowerShell 2.0 Engine
This section explains how to start the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine on [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], which include the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, and on other systems on which [!INCLUDE[psversion2](../Token/psversion2_md.md)], [!INCLUDE[psversion3](../Token/psversion3_md.md)], and [!INCLUDE[psversion4](../Token/psversion4_md.md)] are installed.

[!INCLUDE[psversion4](../Token/psversion4_md.md)] and [!INCLUDE[psversion3](../Token/psversion3_md.md)] are designed to be backwards compatible with [!INCLUDE[psversion2](../Token/psversion2_md.md)]. Cmdlets, providers, snap\-ins, modules, and scripts written for [!INCLUDE[psversion2](../Token/psversion2_md.md)] run unchanged in [!INCLUDE[psversion4](../Token/psversion4_md.md)] and [!INCLUDE[psversion3](../Token/psversion3_md.md)]. However, due to a change in the runtime activation policy in Microsoft .NET Framework 4, [!INCLUDE[wps_2](../Token/wps_2_md.md)] host programs that were written for [!INCLUDE[psversion2](../Token/psversion2_md.md)] and compiled with Common Language Runtime (CLR) 2.0 cannot run without modification in [!INCLUDE[psversion3](../Token/psversion3_md.md)] or [!INCLUDE[psversion4](../Token/psversion4_md.md)], which are compiled with CLR 4.0. The [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is intended to be used only when an existing script or host program cannot run because it is incompatible with [!INCLUDE[psversion4](../Token/psversion4_md.md)], [!INCLUDE[psversion3](../Token/psversion3_md.md)], or Microsoft .NET Framework 4. Such cases are expected to be rare.

Many programs that require the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine start it automatically. These instructions are included for the rare situations in which you need to start the engine manually.

## Installing and Enabling Required Programs
Before starting the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, enable the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine and Microsoft .NET Framework 3.5 with Service Pack 1. For instructions, see [Installing Windows PowerShell](../Topic/Installing-Windows-PowerShell.md).

Systems on which [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881) or [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)] are installed have all of the required components. No further configuration is necessary. For information about installing [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkID=293881) or [!INCLUDE[ps_wmf_3.0](../Token/ps_wmf_3.0_md.md)], see [Installing Windows PowerShell](../Topic/Installing-Windows-PowerShell.md).

## How to start the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine
When you start [!INCLUDE[mshshort](../Token/mshshort_md.md)] the newest version starts by default. To start [!INCLUDE[mshshort](../Token/mshshort_md.md)] with the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, use the Version parameter of PowerShell.exe. You can run the command at any command prompt, including Windows PowerShell and Cmd.exe.

```
PowerShell.exe -Version 2
```

## How to start a remote session with the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine
To run the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine in a remote session, create a session configuration (also known as an "endpoint") on the remote computer that loads the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine. The session configuration is saved on the remote computer and can be used by any authorized user to create  sessions that use the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine.

This is an advanced task that is typically performed by a system administrator.

The following procedure uses the **PSVersion** parameter of the [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/e9152ae2-bd6d-4056-9bc7-dc1893aa29ea) cmdlet to create a session configuration that uses the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine. You can also use the **PowerShellVersion** parameter of the [New-PSSessionConfigurationFile](https://technet.microsoft.com/en-us/library/5f3e3633-6e90-479c-aea9-ba45a1954866) cmdlet to create a session configuration file for a session that loads the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine and you can use the **PSVersion** parameter of the [Set-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/b21fbad3-1759-4260-b206-dcb8431cd6ea) parameter to change a session configuration to use the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine.

For more information about session configuration files, see [about_Session_Configuration_Files](https://technet.microsoft.com/en-us/library/c7217447-1ebf-477b-a8ef-4dbe9a1473b8).For information about session configurations, including setup and security, see [about_Session_Configurations [v4]](https://technet.microsoft.com/en-us/library/a2fbe12a-350c-4d04-be50-24102824e3ab).

#### To start a remote [!INCLUDE[psversion2](../Token/psversion2_md.md)] session

1.  To create a session configuration that requires the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, use the **PSVersion** parameter of the [Register-PSSessionConfiguration](https://technet.microsoft.com/en-us/library/e9152ae2-bd6d-4056-9bc7-dc1893aa29ea) cmdlet with a value of "2.0". Run this command on the computer at the "server side" or receiving end of the connection.

    The following sample command creates the PS2 session configuration on the Server01 computer. To run this command, start [!INCLUDE[psversion4](../Token/psversion4_md.md)] or [!INCLUDE[psversion3](../Token/psversion3_md.md)] with the **Run as administrator** option.

    ```
    Register-PSSessionConfiguration -Name PS2 -PSVersion 2.0
    ```

2.  To create a session on the Server01 computer that uses the PS2 session configuration, use the **ConfigurationName** parameter of cmdlets that create a remote session, such as the [New-PSSession](https://technet.microsoft.com/en-us/library/76f6628c-054c-4eda-ba7a-a6f28daaa26f) cmdlet.

    When a session that uses the session configuration starts, the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine is automatically loaded into the session.

    The following command starts a session on the Server01 computer that uses the PS2 session configuration. The command saves the session in the $s variable.

    ```
    $s = New-PSSession -ComputerName Server01 -ConfigurationName PS2
    ```

## How to start a background job with the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine
To start a background job with the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine, use the **PSVersion** parameter of the [Start-Job](https://technet.microsoft.com/en-us/library/2bc04935-0deb-4ec0-b856-d7290cca6442) cmdlet.

The following command starts a background job with the [!INCLUDE[psversion2](../Token/psversion2_md.md)] Engine

```
Start-Job {Get-Process} -PSVersion 2.0
```

For more information about background jobs, see [about_Jobs [v4]](https://technet.microsoft.com/en-us/library/7362512a-8a4e-4575-b2ea-a740e5c4f002).

