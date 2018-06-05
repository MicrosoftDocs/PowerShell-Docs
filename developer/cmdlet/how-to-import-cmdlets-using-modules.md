---
title: "How to Import Cmdlets Using Modules | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: a41d9e5f-de6f-47b7-9601-c108609320d0
caps.latest.revision: 8
---
# How to Import Cmdlets Using Modules

This topic describes how to import cmdlets to a Windows PowerShell session by using a binary module.

> [!NOTE]
> The members of modules can include cmdlets, providers, functions, variables, aliases, and much more. Snap-ins can contain only cmdlets and providers.

## How to load cmdlets using a module

1. Create a module folder that has the same name as the assembly file in which the cmdlets are implemented. In this procedure, the module folder is created in the `system32` folder.

   `%SystemRoot%\system32\WindowsPowerShell\v1.0\Modules\mymodule`

2. Make sure that the `PSModulePath` environment variable includes the path to your new module folder. By default, the system folder is already added to the `PSModulePath` environment variable.

3. Copy the cmdlet assembly into the module folder.

4. Run the following command to add the cmdlets to the session:

   `import-module [Module_Name]`

   This procedure can be used to test your cmdlets. It adds all the cmdlets in the assembly to the session. For more information about modules, the different types of modules, the different ways to load modules, and how to restrict the elements of a module that are exported, see [Writing a Windows PowerShell Module](../module/writing-a-windows-powershell-module.md).

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Installing Modules](../module/installing-a-powershell-module.md)