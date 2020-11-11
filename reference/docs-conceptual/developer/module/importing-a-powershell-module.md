---
ms.date: 02/03/2020
ms.topic: reference
title: Importing a PowerShell Module
description: Importing a PowerShell Module
---
# Importing a PowerShell Module

Once you have installed a module on a system, you will likely want to import the module. Importing
is the process that loads the module into active memory, so that a user can access that module in
their PowerShell session. In PowerShell 2.0, you can import a newly-installed PowerShell module with
a call to [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) cmdlet. In
PowerShell 3.0, PowerShell is able to implicitly import a module when one of the functions or
cmdlets in the module is called by a user. Note that both versions assume that you install your
module in a location where PowerShell is able to find it; for more information, see [Installing a PowerShell Module](./installing-a-powershell-module.md).
You can use a module manifest to restrict what parts of your module are exported, and you can use
parameters of the `Import-Module` call to restrict what parts are imported.

## Importing a Snap-In (PowerShell 1.0)

Modules did not exist in PowerShell 1.0: instead, you had to register and use snap-ins. However, it
is not recommended that you use this technology at this point, as modules are generally easier to
install and import. For more information, see [How to Create a Windows PowerShell Snap-in](../cmdlet/how-to-create-a-windows-powershell-snap-in.md).

## Importing a Module with Import-Module (PowerShell 2.0)

PowerShell 2.0 uses the appropriately-named [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)
cmdlet to import modules. When this cmdlet is run, Windows PowerShell searches for the specified
module within the directories specified in the `PSModulePath` variable. When the specified directory
is found, Windows PowerShell searches for files in the following order: module manifest files
(.psd1), script module files (.psm1), binary module files (.dll). For more information about adding
directories to the search, see [Modifying the PSModulePath Installation Path](./modifying-the-psmodulepath-installation-path.md).
The following code describes how to import a module:

```powershell
Import-Module myModule
```

Assuming that myModule was located in the `PSModulePath`, PowerShell would load myModule into active
memory. If myModule was not located on a `PSModulePath` path, you could still explicitly tell
PowerShell where to find it:

```powershell
Import-Module -Name C:\myRandomDirectory\myModule -Verbose
```

You can also use the `-Verbose` parameter to identify what is being exported out of the module, and
what is being imported into active memory. Both exports and imports restrict what is exposed to the
user: the difference is who is controlling the visibility. Essentially, exports are controlled by
code within the module. In contrast, imports are controlled by the `Import-Module` call. For more
information, see **Restricting Members That Are Imported**, below.

## Implicitly Importing a Module (PowerShell 3.0)

Beginning in Windows PowerShell 3.0, modules are imported automatically when any cmdlet or function
in the module is used in a command. This feature works on any module in a directory that this
included in the value of the **PSModulePath** environment variable. If you do not save your module
on a valid path however, you can still load them using the explicit [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)
option, described above.

The following actions trigger automatic importing of a module, also known as "module auto-loading."

- Using a cmdlet in a command. For example, typing `Get-ExecutionPolicy` imports the
  Microsoft.PowerShell.Security module that contains the `Get-ExecutionPolicy` cmdlet.

- Using the [Get-Command](/powershell/module/Microsoft.PowerShell.Core/Get-Command) cmdlet to get
  the command. For example, typing `Get-Command Get-JobTrigger` imports the **PSScheduledJob**
  module that contains the `Get-JobTrigger` cmdlet. A `Get-Command` command that includes wildcard
  characters is considered to be discovery and does not trigger importing of a module.

- Using the [Get-Help](/powershell/module/Microsoft.PowerShell.Core/Get-Help) cmdlet to get help for
  a cmdlet. For example, typing `Get-Help Get-WinEvent` imports the Microsoft.PowerShell.Diagnostics
  module that contains the `Get-WinEvent` cmdlet.

To support automatic importing of modules, the `Get-Command` cmdlet gets all cmdlets and functions
in all installed modules, even if the module is not imported into the session. For more information,
see the help topic for the [Get-Command](/powershell/module/Microsoft.PowerShell.Core/Get-Command)
cmdlet.

## The Importing Process

When a module is imported, a new session state is created for the module, and a [System.Management.Automation.PSModuleInfo](/dotnet/api/System.Management.Automation.PSModuleInfo)
object is created in memory. A session-state is created for each module that is imported (this
includes the root module and any nested modules). The members that are exported from the root
module, including any members that were exported to the root module by any nested modules, are then
imported into the caller's session state.

The metadata of members that are exported from a module have a ModuleName property. This property is
populated with the name of the module that exported them.

> [!WARNING]
> If the name of an exported member uses an unapproved verb or if the name of the member uses
> restricted characters, a warning is displayed when the [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)
> cmdlet is run.

By default, the [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module) cmdlet
does not return any objects to the pipeline. However, the cmdlet supports a **PassThru** parameter
that can be used to return a [System.Management.Automation.PSModuleInfo](/dotnet/api/System.Management.Automation.PSModuleInfo)
object for each module that is imported. To send output to the host, users should run the [Write-Host](/powershell/module/Microsoft.PowerShell.Utility/Write-Host)
cmdlet.

## Restricting  the Members That Are Imported

When a module is imported by using the [Import-Module](/powershell/module/Microsoft.PowerShell.Core/Import-Module)
cmdlet, by default, all exported module members are imported into the session, including any
commands exported to the module by a nested module. By default, variables and aliases are not
exported. To restrict the members that are exported, use a [module manifest](./how-to-write-a-powershell-module-manifest.md).
To restrict the members that are imported, use the following parameters of the `Import-Module`
cmdlet.

- **Function**: This parameter restricts the functions that are exported. (If you are using a module
  manifest, see the FunctionsToExport key.)

- `**Cmdlet**: This parameter restricts the cmdlets that are exported (If you are using a module
  manifest, see the CmdletsToExport key.)

- **Variable**: This parameter restricts the variables that are exported (If you are using a module
  manifest, see the VariablesToExport key.)

- **Alias**: This parameter restricts the aliases that are exported (If you are using a module
  manifest, see the AliasesToExport key.)

## See Also

[Writing a Windows PowerShell Module](./writing-a-windows-powershell-module.md)
