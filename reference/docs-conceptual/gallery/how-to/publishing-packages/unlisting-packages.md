---
ms.date:  06/12/2017
contributor:  JKeithB
keywords:  gallery,powershell,cmdlet,psgallery
title:  Unlisting packages
---
# Unlisting Packages

**Why is removing a package from PowerShell Gallery not exposed as an option?**

The PowerShell Gallery does not support users permanently deleting their packages.
This enables others to take dependencies on your packages without worrying about possible breaks in the future.
For example, if the Pester module depends on the Azure module and the Azure module is removed from the gallery, then user can no longer uses the Pester module.

Instead of removing an package, however, you can unlist it instead.

**What does unlisting a package on PowerShell Gallery do?**

Unlisting a package such as module or script on PowerShell Gallery will remove it from the Packages tab.
In addition, unlisted packages will not be discoverable using the search bar.
The only way to download an unlisted package is to specify the exact name and version of the package.
Because of this, the unlisting of an package will not break other modules or scripts that depend on it.

To unlist your package, visit the package details page and select 'Delete Module'. Uncheck the 'Listed' checkbox, and click Save.

**How can I remove an package?**

If you experience a scenario where package deletion is necessary, contact the PowerShell Gallery Administrators.
Valid deletion scenarios are:
- Issues of copyright infringement.
- Package contains potentially harmful content.
- Package contains sensitive data.

To submit a Delete Package Request to the PowerShell Gallery Administrators, visit your package's detail page and select Contact Support.
