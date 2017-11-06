---
ms.date:  2017-06-09
schema:  2.0.0
keywords:  powershell
title:  RequireLicenseAcceptanceScript
---

# Requiring License Acceptance for Scripts

License Acceptance is not supported for scripts. However, the scenario where a script depends on a module that requires license acceptance is supported.

Script commands(Install-Script/Save-Script/Update-Script) support a new parameter -AcceptLicense that behaves as though user saw the license. If -AcceptLicense is not specified; the user will be shown license.txt for dependent module and prompted to accept the license.

## EXAMPLES

### Example 1: Install Script with dependencies requiring license acceptance
Script 'ScriptRequireLicenseAcceptance' depends on module 'ModuleRequireLicenseAcceptance'. User is prompted to Accept License.
```PowerShell
PS C:\> Install-Script -Name ScriptRequireLicenseAcceptance

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

### Example 2: Install Script with dependencies requiring license acceptance and -AcceptLicense
Script 'ScriptRequireLicenseAcceptance' depends on module 'ModuleRequireLicenseAcceptance'. User is not prompted to accept license as -AcceptLicense is specified.
```PowerShell
PS C:\> Install-Script -Name ScriptRequireLicenseAcceptance -AcceptLicense
```

## More details
### [Require License Acceptance support for Modules](../module/RequireLicenseAcceptance.md)

### [Require License Acceptance support on PowerShellGallery](../../psgallery/psgallery_requires_license_acceptance.md)

### [Require License Acceptance on Deploy to Azure Automation](../../psgallery/psgallery_deploy_to_azure_automation_requireLicenseAcceptance.md)
