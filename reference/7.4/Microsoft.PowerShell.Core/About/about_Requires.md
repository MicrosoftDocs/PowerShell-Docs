---
description: Prevents a script from running without the required elements.
Locale: en-US
ms.date: 08/17/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_requires?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Requires
---

# about_Requires

## Short description

Prevents a script from running without the required elements.

## Long description

The `#Requires` statement prevents a script from running unless the PowerShell
version, modules (and version), and edition
prerequisites are met. If the prerequisites aren't met, PowerShell doesn't run
the script or provide other runtime features, such as tab completion.

### Syntax

```
#Requires -Version <N>[.<n>]
#Requires -Modules { <Module-Name> | <Hashtable> }
#Requires -PSEdition <PSEdition-Name>
#Requires -RunAsAdministrator
```

For more information about the syntax, see
[ScriptRequirements](/dotnet/api/system.management.automation.language.scriptrequirements).

### Rules for use

A script can include more than one `#Requires` statement. The `#Requires`
statements can appear on any line in a script.

Placing a `#Requires` statement inside a function doesn't limit its scope. All
`#Requires` statements are always applied globally, and must be met, before the
script can execute.

> [!WARNING]
> Even though a `#Requires` statement can appear on any line in a script, its
> position in a script doesn't affect the sequence of its application. The
> global state the `#Requires` statement presents must be met before script
> execution.

Example:

```powershell
Get-Module AzureRM.Netcore | Remove-Module
#Requires -Modules AzureRM.Netcore
```

You might think that the above code shouldn't run because the required module
was removed before the `#Requires` statement. However, the `#Requires` state
had to be met before the script could even execute. Then the first line of the
script invalidated the required state.

### Parameters

#### -Assembly \<Assembly path> | \<.NET assembly specification>

> [!IMPORTANT]
> The `-Assembly` syntax is deprecated. It serves no function. The syntax was
> added in PowerShell 5.1 but the supporting code was never implemented. The
> syntax is still accepted for backward compatibility.

Specifies the path to the assembly DLL file or a .NET assembly name. The
**Assembly** parameter was introduced in PowerShell 5.0. For more information
about .NET assemblies, see [Assembly names](/dotnet/standard/assembly/names).

For example:

```
#Requires -Assembly path\to\foo.dll
```

```
#Requires -Assembly "System.Management.Automation, Version=3.0.0.0,
  Culture=neutral, PublicKeyToken=31bf3856ad364e35"
```

#### -Version \<N\>[.\<n\>]

Specifies the minimum version of PowerShell that the script requires. Enter a
major version number and optional minor version number.

For example:

```powershell
#Requires -Version 6.0
```

#### -Modules \<Module-Name\> | \<Hashtable\>

Specifies PowerShell modules that the script requires. Enter the module name
and an optional version number.

If the required modules aren't in the current session, PowerShell imports them.
If the modules can't be imported, PowerShell throws a terminating error.

The `#Requires` statement doesn't load class and enumeration definitions in the
module. Use the `using module` statement at the beginning of your script to
import the module, including the class and enumeration definitions. For more
information, see [about_Using](about_Using.md).

For each module, type the module name (\<String\>) or a hashtable. The value
can be a combination of strings and hashtables. The hashtable has the
following keys.

- `ModuleName` - **Required** Specifies the module name.
- `GUID` - **Optional** Specifies the GUID of the module.
- It's also **Required** to specify at least one of the three below keys.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module.
    This can't be used with the other Version keys.

> [!NOTE]
> `RequiredVersion` was added in Windows PowerShell 5.0.
> `MaximumVersion` was added in Windows PowerShell 5.1.

For example:

Require that `AzureRM.Netcore` (version `0.12.0` or greater) is installed.

```powershell
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; ModuleVersion="0.12.0" }
```

Require that `AzureRM.Netcore` (**only** version `0.12.0`) is installed.

```powershell
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; RequiredVersion="0.12.0" }
```

Requires that `AzureRM.Netcore` (version `0.12.0` or lesser) is installed.

```powershell
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; MaximumVersion="0.12.0" }
```

Require that any version of `AzureRM.Netcore` and `PowerShellGet` is installed.

```powershell
#Requires -Modules AzureRM.Netcore, PowerShellGet
```

When using the `RequiredVersion` key, ensure your version string exactly
matches the version string you require.

```powershell
Get-Module AzureRM.Netcore -ListAvailable
```

```Output
    Directory: /home/azureuser/.local/share/powershell/Modules

ModuleType Version Name            PSEdition ExportedCommands
---------- ------- ----            --------- ----------------
Script     0.12.0  AzureRM.Netcore Core
```

The following example fails because **0.12** doesn't exactly match **0.12.0**.

```powershell
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; RequiredVersion="0.12" }
```

#### -PSEdition \<PSEdition-Name\>

Specifies a PowerShell edition that the script requires. Valid values are
**Core** for PowerShell and **Desktop** for Windows PowerShell.

For example:

```powershell
#Requires -PSEdition Core
```

#### -RunAsAdministrator

When this switch parameter is added to your `#Requires` statement, it specifies
that the PowerShell session in which you're running the script must be started
with elevated user rights. The **RunAsAdministrator** parameter is ignored on a
non-Windows operating system. The **RunAsAdministrator** parameter was
introduced in PowerShell 4.0.

For example:

```powershell
#Requires -RunAsAdministrator
```

### Examples

The following script has two `#Requires` statements. If the requirements
specified in both statements aren't met, the script doesn't run. Each
`#Requires` statement must be the first item on a line:

```powershell
#Requires -Modules AzureRM.Netcore
#Requires -Version 6.0
Param
(
    [parameter(Mandatory=$true)]
    [String[]]
    $Path
)
...
```

## See also

- [about_Automatic_Variables](about_Automatic_Variables.md)
- [about_Language_Keywords](about_Language_Keywords.md)
