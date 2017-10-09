---
ms.date:  2017-06-09
schema:  2.0.0
keywords:  powershell
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

## Impact on Install/Save/Update-Module

- Install/Save/Update cmdlets will support a new parameter –AcceptLicense that will behave as though the user saw the license.
- If RequiredLicenseAcceptance is True and –AcceptLicense is not specified, the user will be shown the license.txt, and prompted with: &quot;Do you accept these license terms (Yes/No/YesToAll/NoToAll)&quot;.
  - If the license is accepted
    - **Save-Module:** the module will be copied to the user&#39;s system
    - **Install-Module:** the module will be copied to the user&#39;s system to the proper folder (based on scope)
    - **Update-Module:** the module will be updated.
  - If the license is declined. 
    - Operation will be cancelled.
- All cmdlets will check for the metadata(requireLicenseAcceptance and Format Version) that says a license acceptance is required
  - If format version of client is older than 2.0, operation will fail and ask the user to update the client.
  - If module was published with format version older than 2.0, requireLicenseAcceptance flag will be ignored.

    
 ## Module Dependencies
- During Install/Save/Update operation, if a dependent module(something else depends on the module) requires license acceptance, then the license acceptance behavior (above) will be required.
- If the module version is already listed in the local catalog as being installed on the system, we would bypass the license checking.
- During Install/Save/Update operation, if a dependent module requires a license, and the license acceptance does not occur, the operation will fail and follow normal processes for the item failed to install/save/update.

 ## Impact on -Force

Specifying –Force is NOT sufficient to accept a license. –AcceptLicense is required for permission to install. If –Force is specified, RequiredLicenseAcceptance is True, and –AcceptLicense is NOT specified, the operation will fail.

## EXAMPLES

### Example 1: Update Module Manifest to require license acceptance
```PowerShell
PS C:\> Update-ModuleManifest -Path C:\modulemanifest.psd1 -RequireLicenseAcceptance

PrivateData = @{

    PSData = @{
        # Flag to indicate whether the module requires explicit user acceptance
        RequireLicenseAcceptance = $true
    } # End of PSData hashtable
    
 } # End of PrivateData hashtable
```
This command updates the manifest file and sets the RequireLicenseAcceptance flag to true.
### Example 2: Install Module requiring license acceptance
```PowerShell
PS C:\> Install-Module -Name ModuleRequireLicenseAcceptance

License Acceptance

License 2.0
Copyright (c) 2016 PowerShell Team
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.

Do you accept the license terms for module 'ModuleRequireLicenseAcceptance'.
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): 

```
This command shows the license from license.txt file and prompts the user to accept the license.

### Example 3: Install Module requiring license acceptance with -AcceptLicense
```PowerShell
PS C:\> Install-Module -Name ModuleRequireLicenseAcceptance -AcceptLicense
```
Module is installed without any prompt to accept license.

### Example 4: Install Module requiring license acceptance with -Force
```PowerShell
PS C:\> Install-Module -Name ModuleRequireLicenseAcceptance -Force
PackageManagement\Install-Package : License Acceptance is required for module 'ModuleRequireLicenseAcceptance'. Please specify '-AcceptLicense' to perform this operation.
At C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.1.3.3\PSModule.psm1:1837 char:21
+ ...          $null = PackageManagement\Install-Package @PSBoundParameters
+                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (Microsoft.Power....InstallPackage:InstallPackage) [Install-Package], E
   xception
    + FullyQualifiedErrorId : ForceAcceptLicense,Install-PackageUtility,Microsoft.PowerShell.PackageManagement.Cmdlets
   .InstallPackage
```

### Example 5: Install Module with dependencies requiring license acceptance
Module 'ModuleWithDependency' depends on module 'ModuleRequireLicenseAcceptance'. User is prompted to Accept License.
```PowerShell
PS C:\> Install-Module -Name ModuleWithDependency

License Acceptance
MIT License 2.0
Copyright (c) 2016 PowerShell Team
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.

Do you accept the license terms for module 'ModuleRequireLicenseAcceptance'.
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): 
```

### Example 6: Install Module with dependencies requiring license acceptance and -AcceptLicense
Module 'ModuleWithDependency' depends on module 'ModuleRequireLicenseAcceptance'. User is not prompted to accept license as -AcceptLicense is specified.
```PowerShell
PS C:\>  Install-Module -Name ModuleWithDependency -AcceptLicense
```
### Example 7: Install module requiring license acceptance on a client older than PSGetFormatVersion 2.0
```PowerShell
PS C:\windows\system32> Install-Module -Name ModuleRequireLicenseAcceptance

WARNING: The specified module 'ModuleRequireLicenseAcceptance' with PowerShellGetFormatVersion '2.0' is not supported by the current version of PowerShellGet. Get the latest version of the PowerShellGet module to install this module, 'ModuleRequireLicenseAcceptance'.

```
### Example 8: Save Module requiring license acceptance
```PowerShell
PS C:\> Save-Module -Name ModuleRequireLicenseAcceptance -Path C:\Saved

License Acceptance

License 2.0
Copyright (c) 2016 PowerShell Team
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.

Do you accept the license terms for module 'ModuleRequireLicenseAcceptance'.
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): 
```
This command shows the license from license.txt file and prompts the user to accept the license.

### Example 9: Save Module requiring license acceptance with -AcceptLicense
```PowerShell
PS C:\> Save-Module -Name ModuleRequireLicenseAcceptance -AcceptLicense -Path C:\Saved
```
Module is saved without any prompt to accept license.

### Example 10: Update Module requiring license acceptance
```PowerShell
PS C:\> Update-Module -Name ModuleRequireLicenseAcceptance

License Acceptance

License 2.0
Copyright (c) 2016 PowerShell Team
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.

Do you accept the license terms for module 'ModuleRequireLicenseAcceptance'.
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): 
```
This command shows the license from license.txt file and prompts the user to accept the license.

### Example 11: Update Module requiring license acceptance with -AcceptLicense
```PowerShell
PS C:\> Update-Module -Name ModuleRequireLicenseAcceptance -AcceptLicense
```
Module is updated without any prompt to accept license.

## More details
### [Require License Acceptance for Scripts](../script/script_RequireLicenseAcceptance.md)

### [Require License Acceptance support on PowerShellGallery](../../psgallery/psgallery_requires_license_acceptance.md)

### [Require License Acceptance on Deploy to Azure Automation](../../psgallery/psgallery_deploy_to_azure_automation_requireLicenseAcceptance.md)
