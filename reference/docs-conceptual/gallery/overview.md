---
ms.date: 12/01/2020
title:  The PowerShell Gallery
description: The PowerShell Gallery is the central repository for PowerShell modules, scripts, and DSC resources.
---
# The PowerShell Gallery

The PowerShell Gallery is the central repository for PowerShell content. In it, you can find useful
PowerShell modules containing PowerShell commands and Desired State Configuration (DSC) resources.
You can also find PowerShell scripts, some of which may contain PowerShell workflows, and which
outline a set of tasks and provide sequencing for those tasks. Some of these packages are authored
by Microsoft, and others are authored by the PowerShell community.

## PowerShellGet Overview

The PowerShellGet module contains cmdlets for discovering, installing, updating and publishing
PowerShell packages which contain artifacts such as Modules, DSC Resources, Role Capabilities and
Scripts from the [PowerShell Gallery](https://www.PowerShellGallery.com) and other private
repositories.

## Getting Started with the Gallery

Installing packages from the Gallery requires the latest version of the PowerShellGet module. See
[Installing PowerShellGet](installing-psget.md) for complete instructions.

Check out the [Getting Started](getting-started.md) page for more information on how to use
PowerShellGet commands with the Gallery. You can also run *Update-Help -Module PowerShellGet* to
install local help for these commands.

## Supported Operating Systems

The **PowerShellGet** module requires **PowerShell 3.0 or newer**.

**PowerShellGet** requires .NET Framework 4.5 or above. For more information, see
[Install the .NET Framework for developers](/dotnet/framework/install/guide-for-developers).

Since **PowerShell Core** is cross-platform and that means it works on Windows, Linux and MacOS,
that also makes **PowerShellGet** available on those systems. For a full list of systems supported
by **PowerShell Core** see
[Installing PowerShell](/powershell/scripting/install/installing-powershell).

Many modules hosted in the gallery will support different OSes and have additional requirements.
Please refer to the documentation for the modules for more information.

## Got a question? Have feedback?

More information about the PowerShell Gallery and PowerShellGet can be found in the
[Getting Started](getting-started.md) page.

To see the current status of the PowerShell Gallery services, see the
[PowerShell Gallery Status](https://github.com/PowerShell/PowerShellGallery/blob/master/psgallery_status.md)
page on GitHub.

Please provide feedback and report issues the
[GitHub repository](https://github.com/PowerShell/PowerShellGallery/issues).
