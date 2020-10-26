---
ms.date:  06/12/2017
title:  WMF 5.x Release Notes
description:  WMF 5.x Release Notes
---

# Windows Management Framework (WMF) 5.x Release Notes

## WMF 5.0 Changes

- PowerShell 5.0 adds a new structured **Information** stream
- Improvements to DSC including four new DSC resources:
  - WindowsFeatureSet
  - WindowsOptionalFeatureSet
  - ServiceSet
  - ProcessSet
- Added Just Enough Administration to enable role-based administration through PowerShell remoting
- PowerShell 5.0 extends the language to include user-defined classes and enumerations
- Improved debugging features in PowerShell ISE and added remote debugging
- Added the PowerShellGet and PackageManagement modules
- Enhanced PowerShell script logging and transcripts
- Add Cryptographic Message Syntax cmdlets
- WMF 5.0 includes the NetworkSwitchManager module for Windows
- Added the Microsoft.PowerShell.ODataUtils module
- Added support for Software Inventory Logging (SIL)
- Sever new or update cmdlets in response to user requests and issues

## WMF 5.1 Changes

WMF 5.1 includes the PowerShell, WMI, WinRM, and Software Inventory Logging (SIL) components that
were released with Windows Server 2016. WMF 5.1 can be installed on Windows 7, Windows 8.1, Windows
Server 2008 R2, 2012, and 2012 R2, and provides several improvements over WMF 5.0 including:

- New cmdlets
- PowerShellGet improvements include enforcing signed modules, and installing JEA modules
- PackageManagement added support for Containers, CBS Setup, EXE-based setup, CAB packages
- Debugging improvements for DSC and PowerShell classes
- Security enhancements including enforcement of catalog-signed modules coming from the Pull Server
  and when using PowerShellGet cmdlets
- Responses to a number of user requests and issues

> [!IMPORTANT]
> Before you install WMF 5.1 on Windows Server 2008 or Windows 7, confirm that WMF 3.0 isn't
> installed. For more information, see
> [WMF 5.1 Prerequisites for Windows Server 2008 R2 SP1 and Windows 7 SP1](../setup/install-configure.md#wmf-51-prerequisites-for-windows-server-2008-r2-sp1-and-windows-7-sp1).

## PowerShell Editions

Starting with version 5.1, PowerShell is available in different editions that denote varying
feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules
  targeting versions of PowerShell running on full footprint editions of Windows such as Server Core
  and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules targeting
  versions of PowerShell running on reduced footprint editions of Windows such as Nano Server and
  Windows IoT.

### Learn more about using PowerShell Editions

- [Determine running edition of PowerShell using $PSVersionTable](/powershell/module/microsoft.powershell.core/about/about_automatic_variables)
- [Filter Get-Module results by CompatiblePSEditions using PSEdition parameter](/powershell/module/microsoft.powershell.core/get-module)
- [Prevent script execution unless run on a compatible edition of PowerShell](/powershell/scripting/gallery/concepts/script-psedition-support)
- [Declare a module's compatibility to specific PowerShell versions](/powershell/scripting/gallery/concepts/module-psedition-support)

## Module Analysis Cache

Starting with WMF 5.1, PowerShell provides control over the file that is used to cache data about a
module, such as the commands it exports.

By default, this cache is stored in the file
`${env:LOCALAPPDATA}\Microsoft\Windows\PowerShell\ModuleAnalysisCache`. The cache is typically read
at startup while searching for a command and is written on a background thread sometime after a
module is imported.

To change the default location of the cache, set the `$env:PSModuleAnalysisCachePath` environment
variable before starting PowerShell. Changes to this environment variable will only affect children
processes. The value should name a full path (including filename) that PowerShell has permission to
create and write files. To disable the file cache, set this value to an invalid location, for
example:

```powershell
$env:PSModuleAnalysisCachePath = 'nul'
```

This sets the path to an invalid device. If PowerShell can't write to the path, no error is
returned, but you can see error reporting by using a tracer:

```powershell
Trace-Command -PSHost -Name Modules -Expression { Import-Module Microsoft.PowerShell.Management -Force }
```

When writing out the cache, PowerShell will check for modules that no longer exist to avoid an
unnecessarily large cache. Sometimes these checks are not desirable, in which case you can turn them
off by setting:

```powershell
$env:PSDisableModuleAnalysisCacheCleanup = 1
```

Setting this environment variable will take effect immediately in the current process.

## Specifying module version

In WMF 5.1, `using module` behaves the same way as other module-related constructions in PowerShell.
Previously, you had no way to specify a particular module version; if there were multiple versions
present, this resulted in an error.

In WMF 5.1:

- You can use
  [ModuleSpecification Constructor (Hashtable)](/dotnet/api/microsoft.powershell.commands.modulespecification.-ctor#Microsoft_PowerShell_Commands_ModuleSpecification__ctor_System_Collections_Hashtable_).

  This hash table has the same format as `Get-Module -FullyQualifiedName`.

  **Example:** `using module @{ModuleName = 'PSReadLine'; RequiredVersion = '1.1'}`

- If there are multiple versions of the module, PowerShell uses the **same resolution logic** as
  `Import-Module` and doesn't return an error--the same behavior as `Import-Module` and
  `Import-DscResource`.

## Improvements to Pester

In WMF 5.1, the version of Pester that ships with PowerShell has been updated from 3.3.5 to 3.4.0.
This update enables better behavior for Pester on Nano Server.

You can review the changes in Pest by inspecting the [ChangeLog](https://github.com/pester/Pester/blob/master/CHANGELOG.md)
in the GitHub repository.
