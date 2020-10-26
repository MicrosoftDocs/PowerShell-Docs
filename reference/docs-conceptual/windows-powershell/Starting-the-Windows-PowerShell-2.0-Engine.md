---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Using the Windows PowerShell 2.0 Engine
description: The Windows PowerShell 2.0 Engine is intended to be used only when an existing script or host program cannot run because host programs written for Windows PowerShell 2.0 and compiled with CLR 2.0 cannot run without modification.
---

# Using the Windows PowerShell 2.0 Engine

Windows PowerShell is designed to be backward compatible with previous versions. Cmdlets, providers,
snap-ins, modules, and scripts written for Windows PowerShell 2.0 run unchanged in newer versions
Windows PowerShell. However, Microsoft .NET Framework 4 changed the runtime activation policy.
Windows PowerShell host programs written for Windows PowerShell 2.0 and compiled with Common
Language Runtime (CLR) 2.0 cannot run without modification in new versions Windows PowerShell that
are compiled with CLR 4.0 (or higher).

The Windows PowerShell 2.0 Engine is intended to be used only when an existing script or host
program cannot run because it is incompatible with Windows PowerShell 5.1. Examples of this include
older versions of Exchange or SQL Server modules. Such cases are expected to be rare.

Many programs that require the Windows PowerShell 2.0 Engine start it automatically. These
instructions are included for the rare situations in which you need to start the engine manually.

## Deprecation and security concerns

Windows PowerShell 2.0 was deprecated in August, 2017. For more information, see the
[announcement][] on the PowerShell blog.

Windows PowerShell 2.0 is missing a significant amount of the hardening and security features added
in versions 3, 4, and 5. We highly, highly recommend that users not use it if they can help it. For
more information, see [A Comparison of Shell and Scripting Language Security][] and
[PowerShell ♥ the Blue Team][blueteam].

## Installing and Enabling Required Programs

Before starting the Windows PowerShell 2.0 Engine, enable the Windows PowerShell 2.0 Engine and
Microsoft .NET Framework 3.5 with Service Pack 1. For instructions, see
[Installing Windows PowerShell][].

Systems on which Windows Management Framework 3.0 or higher is installed have all of the required
components. No further configuration is necessary. For information about installing Windows
Management Framework, see [Install and configure WMF][].

## How to start the Windows PowerShell 2.0 Engine

When you start Windows PowerShell the newest version starts by default. To start Windows PowerShell
with the Windows PowerShell 2.0 Engine, use the Version parameter of `PowerShell.exe`. You can run
the command at any command prompt, including Windows PowerShell and Cmd.exe.

```
PowerShell.exe -Version 2
```

## How to start a remote session with the Windows PowerShell 2.0 Engine

To run the Windows PowerShell 2.0 Engine in a remote session, create a session configuration (also
known as an _endpoint_) on the remote computer that loads the Windows PowerShell 2.0 Engine. The
session configuration is saved on the remote computer and can be used by any authorized user to
create sessions that use the Windows PowerShell 2.0 Engine.

This is an advanced task that is typically performed by a system administrator.

The following procedure uses the **PSVersion** parameter of the [Register-PSSessionConfiguration][]
cmdlet to create a session configuration that uses the Windows PowerShell 2.0 Engine. You can also
use the **PowerShellVersion** parameter of the [New-PSSessionConfigurationFile][] cmdlet to create a
session configuration file for a session that loads the Windows PowerShell 2.0 Engine and you can
use the **PSVersion** parameter of the [Set-PSSessionConfiguration][] parameter to change a session
configuration to use the Windows PowerShell 2.0 Engine.

For more information about session configuration files, see [about_Session_Configuration_Files][].
For information about session configurations, including setup and security, see
[about_Session_Configurations][].

### To start a remote Windows PowerShell 2.0 session

1. To create a session configuration that requires the Windows PowerShell 2.0 Engine, use the
   **PSVersion** parameter of the `Register-PSSessionConfiguration` cmdlet with a value of `2.0`.
   Run this command on the computer at the "server side" or receiving end of the connection.

   The following sample command creates the PS2 session configuration on the Server01 computer. To
   run this command, start Windows PowerShell with the **Run as administrator** option.

   ```powershell
   Register-PSSessionConfiguration -Name PS2 -PSVersion 2.0
   ```

1. To create a session on the Server01 computer that uses the PS2 session configuration, use the
   **ConfigurationName** parameter of cmdlets that create a remote session, such as the
   `New-PSSession cmdlet.

   When a session that uses the session configuration starts, the Windows PowerShell 2.0 Engine is
   automatically loaded into the session.

   The following command starts a session on the Server01 computer that uses the PS2 session
   configuration. The command saves the session in the `$s` variable.

   ```powershell
   $s = New-PSSession -ComputerName Server01 -ConfigurationName PS2
   ```

## How to start a background job with the Windows PowerShell 2.0 Engine

To start a background job with the Windows PowerShell 2.0 Engine, use the **PSVersion** parameter of
the [Start-Job][] cmdlet.

The following command starts a background job with the Windows PowerShell 2.0 Engine

```powershell
Start-Job {Get-Process} -PSVersion 2.0
```

For more information about background jobs, see [about_Jobs][].

<!-- link references -->
[announcement]: https://devblogs.microsoft.com/powershell/windows-powershell-2-0-deprecation/
[A Comparison of Shell and Scripting Language Security]: https://devblogs.microsoft.com/powershell/a-comparison-of-shell-and-scripting-language-security/
[blueteam]: https://devblogs.microsoft.com/powershell/powershell-the-blue-team/
[Installing Windows PowerShell]: install/Installing-Windows-PowerShell.md
[Install and configure WMF]: wmf/setup/install-configure.md
[Register-PSSessionConfiguration]: /powershell/module/Microsoft.PowerShell.Core/Register-PSSessionConfiguration
[New-PSSessionConfigurationFile]: /powershell/module/Microsoft.PowerShell.Core/New-PSSessionConfigurationFile
[Set-PSSessionConfiguration]: /powershell/module/Microsoft.PowerShell.Core/Set-PSSessionConfiguration
[about_Session_Configuration_Files]: /powershell/module/Microsoft.PowerShell.Core/about/about_Session_Configuration_Files
[about_Session_Configurations]: /powershell/module/Microsoft.PowerShell.Core/about/about_Session_Configurations
[Start-Job]: /powershell/module/microsoft.powershell.core/start-job
[about_Jobs]: /powershell/module/microsoft.powershell.core/about/about_jobs
