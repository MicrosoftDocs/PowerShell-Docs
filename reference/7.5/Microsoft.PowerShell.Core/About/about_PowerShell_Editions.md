---
description: Different editions of PowerShell run on different underlying runtimes.
Locale: en-US
ms.date: 11/14/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_powershell_editions?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PowerShell_Editions
---
# about_PowerShell_Editions

## Short description

Different editions of PowerShell run on different underlying runtimes.

## Long description

From PowerShell 5.1, there are multiple _editions_ of PowerShell that each run
on a different .NET runtime. As of PowerShell 6.0 there are two editions of
PowerShell:

- **Desktop**, which runs on .NET Framework. PowerShell 4 and below, as well as
  PowerShell 5.1 are available for full-featured Windows editions like Windows
  Desktop, Windows Server, Windows Server Core and most other Windows operating
  systems. This is the original PowerShell edition and is included in the
  default installation of the operating system.
- **Core**, which runs on .NET Core. PowerShell 6.0 and later is installed
  side-by-side with earlier PowerShell releases on full-featured Windows
  editions, some reduced-footprint Windows editions such as Windows Nano Server
  and Windows IoT, or on non-Windows platforms such as Linux and macOS.

Because the edition of PowerShell corresponds to its .NET runtime, it is the
primary indicator of .NET API and PowerShell module compatibility; some .NET
APIs, types or methods are not available in both .NET runtimes and this affects
PowerShell scripts and modules that depend on them.

## The `$PSEdition` automatic variable

In PowerShell 5.1 and above, you can find out what edition you are running with
the `$PSEdition` automatic variable:

```powershell
$PSEdition
```

```Output
Core
```

In PowerShell 4 and below, this variable does not exist. `$PSEdition` being
null should be treated as the same as having the value `Desktop`.

### Edition in `$PSVersionTable`

The `$PSVersionTable` automatic variable also has **PSEdition** property in
PowerShell 5.1 and above:

```powershell
$PSVersionTable
```

```Output
Name                           Value
----                           -----
PSVersion                      7.3.9
PSEdition                      Core
GitCommitId                    7.3.9
OS                             Microsoft Windows 10.0.22621
Platform                       Win32NT
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
```

The **PSEdition** field has the same value as the `$PSEdition` automatic
variable.

## The `CompatiblePSEditions` module manifest field

PowerShell modules can declare what editions of PowerShell they are compatible
with using the `CompatiblePSEditions` field of the module manifest.

For example, a module manifest declaring compatibility with both `Desktop` and
`Core` editions of PowerShell:

```powershell
@{
    ModuleVersion = '1.0'
    FunctionsToExport = @('Test-MyModule')
    CompatiblePSEditions = @('Desktop', 'Core')
}
```

An example of a module manifest with only `Desktop` compatibility:

```powershell
@{
    ModuleVersion = '1.0'
    FunctionsToExport = @('Test-MyModule')
    CompatiblePSEditions = @('Desktop')
}
```

Omitting the `CompatiblePSEditions` field from a module manifest will have the
same effect as setting it to `Desktop`, since modules created before this field
was introduced were implicitly written for this edition.

For modules not shipped as part of Windows (i.e. modules you write or install
from the gallery), this field is informational only; PowerShell does not change
behavior based on the `CompatiblePSEditions` field, but does expose it on the
`PSModuleInfo` object (returned by `Get-Module`) for your own logic:

```powershell
New-ModuleManifest -Path .\TestModuleWithEdition.psd1 -CompatiblePSEditions Desktop,Core -PowerShellVersion '5.1'
$ModuleInfo = Test-ModuleManifest -Path .\TestModuleWithEdition.psd1
$ModuleInfo.CompatiblePSEditions
```

```Output
Desktop
Core
```

> [!NOTE]
> The `CompatiblePSEditions` module field is only compatible with PowerShell
> 5.1 and above. Including this field will cause a module to be incompatible
> with PowerShell 4 and below. Since the field is purely informational, it can
> be safely omitted in later PowerShell versions.

In PowerShell 6.1, `Get-Module -ListAvailable` has had its formatter updated to
display the edition-compatibility of each module:

```powerShell
Get-Module -ListAvailable
```

```Output

    Directory: C:\Users\me\Documents\PowerShell\Modules

ModuleType Version    Name                   PSEdition ExportedCommands
---------- -------    ----                   --------- ----------------
Script     1.4.0      Az                     Core,Desk
Script     1.3.1      Az.Accounts            Core,Desk {Disable-AzDataCollection, Disable-AzContextAutosave, E...
Script     1.0.1      Az.Aks                 Core,Desk {Get-AzAks, New-AzAks, Remove-AzAks, Import-AzAksCreden...

...

Script     4.4.0      Pester                 Desk      {Describe, Context, It, Should...}
Script     1.18.0     PSScriptAnalyzer       Desk      {Get-ScriptAnalyzerRule, Invoke-ScriptAnalyzer, Invoke-...
Script     1.0.0      WindowsCompatibility   Core      {Initialize-WinSession, Add-WinFunction, Invoke-WinComm...

```

## Edition-compatibility for modules that ship as part of Windows

For modules that come as part of Windows (or are installed as part of a role or
feature), PowerShell 6.1 and above treat the `CompatiblePSEditions` field
differently. Such modules are found in the Windows PowerShell system modules
directory (`%windir%\System\WindowsPowerShell\v1.0\Modules`).

For modules loaded from or found in this directory, PowerShell 6.1 and above
uses the `CompatiblePSEditions` field to determine whether the module will be
compatible with the current session and behaves accordingly.

When `Import-Module` is used, a module without `Core` in `CompatiblePSEditions`
will not be imported and an error will be displayed:

```powershell
Import-Module BitsTransfer
```

```Output
Import-Module : Module 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\BitsTransfer\BitsTransfer.psd1'
 does not support current PowerShell edition 'Core'. Its supported editions are 'Desktop'. Use 'Import-Module
 -SkipEditionCheck' to ignore the compatibility of this module.
At line:1 char:1
+ Import-Module BitsTransfer
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : ResourceUnavailable: (C:\WINDOWS\system32\u2026r\BitsTransfer.psd1:String)
 [Import-Module], InvalidOperationException
+ FullyQualifiedErrorId : Modules_PSEditionNotSupported,Microsoft.PowerShell.Commands.ImportModuleCommand
```

When `Get-Module -ListAvailable` is used, modules without `Core` in
`CompatiblePSEditions` will not be displayed:

```powershell
Get-Module -ListAvailable BitsTransfer
```

```Output
# No output
```

In both cases, the `-SkipEditionCheck` switch parameter can be used to override
this behavior:

```powershell
Get-Module -ListAvailable -SkipEditionCheck BitsTransfer
```

```Output

    Directory: C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

ModuleType Version    Name           PSEdition ExportedCommands
---------- -------    ----           --------- ----------------
Manifest   2.0.0.0    BitsTransfer   Desk      {Add-BitsFile, Complete-BitsTransfer, Get-BitsTransfer,...

```

> [!WARNING]
> `Import-Module -SkipEditionCheck` may appear to succeed for a module, but
> using that module runs the risk of encountering an incompatibility later on;
> while loading the module initially succeeds, a command may later call an
> incompatible API and fail spontaneously.

## Authoring PowerShell modules for edition cross-compatibility

When writing a PowerShell module to target both `Desktop` and `Core` editions
of PowerShell, there are things you can do to ensure cross-edition
compatibility.

The only true way to confirm and continually validate compatibility however is
to write tests for your script or module and run them on all versions and
editions of PowerShell you need compatibility with. A recommended testing
framework for this is [Pester][07].

### PowerShell script

As a language, PowerShell works the same between editions; it is the cmdlets,
modules and .NET APIs you use that are affected by edition compatibility.

Generally, scripts that work in PowerShell 6.1 and above will work with Windows
PowerShell 5.1, but there are some exceptions.

[PSScriptAnalyzer][08] version 1.18+ has rules like
[PSUseCompatibleCommands][03] and [PSUseCompatibleTypes][04] that are able to
detect possibly incompatible usage of commands and .NET APIs in PowerShell
scripts.

### .NET assemblies

If you are writing a binary module or a module that incorporates .NET
assemblies (DLLs) generated from source code, you should compile against
[.NET Standard][01] and [PowerShell Standard][06] for compile-time
compatibility validation of .NET and PowerShell API compatibility.

Although these libraries are able to check some compatibility at compile time,
they won't be able to catch possible behavioral differences between editions.
For this you must still write tests.

## See also

- [about_Automatic_Variables][05]
- [Get-Module][09]
- [Import-Module][10]
- [Modules with compatible PowerShell Editions][02]

<!-- link references -->
[01]: /dotnet/standard/net-standard
[02]: /powershell/gallery/concepts/module-psedition-support
[03]: /powershell/utility-modules/psscriptanalyzer/rules/usecompatiblecommands
[04]: /powershell/utility-modules/psscriptanalyzer/rules/usecompatibletypes
[05]: about_Automatic_Variables.md
[06]: https://devblogs.microsoft.com/powershell/powershell-standard-library-build-single-module-that-works-across-windows-powershell-and-powershell-core/
[07]: https://github.com/pester/Pester/wiki/Pester
[08]: https://www.powershellgallery.com/packages/PSScriptAnalyzer/
[09]: xref:Microsoft.PowerShell.Core.Get-Module
[10]: xref:Microsoft.PowerShell.Core.Import-Module
