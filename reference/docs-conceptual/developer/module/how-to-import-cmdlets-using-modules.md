---
ms.date: 08/28/2019
ms.topic: reference
title: How to Import Cmdlets Using Modules
description: How to Import Cmdlets Using Modules
---

# How to Import Cmdlets Using Modules

This article describes how to import cmdlets to a PowerShell session by using a binary module.

> [!NOTE]
> The members of modules can include cmdlets, providers, functions, variables, aliases, and much
> more. Snap-ins can contain only cmdlets and providers.

## How to load cmdlets using a module

1. Create a module folder that has the same name as the assembly file in which the cmdlets are
   implemented. In this procedure, the module folder is created in the Windows `system32` folder.

   `%SystemRoot%\system32\WindowsPowerShell\v1.0\Modules\mymodule`

1. Make sure that the `PSModulePath` environment variable includes the path to your new module
   folder. By default, the system folder is already added to the `PSModulePath` environment
   variable. To view the `PSModulePath`, type: `$env:PSModulePath`.

1. Copy the cmdlet assembly into the module folder.

1. Add a module manifest file (`.psd1`) in the module's root folder. PowerShell uses the module
   manifest to import your module. For more information, see [How to Write a PowerShell Module Manifest](../module/how-to-write-a-powershell-module-manifest.md).

1. Run the following command to add the cmdlets to the session:

   `Import-Module [Module_Name]`

   This procedure can be used to test your cmdlets. It adds all the cmdlets in the assembly to the
   session. For more information about modules, see [Writing a Windows PowerShell Module](../module/writing-a-windows-powershell-module.md).

## See also

[How to Write a PowerShell Module Manifest](../module/how-to-write-a-powershell-module-manifest.md)

[Importing a PowerShell Module](../module/importing-a-powershell-module.md)

[Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)

[Installing Modules](../module/installing-a-powershell-module.md)

[Modifying the PSModulePath Installation Path](../module/modifying-the-psmodulepath-installation-path.md)

[Writing a Windows PowerShell Cmdlet](../cmdlet/cmdlet-overview.md)
