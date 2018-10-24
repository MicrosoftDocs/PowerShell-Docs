---
ms.date:  06/12/2017
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery
title:  Packages with compatible PowerShell Editions
---
# Packages with compatible PowerShell Editions

Starting with version 5.1, PowerShell is available in different editions which denote varying
feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules
  targeting versions of PowerShell running on full footprint editions of Windows such as Server Core
  and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules
  targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano
  Server and Windows IoT.

## PowerShell Gallery extracts supported PSEditions metadata and allows you to filters the packages compatible for specific PowerShell Editions

If a package has compatible PSEditions specified, they will be listed as part of 'PowerShell
Editions' in the package display page and also in packages results.

![Item display page with PSEditions](../../Images/manual_package_download.png)

## Search for packages in the gallery UI which works on PowerShellCore

Use Tags:"PSEdition_Desktop" and Tags:"PSEdition_Core" to filters the packages on PowerShell Gallery.

### Use Tags:"PSEdition_Core" to search items compatible with PowerShell Core Edition.

![Search results for items compatible with Core PSEdition](../../Images/SearchResultsWithPSEditions.PNG)

### Use Tags:"PSEdition_Desktop" to search items compatible with PowerShell Desktop Edition.

![Search results for items compatible with Desktop PSEdition](../../Images/SearchResultsWithPSEdition-Desktop.PNG)

## More details on authoring and finding the packages with compatible PowerShell Editions

- [Modules with PSEditions](../../concepts/module-psedition-support.md)
- [Scripts with PSEditions](../../concepts/script-psedition-support.md)
