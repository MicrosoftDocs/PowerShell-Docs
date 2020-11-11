---
title: WS-Management (WSMan) Remoting in PowerShell Core
description: Remoting in PowerShell Core using WSMan
ms.date: 08/06/2018
---
# WS-Management (WSMan) Remoting in PowerShell Core

## Instructions to Create a Remoting Endpoint

The PowerShell Core package for Windows includes a WinRM plug-in (`pwrshplugin.dll`) and an
installation script (`Install-PowerShellRemoting.ps1`) in `$PSHome`. These files enable PowerShell
to accept incoming PowerShell remote connections when its endpoint is specified.

### Motivation

An installation of PowerShell can establish PowerShell sessions to remote computers using
`New-PSSession` and `Enter-PSSession`. To enable it to accept incoming PowerShell remote
connections, the user must create a WinRM remoting endpoint. This is an explicit opt-in scenario
where the user runs Install-PowerShellRemoting.ps1 to create the WinRM endpoint. The installation
script is a short-term solution until we add additional functionality to `Enable-PSRemoting` to
perform the same action. For more details, please see issue
[#1193](https://github.com/PowerShell/PowerShell/issues/1193).

### Script Actions

The script

1. Creates a directory for the plug-in within `$env:windir\System32\PowerShell`
1. Copies pwrshplugin.dll to that location
1. Generates a configuration file
1. Registers that plug-in with WinRM

### Registration

The script must be executed within an Administrator-level PowerShell session and runs in two modes.

#### Executed by the instance of PowerShell that it will register

```powershell
Install-PowerShellRemoting.ps1
```

#### Executed by another instance of PowerShell on behalf of the instance that it will register

```powershell
<path to powershell>\Install-PowerShellRemoting.ps1 -PowerShellHome "<absolute path to the instance's $PSHOME>"
```

For Example:

```powershell
Set-Location -Path 'C:\Program Files\PowerShell\6.0.0\'
.\Install-PowerShellRemoting.ps1 -PowerShellHome "C:\Program Files\PowerShell\6.0.0\"
```

> [!NOTE]
> The remoting registration script restarts WinRM. All existing PSRP sessions are terminate
> immediately after the script is run. If run during a remote session, the script terminates the
> connection.

## How to Connect to the New Endpoint

Create a PowerShell session to the new PowerShell endpoint by specifying
`-ConfigurationName "some endpoint name"`. To connect to the PowerShell instance from the example
above, use either:

```powershell
New-PSSession ... -ConfigurationName "powershell.6.0.0"
Enter-PSSession ... -ConfigurationName "powershell.6.0.0"
```

Note that `New-PSSession` and `Enter-PSSession` invocations that do not specify `-ConfigurationName`
will target the default PowerShell endpoint, `microsoft.powershell`.
