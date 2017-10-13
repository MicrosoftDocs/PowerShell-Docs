---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Core_Commands
---

# About Core Commands

## Short Description

Lists the cmdlets that are designed for use with Windows PowerShell providers.

## Long Description

Windows PowerShell includes a set of cmdlets that are specifically designed to manage the items in the data stores that are exposed by Windows PowerShell providers. You can use these cmdlets in the same ways to manage all the different types of data that the providers make available to you. For more information about providers, see [about_Providers](about_Providers.md).

For example, you can use the `Get-ChildItem` cmdlet to list the files in a file system directory, the keys under a registry key, or the items that are exposed by a provider that you write or download.

The following is a list of the Windows PowerShell cmdlets that are designed for use with providers:

* ChildItem cmdlets
  - Get-ChildItem
* Content cmdlets
  - Add-Content
  - Clear-Content
  - Get-Content
  - Set-Content
* Item cmdlets
  - Clear-Item
  - Copy-Item
  - Get-Item
  - Invoke-Item
  - Move-Item
  - New-Item
  - Remove-Item
  - Rename-Item
  - Set-Item
* ItemProperty cmdlets
  - Clear-ItemProperty
  - Copy-ItemProperty
  - Get-ItemProperty
  - Move-ItemProperty
  - New-ItemProperty
  - Remove-ItemProperty
  - Rename-ItemProperty
  - Set-ItemProperty
* Location cmdlets
  - Get-Location
  - Pop-Location
  - Push-Location
  - Set-Location
* Path cmdlets
  - Convert-Path
  - Join-Path
  - Resolve-Path
  - Split-Path
  - Test-Path
* PSDrive cmdlets
  - Get-PSDrive
  - New-PSDrive
  - Remove-PSDrive
* PSProvider cmdlets
  - Get-PSProvider

For more information about a cmdlet, type `Get-Help <cmdlet-name>`.

## See Also

[about_Providers](about_Providers.md)
