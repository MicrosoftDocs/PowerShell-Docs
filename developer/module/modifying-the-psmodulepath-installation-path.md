---
title: "Modifying the PSModulePath Installation Path | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: dc5ce5a2-50e9-4c88-abf1-ac148a8a6b7b
caps.latest.revision: 15
---
# Modifying the PSModulePath Installation Path

The `PSModulePath` environment variable stores the paths to the locations of the modules that are installed on disk. Windows PowerShell uses this variable to locate modules when the user does not specify the full path to a module. The paths in this variable are searched in the order in which they appear.

When Windows PowerShell starts, `PSModulePath` is created as a system environment variable with the following default value: `$home\Documents\WindowsPowerShell\Modules; $pshome\Modules`.

## To view the PSModulePath variable

To view the paths that are specified in the `PSModulePath` variable, type the following command:

`$env:PSModulePath`

## To add locations to the PSModulePath variable

To add paths to this variable, use one of the following methods:

- To add a temporary value that is available only for the current session, run the following command at the command line:

  `$env:PSModulePath = $env:PSModulePath + ";c:\ModulePath"`

- To add a persistent value that is available whenever a session is opened, add the following command to a Windows PowerShell profile:

  `$env:PSModulePath = $env:PSModulePath + ";c:\ModulePath"`

  For more information about profiles, see [about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles) in the Microsoft TechNet library.

- To add a persistent variable to the registry, create a new user environment variable called `PSModulePath` using the Environment Variables Editor in the **System Properties** dialog box.

- To add a persistent variable by using a script, use the **SetEnvironmentVariable** method on the Environment class. For example, the following script adds the "C:\Program Files\Fabrikam\Module path to the value of the PSModulePath environment variable for the computer. To add the path to the user PSModulePath environment variable, set the target to "User".

  ```powershell
  $CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
  [Environment]::SetEnvironmentVariable("PSModulePath", $CurrentValue + ";C:\Program Files\Fabrikam\Modules", "Machine")

  ```

## To remove locations from the PSModulePath

You can remove paths from the variable using similar methods: for example, `$env:PSModulePath = $envPSModulePath -replace ";c:\\ModulePath"` will remove the **c:\ModulePath** path from the current session.

## See Also

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)
