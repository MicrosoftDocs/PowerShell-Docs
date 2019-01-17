---
ms.date:  1/17/2019
keywords:  dsc,powershell,configuration,setup
title:  Reboot a Node
---
# Reboot a Node

> [!NOTE]
> This topic talks about how to reboot a Node. In order for the reboot to be successful the
> **ActionAfterReboot** and **RebootNodeIfNeeded** LCM settings need to be configured properly.
> To read about Local Configuration Manager settings, see [Configure the Local Configuration Manager](../managing-nodes/metaConfig.md),
> or [Configure the Local Configuration Manager (v4)](../managing-nodes/metaConfig4.md).

Nodes can be rebooted from within a resource, by using the `$global:DSCMachineStatus` flag. Setting
this flag to `1` in the `Set-TargetResource` function forces the LCM to reboot the Node directly
after the **Set** method of the current resource. Using this flag, the **xPendingReboot** resource
detects if a reboot is pending outside of DSC.

Your [configurations](configurations.md) may perform steps that require the Node to reboot. This
could include things such as:

- Windows updates
- Software install
- File renames
- Computer rename

The **xPendingReboot** resource checks specific computer locations to determine if a reboot is
pending. If the Node requires a reboot outside of DSC, the **xPendingReboot** resource sets the
`$global:DSCMachineStatus` flag to `1` forcing a reboot and resolving the pending condition.

## Syntax

```
xPendingReboot [String] #ResourceName
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
| SkipComputerRename | Skip reboots triggerd by Computer renames. |
| PSDSCRunAsCredential | Supported in v5. Executes the resource as the specified user. |
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`. For more information, see [Using DependsOn](resource-depends-on.md)|

## Example

The following example renames a computer using the **Computer** resource, reboots the machine using
**xPendingReboot**, and logs a message.

```powershell
Configuration RenameComputer
{
    Import-DscResource -ModuleName xPendingReboot, PSDesiredStateConfiguration, ComputerManagementDSC

    Node localhost
    {
        Computer Rename
        {
            Name = "Server01"
        }

        xPendingReboot ComputerRename
        {
            Name = "ComputerRename"
            DependsOn = "[Computer]Rename"
        }

        Log Success
        {
            Message = "Successfully rebooted the Node"
            DependsOn = "[xPendingReboot]ComputerRename"
        }
    }
}
```

> [!NOTE]
> This example assumes that you have configured your Local Configuration Manager to allow reboots
> and continue the configuration after a reboot.

## Where to Download

You can download the resources used in this topic at the following locations, or by using the PowerShell gallery.

- [xPendingReboot](https://github.com/PowerShell/xPendingReboot)
- [ComputerManagementDSC](https://github.com/PowerShell/ComputerManagementDsc)
