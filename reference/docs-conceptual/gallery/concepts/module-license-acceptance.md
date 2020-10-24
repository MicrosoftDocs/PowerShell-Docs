---
ms.date:  06/09/2017
title:  Modules Requiring License Acceptance
description: The article explains how to work with modules published in the PowerShell Gallery that require acceptance of an end user license.
---
# Modules Requiring License Acceptance

## SYNOPSIS

Legal departments for some module publishers require that customers must explicitly accept the
license before installing their module from PowerShell Gallery. If a user installs, updates, or
saves a module using PowerShellGet, whether directly or as a dependency for another package, and
that module requires the user to agree to a license, the user must indicate they accept the license
or the operation fails.

## Publish Requirements for Modules

Modules that would like to require users to accept license should fulfill following requirements:

- PSData section of module manifest should include RequireLicenseAcceptance = $True.
- Module should contain license.txt file in root directory.
- Module manifest should contain License Uri.
- Module should be published with PowerShellGet Format Version 2.0 and above.

## Impact on Install/Save/Update-Module

- Install/Save/Update cmdlets support a new parameter **AcceptLicense** that behaves as though
  the user saw the license.
- If **RequiredLicenseAcceptance** is True and **AcceptLicense** is not specified, the user is shown
  the `license.txt`, and prompted with: `Do you accept these license terms
  (Yes/No/YesToAll/NoToAll)`.
  - If the license is accepted
    - **Save-Module:** the module is copied to the user's system
    - **Install-Module:** the module is copied to the user's system to the proper folder (based on
      scope)
    - **Update-Module:** the module is updated.
  - If the license is declined.
    - Operation is canceled.
    - All cmdlets check for the metadata (**requireLicenseAcceptance** and Format Version) that says
      a license acceptance is required
    - If format version of client is older than 2.0, operation fails and asks the user to update the
      client.
    - If module was published with format version older than 2.0, requireLicenseAcceptance flag is
      ignored.

## Module Dependencies

- During Install/Save/Update operation, if a dependent module(something else depends on the module)
  requires license acceptance, then the license acceptance behavior (above) is required.
- If the module version is already listed in the local catalog as being installed on the system, we
  would bypass the license checking.
- During Install/Save/Update operation, if a dependent module requires a license, and the license
  acceptance does not occur, the operation fails and follows normal processes for the package
  failed to install/save/update.

## Impact on -Force

Specifying `–Force` is NOT sufficient to accept a license. `–AcceptLicense` is required for
permission to install. If `–Force` is specified, RequiredLicenseAcceptance is True, and
`–AcceptLicense` is NOT specified, the operation fails.

## EXAMPLES

### Example 1: Update Module Manifest to require license acceptance

```powershell
Update-ModuleManifest -Path C:\modulemanifest.psd1 -RequireLicenseAcceptance -PrivateData @{
    PSData = @{
        # Flag to indicate whether the module requires explicit user acceptance
        RequireLicenseAcceptance = $true
    } # End of PSData hashtable

 } # End of PrivateData hashtable
```

This command updates the manifest file and sets the RequireLicenseAcceptance flag to true.

### Example 2: Install Module requiring license acceptance

```powershell
Install-Module -Name ModuleRequireLicenseAcceptance
```

```Output
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

This command shows the license from `license.txt` file and prompts the user to accept the license.

### Example 3: Install Module requiring license acceptance with -AcceptLicense

```powershell
Install-Module -Name ModuleRequireLicenseAcceptance -AcceptLicense
```

Module is installed without any prompt to accept license.

### Example 4: Install Module requiring license acceptance with -Force

```powershell
Install-Module -Name ModuleRequireLicenseAcceptance -Force
```

```Output
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

Module **ModuleWithDependency** depends on module **ModuleRequireLicenseAcceptance**. User is
prompted to accept license.

```powershell
Install-Module -Name ModuleWithDependency
```

```Output
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

Module **ModuleWithDependency** depends on module **ModuleRequireLicenseAcceptance**. User is not
prompted to accept license as **AcceptLicense** is specified.

```powershell
Install-Module -Name ModuleWithDependency -AcceptLicense
```

### Example 7: Install module requiring license acceptance on a client older than PSGetFormatVersion 2.0

```powershell
Install-Module -Name ModuleRequireLicenseAcceptance
```

```Output
WARNING: The specified module 'ModuleRequireLicenseAcceptance' with PowerShellGetFormatVersion
'2.0' is not supported by the current version of PowerShellGet. Get the latest version of the
PowerShellGet module to install this module, 'ModuleRequireLicenseAcceptance'.
```

### Example 8: Save Module requiring license acceptance

```powershell
Save-Module -Name ModuleRequireLicenseAcceptance -Path C:\Saved
```

```Output
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

This command shows the license from `license.txt` file and prompts the user to accept the license.

### Example 9: Save Module requiring license acceptance with -AcceptLicense

```powershell
Save-Module -Name ModuleRequireLicenseAcceptance -AcceptLicense -Path C:\Saved
```

Module is saved without any prompt to accept license.

### Example 10: Update Module requiring license acceptance

```powershell
Update-Module -Name ModuleRequireLicenseAcceptance
```

```Output
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

This command shows the license from `license.txt` file and prompts the user to accept the license.

### Example 11: Update Module requiring license acceptance with -AcceptLicense

```powershell
Update-Module -Name ModuleRequireLicenseAcceptance -AcceptLicense
```

Module is updated without any prompt to accept license.

## More details

[Require License Acceptance for Scripts](./script-license-acceptance.md)

[Require License Acceptance support on PowerShellGallery](../how-to/working-with-packages/packages-that-require-license-acceptance.md)

[Require License Acceptance on Deploy to Azure Automation](../how-to/working-with-packages/deploy-to-azure-automation.md)
