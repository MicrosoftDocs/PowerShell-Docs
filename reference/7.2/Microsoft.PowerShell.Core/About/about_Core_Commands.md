---
description: Lists the cmdlets that are designed for use with PowerShell providers.
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_core_commands?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Core_Commands
---
# About Core Commands

## SHORT DESCRIPTION
Lists the cmdlets that are designed for use with PowerShell providers.

## LONG DESCRIPTION

PowerShell includes a set of cmdlets that are specifically designed to manage
the items in the data stores that are exposed by PowerShell providers.
You can use these cmdlets in the same ways to manage all the different types
of data that the providers make available to you. For more information about
providers, type "get-help about_providers".

For example, you can use the Get-ChildItem cmdlet to list the files in a file
system directory, the keys under a registry key, or the items that are exposed
by a provider that you write or download.

The following is a list of the PowerShell cmdlets that are designed for use
with providers:

ChildItem cmdlets

- Get-ChildItem

Content cmdlets

- Add-Content
- Clear-Content
- Get-Content
- Set-Content

Item cmdlets

- Clear-Item
- Copy-Item
- Get-Item
- Invoke-Item
- Move-Item
- New-Item
- Remove-Item
- Rename-Item
- Set-Item

ItemProperty cmdlets

- Clear-ItemProperty
- Copy-ItemProperty
- Get-ItemProperty
- Move-ItemProperty
- New-ItemProperty
- Remove-ItemProperty
- Rename-ItemProperty
- Set-ItemProperty

Location cmdlets

- Get-Location
- Pop-Location
- Push-Location
- Set-Location

Path cmdlets

- Join-Path
- Convert-Path
- Split-Path
- Resolve-Path
- Test-Path

PSDrive cmdlets

- Get-PSDrive
- New-PSDrive
- Remove-PSDrive

PSProvider cmdlets

- Get-PSProvider

For more information about a cmdlet, type `get-help <cmdlet-name>`.

## SEE ALSO

[about_Providers](about_Providers.md)

