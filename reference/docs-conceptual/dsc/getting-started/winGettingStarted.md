---
ms.date:  08/15/2019
keywords:  dsc,powershell,configuration,setup
title:  Get started with Desired State Configuration (DSC) for Windows
description: This topic explains how to get started using PowerShell Desired State Configuration (DSC) for Windows.
---

# Get started with Desired State Configuration (DSC) for Windows

This topic explains how to get started using PowerShell Desired State Configuration (DSC) for
Windows. For general information about DSC, see
[Get Started with Windows PowerShell Desired State Configuration](../overview/overview.md).

## Supported Windows operation system versions

The following versions are supported:

- Windows Server 2019
- Windows Server 2016
- Windows Server 2012R2
- Windows Server 2012
- Windows Server 2008 R2 SP1
- Windows 10
- Windows 8.1
- Windows 7

The [Microsoft Hyper-V Server](/windows-server/virtualization/hyper-v/hyper-v-server-2016)
standalone product sku doesn't contain an implementation of Desired State Configuration
so it cannot be managed by PowerShell DSC or Azure Automation State Configuration.

## Installing DSC

PowerShell Desired State Configuration is included in Windows and updated through Windows Management
Framework. The latest version is
[Windows Management Framework 5.1](https://www.microsoft.com/download/details.aspx?id=54616).

> [!NOTE]
> You do not need to enable the Windows Server feature 'DSC-Service' to manage a machine using DSC.
> That feature is only needed when building a Windows Pull Server instance.

## Using DSC for Windows

The following sections explain how to create and run DSC configurations on Windows computers.

### Creating a configuration MOF document

The Windows PowerShell `Configuration` keyword is used to create a configuration.
The following steps describe the creation of a configuration document using Windows PowerShell.

#### Define a configuration and generate the configuration document:

```powershell
Configuration EnvironmentVariable_Path
{
    param ()

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        Environment CreatePathEnvironmentVariable
        {
            Name = 'TestPathEnvironmentVariable'
            Value = 'TestValue'
            Ensure = 'Present'
            Path = $true
            Target = @('Process', 'Machine')
        }
    }
}

EnvironmentVariable_Path -OutputPath:"C:\EnvironmentVariable_Path"
```

#### Install a module containing DSC resources

Windows PowerShell Desired State Configuration includes built-in modules containing DSC resources.
You can also load modules from external sources such as the PowerShell Gallery, using the
PowerShellGet cmdlets.

```PowerShell
Install-Module 'PSDscResources' -Verbose
```

#### Apply the configuration to the machine

> [!NOTE]
> To allow DSC to run, Windows needs to be configured to receive PowerShell remote commands
> even when you're running a `localhost` configuration. To easily configure your environment
> correctly, just run `Set-WsManQuickConfig -Force` in an elevated PowerShell Terminal.

Configuration documents (MOF files) can be applied to the machineusing the
[Start-DscConfiguration](/powershell/module/psdesiredstateconfiguration/start-dscconfiguration)
cmdlet.

```powershell
Start-DscConfiguration -Path 'C:\EnvironmentVariable_Path' -Wait -Verbose
```

#### Get the current state of the configuration

The [Get-DscConfiguration](/powershell/module/psdesiredstateconfiguration/get-dscconfiguration)
cmdlet queries the current status of the machine and returns the current values for the
configuration.

```powershell
Get-DscConfiguration
```

The [Get-DscLocalConfigurationManager](/powershell/module/psdesiredstateconfiguration/get-dscLocalConfigurationManager)
cmdlet returns the current meta-configuration applied to the machine.

```powershell
Get-DscLocalConfigurationManager
```

#### Remove the current configuration from a machine

The [Remove-DscConfigurationDocument](/powershell/module/psdesiredstateconfiguration/remove-dscconfigurationdocument)

```powershell
Remove-DscConfigurationDocument -Stage Current -Verbose
```

#### Configure settings in Local Configuration Manager

Apply a Meta Configuration MOF file to the machine using the
[Set-DSCLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration/Set-DscLocalConfigurationManager)
cmdlet. Requires the path to the Meta Configuration MOF.

```powershell
Set-DSCLocalConfigurationManager -Path 'c:\metaconfig\localhost.meta.mof' -Verbose
```

## Windows PowerShell Desired State Configuration log files

Logs for DSC are written to Windows Event Log in the path `Microsoft-Windows-Dsc/Operational`.
Additional logs for debugging purposes can be enabled following the steps in
[Where Are DSC Event Logs](/powershell/scripting/dsc/troubleshooting/troubleshooting#where-are-dsc-event-logs).
