---
Download Help Link: https://go.microsoft.com/fwlink/?LinkId=393271
Help Version: 5.2.0.0
keywords: powershell,cmdlet
Locale: en-US
Module Guid: 1d73a601-4a6c-43c5-ba3f-619b18bbb404
Module Name: PowerShellGet
ms.date: 06/09/2017
schema: 2.0.0
title: PowerShellGet
---
# PowerShellGet Module

## Description

PowerShellGet is a module with commands for discovering, installing, updating and publishing
PowerShell artifacts like Modules, DSC Resources, Role Capabilities, and Scripts.

> [!IMPORTANT]
> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS)
> versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when
> trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS
> 1.2:
>
> `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`
>
> For more information, see the
> [announcement](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/) in the
> PowerShell blog.

## PowerShellGet Cmdlets

### [Find-Command](Find-Command.md)
Finds PowerShell commands in modules.

### [Find-DscResource](Find-DscResource.md)
Finds a DSC resource.

### [Find-Module](Find-Module.md)
Finds modules in a repository that match specified criteria.

### [Find-RoleCapability](Find-RoleCapability.md)
Finds role capabilities in modules.

### [Find-Script](Find-Script.md)
Finds a script.

### [Get-InstalledModule](Get-InstalledModule.md)
Gets a list of modules on the computer that were installed by PowerShellGet.

### [Get-InstalledScript](Get-InstalledScript.md)
Gets an installed script.

### [Get-PSRepository](Get-PSRepository.md)
Gets PowerShell repositories.

### [Install-Module](Install-Module.md)
Downloads one or more modules from a repository, and installs them on the local computer.

### [Install-Script](Install-Script.md)
Installs a script.

### [New-ScriptFileInfo](New-ScriptFileInfo.md)
Creates a script file with metadata.

### [Publish-Module](Publish-Module.md)
Publishes a specified module from the local computer to an online gallery.

### [Publish-Script](Publish-Script.md)
Publishes a script.

### [Register-PSRepository](Register-PSRepository.md)
Registers a PowerShell repository.

### [Save-Module](Save-Module.md)
Saves a module and its dependencies on the local computer but doesn't install the module.

### [Save-Script](Save-Script.md)
Saves a script.

### [Set-PSRepository](Set-PSRepository.md)
Sets values for a registered repository.

### [Test-ScriptFileInfo](Test-ScriptFileInfo.md)
Validates a comment block for a script.

### [Uninstall-Module](Uninstall-Module.md)
Uninstalls a module.

### [Uninstall-Script](Uninstall-Script.md)
Uninstalls a script.

### [Unregister-PSRepository](Unregister-PSRepository.md)
Unregisters a repository.

### [Update-Module](Update-Module.md)
Downloads and installs the newest version of specified modules from an online gallery to the local
computer.

### [Update-ModuleManifest](Update-ModuleManifest.md)
Updates a module manifest file.

### [Update-Script](Update-Script.md)
Updates a script.

### [Update-ScriptFileInfo](Update-ScriptFileInfo.md)
Updates information for a script.
