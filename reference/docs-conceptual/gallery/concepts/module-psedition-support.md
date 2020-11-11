---
ms.date: 06/10/2020
title:  Modules with compatible PowerShell Editions
description: This article explains how the PowerShellGet cmdlets support the Desktop and Core editions of PowerShell modules.
---
# Modules with compatible PowerShell Editions

Starting with version 5.1, PowerShell is available in different editions, which denote varying
feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework, applies to Windows PowerShell v4.0 and below as well
  as Windows PowerShell 5.1 on Windows Desktop, Windows Server, Windows Server Core and most other
  Windows editions.
- **Core Edition:** Built on .NET Core, applies to PowerShell Core 6.0 and above as well as
  Windows PowerShell 5.1 on reduced footprint Windows Editions such as Windows IoT and Windows
  Nanoserver.

For more information on PowerShell editions, see [about_PowerShell_Editions][].

## Declaring compatible editions

Module authors can declare their modules to be compatible with one or more PowerShell editions using
the `CompatiblePSEditions` module manifest key. This key is only supported on PowerShell 5.1 or
later.

> [!NOTE]
> Once a module manifest is specified with the `CompatiblePSEditions` key or uses the `$PSEdition`
> variable, it can not be imported on PowerShell v4 or lower.

```powershell
New-ModuleManifest -Path .\TestModuleWithEdition.psd1 -CompatiblePSEditions Desktop,Core -PowerShellVersion 5.1
$ModuleInfo = Test-ModuleManifest -Path .\TestModuleWithEdition.psd1
$ModuleInfo.CompatiblePSEditions
```

```Output
Desktop
Core
```

```powershell
$ModuleInfo | Get-Member CompatiblePSEditions
```

```Output
   TypeName: System.Management.Automation.PSModuleInfo

Name                 MemberType Definition
----                 ---------- ----------
CompatiblePSEditions Property   System.Collections.Generic.IEnumerable[string] CompatiblePSEditions {get;}
```

When getting a list of available modules, you can filter the list by PowerShell edition.

```powershell
Get-Module -ListAvailable -PSEdition Desktop
```

```Output
    Directory: C:\Program Files\WindowsPowerShell\Modules

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0        ModuleWithPSEditions
```

```powershell
Get-Module -ListAvailable -PSEdition Core | % CompatiblePSEditions
```

```Output
Desktop
Core
```

Beginning in PowerShell 6, the `CompatiblePSEditions` value is used to decide if a module is
compatible when modules are imported from `$env:windir\System32\WindowsPowerShell\v1.0\Modules`.
This behavior only applies to Windows. Outside of this scenario, the value is only used as metadata.

## Finding compatible modules

PowerShell Gallery users can find the list of modules supported on a specific PowerShell Edition
using tags **PSEdition_Desktop** and **PSEdition_Core**.

Modules without **PSEdition_Desktop** and **PSEdition_Core** tags are considered to work fine on
PowerShell Desktop editions.

```powershell
# Find modules supported on PowerShell Desktop edition
Find-Module -Tag PSEdition_Desktop

# Find modules supported on PowerShell Core editions
Find-Module -Tag PSEdition_Core
```

## Targeting multiple editions

Module authors can publish a single module targeting to either or both PowerShell editions (Desktop
and Core).

A single module can work on both Desktop and Core editions, in that module author has to add
required logic in either RootModule or in the module manifest using `$PSEdition` variable. Modules
can have two sets of compiled DLLs targeting both **CoreCLR** and **FullCLR**. Here are the
packaging options with logic for loading proper DLLs.

### Option 1: Packaging a module for targeting multiple versions and multiple editions of PowerShell

Module folder contents

- Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules.dll
- Microsoft.Windows.PowerShell.ScriptAnalyzer.dll
- PSScriptAnalyzer.psd1
- PSScriptAnalyzer.psm1
- ScriptAnalyzer.format.ps1xml
- ScriptAnalyzer.types.ps1xml
- coreclr\Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules.dll
- coreclr\Microsoft.Windows.PowerShell.ScriptAnalyzer.dll
- en-US\about_PSScriptAnalyzer.help.txt
- en-US\Microsoft.Windows.PowerShell.ScriptAnalyzer.dll-Help.xml
- PSv3\Microsoft.Windows.PowerShell.ScriptAnalyzer.BuiltinRules.dll
- PSv3\Microsoft.Windows.PowerShell.ScriptAnalyzer.dll
- Settings\CmdletDesign.psd1
- Settings\DSC.psd1
- Settings\ScriptFunctions.psd1
- Settings\ScriptingStyle.psd1
- Settings\ScriptSecurity.psd1

Contents of `PSScriptAnalyzer.psd1` file

```powershell
@{

# Author of this module
Author = 'Microsoft Corporation'

# Script module or binary module file associated with this manifest.
RootModule = 'PSScriptAnalyzer.psm1'

# Version number of this module.
ModuleVersion = '1.6.1'

# ---
}
```

Below logic loads the required assemblies depending on the current edition or version.

Contents of `PSScriptAnalyzer.psm1` file:

```powershell
#
# Script module for module 'PSScriptAnalyzer'
#
Set-StrictMode -Version Latest

# Set up some helper variables to make it easier to work with the module
$PSModule = $ExecutionContext.SessionState.Module
$PSModuleRoot = $PSModule.ModuleBase

# Import the appropriate nested binary module based on the current PowerShell version
$binaryModuleRoot = $PSModuleRoot


if (($PSVersionTable.Keys -contains "PSEdition") -and ($PSVersionTable.PSEdition -ne 'Desktop')) {
    $binaryModuleRoot = Join-Path -Path $PSModuleRoot -ChildPath 'coreclr'
}
else
{
    if ($PSVersionTable.PSVersion -lt [Version]'5.0')
    {
        $binaryModuleRoot = Join-Path -Path $PSModuleRoot -ChildPath 'PSv3'
    }
}

$binaryModulePath = Join-Path -Path $binaryModuleRoot -ChildPath 'Microsoft.Windows.PowerShell.ScriptAnalyzer.dll'
$binaryModule = Import-Module -Name $binaryModulePath -PassThru

# When the module is unloaded, remove the nested binary module that was loaded with it
$PSModule.OnRemove = {
    Remove-Module -ModuleInfo $binaryModule
}
```

### Option 2: Use $PSEdition variable in the PSD1 file to load the proper DLLs

In PS 5.1 or newer, `$PSEdition` global variable is allowed in the module manifest file. Using this
variable, module author can specify the conditional values in the module manifest file. `$PSEdition`
variable can be referenced in restricted language mode or a Data section.

Sample module manifest file with `CompatiblePSEditions` key.

```powershell
@{
    # Script module or binary module file associated with this manifest.
    RootModule = if($PSEdition -eq 'Core')
    {
        'coreclr\MyCoreClrRM.dll'
    }
    else # Desktop
    {
        'clr\MyFullClrRM.dll'
    }

    # Supported PSEditions
    CompatiblePSEditions = 'Desktop', 'Core'

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules = if($PSEdition -eq 'Core')
    {
        'coreclr\MyCoreClrNM1.dll',
        'coreclr\MyCoreClrNM2.dll'
    }
    else # Desktop
    {
        'clr\MyFullClrNM1.dll',
        'clr\MyFullClrNM2.dll'
    }
}
```

Module contents

- ModuleWithEditions\ModuleWithEditions.psd1
- ModuleWithEditions\clr\MyFullClrNM1.dll
- ModuleWithEditions\clr\MyFullClrNM2.dll
- ModuleWithEditions\clr\MyFullClrRM.dll
- ModuleWithEditions\coreclr\MyCoreClrNM1.dll
- ModuleWithEditions\coreclr\MyCoreClrNM2.dll
- ModuleWithEditions\coreclr\MyCoreClrRM.dll

## More details

[Scripts with PSEditions](script-psedition-support.md)

[PSEditions support on PowerShellGallery](../how-to/finding-packages/searching-by-compatibility.md)

[Update module manifest](/powershell/module/powershellget/update-modulemanifest)

[about_PowerShell_Editions][]

[about_PowerShell_Editions]: /powershell/module/Microsoft.PowerShell.Core/About/about_PowerShell_Editions
