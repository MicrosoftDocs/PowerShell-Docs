---
title:   New Scenarios and Features in WMF 5.1 (Preview)
ms.date:  2016-05-16
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  keithb
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

# New Scenarios and Features in WMF 5.1 (Preview) #

> Note: This information is preliminary and subject to change.

## PowerShell Editions ##
Starting with version 5.1, PowerShell is available in different editions which denote varying feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules targeting versions of PowerShell running on full footprint editions of Windows such as Server Core and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano Server and Windows IoT.

**Learn more about using PowerShell Editions**
- [Determine running edition of PowerShell]()
- [Declare a module's compatibility to specific PowerShell versions]()
- [Filter Get-Module results by CompatiblePSEditions]()
- [Prevent script execution unless run on a comaptible edition of PowerShell]()

## Module Analysis Cache ##
Starting with version 5.1, PowerShell provides the following control
over the file that is used to cache data about a module like the commands it exports.

`TODO` need to either provide a better description of analysis cache and the 'control' options beyond turning it off/on unless that is the limits to the changes introduced.

By default, this cache is stored in the file `${env:LOCALAPPDATA}\Microsoft\Windows\PowerShell\ModuleAnalysisCache`.
The cache is typically read at startup while searching for a command
and is written on a background thread sometime after a module is imported.

**Learn more about controlling module analysis cache**
- [Change the default location of the cache]()
- [Enable or disable file cache]()
- [Enable or disable cache cleanup]()

## Onege
