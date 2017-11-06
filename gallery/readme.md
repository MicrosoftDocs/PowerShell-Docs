---
ms.date:  2017-06-12
contributor:  JKeithB
ms.topic:  conceptual
keywords:  gallery,powershell,cmdlet,psgallery,psget
title:  The PowerShell Gallery
---

# The PowerShell Gallery

The PowerShell Gallery is the central repository for PowerShell content. You can find new PowerShell commands or Desired State Configuration (DSC) resources in the Gallery.

## PowerShellGet Overview

The PowerShellGet module contains cmdlets for discovering, installing, updating and publishing PowerShell artifacts such as Modules, DSC Resources, Role Capabilities and Scripts from the [PowerShell Gallery](https://www.PowerShellGallery.com) and other private repositories.

## Getting Started with the Gallery

Installing items from the Gallery requires the latest version of the PowerShellGet module, which is available in Windows 10, in Windows Management Framework (WMF) 5.0, or in the MSI-based installer (for PowerShell 3 and 4).

- [**Get Windows 10**](http://go.microsoft.com/fwlink/?LinkID=624830&clcid=0x409),
- [**Get WMF 5.0**](http://go.microsoft.com/fwlink/?LinkId=398175), or
- [**Get MSI Installer**](http://go.microsoft.com/fwlink/?LinkID=746217&clcid=0x409)

With the latest
[PowerShellGet](http://go.microsoft.com/fwlink/?LinkID=760387&clcid=0x409)
module, you can:

-   Search through items in the Gallery with
    [Find-Module](https://go.microsoft.com/fwlink/?LinkId=821658)
    and
    [Find-Script](https://go.microsoft.com/fwlink/?LinkId=822322)
-   Save items to your system from the Gallery with
    [Save-Module](https://go.microsoft.com/fwlink/?LinkId=821669)
    and
    [Save-Script](https://go.microsoft.com/fwlink/?LinkId=822334)
-   Install items from the Gallery with
    [Install-Module](https://go.microsoft.com/fwlink/?LinkId=821663)
    and
    [Install-Script](https://go.microsoft.com/fwlink/?LinkId=822327)
-   Upload items to the Gallery with
    [Publish-Module](https://go.microsoft.com/fwlink/?LinkId=821666)
    and
    [Publish-Script](https://go.microsoft.com/fwlink/?LinkId=822331)
-   Add your own custom repository with
    [Register-PSRepository](https://go.microsoft.com/fwlink/?LinkId=821668)

Check out the [Getting Started](psgallery/psgallery_gettingstarted.md) page for more information on how to use PowerShellGet commands with the Gallery. You can also run *Update-Help -Module PowerShellGet* to install local help for these commands.

## Supported Operating Systems

The **PowerShellGet** module requires **PowerShell 3.0 or newer**.

Therefore, **PowerShellGet** requires one of the following operating systems:

- Windows 10
- Windows 8.1 Pro
- Windows 8.1 Enterprise
- Windows 7 SP1
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2008 R2 SP1

**PowerShellGet** also  requires .NET Framework 4.5 or above. You can install .NET Framework 4.5 or above from [here](https://msdn.microsoft.com/en-us/library/5a4x27ek.aspx).


## Got a question? Have feedback?

More information about the PowerShell Gallery and PowerShellGet can be found in the [Getting Started](psgallery/psgallery_gettingstarted.md) page. Please provide feedback and report issues using [UserVoice](http://windowsserver.uservoice.com/forums/301869-powershell).

