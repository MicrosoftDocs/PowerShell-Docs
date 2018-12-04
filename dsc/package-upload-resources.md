---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  Automatically download Resources to a Node (v4)
---

# Automatically download Resources to a Node (v4)

When you deploy [Configurations](configurations.md) to clients in [**Push** or **Pull**](enactingConfigurations.md) mode, any required resources need to exist on the Node. This can be accomplished by copying resources the resources manually using **SMB**, **FTP**, [PowerShell v5 sessions](/powershell/scripting/whats-new/what-s-new-in-windows-powershell-50#new-features-in-windows-powershell), or any other method, to the directory required by the LCM. In PowerShell v4, this must be under "Program Files\WindowsPowerShell\Modules" or `$pshome\Modules`.

This article will show you how to upload resources so they are available to be downloaded, and configure clients to download resources automatically.

## Automatically download Resources from a DSC HTTP Pull Server

When you set up your HTTP Pull Server, as explained in [Set up a DSC HTTP Pull Server](pullServer.md), you specify directories for the **ModulePath** and **ConfigurationPath** keys. The **ConfigurationPath** key indicates where any ".mof" files should be stored. The **ModulePath** indicates where any DSC Resource Modules should be stored.

```powershell
    xDscWebService PSDSCPullServer
    {
    ...
        ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
        ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
    ...
    }

```

## Automatically download Resources from a DSC SMB Pull Server

When you set up a SMB Pull Server, as explained in [Set up a DSC SMB Pull Server](pullServerSMB.md), you create and permission a SMB share. For each Node that you register with the

## Packaging and Uploading Resources to the Pull Server

The following steps will show you how to package and upload a resource to your Pull Server.

