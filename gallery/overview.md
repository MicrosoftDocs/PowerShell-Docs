---
ms.date:  06/12/2017
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery,psget
title:  The PowerShell Gallery
---
# The PowerShell Gallery

The PowerShell Gallery is the central repository for PowerShell content. In it, you can find useful
PowerShell modules containing PowerShell commands and Desired State Configuration (DSC) resources.
You can also find PowerShell scripts, some of which may contain PowerShell workflows, and which
outline a set of tasks and provide sequencing for those tasks. Some of these packages are authored by
Microsoft, and others are authored by the PowerShell community.

## PowerShellGet Overview

The PowerShellGet module contains cmdlets for discovering, installing, updating and publishing
PowerShell packages which contain artifacts such as Modules, DSC Resources, Role Capabilities and Scripts from the
[PowerShell Gallery](https://www.PowerShellGallery.com) and other private repositories.

## Getting Started with the Gallery

Installing packages from the Gallery requires the latest version of the PowerShellGet module.
See [Installing PowerShellGet](installing-psget.md) for complete instructions.

Check out the [Getting Started](getting-started.md) page for more information on how to use
PowerShellGet commands with the Gallery. You can also run *Update-Help -Module PowerShellGet* to
install local help for these commands.

## Supported Operating Systems

The **PowerShellGet** module requires **Windows PowerShell 3.0 or newer**, or **PowerShell Core 6.0 or newer**.

A suitable version of **Windows PowerShell** is available for these operating systems:

- Windows 10
- Windows 8.1 Pro
- Windows 8.1 Enterprise
- Windows 7 SP1
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2008 R2 SP1

**PowerShellGet** requires .NET Framework 4.5 or above. You can install .NET Framework 4.5 or
above from [here](https://msdn.microsoft.com/library/5a4x27ek.aspx).

Since **PowerShell Core** is cross-platform and that means it works on Windows, Linux and MacOS, that also makes
**PowerShellGet** available on those systems. For a full list of systems supported by **PowerShell Core** see
[Installing PowerShell](/powershell/scripting/setup/installing-powershell).

Many modules hosted in the gallery will support different OSes and have additional requirements. Please refer to the documentation for the modules for more information.

## Got a question? Have feedback?

More information about the PowerShell Gallery and PowerShellGet can be found in the
[Getting Started](getting-started.md) page. Please provide feedback and report issues using
[UserVoice](http://windowsserver.uservoice.com/forums/301869-powershell).
