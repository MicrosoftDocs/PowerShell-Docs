---
description: Describes the settings and practices for writing module manifest files.
Locale: en-US
ms.date: 07/07/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_module_manifests?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Module_Manifests
---
# about_Module_Manifests

## Short description
Describes the settings and practices for writing module manifest files.

## Long description

A module manifest is a PowerShell data file (`.psd1`) containing a hash table.
The keys-value pairs in the hash table describe the contents and attributes of
the module, define the prerequisites, and control how the components are
processed.

Manifests aren't required to load a module but they're required to publish a
module to the PowerShell Gallery. Manifests also enable you to separate your
module's implementation from how it loads. With a manifest, you can define
requirements, compatibility, loading order, and more.

When you use `New-ModuleManifest` without specifying any parameters for the
manifest's settings it writes a minimal manifest file. The snippet below shows
you this default output, snipped of commentary and spacing for brevity:

```powershell
@{
# RootModule = ''
ModuleVersion = '1.0'
# CompatiblePSEditions = @()
GUID = 'e7184b71-2527-469f-a50e-166b612dfb3b'
Author = 'username'
CompanyName = 'Unknown'
Copyright = '(c) 2022 username. All rights reserved.'
# Description = ''
# PowerShellVersion = ''
# PowerShellHostName = ''
# PowerShellHostVersion = ''
# DotNetFrameworkVersion = ''
# CLRVersion = ''
# ProcessorArchitecture = ''
# RequiredModules = @()
# RequiredAssemblies = @()
# ScriptsToProcess = @()
# TypesToProcess = @()
# FormatsToProcess = @()
# NestedModules = @()
FunctionsToExport = @()
CmdletsToExport = @()
VariablesToExport = '*'
AliasesToExport = @()
# DscResourcesToExport = @()
# ModuleList = @()
# FileList = @()
PrivateData = @{
    PSData = @{
        # Tags = @()
        # LicenseUri = ''
        # ProjectUri = ''
        # IconUri = ''
        # ReleaseNotes = ''
    } # End of PSData hashtable
} # End of PrivateData hashtable
# HelpInfoURI = ''
# DefaultCommandPrefix = ''
}
```

You can use `Test-ModuleManifest` to validate a module manifest before you
publish your module. `Test-ModuleManifest` returns an error if the manifest is
invalid or the module can't be imported into the current session because the
session doesn't meet requirements set in the manifest.

## Using script code in a module manifest

The values assigned the settings in the manifest file can be expressions that
are evaluated by PowerShell. This allows you to construct paths and
conditionally assign values based on variables.

When you import a module using `Import-Module`, the manifest is evaluated in
`Restricted` language mode. `Restricted` mode limits the commands and variables
that can be used.

Allowed commands

- `Import-LocalizedData`
- `ConvertFrom-StringData`
- `Write-Host`
- `Out-Host`
- `Join-Path`

Allowed variables

- `$PSScriptRoot`
- `$PSEdition`
- `$EnabledExperimentalFeatures`
- Any environment variables, like `$ENV:TEMP`

For more information, see [about_Language_Modes][08].

## Manifest settings

The following sections detail every available setting in a module manifest and
how you can use them. They start with a synopsis of the setting and are
followed by a matrix that lists:

- **Input type**: The object type that you can specify for this setting in the
  manifest.
- **Required**: If this value is `Yes`, the setting is required both to import
  the module and to publish it to the PowerShell Gallery. If it's `No`, it's
  required for neither. If it's `PowerShell Gallery`, it's only required for
  publishing to the PowerShell Gallery.
- **Value if unset**: The value this setting has when imported and not
  explicitly set.
- **Accepts wildcards**: Whether this setting can take a wildcard value or not.

### RootModule

This setting specifies the primary or root file of the module. When the module
is imported, the members exported by the root module file are imported into the
caller's session state.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

The value must be the path to one of the following:

- a script (`.ps1`)
- a script module (`.psm1`)
- a module manifest (`.psd1`)
- an assembly (`.dll`)
- a cmdlet definition XML file (`.cdxml`)
- a Windows PowerShell 5.1 Workflow (`.xaml`)

The path should be relative to the module manifest.

If a module manifest has no root file was designated in the **RootModule** key,
the manifest becomes the primary file for the module, and the module becomes a
manifest module (ModuleType = Manifest). When **RootModule** is defined, the
module's type is determined from the file extension used:

- a `.ps1` or `.psm1` file makes the module type **Script**
- a `.psd1` file makes the module type **Manifest**
- a `.dll` file makes the module type **Binary**
- a `.cdxml` file makes the module type **CIM**
- a `.xaml` file makes the module type **Workflow**

By default, all module members in the **RootModule** are exported.

> [!TIP]
> Module loading speed differs between **Binary**, **Script**, and **CIM**
> module types. For more information, see
> [PowerShell module authoring considerations][05]

For example, this module's **ModuleType** is **Manifest**. The only module
members this module can export are those defined in the modules specified with
the **NestedModules** setting.

```powershell
@{
    RootModule = ''
}
```

> [!NOTE]
> This setting may also be specified in module manifests as
> **ModuleToProcess**. While that name for this setting is valid, it's best
> practice to use **RootModule** instead.

### ModuleVersion

This setting specifies the version of the module. When multiple versions of a
module exist on a system, the latest version is loaded by default when you run
`Import-Module`.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | Yes             |
| **Value if unset**    | None            |
| **Accepts wildcards** | No              |

The value of this setting must be convertible to `System.Version` when you run
`Import-Module`.

For example, this manifest declares the module's version as `'1.2.3'`.

```powershell
@{
    ModuleVersion = '1.2.3'
}
```

When you import the module and inspect the **Version** property, note that it
is a **System.Version** object and not a string:

```powershell
$ExampleModule = Import-Module example.psd1
$ExampleModule.Version
$ExampleModule.Version.GetType().Name
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
1      2      3      -1

Version
```

### CompatiblePSEditions

This setting specifies the module's compatible PSEditions.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Accepted Values**   | `Desktop`, `Core` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | No                |

If the value of this setting is `$null`, the module can be imported regardless
of the PSEdition of the session. You can set it to one or more of the accepted
values.

For information about PSEdition, see:

- [about_PowerShell_Editions][04]
- [Modules with compatible PowerShell Editions][02].

When this setting is defined, the module can only be imported into a session
where the `$PSEdition` automatic variable's value is included in the setting.

> [!NOTE]
> Because the `$PSEdition` automatic variable was introduced in version 5.1,
> older versions of Windows PowerShell can't load a module that uses the
> **CompatiblePSEditions** setting.

For example, you can import this module manifest in any session:

```powershell
@{
    # CompatiblePSEditions = @()
}
```

With the setting specified, this module can only be imported in sessions where
the `$PSEdition` automatic variable's value is `Core`.

```powershell
@{
    CompatiblePSEditions = @('Core')
}
```

### GUID

This setting specifies a unique identifier for the module. The **GUID** is used
to distinguish between modules with the same name.

|                       |                 Value                  |
| --------------------- | -------------------------------------- |
| **Input Type**        | `System.String`                        |
| **Required**          | No                                     |
| **Value if unset**    | `00000000-0000-0000-0000-000000000000` |
| **Accepts wildcards** | No                                     |

The value of this setting must be convertible to `System.Guid` when you run
`Import-Module`.

> [!CAUTION]
> While it's not a required setting, not specifying a **GUID** in a manifest
> has no benefits and may lead to name collisions for modules.

You can create a new guid to use in your manifest:

```powershell
New-Guid | Select-Object -ExpandProperty Guid
```

```Output
8456b025-2fa5-4034-ae47-e6305f3917ca
```

```powershell
@{
    GUID = '8456b025-2fa5-4034-ae47-e6305f3917ca'
}
```

If there is another module on the machine with the same name, you can still
import the one you want by specifying the module's fully qualified name:

```powershell
Import-Module -FullyQualifiedName @{
    ModuleName    = 'Example'
    GUID          = '8456b025-2fa5-4034-ae47-e6305f3917ca'
    ModuleVersion = '1.0.0'
}
```

### Author

This setting identifies the module author.

|                       |       Value        |
| --------------------- | ------------------ |
| **Input Type**        | `System.String`    |
| **Required**          | PowerShell Gallery |
| **Value if unset**    | `$null`            |
| **Accepts wildcards** | No                 |

This manifest declares that the module's author is the Contoso Developer
Experience Team.

```powershell
@{
    Author = 'Contoso Developer Experience Team'
}
```

### CompanyName

This setting identifies the company or vendor who created the module.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

This manifest declares that the module was created by Contoso, Ltd.

```powershell
@{
    CompanyName = 'Contoso, Ltd.'
}
```

### Copyright

This setting specifies a copyright statement for the module.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

This manifest declares a copyright statement reserving all rights to Contoso,
Ltd. as of 2022.

```powershell
@{
    Copyright = '(c) 2022 Contoso, Ltd. All rights reserved.'
}
```

### Description

This setting describes the module at a high level.

|                       |       Value        |
| --------------------- | ------------------ |
| **Input Type**        | `System.String`    |
| **Required**          | PowerShell Gallery |
| **Value if unset**    | `$null`            |
| **Accepts wildcards** | No                 |

This manifest includes a short description. You can also use a here-string to
write a longer or multi-line description.

```powershell
@{
    Description = 'Example commands to show a valid module manifest'
}
```

### PowerShellVersion

This setting specifies the minimum version of PowerShell this module requires.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

The value of this setting must be convertible to `System.Version` when you run
`Import-Module`.

If this setting isn't set, PowerShell doesn't restrict the module's import
based on the current version.

For example, this manifest declares that the module is compatible with every
version of PowerShell and Windows PowerShell.

```powershell
@{
    # PowerShellVersion = ''
}
```

With **PowerShellVersion** set to `7.2`, you can only import the module in
PowerShell 7.2 or higher.

```powershell
@{
    PowerShellVersion = '7.2'
}
```

### PowerShellHostName

This setting specifies the name of the PowerShell host program that the module
requires, such as **Windows PowerShell ISE Host** or **ConsoleHost**.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

You can find the name of the host for a session with the `$Host.Name`
statement. For example, you can see that the host for a remote session is
**ServerRemoteHost** instead of **ConsoleHost**:

```powershell
$Host.Name
Enter-PSSession -ComputerName localhost
$Host.Name
```

```Output
ConsoleHost
[localhost]: PS C:\Users\username\Documents> $Host.Name
ServerRemoteHost
```

This module can be imported into any host.

```powershell
@{
    # PowerShellHostName = ''
}
```

With **PowerShellHostName** set to `ServerRemoteHost`, you can only import the
module in a remote PowerShell session.

```powershell
@{
    PowerShellHostName = 'ServerRemoteHost'
}
```

### PowerShellHostVersion

This setting specifies the minimum version of a PowerShell host program that
the module requires.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

The value of this setting must be convertible to `System.Version` when you run
`Import-Module`.

> [!CAUTION]
> While this setting can be used without the **PowerShellHostName** setting, it
> increases the odds of unexpected behavior. Only use this setting when you are
> also using the **PowerShellHostName** setting.

For example, this manifest's module can be imported from any PowerShell session
running in **ConsoleHost**, regardless of the host's version.

```powershell
@{
    PowerShellHostName = 'ConsoleHost'
    # PowerShellHostVersion = ''
}
```

With the **PowerShellHostVersion** set to `5.1`, you can only import the module
from any PowerShell session running in **ConsoleHost** where the host's version
is 5.1 or higher.

```powershell
@{
    PowerShellHostName    = 'ConsoleHost'
    PowerShellHostVersion = '5.1'
}
```

### DotNetFrameworkVersion

This setting specifies the minimum version of the Microsoft .NET Framework that
the module requires.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

> [!NOTE]
> This setting is valid for the PowerShell Desktop edition only, such as
> Windows PowerShell 5.1, and only applies to .NET Framework versions lower
> than 4.5. This requirement has no effect for newer versions of PowerShell or
> the .NET Framework.

The value of this setting must be convertible to `System.Version` when you run
`Import-Module`.

For example, this manifest declares that its module can be imported in any
PowerShell or Windows PowerShell session, regardless of the version of the
Microsoft .NET Framework.

```powershell
@{
    # DotNetFrameworkVersion = ''
}
```

With **DotNetFrameworkVersion** set to `4.0`, you can import this module in any
session of Windows PowerShell where the latest available version of the
Microsoft .NET Framework is at least 4.0. You can also import it in any
PowerShell session.

```powershell
@{
    DotNetFrameworkVersion = '4.0'
}
```

### CLRVersion

This setting specifies the minimum version of the Common Language Runtime (CLR)
of the Microsoft .NET Framework that the module requires.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

> [!NOTE]
> This setting is valid for the PowerShell Desktop edition only, such as
> Windows PowerShell 5.1, and only applies to .NET Framework versions lower
> than 4.5. This requirement has no effect for newer versions of PowerShell or
> the .NET Framework.

The value of this setting must be convertible to `System.Version` when you run
`Import-Module`.

For example, this manifest declares that its module can be imported in any
PowerShell or Windows PowerShell session, regardless of the version of the
Microsoft .NET Framework's CLR version.

```powershell
@{
    # CLRVersion = ''
}
```

With **CLRVersion** set to `4.0`, you can import this module in any session of
Windows PowerShell where the latest available version of the CLR is at least
4.0. You can also import it in any PowerShell session.

```powershell
@{
    CLRVersion = '4.0'
}
```

### ProcessorArchitecture

This setting specifies the processor architecture that the module requires.

|                       |                     Value                     |
| --------------------- | --------------------------------------------- |
| **Input Type**        | `System.String`                               |
| **Accepted Values**   | `None`, `MSIL`, `X86`, `IA64`, `Amd64`, `Arm` |
| **Required**          | No                                            |
| **Value if unset**    | `None`                                        |
| **Accepts wildcards** | No                                            |

The value of this setting must be convertible to
`System.Reflection.ProcessorArchitecture` when you run `Import-Module`.

For example, this manifest declares that its module can be imported in any
session, regardless of the system's processor architecture.

```powershell
@{
    # ProcessorArchitecture = ''
}
```

With **ProcessorArchitecture** set to `Amd64`, you can only import this module
in a session running on a machine with a matching architecture.

```powershell
@{
    ProcessorArchitecture = 'Amd64'
}
```

### RequiredModules

This setting specifies modules that must be in the global session state. If the
required modules aren't in the global session state, PowerShell imports them.
If the required modules aren't available, the `Import-Module` command fails.

|                       |                        Value                        |
| --------------------- | --------------------------------------------------- |
| **Input Type**        | `System.String[]`, `System.Collections.Hashtable[]` |
| **Required**          | No                                                  |
| **Value if unset**    | `$null`                                             |
| **Accepts wildcards** | No                                                  |

Entries for this setting can be a module name, a full module specification, or
a path to a module file.

When the value is a path, the path can be fully qualified or relative.

When the value is a name or module specification, PowerShell searches the
**PSModulePath** for the specified module.

A module specification is a hash table that has the following keys.

- `ModuleName` - **Required**. Specifies the module name.
- `GUID` - **Optional**. Specifies the GUID of the module.
- It's also **Required** to specify at least one of the three below keys. The
  `RequiredVersion` key can't be used with the `ModuleVersion` or
  `MaximumVersion` keys. You can define an acceptable version range for the
  module by specifying the `ModuleVersion` and `MaximumVersion` keys together.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.

> [!NOTE]
> `RequiredVersion` was added in Windows PowerShell 5.0.
> `MaximumVersion` was added in Windows PowerShell 5.1.

For example, this manifest declares that its module doesn't require any other
modules for its functionality.

```powershell
@{
    # RequiredModules = @()
}
```

This manifest declares that it requires the PSReadLine module. When you run
`Import-Module` on this manifest, PowerShell imports the latest version of
PSReadLine that's available to the session. If no version is available, the
import returns an error.

```powershell
@{
    RequiredModules = @(
        'PSReadLine'
    )
}
```

> [!TIP]
> In PowerShell 2.0, `Import-Module` doesn't import required modules
> automatically. It only verifies that the required modules are in the global
> session state.

This manifest declares that it requires a version of the PSReadLine module
vendored in it's own module folder. When you run `Import-Module` on this
manifest, PowerShell imports the vendored PSReadLine from the specified path.

```powershell
@{
    RequiredModules = @(
        'Vendored\PSReadLine\PSReadLine.psd1'
    )
}
```

This manifest declares that it specifically requires version 2.0.0 of the
PSReadLine module. When you run `Import-Module` on this manifest, PowerShell
imports version 2.0.0 of PSReadLine if it's available. If it's not available,
`Import-Module` returns an error.

```powershell
@{
    RequiredModules = @(
        @{
            ModuleName      = 'PSReadLine'
            RequiredVersion = '2.0.0'
        }
    )
}
```

This manifest declares that it requires the PSReadLine module to be imported at
version 2.0.0 or higher.

```powershell
@{
    RequiredModules = @(
        @{
            ModuleName    = 'PSReadLine'
            ModuleVersion = '2.0.0'
        }
    )
}
```

This manifest declares that it requires the PSReadLine module to be imported at
version 2.0.0 or lower.

```powershell
@{
    RequiredModules = @(
        @{
            ModuleName     = 'PSReadLine'
            MaximumVersion = '2.0.0'
        }
    )
}
```

This manifest declares that it requires the PSDesiredStateConfiguration module
to be imported at a version equal to or higher than 2.0.0 but no higher than
2.99.99.

```powershell
@{
    RequiredModules = @(
        @{
            ModuleName     = 'PSDesiredStateConfiguration'
            ModuleVersion  = '2.0.0'
            MaximumVersion = '2.99.99'
        }
    )
}
```

### RequiredAssemblies

This setting specifies the assembly (`.dll`) files that the module requires.
PowerShell loads the specified assemblies before updating types or formats,
importing nested modules, or importing the module file that's specified in the
value of the **RootModule** key.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | No                |

Entries for this setting can be the filename of an assembly or the path to one.
List all required assemblies, even if they're also listed as binary modules in
the **NestedModules** setting.

This manifest requires the `example.dll` assembly. Before loading any
formatting or type files specified in this manifest, PowerShell loads
`example.dll` from the `Assemblies` folder located in the same directory as the
module manifest.

```powershell
@{
    RequiredAssemblies = @(
        'Assemblies\Example.dll'
    )
}
```

### ScriptsToProcess

This setting specifies script (`.ps1`) files that run in the caller's session
state when the module is imported. You can use these scripts to prepare an
environment, just as you might use a login script.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | No                |

To specify scripts that run in the module's session state, use the
**NestedModules** key.

When you import this manifest, PowerShell runs the `Initialize.ps1` in your
current session.

```powershell
@{
    ScriptsToProcess = @(
        'Scripts\Initialize.ps1'
    )
}
```

For example, if `Initialize.ps1` writes informational messages and sets the
`$ExampleState` variable:

```powershell
if ([string]::IsNullOrEmpty($ExampleState)) {
    Write-Information "Example not initialized."
    Write-Information "Initializing now..."
    $ExampleState = 'Initialized'
} else {
    Write-Information "Example already initialized."
}
```

When you import the module, the script runs, writing those messages and setting
`$ExampleState` in your session.

```powershell
$InformationPreference = 'Continue'
"Example State is: $ExampleState"
Import-Module .\example7x.psd1
"Example State is: $ExampleState"
Import-Module .\example7x.psd1 -Force
```

```Output
Example State is:

Example not initialized.
Initializing now...

Example State is: Initialized

Example already initialized.
```

### TypesToProcess

This setting specifies the type files (`.ps1xml`) that run when the module is
imported.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | No                |

When you import the module, PowerShell runs the `Update-TypeData` cmdlet with
the specified files. Because type files aren't scoped, they affect all session
states in the session.

For more information on type files, see [about_Types.ps1xml][09]

For example, when you import this manifest, PowerShell loads the types
specified in the `Example.ps1xml` file from the `Types` folder located in the
same directory as the module manifest.

```powershell
@{
    TypesToProcess = @(
        'Types\Example.ps1xml'
    )
}
```

### FormatsToProcess

This setting specifies the formatting files (`.ps1xml`) that run when the
module is imported.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | No                |

When you import a module, PowerShell runs the `Update-FormatData` cmdlet with
the specified files. Because formatting files aren't scoped, they affect all
session states in the session.

For more information on type files, see [about_Format.ps1xml][07]

For example, when you import this module, PowerShell loads the formats
specified in the `Example.ps1xml` file from the `Formats` folder located in the
same directory as the module manifest.

```powershell
@{
    FormatsToProcess = @(
        'Formats\Example.ps1xml'
    )
}
```

### NestedModules

This setting specifies script modules (`.psm1`) and binary modules (`.dll`)
that are imported into the module's session state. You can also specify script
files (`.ps1`). The files in this setting run in the order in which they're
listed.

|                       |                        Value                        |
| --------------------- | --------------------------------------------------- |
| **Input Type**        | `System.String[]`, `System.Collections.Hashtable[]` |
| **Required**          | No                                                  |
| **Value if unset**    | `$null`                                             |
| **Accepts wildcards** | No                                                  |

Entries for this setting can be a module name, a full module specification, or
a path to a module or script file.

When the value is a path, the path can be fully qualified or relative.

When the value is a module name or specification, PowerShell searches the
**PSModulePath** for the specified module.

A module specification is a hash table that has the following keys.

- `ModuleName` - **Required**. Specifies the module name.
- `GUID` - **Optional**. Specifies the GUID of the module.
- It's also **Required** to specify at least one of the three below keys. The
  `RequiredVersion` key can't be used with the `ModuleVersion` or
  `MaximumVersion` keys. You can define an acceptable version range for the
  module by specifying the `ModuleVersion` and `MaximumVersion` keys together.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.

> [!NOTE]
> `RequiredVersion` was added in Windows PowerShell 5.0.
> `MaximumVersion` was added in Windows PowerShell 5.1.

Any items that need to be exported from a nested module must be exported by the
nested module using the `Export-ModuleMember` cmdlet or be listed in one of the
export properties:

- **FunctionsToExport**
- **CmdletsToExport**
- **VariablesToExport**
- **AliasesToExport**

Nested modules in the module session state are available to the root module,
but they aren't returned by a `Get-Module` command in the caller's session
state.

Scripts (`.ps1`) that are listed in this setting are run in the module's
session state, not in the caller's session state. To run a script in the
caller's session state, list the script filename in the **ScriptsToProcess**
setting.

For example, when you import this manifest, the `Helpers.psm1` module is loaded
into the root module's session state. Any cmdlets declared in the nested module
are exported unless otherwise restricted.

```powershell
@{
    NestedModules = @(
        'Helpers\Helpers.psm1'
    )
}
```

### FunctionsToExport

This setting specifies the functions that the module exports. You can use this
setting to restrict the functions that are exported by the module. It can
remove functions from the list of exported functions, but it can't add
functions to the list.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | Yes               |

You can specify entries in this setting with wildcards. All matching functions
in the list of exported functions are exported.

> [!TIP]
> For performance and discoverability, you should always explicitly list the
> functions you want your module to export in this setting without using any
> wildcards.

For example, when you import a module with the setting commented out, all
functions in the root module and any nested modules are exported.

```powershell
@{
    # FunctionsToExport = @()
}
```

This manifest is functionally identical to not specifying the setting at all.

```powershell
@{
    FunctionsToExport = '*'
}
```

With **FunctionsToExport** set as an empty array, when you import this module
no functions the root module or any nested modules export are available.

```powershell
@{
    FunctionsToExport = @()
}
```

> [!NOTE]
> If you create your module manifest with the `New-ModuleManifest` command and
> don't specify the **FunctionsToExport** parameter, the created manifest has
> this setting specified as an empty array. Unless you edit the manifest, no
> functions from the module are exported.

With **FunctionsToExport** set to only include the `Get-Example` function, when
you import this module only the `Get-Example` function is made available, even
if other functions were exported by the root module or any nested modules.

```powershell
@{
    FunctionsToExport = @(
        'Get-Example'
    )
}
```

With **FunctionsToExport** set with a wildcard string, when you import this
module any function whose name ends with `Example` is made available, even if
other functions were exported as module members by the root module or any
nested modules.

```powershell
@{
    FunctionsToExport = @(
        '*Example'
    )
}
```

### CmdletsToExport

This setting specifies the cmdlets that the module exports. You can use this
setting to restrict the cmdlets that are exported by the module. It can remove
cmdlets from the list of exported module members, but it can't add cmdlets to
the list.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | Yes               |

You can specify entries in this setting with wildcards. All matching cmdlets
in the list of exported cmdlets is exported.

> [!TIP]
> For performance and discoverability, you should always explicitly list the
> cmdlets you want your module to export in this setting without using any
> wildcards.

For example, when you import a module with this setting commented out, all
cmdlets in the root module and any nested modules are exported.

```powershell
@{
    # CmdletsToExport = @()
}
```

This manifest is functionally identical to not specifying the setting at all.

```powershell
@{
    CmdletsToExport = '*'
}
```

With **CmdletsToExport** set as an empty array, when you import this module no
cmdlets the root module or any nested modules export are available.

```powershell
@{
    CmdletsToExport = @()
}
```

> [!NOTE]
> If you create your module manifest with the `New-ModuleManifest` command and
> don't specify the **CmdletsToExport** parameter, the created manifest has
> this setting specified as an empty array. Unless you edit the manifest, no
> cmdlets from the module is exported.

With **CmdletsToExport** set to only include the `Get-Example` cmdlet, when
you import this module only the `Get-Example` cmdlet is made available, even
if other cmdlets were exported by the root module or any nested modules.

```powershell
@{
    CmdletsToExport = @(
        'Get-Example'
    )
}
```

With **CmdletsToExport** set with a wildcard string, when you import this
module any cmdlet whose name ends with `Example` is made available, even if
other cmdlets were exported as module members by the root module or any nested
modules.

```powershell
@{
    CmdletsToExport = @(
        '*Example'
    )
}
```

### VariablesToExport

This setting specifies the variables that the module exports. You can use this
setting to restrict the variables that are exported by the module. It can
remove variables from the list of exported module members, but it can't add
variables to the list.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | Yes               |

You can specify entries in this setting with wildcards. All matching variables
in the list of exported module members is exported.

> [!TIP]
> For performance and discoverability, you should always explicitly list the
> variables you want your module to export in this setting without using any
> wildcards.

For example, when you import a module with this setting commented out, all
variables in the root module and any nested modules are exported.

```powershell
@{
    # VariablesToExport = @()
}
```

This manifest is functionally identical to not specifying the setting at all.

```powershell
@{
    VariablesToExport = '*'
}
```

> [!NOTE]
> If you create your module manifest with the `New-ModuleManifest` command and
> don't specify the **VariablesToExport** parameter, the created manifest has
> this setting specified as `'*'`. Unless you edit the manifest, all variables
> from the module is exported.

With **VariablesToExport** set as an empty array, when you import this module
no variables the root module or any nested modules export are available.

```powershell
@{
    VariablesToExport = @()
}
```

With **VariablesToExport** set to only include the `SomeExample` variable, when
you import this module only the `$SomeExample` variable is made available, even
if other variables were exported by the root module or any nested modules.

```powershell
@{
    VariablesToExport = @(
        'SomeExample'
    )
}
```

With **VariablesToExport** set with a wildcard string, when you import this
module any variable whose name ends with `Example` is made available, even if
other variables were exported as module members by the root module or any
nested modules.

```powershell
@{
    VariablesToExport = @(
        '*Example'
    )
}
```

### DscResourcesToExport

This setting specifies the DSC Resources that the module exports. You can use
this setting to restrict the class-based DSC Resources that are exported by the
module. It can remove DSC Resources from the list of exported module members,
but it can't add DSC Resources to the list.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | Yes               |

You can specify entries in this setting with wildcards. All matching
class-based DSC Resources in the module are exported.

> [!TIP]
> For discoverability, you should always explicitly list all the DSC
> Resources your module exports.

For more information on authoring and using DSC Resources, see the
[documentation for DSC][01].

This manifest exports all the class-based and MOF-based DSC Resources defined
in the root module and any nested modules.

```powershell
@{
    # DscResourcesToExport = @()
}
```

This manifest exports all the MOF-based DSC Resources defined in the root
module and any nested modules, but only one class-based DSC Resource,
`ExampleClassResource`.

```powershell
@{
    DscResourcesToExport = @(
        'ExampleClassResource'
    )
}
```

This manifest exports all the DSC Resources it includes. Even if the MOF-Based
resource wasn't listed, the module would still export it.

```powershell
@{
    DscResourcesToExport = @(
        'ExampleClassResource'
        'ExampleMofResourceFirst'
    )
}
```

### ModuleList

This setting is an informational inventory list of the modules included in this
one. This list doesn't affect the behavior of the module.

|                       |                        Value                        |
| --------------------- | --------------------------------------------------- |
| **Input Type**        | `System.String[]`, `System.Collections.Hashtable[]` |
| **Required**          | No                                                  |
| **Value if unset**    | `$null`                                             |
| **Accepts wildcards** | No                                                  |

Entries for this setting can be a module name, a full module specification, or
a path to a module or script file.

When the value is a path, the path can be fully qualified or relative.

When the value is a module name or specification, PowerShell searches the
**PSModulePath** for the specified module.

A module specification is a hash table that has the following keys.

- `ModuleName` - **Required**. Specifies the module name.
- `GUID` - **Optional**. Specifies the GUID of the module.
- It's also **Required** to specify at least one of the three below keys. The
  `RequiredVersion` key can't be used with the `ModuleVersion` or
  `MaximumVersion` keys. You can define an acceptable version range for the
  module by specifying the `ModuleVersion` and `MaximumVersion` keys together.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.

> [!NOTE]
> `RequiredVersion` was added in Windows PowerShell 5.0.
> `MaximumVersion` was added in Windows PowerShell 5.1.

This manifest doesn't provide an informational list of the modules it includes.
It may or may not have modules. Even though this setting isn't specified, any
modules listed in the **RootModule**, **ScriptsToProcess**, or
**NestedModules** settings still behave normally.

```powershell
@{
    # ModuleList = @()
}
```

This manifest declares that the only modules it includes are `Example.psm1` and
the submodules `First.psm1` and `Second.psm1` in the `Submodules` folder.

```powershell
@{
    ModuleList = @(
        'Example.psm1'
        'Submodules\First.psm1'
        'Submodules\Second.psm1'
    )
}
```

### FileList

This setting is an informational inventory list of the files included in this
module. This list doesn't affect the behavior of the module.

|                       |       Value       |
| --------------------- | ----------------- |
| **Input Type**        | `System.String[]` |
| **Required**          | No                |
| **Value if unset**    | `$null`           |
| **Accepts wildcards** | Yes               |

Entries for this setting should be the relative path to a file from the folder
containing the module manifest.

When a user calls `Get-Module` against a manifest with this setting defined,
the **FileList** property contains the full path to these files, joining the
module's path with each entry's relative path.

This manifest doesn't include a list of its files.

```powershell
@{
    # FileList = @()
}
```

This manifest declares that the only files it includes are listed in this
setting.

```powershell
@{
    FileList = @(
        'Example.psd1'
        'Example.psm1'
        'Assemblies\Example.dll'
        'Scripts\Initialize.ps1'
        'Submodules\First.psm1'
        'Submodules\Second.psm1'
    )
}
```

### PrivateData

This setting defines a hash table of data that's available to any commands or
functions in the root module's scope.

|                       |             Value              |
| --------------------- | ------------------------------ |
| **Input Type**        | `System.Collections.Hashtable` |
| **Required**          | PowerShell Gallery, Crescendo  |
| **Value if unset**    | `$null`                        |
| **Accepts wildcards** | No                             |

When you export a Crescendo manifest to create a new module,
`Export-CrescendoModule` adds two keys to **PrivateData**

- **CrescendoGenerated** - timestamp when the module was exported
- **CrescendoVersion** - the version of Crescendo used to export the module

You can add your own keys to hold metadata that you want to track. Any keys
added to this setting are available to functions and cmdlets in the root module
using `$MyInvocation.MyCommand.Module.PrivateData`. The hash table isn't
available in the module scope itself, only in cmdlets you define in the module.

For example, this manifest defines the **PublishedDate** key in
**PrivateData**.

```powershell
@{
    PrivateData = @{
        PublishedDate = '2022-06-01'
    }
}
```

Cmdlets in the module can access this value with the `$MyInvocation` variable.

```powershell
Function Get-Stale {
    [CmdletBinding()]
    param()

    $PublishedDate = $MyInvocation.MyCommand.Module.PrivateData.PublishedDate
    $CurrentDate = Get-Date

    try {
        $PublishedDate = Get-Date -Date $PublishedDate -ErrorAction Stop
    } catch {
        # The date was set in the manifest, set to an invalid value, or
        # the script module was directly imported without the manifest.
        Throw "Unable to determine published date. Check the module manifest."
    }

    if ($CurrentDate -gt $PublishedDate.AddDays(30)) {
        Write-Warning "This module version was published more than 30 days ago."
    } else {
        $TimeUntilStale = $PublishedDate.AddDays(30) - $CurrentDate
        "This module will be stale in $($TimeUntilStale.Days) days"
    }
}
```

Once the module is imported, the function uses the value from **PrivateData**
to determine when the module was published.

```powershell
Get-Stale -TestDate '2022-06-15'
Get-Stale -TestDate '2022-08-01'
```

```Output
This module will be stale in 16 days

WARNING: This module version was published more than 30 days ago.
```

#### PrivateData.PSData

The **PSData** child property defines a hash table of values that support
specific extension scenarios.

|                       |                            Value                             |
| --------------------- | ------------------------------------------------------------ |
| **Input Type**        | `System.Collections.Hashtable`                               |
| **Required**          | PowerShell Gallery, Experimental features, Crescendo modules |
| **Value if unset**    | `$null`                                                      |
| **Accepts wildcards** | No                                                           |

The **PSData** child property is used for the following scenarios:

- PowerShell Gallery - When you create a module manifest using
  `New-ModuleManifest` the cmdlet prepopulates the **PSData** hashtable with
  place holder keys that are needed when publishing the module to the
  PowerShell Gallery. For more information on module manifests and the
  publishing to the PowerShell Gallery, see
  [Package manifest values that impact the PowerShell Gallery UI][03].
- Crescendo modules - When you export a Crescendo manifest to create a new
  module, `Export-CrescendoModule` adds the value `CrescendoBuilt` to the
  **PSData.Tags** property. You can use this tag to find modules in the
  PowerShell Gallery that were created using Crescendo. For more information,
  see [Export-CrescendoModule][14].

### HelpInfoURI

This setting specifies the internet address of the HelpInfo XML file for the
module.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

This setting's value must be a Uniform Resource Identifier (URI) that begins
with **http** or **https**.

The HelpInfo XML file supports the Updatable Help feature that was introduced
in PowerShell 3.0. It contains information about the location of downloadable
help files for the module and the version numbers of the newest help files for
each supported locale.

For information about Updatable Help, see [about_Updatable_Help][10]. For
information about the HelpInfo XML file, see [Supporting Updatable Help][06].

For example, this module supports updatable help.

```powershell
@{
    HelpInfoUri = 'http://https://go.microsoft.com/fwlink/?LinkID=603'
}
```

### DefaultCommandPrefix

This setting specifies a prefix that's prepended to the nouns of all commands
in the module when they're imported into a session. Prefixes help prevent
command name conflicts in a user's session.

|                       |      Value      |
| --------------------- | --------------- |
| **Input Type**        | `System.String` |
| **Required**          | No              |
| **Value if unset**    | `$null`         |
| **Accepts wildcards** | No              |

Module users can override this prefix by specifying the **Prefix** parameter of
the `Import-Module` cmdlet.

This setting was introduced in PowerShell 3.0.

When this manifest is imported, any cmdlets imported from this module have
`Example` prepended to the noun in their name. For example, `Get-Item` is
imported as `Get-ExampleItem`.

```powershell
@{
    DefaultCommandPrefix = 'Example'
}
```

## See also

- [about_PowerShell_Editions][04]
- [New-ModuleManifest][12]
- [Test-ModuleManifest][13]
- [Modules with compatible PowerShell Editions][02]
- [Package manifest values that impact the PowerShell Gallery UI][03]
- [PowerShell module authoring considerations][05]

<!-- link references -->
[01]: /powershell/dsc/overview
[02]: /powershell/gallery/concepts/module-psedition-support
[03]: /powershell/gallery/concepts/package-manifest-affecting-ui
[04]: /powershell/module/microsoft.powershell.core/about/about_powershell_editions
[05]: /powershell/scripting/dev-cross-plat/performance/module-authoring-considerations
[06]: /powershell/scripting/developer/module/supporting-updatable-help
[07]: about_Format.ps1xml.md
[08]: about_Language_Modes.md
[09]: about_Types.ps1xml.md
[10]: about_Updatable_Help.md
[12]: xref:Microsoft.PowerShell.Core.New-ModuleManifest
[13]: xref:Microsoft.PowerShell.Core.Test-ModuleManifest
[14]: xref:Microsoft.PowerShell.Crescendo.Export-CrescendoModule
