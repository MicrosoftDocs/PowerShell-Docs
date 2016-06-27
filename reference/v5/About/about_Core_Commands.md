---
title: about_Core_Commands
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9e4b0317-37b5-49d4-a5f6-0d2bd6100c3c
---
# about_Core_Commands
## TOPIC  
 about\_Core\_Commands  
  
## SHORT DESCRIPTION  
 Lists the cmdlets that are designed for use with Windows PowerShell providers.  
  
## LONG DESCRIPTION  
 Windows PowerShell includes a set of cmdlets that are specifically designed to manage the items in the data stores that are exposed by Windows PowerShell providers. You can use these cmdlets in the same ways to manage all the different types of data that the providers make available to you. For more information about providers, type "get\-help about\_providers".  
  
 For example, you can use the Get\-ChildItem cmdlet to list the files in a file system directory, the keys under a registry key, or the items that are exposed by a provider that you write or download.  
  
 The following is a list of the Windows PowerShell cmdlets that are designed for use with providers:  
  
```  
  
ChildItem cmdlets  
    Get-ChildItem  
  
Content cmdlets  
    Add-Content  
    Clear-Content  
    Get-Content  
    Set-Content  
  
Item cmdlets  
    Clear-Item  
    Copy-Item  
    Get-Item  
    Invoke-Item  
    Move-Item  
    New-Item  
    Remove-Item  
    Rename-Item  
    Set-Item  
  
ItemProperty cmdlets  
    Clear-ItemProperty  
    Copy-ItemProperty  
    Get-ItemProperty  
    Move-ItemProperty  
    New-ItemProperty  
    Remove-ItemProperty  
    Rename-ItemProperty  
    Set-ItemProperty  
  
Location cmdlets  
    Get-Location  
    Pop-Location  
    Push-Location  
    Set-Location  
  
Path cmdlets  
    Join-Path  
    Convert-Path  
    Split-Path  
    Resolve-Path  
    Test-Path  
  
PSDrive cmdlets  
    Get-PSDrive  
    New-PSDrive  
    Remove-PSDrive  
  
PSProvider cmdlets  
    Get-PSProvider  
  
```  
  
 For more information about a cmdlet, type "get\-help \<cmdlet\-name\>".  
  
## SEE ALSO  
 about\_Providers