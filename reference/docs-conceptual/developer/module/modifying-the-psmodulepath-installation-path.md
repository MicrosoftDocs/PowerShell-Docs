---
ms.date: 09/13/2016
ms.topic: reference
title: Modifying the PSModulePath Installation Path
description: Modifying the PSModulePath Installation Path
---
# Modifying the PSModulePath Installation Path

The `PSModulePath` environment variable stores the paths to the locations of the modules that are
installed on disk. PowerShell uses this variable to locate modules when the user does not specify
the full path to a module. The paths in this variable are searched in the order in which they
appear.

When PowerShell starts, `PSModulePath` is created as a system environment variable with the
following default value: `$HOME\Documents\PowerShell\Modules; $PSHOME\Modules` on Windows and
`$HOME/.local/share/powershell/Modules: usr/local/share/powershell/Modules` on Linux or Mac, and
`$HOME\Documents\WindowsPowerShell\Modules; $PSHOME\Modules` for Windows PowerShell.

> [!NOTE]
> The user-specific **CurrentUser** location is the `WindowsPowerShell\Modules` folder located in
> the **Documents** location in your user profile. The specific path of that location varies by
> version of Windows and whether or not you are using folder redirection. By default, on Windows 10,
> that location is `$HOME\Documents\WindowsPowerShell\Modules`.

## To view the PSModulePath variable

To view the paths that are specified in the `PSModulePath` variable, type the following command:

`$env:PSModulePath`

## To add locations to the PSModulePath variable

To add paths to this variable, use one of the following methods:

- To add a temporary value that is available only for the current session, run the following command
  at the command line:

  `$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$MyModulePath"`

- To add a persistent value that is available whenever a session is opened, add the above command to
  a PowerShell profile file (`$PROFILE`)>

  For more information about profiles, see [about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles).

- To add a persistent variable to the registry, create a new user environment variable called
  `PSModulePath` using the Environment Variables Editor in the **System Properties** dialog box.

- To add a persistent variable by using a script, use the .Net method [SetEnvironmentVariable](/dotnet/api/system.environment.setenvironmentvariable)
  on the [System.Environment](/dotnet/api/system.environment) class. For
  example, the following script adds the `C:\Program Files\Fabrikam\Module` path to the value of the
  `PSModulePath` environment variable for the computer. To add the path to the user `PSModulePath`
  environment variable, set the target to "User".

  ```powershell
  $CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
  [Environment]::SetEnvironmentVariable("PSModulePath", $CurrentValue + [System.IO.Path]::PathSeparator + "C:\Program Files\Fabrikam\Modules", "Machine")

  ```

## To remove locations from the PSModulePath

You can remove paths from the variable using similar methods: for example, `$env:PSModulePath = $env:PSModulePath -replace "$([System.IO.Path]::PathSeparator)c:\\ModulePath"`
will remove the **c:\ModulePath** path from the current session.

## See Also

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)

[about_Modules](/powershell/module/microsoft.powershell.core/about/about_modules)
