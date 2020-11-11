---
description:  Describes new features that are included in Windows PowerShell 5.1. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/17/2018
online version: https://docs.microsoft.com/powershell/module/?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Windows_PowerShell_5.1
---

# about_Windows_PowerShell_5.1

## SHORT DESCRIPTION

Describes new features that are included in Windows PowerShell 5.1.

## LONG DESCRIPTION

Windows PowerShell 5.1 includes significant new features that extend its use,
improve its usability, and allow you to control and manage Windows-based
environments more easily and comprehensively.

Windows PowerShell 5.1 is backward-compatible. Cmdlets, providers, modules,
snap-ins, scripts, functions, and profiles that were designed for Windows
PowerShell 4.0, Windows PowerShell 3.0, and Windows PowerShell 2.0 generally
work in Windows PowerShell 5.1 without changes.

- New cmdlets: local users and groups; Get-ComputerInfo
- PowerShellGet improvements include enforcing signed modules, and installing
  JEA modules
- PackageManagement added support for Containers, CBS Setup, EXE-based setup,
  CAB packages
- Debugging improvements for DSC and PowerShell classes
- Security enhancements including enforcement of catalog-signed modules coming
  from the Pull Server and when using PowerShellGet cmdlets
- Responses to a number of user requests and issues

Windows PowerShell 5.1 is installed by default on Windows Server 2016 and
Windows 10. To install Windows PowerShell 5.1 on Windows Server 2012 R2,
Windows 8.1 Enterprise, or Windows 8.1 Pro, see
[Install and Configure WMF 5.1](/powershell/scripting/wmf/setup/install-configure).
Be sure to read the download details, and meet all system requirements, before
you install Windows Management Framework 5.1.

You can also read about changes to Windows PowerShell 5.1 in
[What's New in Windows PowerShell](/powershell/scripting/windows-powershell/whats-new/what-s-new-in-windows-powershell-50).

## New Scenarios and Features in WMF 5.1

> Note: This information is preliminary and subject to change.

### PowerShell Editions
Starting with version 5.1, PowerShell is available in different editions which denote varying feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with
  scripts and modules targeting versions of PowerShell running on full footprint
  editions of Windows such as Server Core and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts
  and modules targeting versions of PowerShell running on reduced footprint
  editions of Windows such as Nano Server and Windows IoT.

**Learn more about using PowerShell Editions**

- [Determine running edition of PowerShell using $PSVersionTable](/powershell/module/microsoft.powershell.core/about/about_automatic_variables)
- [Filter Get-Module results by CompatiblePSEditions using PSEdition parameter](/powershell/module/microsoft.powershell.core/get-module)
- [Prevent script execution unless run on a compatible edition of PowerShell](/powershell/scripting/gallery/concepts/script-psedition-support)
- [Declare a module's compatibility to specific PowerShell versions](/powershell/scripting/gallery/concepts/module-psedition-support)

### Catalog Cmdlets

Two new cmdlets have been added in the
[Microsoft.PowerShell.Security](/previous-versions/windows/powershell-scripting/hh847877(v=wps.640))
module; these generate and validate Windows catalog files.

#### New-FileCatalog

New-FileCatalog creates a Windows catalog file for set of folders and files.
This catalog file contains hashes for all files in specified paths. Users can
distribute the set of folders along with corresponding catalog file
representing those folders. This information is useful to validate whether any
changes have been made to the folders since catalog creation time.

```
New-FileCatalog [-CatalogFilePath] <string> [[-Path] <string[]>]
 [-CatalogVersion <int>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

Catalog versions 1 and 2 are supported. Version 1 uses the SHA1 hashing
algorithm to create file hashes; version 2 uses SHA256. Catalog version 2 is
not supported on *Windows Server 2008 R2* or *Windows 7*. You should use
catalog version 2 on *Windows 8*, *Windows Server 2012*, and later operating
systems.

To verify the integrity of catalog file (Pester.cat in above example), sign it
using
[Set-AuthenticodeSignature](/powershell/module/microsoft.powershell.security/set-authenticodesignature)
cmdlet.

#### Test-FileCatalog

Test-FileCatalog validates the catalog representing a set of folders.

```
Test-FileCatalog [-Detailed] [-FilesToSkip <String[]>]
 [-CatalogFilePath] <String> [[-Path] <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

This cmdlet compares all the files hashes and their relative paths found in
*catalog* with ones on *disk*. If it detects any mismatch between file hashes
and paths it returns the status as *ValidationFailed*. Users can retrieve all
this information by using the *-Detailed* parameter. It also displays signing
status of catalog in *Signature* property which is equivalent to calling
[Get-AuthenticodeSignature](/powershell/module/microsoft.powershell.security/get-authenticodesignature)
cmdlet on the catalog file. Users can also skip any file during validation by
using the *-FilesToSkip* parameter.

### Module Analysis Cache

Starting with WMF 5.1, PowerShell provides control over the file that is used
to cache data about a module, such as the commands it exports.

By default, this cache is stored in the file
`${env:LOCALAPPDATA}\Microsoft\Windows\PowerShell\ModuleAnalysisCache`. The
cache is typically read at startup while searching for a command and is
written on a background thread sometime after a module is imported.

To change the default location of the cache, set the
`$env:PSModuleAnalysisCachePath` environment variable before starting
PowerShell. Changes to this environment variable will only affect children
processes. The value should name a full path (including filename) that
PowerShell has permission to create and write files. To disable the file
cache, set this value to an invalid location, for example:

```powershell
$env:PSModuleAnalysisCachePath = 'nul'
```

This sets the path to an invalid device. If PowerShell can't write to the
path, no error is returned, but you can see error reporting by using a tracer:

```powershell
Trace-Command -PSHost -Name Modules -Expression {
  Import-Module Microsoft.PowerShell.Management -Force
}
```

When writing out the cache, PowerShell will check for modules that no longer
exist to avoid an unnecessarily large cache. Sometimes these checks are not
desirable, in which case you can turn them off by setting:

```powershell
$env:PSDisableModuleAnalysisCacheCleanup = 1
```

Setting this environment variable will take effect immediately in the current
process.

### Specifying module version

In WMF 5.1, `using module` behaves the same way as other module-related
constructions in PowerShell. Previously, you had no way to specify a
particular module version; if there were multiple versions present, this
resulted in an error.

In WMF 5.1:

* You can use [ModuleSpecification Constructor (Hashtable)](/dotnet/api/microsoft.powershell.commands.modulespecification.-ctor).
  This hash table has the same format as `Get-Module -FullyQualifiedName`.

  **Example:** `using module @{ModuleName = 'PSReadLine'; RequiredVersion = '1.1'}`

* If there are multiple versions of the module, PowerShell uses the **same
  resolution logic** as `Import-Module` and doesn't return an error--the same
  behavior as `Import-Module` and `Import-DscResource`.

### Improvements to Pester

In WMF 5.1, the version of Pester that ships with PowerShell has been updated
from 3.3.5 to 3.4.0, with the addition of GitHub [PR# 484](https://github.com/pester/Pester/pull/484),
which enables better behavior for Pester on Nano Server.

You can review the changes in versions 3.3.5 to 3.4.0 by inspecting the
ChangeLog.md file at:
https://github.com/pester/Pester/blob/master/CHANGELOG.md

## KEYWORDS

What's New in Windows PowerShell 5.1
