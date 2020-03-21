---
keywords: powershell,cmdlet
locale: en-us
ms.date: 03/21/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility?view=powershell-7.x&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Windows_PowerShell_Compatibility
---
# About Windows PowerShell compatibility

## SHORT DESCRIPTION

Describes the Windows PowerShell Compatibility functionality for PowerShell 7.

## LONG DESCRIPTION

Unless the module manifest indicates that module is compatible with PowerShell
Core, modules in the `%windir%\system32\WindowsPowerShell\v1.0\Modules` folder
are loaded in a background Windows PowerShell 5.1 process by Windows PowerShell
Compatibility feature. That module is used via implicit remoting reflected into
current PowerShell session.

Windows PowerShell Compatibility blocks loading of modules that are listed in
the `WindowsPowerShellCompatibilityModuleDenyList` setting in PowerShell
configuration file.

The default value of this setting:

```json
"WindowsPowerShellCompatibilityModuleDenyList":  [
   "PSScheduledJob","BestPractices","UpdateServices"
]
```

The compatibility feature can be invoked in three ways:

1. Explicitly using module import with `-UseWindowsPowerShell` parameter

   ```powershell
   Import-Module -Name ScheduledTasks -UseWindowsPowerShell
   ```

1. Implicitly using module import by module name or path

   ```powershell
   Import-Module -Name ServerManager
   ```

1. Implicitly by command discovery / module autoload

   ```powershell
   Get-WindowsFeature
   ```

   This autoloads ServerManager module using Windows PowerShell Compatibility.

To disable implicit Windows PowerShell Compatibility import (cases 2 and 3
above) you can use `DisableImplicitWinCompat` setting in PowerShell
configuration file.

```powershell
$ConfigPath = "$PSHOME\DisableWinCompat.powershell.config.json"
$ConfigJSON = ConvertTo-Json -InputObject @{
  "DisableImplicitWinCompat" = $false
  "Microsoft.PowerShell:ExecutionPolicy" = "RemoteSigned"
}
$ConfigJSON | Out-File -Force $ConfigPath
pwsh -settingsFile $ConfigPath
```

When the first module is imported using Windows PowerShell Compatibility
functionality a `WinPSCompatSession` remoting session is created using the same
transport used for PowerShell jobs. This remoting session can be used for
operations that do not work correctly on deserialized objects. The entire
pipeline is executed in Windows PowerShell and only the final result is
returned.

```powershell
$s = Get-PSSession -Name WinPSCompatSession
Invoke-Command -Session $s -ScriptBlock {
  "Running in Windows PowerShell version $($PSVersionTable.PSVersion)"
}
```

The background Windows PowerShell 5.1 process is created when the first module
is imported using Windows PowerShell Compatibility feature. The process is
closed when the last such module is removed (using `Remove-Module`) or when
PowerShell process exits.

When a module is imported using the Windows PowerShell Compatibility feature,
implicit remoting generates a proxy module in user `$env:Temp` directory and
imports this proxy module into current PowerShell session. This allows
PowerShell to detect that the module was loaded using Windows PowerShell
Compatibility functionality.

For more the latest information about module compatibility, see the
[PowerShell 7 module compatibility](https://aka.ms/PSModuleCompat) list.

## LIMITATIONS

The Windows PowerShell Compatibility functionality:

1. Only works locally on Windows OS
1. Requires that Windows PowerShell 5.1 is installed on the system (Can be
   installed via [WMF 5.1](/powershell/scripting/wmf/setup/install-configure)
   on older OSes.)
1. Operates on serialized cmdlet parameters and return values (not on live
   objects)
1. All modules imported into the Windows PowerShell remoting session share the
   same runspace.

## KEYWORDS

about_Windows_PowerShell_Compatibility

## SEE ALSO

[about_Modules](about_Modules.md)

[Import-Module](../Import-Module.md)
