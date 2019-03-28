---
ms.date:  03/22/2019
contributor:  manikb
keywords:  gallery,powershell,cmdlet,psget
title:  Modules with compatible PowerShell Editions
---
# Modules with compatible PowerShell Editions

Starting with version 5.1, PowerShell is available in different editions which denote varying
feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework, applies to Windows PowerShell v4.0 and below as well
  as Windows PowerShell 5.1 on Windows Desktop, Windows Server, Windows Server Core and most other
  Windows editions.
- **Core Edition:** Built on .NET Core, applies to PowerShell Core 6.0 and above as well as
  Windows PowerShell 5.1 on reduced footprint Windows Editions such as Windows IoT and Windows
  Nanoserver.

In PowerShell 5.1 and above, the edition of the running PowerShell session can be retrieved from the
`$PSEdition` automatic variable:

```powershell
$PSEdition
```

```Output
Core
```

Edition information is also present in the PSEdition property of `$PSVersionTable`:

```powershell
$PSVersionTable
```

```Output
Name                           Value
----                           -----
PSVersion                      5.1.14300.1000
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
CLRVersion                     4.0.30319.42000
BuildVersion                   10.0.14300.1000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

## Declaring compatible editions

Module authors can declare their modules to be compatible with one or more PowerShell editions
using the CompatiblePSEditions module manifest key. This key is only supported on PowerShell 5.1 or
later.

> [!NOTE]
> Once a module manifest is specified with the CompatiblePSEditions key, it can not be imported on
> lower versions of PowerShell.

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

## Edition-compatibility for PowerShell modules that ship as part of Windows

For most modules, the `CompatiblePSEditions` field is purely informational;
PowerShell module tooling allows users to filter on this field, but does not perform
checks on it itself.

In PowerShell 6.1 and above however, for modules that ship as part of Windows in the Windows
PowerShell system module directory (`%windir%\System32\WindowsPowerShell\v1.0\Modules`),
the `CompatiblePSEditions` field is checked by PowerShell. This is so that Windows PowerShell modules
that have been validated as compatible with PowerShell Core will work normally, while modules
that are not yet compatible will be ignored or stopped from importing
(preventing unpredictable compatibility issues later).

> [!NOTE]
> Any module you write will not have the `CompatiblePSEditions` field checked.
> Edition-checking only occurs on Windows PowerShell modules that ship as part of Windows
> in the `%windir%\System32\WindowsPowerShell\v1.0\Modules` directory.

For `Import-Module`, the `CompatiblePSEditions` check means a Core-incompatible module will fail
to load in PowerShell Core 6.1 and above:

```powershell
Import-Module BitsTransfer
```

```Output
Import-Module : Module 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\BitsTransfer\BitsTransfer.psd1' does not support current PowerShell edition 'Core'. Its supported editions are 'Desktop'. Use 'Import-Module -SkipEditionCheck' to ignore the compatibility of this module.
At line:1 char:1
+ Import-Module BitsTransfer
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : ResourceUnavailable: (C:\WINDOWS\system32\u2026r\BitsTransfer.psd1:String) [Import-Module], InvalidOperationException
+ FullyQualifiedErrorId : Modules_PSEditionNotSupported,Microsoft.PowerShell.Commands.ImportModuleCommand
```

With `Get-Module`, the `CompatiblePSEditions` check means edition-incompatible modules are not
returned or displayed by default:

```powershell
Get-Module -ListAvailable BitsTransfer
```

```Output
```

In both cases, you can bypass this with the `-SkipEditionCheck` switch parameter:

```powershell
Import-Module -SkipEditionCheck AppLocker -PassThru
```

```Output

ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   2.0.0.0    AppLocker                           {Get-AppLockerFileInformation, Get-AppLockerPolicy, New-AppLocker…

```

```powershell
Get-Module -ListAvailable BitsTransfer
```

```Output


    Directory: C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Manifest   2.0.0.0    BitsTransfer                        Desk      {Add-BitsFile, Complete-BitsTransfer, Get-BitsTransfer,…

```

However, if you import a module that is not marked as compatible with PowerShell Core,
be aware that errors due to an incompatibility could occur at a later stage
(the module may even import successfully and only fail while executing a command):

```powershell
Import-Module -SkipEditionCheck BitsTransfer
```

```Output
Import-Module : Could not load type 'System.Management.Automation.PSSnapIn' from assembly 'System.Management.Automation, Version=6.2.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.
At line:1 char:1
+ Import-Module -SkipEditionCheck BitsTransfer
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (:) [Import-Module], TypeLoadException
+ FullyQualifiedErrorId : System.TypeLoadException,Microsoft.PowerShell.Commands.ImportModuleCommand
```

Changes to formatting in PowerShell Core 6.1 and above mean you will be informed about how
PowerShell interprets the `CompatiblePSEditions` field under the `PSEdition` format table header:

```powershell
Get-Module -ListAvailable
```

```Output

    Directory: C:\Users\me\Documents\PowerShell\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Script     1.3.1      Az.Accounts                         Core,Desk {Disable-AzDataCollection, Disable-AzContextAutosave, E…
Script     4.4.0      Pester                              Desk      {Describe, Context, It, Should…}
Script     1.0.0      WindowsCompatibility                Core      {Initialize-WinSession, Add-WinFunction, Invoke-WinComm…

    Directory: C:\Program Files\PowerShell\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Script     1.2.2      PackageManagement                   Desk      {Find-Package, Get-Package, Get-PackageProvider, Get-Pa…
Script     2.0.1      PowerShellGet                       Desk      {Find-Command, Find-DSCResource, Find-Module, Find-Role…

...

    Directory: C:\program files\powershell\6-preview\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Manifest   6.1.0.0    CimCmdlets                          Core      {Get-CimAssociatedInstance, Get-CimClass, Get-CimInstan…
Manifest   1.2.2.0    Microsoft.PowerShell.Archive        Desk      {Compress-Archive, Expand-Archive}
Manifest   6.1.0.0    Microsoft.PowerShell.Diagnostics    Core      {Get-WinEvent, New-WinEvent}

...

    Directory: C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

ModuleType Version    Name                                PSEdition ExportedCommands
---------- -------    ----                                --------- ----------------
Manifest   1.0.0.0    BitLocker                           Core,Desk {Unlock-BitLocker, Suspend-BitLocker, Resume-BitLocker,…
Script     3.0        Dism                                Core,Desk {Add-AppxProvisionedPackage, Add-WindowsDriver, Add-Win…

...

```

## Targeting multiple editions

Module authors can publish a single module targeting to either or both PowerShell editions (Desktop
and Core).

A single module can work on both Desktop and Core editions, in that module author has to add
required logic in either RootModule or in the module manifest using $PSEdition variable. Modules
can have two sets of compiled DLLs targeting both CoreCLR and FullCLR. Here are the couple of
options to package your module with logic for loading proper dlls.

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

Contents of PSScriptAnalyzer.psd1 file

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

Contents of PSScriptAnalyzer.psm1 file:

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

### Option 2: Use $PSEdition variable in the PSD1 file to load the proper DLLs and Nested/Required modules

In PS 5.1 or newer, $PSEdition global variable is allowed in the module manifest file. Using this
variable, module author can specify the conditional values in the module manifest file. $PSEdition
variable can be referenced in restricted language mode or a Data section.

> [!NOTE]
> Once a module manifest is specified with the CompatiblePSEditions key or uses `$PSEdition`
> variable, it can not be imported on lower versions of PowerShell.

Sample module manifest file with CompatiblePSEditions key

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

### Module contents

```powershell
dir -Recurse
```

```Output
    Directory: C:\Users\manikb\Documents\WindowsPowerShell\Modules\ModuleWithEditions

Mode           LastWriteTime   Length Name
----           -------------   ------ ----
d-----    7/5/2016   1:37 PM          clr
d-----    7/5/2016   1:36 PM          coreclr
-a----    7/5/2016   1:34 PM     4906 ModuleWithEditions.psd1

    Directory: C:\Users\manikb\Documents\WindowsPowerShell\Modules\ModuleWithEditions\clr

Mode           LastWriteTime    Length Name
----           -------------    ------ ----
-a----    7/5/2016   1:35 PM         0 MyFullClrNM1.dll
-a----    7/5/2016   1:35 PM         0 MyFullClrNM2.dll
-a----    7/5/2016   1:35 PM         0 MyFullClrRM.dl

    Directory: C:\Users\manikb\Documents\WindowsPowerShell\Modules\ModuleWithEditions\coreclr

Mode           LastWriteTime   Length Name
----           -------------   ------ ----
-a----    7/5/2016   1:35 PM        0 MyCoreClrNM1.dll
-a----    7/5/2016   1:35 PM        0 MyCoreClrNM2.dll
-a----    7/5/2016   1:35 PM        0 MyCoreClrRM.dl
```

PowerShell Gallery users can find the list of modules supported on a specific PowerShell Edition
using tags PSEdition_Desktop and PSEdition_Core.

Modules without PSEdition_Desktop and PSEdition_Core tags are considered to work fine on PowerShell
Desktop editions.

```powershell
# Find modules supported on PowerShell Desktop edition
Find-Module -Tag PSEdition_Desktop

# Find modules supported on PowerShell Core editions
Find-Module -Tag PSEdition_Core
```

## More details

[Scripts with PSEditions](script-psedition-support.md)

[PSEditions support on PowerShellGallery](../how-to/finding-packages/searching-by-compatibility.md)

[Update module manifest](/powershell/module/powershellget/update-modulemanifest)
