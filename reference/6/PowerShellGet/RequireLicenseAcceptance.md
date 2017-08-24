---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell
online version:  
external help file:  
title:  RequireLicenseAcceptance
---

# Modules Requiring License Acceptance

## SYNOPSIS
Legal departments for some module publishers require that customers must explicitly accept the license before installing their module from PowerShell Gallery. If a user installs, updates, or saves a module using PowerShellGet, whether directly or as a dependency for another item, and that module requires the user to agree to a license, the user must indicate they accept the license or the operation fails.

## Publish Requirements for Modules

Modules that would like to require users to accept license should fulfill following requirements:
	
- PSData section of module manifest should include RequireLicenseAcceptance = $True.
- Module should contain license.txt file in root directory.
- Module manifest should contain License Uri.
- Module should be published with PowerShellGet Format Version 2.0 and above.

## Impact on Install/Save/Upave-Module

- Install/Save/Update cmdlets will support a new parameter –AcceptLicense that will behave as though the user saw the license.
- If RequiredLicenseAcceptance is True and –AcceptLicense is not specified, the user will be shown the license.txt, and prompted with: &quot;Do you accept these license terms (Yes / No/YesToAll/NoToAll)&quot;.
  - If the license is accepted
    - Case save-module: the module will be copied to the user&#39;s system
    - Case install-module: the module will be copied to the user&#39;s system to the proper folder (based on scope)
    - Case update-module: if the module license has not been previously accepted, the update will proceed.
  - If the license is declined. 
    - Operation will be cancelled.
- All cmdlets will check for the metadata(requireLicenseAcceptance and Format Version) that says a license acceptance is required
  - If format version of client is older than 2.0, operation will fail and ask the user to update the client.
  - If module was published with format version older than 2.0, requireLicenseAcceptance flag will be ignored.

    
 ## Module Dependencies
- During any operation, if a dependent module (something else depends on the module) is installed and RequiredLicenseAcceptance is True, then the license acceptance behavior (above) will be required.
- If the module version is already listed in the local catalog as being installed on the system, we would bypass the license checking.
- During any operation, if a dependent module requires a license, and the license acceptance does not occur, the operation will fail and follow normal processes for the item failed to install/save/update.

 ## Impact on -Force

Specifying –Force is NOT sufficient to accept a license. –AcceptLicense is required for permission to install. If –Force is specified, RequiredLicenseAcceptance is True, and –AcceptLicense is NOT specified, the operation will fail.


## Scripts
License Acceptance is not supported for scripts. However, the scenario where a script depends on a module that requires license acceptance is supported.

Script commands will support a new parameter -AcceptLicense that will behave as though user saw the license. If -AcceptLicense is not specified; the user will be shown license.txt for dependent module and prompted to accept the license.

## EXAMPLES

### Example 1: Update Module Manifest to include require license acceptance
```
PS C:\Users\farehar> Update-ModuleManifest -Path C:\modulemanifest.psd1 -RequireLicenseAcceptance

This command updates the manifest file and sets the RequireLicenseAcceptance flag to true.

PrivateData = @{

    PSData = @{
        # Flag to indicate whether the module requires explicit user acceptance
        RequireLicenseAcceptance = $true
    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

