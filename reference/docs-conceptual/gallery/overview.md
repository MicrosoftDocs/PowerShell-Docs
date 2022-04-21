---
description: The PowerShell Gallery is the central repository for PowerShell modules, scripts, and DSC resources.
ms.date: 04/21/2022
title: The PowerShell Gallery
---
# The PowerShell Gallery

The PowerShell Gallery is the central repository for PowerShell content. In it, you can find
PowerShell scripts, modules containing PowerShell cmdlets and Desired State Configuration (DSC)
resources. Some of these packages are authored by Microsoft, and others are authored by the
PowerShell community.

## The PowerShellGet module

The **PowerShellGet** module contains cmdlets for discovering, installing, updating, and publishing
PowerShell packages from the [PowerShell Gallery](https://www.powershellgallery.com). These packages
can contain artifacts such as Modules, DSC Resources, Role Capabilities, and Scripts.

### Version history

Windows PowerShell 5.1 comes with version 1.0.0.1 of **PowerShellGet** preinstalled.

> [!IMPORTANT]
> This version of PowerShellGet has a limited features and doesn't support the updated capabilities
> of the PowerShell Gallery. To be supported, you must update to the latest version.

PowerShell 6.0 shipped with version 1.6.0 of **PowerShellGet**. PowerShell 7.0 shipped with version
2.2.3 of **PowerShellGet**. The current supported version of **PowerShellGet** is 2.2.5.

For best results, use the latest version of the **PowerShellGet** module. See
[Installing PowerShellGet](installing-psget.md) for complete instructions. The cmdlet reference
documentation on this site documents the latest version.

## Getting Started with the PowerShell Gallery

Check out the [Getting Started](getting-started.md) page for more information on how to use
**PowerShellGet** commands with the Gallery. You can also run
`Update-Help -Module PowerShellGet -Force` to install local help for these commands.

PowerShell is cross-platform, which means it works on Windows, Linux, and macOS. That also makes
**PowerShellGet** available on those systems. For a full list of systems supported by PowerShell
see [Installing PowerShell](/powershell/scripting/install/installing-powershell).

Modules in the PowerShell Gallery can support different operating systems and have additional
requirements. For information, see the documentation for the module.

## Got a question? Have feedback?

More information about the PowerShell Gallery and **PowerShellGet** can be found in the
[Getting Started](getting-started.md) page.

To see the current status of the PowerShell Gallery services, see the
[PowerShell Gallery Status](https://aka.ms/psgallery-status) page on GitHub.

Please provide feedback and report issues the [GitHub repository](https://aka.ms/psgallery-issues).
