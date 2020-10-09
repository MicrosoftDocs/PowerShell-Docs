---
description:  Describes the Windows PowerShell Compatibility functionality for PowerShell 7. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 04/22/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility?view=powershell-7&WT.mc_id=ps-gethelp
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
Compatibility feature.

### Using the Compatibility feature

When the first module is imported using Windows PowerShell Compatibility
feature, PowerShell creates a remote session named `WinPSCompatSession` that is
running in a background Windows PowerShell 5.1 process. This process is created
when the Compatibility feature imports the first module. The process is closed
when the last such module is removed (using `Remove-Module`) or when PowerShell
process exits.

The modules loaded in the `WinPSCompatSession` session are used via implicit
remoting and reflected into current PowerShell session. This is the same
transport method used for PowerShell jobs.

When a module is imported into the `WinPSCompatSession` session, implicit
remoting generates a proxy module in the user's `$env:Temp` directory and
imports this proxy module into current PowerShell session. This allows
PowerShell to detect that the module was loaded using Windows PowerShell
Compatibility functionality.

Once the session is created, it can be used for operations that don't work
correctly on deserialized objects. The entire pipeline is executed in Windows
PowerShell and only the final result is returned. For example:

```powershell
$s = Get-PSSession -Name WinPSCompatSession
Invoke-Command -Session $s -ScriptBlock {
  "Running in Windows PowerShell version $($PSVersionTable.PSVersion)"
}
```

The Compatibility feature can be invoked in two ways:

- Explicitly by importing a module using the **UseWindowsPowerShell** parameter

   ```powershell
   Import-Module -Name ScheduledTasks -UseWindowsPowerShell
   ```

- Implicitly by importing a Windows PowerShell module by module name, path, or
  autoloading via command discovery.

   ```powershell
   Import-Module -Name ServerManager
   Get-AppLockerPolicy -Local
   ```

   If not already loaded, the AppLocker module is autoloaded when you run
   `Get-AppLockerPolicy`.

Windows PowerShell Compatibility blocks loading of modules that are listed in
the `WindowsPowerShellCompatibilityModuleDenyList` setting in PowerShell
configuration file.

The default value of this setting is:

```json
"WindowsPowerShellCompatibilityModuleDenyList":  [
   "PSScheduledJob","BestPractices","UpdateServices"
]
```

### Managing implicit module loading

To disable implicit import behavior of the Windows PowerShell Compatibility
feature, use the `DisableImplicitWinCompat` setting in a PowerShell
configuration file. This setting can be added to the `powershell.config.json`
file. For more information, see
[about_powershell_config](about_powershell_config.md).

This example shows how to create a configuration file that disables the
implicit module-loading feature of Windows PowerShell Compatibility.

```powershell
$ConfigPath = "$PSHOME\DisableWinCompat.powershell.config.json"
$ConfigJSON = ConvertTo-Json -InputObject @{
  "DisableImplicitWinCompat" = $true
  "Microsoft.PowerShell:ExecutionPolicy" = "RemoteSigned"
}
$ConfigJSON | Out-File -Force $ConfigPath
pwsh -settingsFile $ConfigPath
```

For more the latest information about module compatibility, see the
[PowerShell 7 module compatibility](https://aka.ms/PSModuleCompat) list.

### Managing cmdlet clobbering

The Windows PowerShell Compatibility feature uses implicit remoting to load
modules in compatibility mode. The result is that commands exported by the
module take precedence over commands of the same name in the current PowerShell
7 session. In the PowerShell 7.0.0 release, this included the core modules that
ship with PowerShell.

In PowerShell 7.1, the behavior was changed so that the following core
PowerShell modules are not clobbered:

- Microsoft.PowerShell.ConsoleHost
- Microsoft.PowerShell.Diagnostics
- Microsoft.PowerShell.Host
- Microsoft.PowerShell.Management
- Microsoft.PowerShell.Security
- Microsoft.PowerShell.Utility
- Microsoft.WSMan.Management

PowerShell 7.1 also added the ability to list additional modules that should
not be clobbered by compatibility mode.

You can add the `WindowsPowerShellCompatibilityNoClobberModuleList` setting to
PowerShell configuration file. The value of this setting is a comma-separated
list of module names. The default value of this setting is:

```json
"WindowsPowerShellCompatibilityNoClobberModuleList": [ ]
```

## Limitations

The Windows PowerShell Compatibility functionality:

1. Only works locally on Windows computers
1. Requires that Windows PowerShell 5.1
1. Operates on serialized cmdlet parameters and return values, not on live
   objects
1. All modules imported into the Windows PowerShell remoting session share the
   same runspace.

## Keywords

about_Windows_PowerShell_Compatibility

## See also

[about_Modules](about_Modules.md)

[Import-Module](xref:Microsoft.PowerShell.Core.Import-Module)
