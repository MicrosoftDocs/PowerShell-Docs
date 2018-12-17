---
ms.date:  12/14/2018
keywords:  powershell,cmdlet
title:  Writing Portable Modules
---

# Portable Modules

Portable modules are modules that work in both Windows PowerShell and PowerShell
Core.
Windows PowerShell is written for [.NET Framework](/dotnet/framework/)
while PowerShell Core is written for [.NET Core](/dotnet/core/).

While .NET Framework and .NET Core are highly compatible, there are differences
in the available APIs between the two so modules intended to be used in both
environments need to be aware of these differences.

## Porting an Existing Module

### Porting a PSSnapIn

PowerShell SnapIns (PSSnapIn) are not supported in PowerShell Core.
However, it is nearly trivial to convert a PSSnapIn to a PowerShell module.
Typically, the PSSnapIn registration code is in a single source file of a
class that derives from [PSSnapIn](/dotnet/api/system.management.automation.pssnapin?view=powershellsdk-1.1.0).
Simply remove this source file from the build as it is no longer needed.

Use [`New-ModuleManifest`](/powershell/module/microsoft.powershell.core/new-modulemanifest)
to create a new module manifest that replaces the need for the PSSnapIn
registration code.  Some of the values from the PSSnapIn (such as Description)
can be reused within the module manifest.

### The .NET Portability Analyzer (aka APIPort)

If the module was already written for Windows PowerShell and the intent is to
port it to work with PowerShell Core, the best practice is to start with the
[.NET Portability Analyzer](https://github.com/Microsoft/dotnet-apiport).
This is a tool that you can run against your compiled assembly to determine if
the .NET APIs it is using is compatible with .NET Framework, .NET Core, and
other .NET runtimes.
The tool will suggest alternate APIs if they exist, otherwise you may need to
add [runtime checks](/dotnet/api/system.runtime.interopservices.runtimeinformation.frameworkdescription?view=netframework-4.7.2#System_Runtime_InteropServices_RuntimeInformation_FrameworkDescription)
and restrict capabilities not available in specific runtimes.

## Creating a New Module

If creating a new module, the recommendation is to use the [DotNet CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/?tabs=netcore2x).

### Installing the PowerShell Standard Module Template

Once the DotNet CLI is installed, you can then install a template library to
generate a simple PowerShell module that is compatible with Windows PowerShell,
PowerShell Core, Windows, Linux, and macOS.

```powershell
dotnet new -i Microsoft.PowerShell.Standard.Module.Template
```

```output
  Restoring packages for C:\Users\Steve\.templateengine\dotnetcli\v2.1.302\scratch\restore.csproj...
  Installing Microsoft.PowerShell.Standard.Module.Template 0.1.3.
  Generating MSBuild file C:\Users\Steve\.templateengine\dotnetcli\v2.1.302\scratch\obj\restore.csproj.nuget.g.props.
  Generating MSBuild file C:\Users\Steve\.templateengine\dotnetcli\v2.1.302\scratch\obj\restore.csproj.nuget.g.targets.
  Restore completed in 1.66 sec for C:\Users\Steve\.templateengine\dotnetcli\v2.1.302\scratch\restore.csproj.

Usage: new [options]

Options:
  -h, --help          Displays help for this command.
  -l, --list          Lists templates containing the specified name. If no name is specified, lists all templates.
  -n, --name          The name for the output being created. If no name is specified, the name of the current directory is used.
  -o, --output        Location to place the generated output.
  -i, --install       Installs a source or a template pack.
  -u, --uninstall     Uninstalls a source or a template pack.
  --nuget-source      Specifies a NuGet source to use during install.
  --type              Filters templates based on available types. Predefined values are "project", "item" or "other".
  --force             Forces content to be generated even if it would change existing files.
  -lang, --language   Filters templates based on language and specifies the language of the template to create.


Templates                                         Short Name         Language          Tags
----------------------------------------------------------------------------------------------------------------------------
Console Application                               console            [C#], F#, VB      Common/Console
Class library                                     classlib           [C#], F#, VB      Common/Library
PowerShell Standard Module                        psmodule           [C#]              Library/PowerShell/Module
...
```

### Creating a New Module Project

After the template is installed, you can create a new PowerShell module
project using that template.
In this example the sample module is called 'myModule'.

```powershell
mkdir myModule
cd myModule
```

```output
PS> mkdir myModule
Directory: C:\Users\Steve
Mode LastWriteTime Length Name
---- ------------- ------ ----
d----- 8/3/2018 2:41 PM myModule
PS> cd myModule
PS C:\Users\Steve\myModule> dotnet new psmodule
The template "PowerShell Standard Module" was created successfully.

Processing post-creation actions...
Running 'dotnet restore' on C:\Users\Steve\myModule\myModule.csproj...
  Restoring packages for C:\Users\Steve\myModule\myModule.csproj...
  Installing PowerShellStandard.Library 5.1.0.
  Generating MSBuild file C:\Users\Steve\myModule\obj\myModule.csproj.nuget.g.props.
  Generating MSBuild file C:\Users\Steve\myModule\obj\myModule.csproj.nuget.g.targets.
  Restore completed in 1.76 sec for C:\Users\Steve\myModule\myModule.csproj.

Restore succeeded.
```

### Building the Module

Use standard DotNet CLI commands to build the project.

```powershell
dotnet build
```

```output
PS C:\Users\Steve\myModule> dotnet build
Microsoft (R) Build Engine version 15.7.179.6572 for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restore completed in 76.85 ms for C:\Users\Steve\myModule\myModule.csproj.
  myModule -> C:\Users\Steve\myModule\bin\Debug\netstandard2.0\myModule.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:05.40
```

### Testing the Module

After building the module, you can import it and execute the sample cmdlet.

```powershell
ipmo .\bin\Debug\netstandard2.0\myModule.dll
Test-SampleCmdlet -?
Test-SampleCmdlet -FavoriteNumber 7 -FavoritePet Cat
```

```output
PS C:\Users\Steve\myModule> ipmo .\bin\Debug\netstandard2.0\myModule.dll
PS C:\Users\Steve\myModule> Test-SampleCmdlet -?

NAME
    Test-SampleCmdlet

SYNTAX
    Test-SampleCmdlet [-FavoriteNumber] <int> [[-FavoritePet] {Cat | Dog | Horse}] [<CommonParameters>]


ALIASES
    None


REMARKS
    None



PS C:\Users\Steve\myModule> Test-SampleCmdlet -FavoriteNumber 7 -FavoritePet Cat

FavoriteNumber FavoritePet
-------------- -----------
             7 Cat
```

The following sections describe in detail some of the technologies leveraged
by this template.

## .NET Standard Library

[.NET Standard](/dotnet/standard/net-standard)
is a formal specification of .NET APIs that are intended to be available in all
.NET implementations.  Managed code targeting .NET Standard will work on .NET
Framework and .NET Core versions that support that version of the .NET Standard.

> [!NOTE]
> Although an API may exist in .NET Standard, the API implementation in .NET
> Core may throw a `PlatformNotSupportedException` at runtime,
> so to verify compatibility with Windows PowerShell and PowerShell Core,
> the best practice is to run tests for your module within both environments.

Building targeting .NET Standard will help ensure at that as the module evolves,
incompatible APIs don't accidentally get introduced and will be discovered at
build time.

However, targeting .NET Standard is not *required* to have a module work with
both Windows PowerShell and PowerShell Core as the Intermediate Language (IL)
is compatible between the two runtimes.

## PowerShell Standard Library

The [PowerShell Standard](https://github.com/PowerShell/PowerShellStandard)
library is a formal specification of PowerShell APIs that are intended to be
available in all PowerShell versions greater than or equal to the version of
that standard.

For example, [PowerShell Standard 5.1](https://www.nuget.org/packages/PowerShellStandard.Library/5.1.0)
is compatible with both Windows PowerShell 5.1 and PowerShell Core 6.0 or newer.

Compiling your module using PowerShell Standard Library is recommended as it
ensures that the APIs are available and implemented in both Windows PowerShell
and PowerShell Core 6.
PowerShell Standard is intended to always be forwards
compatible meaning that a module built using PowerShell Standard Library 5.1
will always be compatible with future versions of PowerShell.

## Module Manifest

### Indicating Compatibility With Windows PowerShell and PowerShell Core

After validating that your module works with both Windows PowerShell and
PowerShell Core, the module manifest should explicitly indicate compatibility
by using the [`CompatiblePSEditions` property](https://docs.microsoft.com/en-us/powershell/gallery/concepts/module-psedition-support).
A value of `Desktop` means that the module is compatible with Windows
PowerShell, while a value of `Core` means that the module is compatible
with PowerShell Core.

> [!NOTE]
> `Core` does not automatically mean that the module is compatible with
> Windows, Linux, and macOS.

### Indicating OS Compatibility

After validating that your module also works on Linux and macOS, it is a best
practice to indicate compatibility with those operating systems in the module
manifest making it easier for users to find your module when published to the
[PowerShell Gallery](https://www.powershellgallery.com) for their operating
system.

Within the module manifest in the `PrivateData` property is a `PSData` property.
Within the `PSData` property is an optional `Tags` property that takes an array
of values indicating tags that will show up in PowerShell Gallery.

| Tag               | Description                                |
|-------------------|--------------------------------------------|
| PSEdition_Core    | Compatible with PowerShell Core 6          |
| PSEdition_Desktop | Compatible with Windows PowerShell         |
| Windows           | Compatible with Windows                    |
| Linux             | Compatible with Linux (no specific distro) |
| macOS             | Compatible with macOS                      |

Example:

```powershell
@{
    GUID = "4ae9fd46-338a-459c-8186-07f910774cb8"
    Author = "Microsoft Corporation"
    CompanyName = "Microsoft Corporation"
    Copyright = "(C) Microsoft Corporation. All rights reserved."
    HelpInfoUri = "https://go.microsoft.com/fwlink/?linkid=855962"
    ModuleVersion = "1.2.4"
    PowerShellVersion = "3.0"
    ClrVersion = "4.0"
    RootModule = "PackageManagement.psm1"
    Description = 'PackageManagement (a.k.a. OneGet) is a new way to discover and install software packages from around the web.
 It is a manager or multiplexor of existing package managers (also called package providers) that unifies Windows package management with a single Windows PowerShell interface. With PackageManagement, you can do the following.
  - Manage a list of software repositories in which packages can be searched, acquired and installed
  - Discover software packages
  - Seamlessly install, uninstall, and inventory packages from one or more software repositories'

    CmdletsToExport = @(
        'Find-Package',
        'Get-Package',
        'Get-PackageProvider',
        'Get-PackageSource',
        'Install-Package',
        'Import-PackageProvider'
        'Find-PackageProvider'
        'Install-PackageProvider'
        'Register-PackageSource',
        'Set-PackageSource',
        'Unregister-PackageSource',
        'Uninstall-Package'
        'Save-Package'
    )

    FormatsToProcess  = @('PackageManagement.format.ps1xml')

    PrivateData = @{
        PSData = @{
            Tags = @('PackageManagement', 'PSEdition_Core', 'PSEdition_Desktop', 'Windows', 'Linux', 'macOS')
            ProjectUri = 'https://oneget.org'
        }
    }
}
```
