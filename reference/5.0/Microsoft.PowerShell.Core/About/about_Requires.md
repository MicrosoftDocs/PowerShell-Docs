---
ms.date:  01/03/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Requires
---
# About Requires

## Short description
Prevents a script from running without the required elements.

## Long description

The `#Requires` statement prevents a script from running unless the Windows
PowerShell version, modules, snap-ins, and module and snap-in version
prerequisites are met. If the prerequisites are not met, Windows PowerShell
does not run the script.

### Syntax

```powershell
#Requires -Version <N>[.<n>]
#Requires -PSSnapin <PSSnapin-Name> [-Version <N>[.<n>]]
#Requires -Modules { <Module-Name> | <Hashtable> }
#Requires -ShellId <ShellId>
#Requires -RunAsAdministrator
```

### Rules for use

- A script can include more than one `#Requires` statement.
- The `#Requires` statements can appear on any line in a script.
  
  Placing a `#Requires` statement inside a function does NOT limit its scope.
  All `#Requires` statements are always applied globally, and must be met,
  before the script can execute.
  > [!WARNING]
  > Even though a `#Requires` statement can appear on any line in a script,
  > its position in a script does not affect the sequence of its application.
  >
  > The global state the `#Requires` statement presents must be met before
  > script execution.
  
  Example:

  ```powershell
  Get-Module Hyper-V | Remove-Module
  #Requires -Modules Hyper-V
  ```

  You might think that the above code should not run because the required
  module was removed before the `#Requires` statement. However, the `#Requires`
  state had to be met before the script could even execute. Then the first line
  of the script invalidated the required state.

### Parameters

#### -Version \<N\>[.\<n\>]

Specifies the minimum version of Windows PowerShell that the script requires.
Enter a major version number and optional minor version number.

For example:

```powershell
#Requires -Version 3.0
```

#### -PSSnapin \<PSSnapin-Name\> [-Version \<N\>[.\<n\>]]

Specifies a Windows PowerShell snap-in that the script requires. Enter the
snap-in name and an optional version number.

For example:

```powershell
#Requires -PSSnapin DiskSnapin -Version 1.2
```

#### -Modules \<Module-Name\> | \<Hashtable\>

Specifies Windows PowerShell modules that the script requires. Enter the
module name and an optional version number. The Modules parameter is
introduced in Windows PowerShell 3.0.

If the required modules are not in the current session, Windows PowerShell
imports them. If the modules cannot be imported, Windows PowerShell throws a
terminating error.

For each module, type the module name (\<String\>) or a hash table with the
following keys. The value can be a combination of strings and hash tables.

- `ModuleName` - __[Required]__ Specifies the module name.
- `GUID` - __[Optional]__ Specifies the GUID of the module.
- It is also **Required** to specify **one** of the two below keys,
  they cannot be used together.
  - `ModuleVersion` - __[Required]__ Specifies a minimum acceptable version of the module.
  - `RequiredVersion` - __[Required]__ Specifies an exact, required version of the module.

> [!NOTE]
> `RequiredVersion` was added in Windows PowerShell 5.0.

For example,

Require that `Hyper-V` (version `1.1` or greater) is installed.

```powershell
#Requires -Modules @{ ModuleName="Hyper-V"; ModuleVersion="1.1" }
```

Requires that `Hyper-V` (**only** version `1.1`) is installed.

```powershell
#Requires -Modules @{ ModuleName="Hyper-V"; RequiredVersion="1.1" }
```

Requires that any version of `PSScheduledJob` and `PSWorkflow`, is installed.

```powershell
#Requires -Modules PSWorkflow, PSScheduledJob
```

When using the `RequiredVersion` key, ensure your version string exactly matches
the version string you wish to require.

```powershell
Get-Module Hyper-V
```

```output
ModuleType Version    Name     ExportedCommands
---------- -------    ----     ------------------
Binary     2.0.0.0    hyper-v  {Add-VMAssignableDevice, ...}
```

This will **FAIL**, because "2.0.0" does not exactly match "2.0.0.0"

```powershell
#Requires -Modules @{ ModuleName="Hyper-V"; RequiredVersion="2.0.0" }
```

#### -ShellId

Specifies the shell that the script requires. Enter the shell ID.

For example,

```powershell
#Requires -ShellId MyLocalShell
```

You can find current ShellId by querying `$ShellId` automatic variable.

#### -RunAsAdministrator

When this switch parameter is added to your requires statement, it specifies
that the Windows PowerShell session in which you are running the script must
be started with elevated user rights (Run as Administrator).
The RunAsAdministrator parameter is introduced in Windows PowerShell 4.0.

For example,

```powershell
#Requires -RunAsAdministrator
```

### Examples

The following script has two `#Requires` statements. If the requirements
specified in both statements are not met, the script does not run. Each
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

### Notes

In Windows PowerShell 3.0, the Windows PowerShell Core packages appear as
modules in sessions started by using the InitialSessionState.CreateDefault2
method, such as sessions started in the Windows PowerShell console. Otherwise,
they appear as snap-ins. The exception is Microsoft.PowerShell.Core, which is
always a snap-in.

## See also

[about_Automatic_Variables](about_Automatic_Variables.md)

[about_Language_Keywords](about_Language_Keywords.md)

[about_PSSnapins](about_PSSnapins.md)

[Get-PSSnapin](../Get-PSSnapin.md)