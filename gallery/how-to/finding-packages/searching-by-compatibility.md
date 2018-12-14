---
ms.date:  12/11/2018
contributor:  JKeithB, SydneyhSmith
keywords:  gallery,powershell,cmdlet,psgallery
title:  Packages with compatible PowerShell Editions or Operating System
---
# Packages with compatible PowerShell Editions or Operating Systems

Starting with version 5.1, PowerShell is available in different editions which denote varying
feature sets and platform compatibilities.

## Searching by PowerShell Edition 

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules
  targeting versions of PowerShell running on full footprint editions of Windows such as Server Core
  and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules
  targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano
  Server and Windows IoT.

### PowerShell Gallery extracts supported PSEditions metadata and allows you to filters the packages compatible for specific PowerShell Editions

If a package has compatible PSEditions specified, they will be listed as part of 'PowerShell
Editions' in the package display page and also in packages results.

![Item display page with PSEditions](../../Images/packagedisplaypagewithpseditions.PNG)

### Search for packages in the gallery UI which works on PowerShellCore

Use Tags:"PSEdition_Desktop" and Tags:"PSEdition_Core" to filters the packages on PowerShell Gallery.

#### Use Tags:"PSEdition_Core" to search items compatible with PowerShell Core Edition.

![Search results for items compatible with Core PSEdition](../../Images/searchresultswithpseditions.PNG)

#### Use Tags:"PSEdition_Desktop" to search items compatible with PowerShell Desktop Edition.

![Search results for items compatible with Desktop PSEdition](../../Images/searchresultswithpseditionsdesktop.PNG)

## Searching by Operating System 

Since PowerShell Core is available for Windows, Linux, and MacOS, packages in the Gallery may be designed for any combination of these operating systems. In the gallery UI use the following searchs tags to find packages tagged by operating system:

- Tags: "Windows"
- Tags: "Linux"
- Tags: "MacOS" 

## Searching for Multiple Compatibilities

If I am looking for a package that has multiple compatibilities I would use the syntax: 

Tags: "Compatibility1" "Compatibility2" 

For example, if I am looking for a package with PowerShell Core Compatibility that will run on both my Windows and Linux machines I would search:

Tags: "PSEdition_Core" "Windows" "Linux" 

## More details on authoring and finding the packages with compatible PowerShell Editions

- [Modules with PSEditions](../../concepts/module-psedition-support.md)
- [Scripts with PSEditions](../../concepts/script-psedition-support.md)
