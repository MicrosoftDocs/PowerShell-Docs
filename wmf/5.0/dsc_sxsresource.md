---
ms.date:  06/12/2017


keywords:  wmf,powershell,setup
---

# Side-By-Side Module Versioning Support for DSC Resources

Modules containing DSC resources can be installed side-by-side, and DSC configurations can use a specific version of the resource that is installed on the system.

For more information, see [Using resources with multiple versions](https://msdn.microsoft.com/powershell/dsc/sxsresource).

## Known issues

In this release, the following are known issues of side-by-side installation:

-   Using two different versions of the DSC resource within the same configuration is not supported.
