---
ms.date:  01/17/2019
keywords:  dsc,powershell,configuration,setup
title:  Reboot a Node
description: Many configuration settings can require the computer to be rebooted for the configuration change to be complete. This article explains how to manage reboots in a configuration.
---
# Reboot a Node

> [!NOTE]
> This topic talks about how to reboot a Node. In order for the reboot to be successful the
> **ActionAfterReboot** and **RebootNodeIfNeeded** LCM settings need to be configured properly. To
> read about Local Configuration Manager settings, see
> [Configure the Local Configuration Manager](../managing-nodes/metaConfig.md), or
> [Configure the Local Configuration Manager (v4)](../managing-nodes/metaConfig4.md).

Nodes can be rebooted from within a resource, by using the `$global:DSCMachineStatus` flag. Setting
this flag to `1` in the `Set-TargetResource` function forces the LCM to reboot the Node directly
after the **Set** method of the current resource. Using this flag, the **PendingReboot** resource in
the [ComputerManagementDsc](https://github.com/PowerShell/ComputerManagementDsc) DSC Resource module
detects if a reboot is pending outside of DSC.

Your [configurations](configurations.md) may perform steps that require the Node to reboot. This
could include things such as:

- Windows updates
- Software install
- File renames
- Computer rename

The **PendingReboot** resource checks specific computer locations to determine if a reboot is
pending. If the Node requires a reboot outside of DSC, the **PendingReboot** resource sets the
`$global:DSCMachineStatus` flag to `1` forcing a reboot and resolving the pending condition.

> [!NOTE]
> Any DSC resource can instruct the LCM to reboot the node by setting this flag in the
> `Set-TargetResource` function. For more information, see
> [Writing a custom DSC resource with MOF](../resources/authoringResourceMOF.md).

## Syntax

```
PendingReboot [String] #ResourceName
{
    Name = [string]
    [DependsOn = [string[]]]
    [PsDscRunAsCredential = [PSCredential]]
    [SkipCcmClientSDK = [bool]]
    [SkipComponentBasedServicing = [bool]]
    [SkipPendingComputerRename = [bool]]
    [SkipPendingFileRename = [bool]]
    [SkipWindowsUpdate = [bool]]
}
```

## Properties

| Property | Description |
| --- | --- |
| Name| Required parameter that must be unique per instance of the resource within a configuration.|
| SkipComponentBasedServicing | Skip reboots triggered by the Component-Based Servicing component. |
| SkipWindowsUpdate | Skip reboots triggered by Windows Update.|
| SkipPendingFileRename | Skip pending file rename reboots. |
| SkipCcmClientSDK | Skip reboots triggered by the ConfigMgr client. |
| SkipComputerRename | Skip reboots triggered by Computer renames. |
| PSDSCRunAsCredential | Supported in v5. Executes the resource as the specified user. |
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. For more information, see [Using DependsOn](resource-depends-on.md)|

## Example

The following example installs Microsoft Exchange using the
[xExchange](https://github.com/PowerShell/xExchange) resource. Throughout the install, the
**PendingReboot** resource is used to reboot the Node.

> [!NOTE]
> This example requires the credential of an account that has rights to add an Exchange server to
> the forest. For more information on using credentials in DSC, see
> [Handling Credentials in DSC](../configurations/configDataCredentials.md)

```powershell
$ConfigurationData = @{
    AllNodes = @(
        @{
            NodeName                    = '*'
            PSDSCAllowPlainTextPassword = $true
        },
        @{
            NodeName = 'DSCPULL-1'
        }
    )
}

Configuration Example
{
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        $ExchangeAdminCredential
    )

    Import-DscResource -Module xExchange
    Import-DscResource -Module ComputerManagementDsc

    Node $AllNodes.NodeName
    {
        # Copy the Exchange setup files locally
        File ExchangeBinaries
        {
            Ensure          = 'Present'
            Type            = 'Directory'
            Recurse         = $true
            SourcePath      = '\\rras-1\Binaries\E15CU6'
            DestinationPath = 'C:\Binaries\E15CU6'
        }

        # Check if a reboot is needed before installing Exchange
        PendingReboot BeforeExchangeInstall
        {
            Name       = 'BeforeExchangeInstall'
            DependsOn  = '[File]ExchangeBinaries'
        }

        # Do the Exchange install
        xExchInstall InstallExchange
        {
            Path       = 'C:\Binaries\E15CU6\Setup.exe'
            Arguments  = '/mode:Install /role:Mailbox /Iacceptexchangeserverlicenseterms'
            Credential = $ExchangeAdminCredential
            DependsOn  = '[PendingReboot]BeforeExchangeInstall'
        }

        # See if a reboot is required after installing Exchange
        PendingReboot AfterExchangeInstall
        {
            Name      = 'AfterExchangeInstall'
            DependsOn = '[xExchInstall]InstallExchange'
        }
    }
}
```

> [!NOTE]
> This example assumes that you have configured your Local Configuration Manager to allow reboots
> and continue the configuration after a reboot.

## Where to Download

You can download the resources used in this topic at the following locations, or by using the
PowerShell gallery.

- [ComputerManagementDsc](https://github.com/PowerShell/ComputerManagementDsc)
- [xExchange](https://github.com/PowerShell/xExchange)
