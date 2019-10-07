---
keywords: powershell,cmdlet
locale: en-us
ms.date: 07/01/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_requires?view=powershell-4.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Requires
---

# About Requires

## Short description
Prevents a script from running without the required elements.

## Long description

The `#Requires` statement prevents a script from running unless the PowerShell
version, modules (and version), or snap-ins (and version) prerequisites are
met. If the prerequisites aren't met, PowerShell doesn't run the script.

### Syntax

```
#Requires -Version <N>[.<n>]
#Requires -PSSnapin <PSSnapin-Name> [-Version <N>[.<n>]]
#Requires -Modules { <Module-Name> | <Hashtable> }
#Requires -ShellId <ShellId> -PSSnapin <PSSnapin-Name> [-Version <N>[.<n>]]
#Requires -RunAsAdministrator
```

### Rules for use

A script can include more than one `#Requires` statement. The `#Requires`
statements can appear on any line in a script.

Placing a `#Requires` statement inside a function does NOT limit its scope. All
`#Requires` statements are always applied globally, and must be met, before the
script can execute.

> [!WARNING]
> Even though a `#Requires` statement can appear on any line in a script, its
> position in a script does not affect the sequence of its application. The
> global state the `#Requires` statement presents must be met before script
> execution.

Example:

  ```powershell
  Get-Module Hyper-V | Remove-Module
  #Requires -Modules Hyper-V
  ```

You might think that the above code shouldn't run because the required module
was removed before the `#Requires` statement. However, the `#Requires` state
had to be met before the script could even execute. Then the first line of the
script invalidated the required state.

### Parameters

#### -Version \<N\>[.\<n\>]

Specifies the minimum version of PowerShell that the script requires. Enter a
major version number and optional minor version number.

For example:

```powershell
#Requires -Version 4.0
```

#### -PSSnapin \<PSSnapin-Name\> [-Version \<N\>[.\<n\>]]

Specifies a PowerShell snap-in that the script requires. Enter the snap-in name
and an optional version number.

For example:

```powershell
#Requires -PSSnapin DiskSnapin -Version 1.2
```

#### -Modules \<Module-Name\> | \<Hashtable\>

Specifies PowerShell modules that the script requires. Enter the module name
and an optional version number.

If the required modules aren't in the current session, PowerShell imports them.
If the modules can't be imported, PowerShell throws a terminating error.

For each module, type the module name (\<String\>) or a hash table. The value
can be a combination of strings and hash tables. The hash table has the
following keys.

- `ModuleName` - **Required** Specifies the module name.
- `ModuleVersion` - Specifies a minimum acceptable version of the module.
- `GUID` - **Optional** Specifies the GUID of the module.

For example:

Require that `Hyper-V` (version `1.1` or greater) is installed.

```powershell
#Requires -Modules @{ ModuleName="Hyper-V"; ModuleVersion="1.1" }
```

Require that any version of `PSScheduledJob` and `PSWorkflow` are installed.

```powershell
#Requires -Modules PSWorkflow, PSScheduledJob
```

#### -ShellId

Specifies the shell that the script requires. Enter the shell ID. If you use
the **ShellId** parameter, you must also include the **PSSnapin** parameter.
You can find the current **ShellId** by querying the `$ShellId` automatic
variable.

For example:

```powershell
#Requires -ShellId MyLocalShell -PSSnapin Microsoft.PowerShell.Core
```

> [!NOTE]
> This parameter is intended for use in mini-shells, which have been deprecated.

#### -RunAsAdministrator

When this switch parameter is added to your requires statement, it specifies
that the Windows PowerShell session in which you are running the script must
be started with elevated user rights (Run as Administrator).
The RunAsAdministrator parameter is introduced in Windows PowerShell 4.0.

For example:

```powershell
#Requires -RunAsAdministrator
```

### Examples

The following script has two `#Requires` statements. If the requirements
specified in both statements aren't met, the script doesn't run. Each
`#Requires` statement must be the first item on a line:

```powershell
#Requires -Modules PSWorkflow
#Requires -Version 3
Param
(
    [parameter(Mandatory=$true)]
    [String[]]
    $Path
)
...
```

## See also

[about_Automatic_Variables](about_Automatic_Variables.md)

[about_Language_Keywords](about_Language_Keywords.md)

[about_PSSnapins](about_PSSnapins.md)

[Get-PSSnapin](../Get-PSSnapin.md)
