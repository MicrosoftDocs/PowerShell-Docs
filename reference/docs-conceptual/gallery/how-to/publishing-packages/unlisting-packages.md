---
ms.date:  06/12/2017
title:  Unlisting packages
description: The PowerShell Gallery does not support users permanently deleting their packages. This enables others to take dependencies on your packages without worrying about possible breaks in the future.
---
# Unlisting Packages

**Why is removing a package from PowerShell Gallery not exposed as an option?**

The PowerShell Gallery does not support users permanently deleting their packages. This enables
others to take dependencies on your packages without worrying about possible breaks in the future.
For example, if the Pester module depends on the Azure module and the Azure module is removed from
the gallery, then users can no longer use the Pester module.

Instead of removing a package you can unlist it.

**What does unlisting a package on PowerShell Gallery do?**

Unlisting a package such as a module or script in the PowerShell Gallery removes it from the
Packages tab. In addition, unlisted packages will not be discoverable using the search bar. The only
way to download an unlisted package is to specify the exact name and version of the package. Because
of this, the unlisting of a package will not break other modules or scripts that depend on it.

To unlist your package, visit the package details page and select 'Delete Module'. Uncheck the
'Listed' checkbox, and select 'Save'.

**How can I remove a package?**

If you experience a scenario where package deletion is necessary, contact the PowerShell Gallery
Administrators. Valid deletion scenarios are:

- Issues of copyright infringement.
- Package contains potentially harmful content.
- Package contains sensitive data.

To submit a Delete Package Request to the PowerShell Gallery Administrators, visit your package's
detail page and select Contact Support.
