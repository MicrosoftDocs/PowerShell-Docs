---
description: This article explains how PowerShell handles case-sensitivity.
Locale: en-US
ms.date: 01/06/2026
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_case-sensitivity?view=powershell-7.4&WT.mc_id=ps-gethelp
title: about_Case-Sensitivity
---
# about_Case-Sensitivity

## Short description

PowerShell is as case-insensitive while preserving case.

## Long description

As a general principle, PowerShell is case-insensitive wherever possible while
preserving case and not breaking the underlying OS.

Windows-based systems are case-insensitive for most operations. However,
non-Windows systems are case-sensitive for most operations, especially for
file system and environment variable access.

PowerShell is guaranteed to be case-insensitive on all systems for the
following areas:

- Variable names
- Operator names
- Non-dictionary member-access
- Command discovery of PowerShell commands and aliases. This excludes
  ExternalScript and Application commands.
- Parameter names and aliases
- PowerShell language keywords
- `using namespace` statements
- Type literals
- `#Requires` statements
- Comment-based help keywords
- PSProvider names
- PSDrive names
- Scope modifiers

## Special cases

- Module names are case-insensitive (with exceptions)

  The _name_ of the module is purely a PowerShell concept and treated
  case-insensitively. However, there is a strong mapping to a foldername, which
  can be case-sensitive in the underlying operating system. Importing two
  modules with the same case-insensitive name has the same behavior as
  importing two modules with the same name from different paths.

  The name of a module is stored in the session state using the case by which
  it was imported. The name, as stored in the session state, is used
  `Update-Help` when looking for new help files. The web service that serves
  the help files for Microsoft uses a case-sensitive file system. When the case
  of the imported name of the module doesn't match, `Update-Help` can't find
  the help files and reports an error.

- [PS providers][05]:

  The `FileSystem` and `Environment` providers are case-sensitive on
  non-Windows systems. Generally, operations involving paths or environment
  variables are case-sensitive on such systems.

  However, [wildcard matching][09] by [provider cmdlets][02] is
  case-insensitive, irrespective of the system.

  ```powershell
  [void] (New-Item -Path Temp:foo.txt -Force)

  (Get-Item -Path Temp:FOO.txt).Name
  # Get-Item: Cannot find path 'Temp:/FOO.txt' because it does not exist.

  (Get-Item -Path Temp:F[O]*.txt).Name
  # foo.txt

  (Get-Item -Path Env:hOME).Name
  # Get-Item: Cannot find path 'Env:/hOME' because it does not exist.

  (Get-Item -Path Env:hOM[E]).Name
  # HOME
  ```

- Parameter set names are case-sensitive.

  The `DefaultParameterSetName` case must be identical to `ParameterSetName`.

- .NET methods often exhibit case-sensitive behavior by default.

  Examples include:

  - Equivalent .NET methods (without explicit opt-in) for common PowerShell
    operators such as:
    - `Array.Contains()`, `String.Contains()`, `String.Replace()`,
      `Regex.Match()`, `Regex.Replace()`
  - Reflection; member names must use the correct case.
  - Non-literal dictionary instantiation. For example:
    - `[hashtable]::new()` has case-sensitive keys, whereas a hashtable
      literal `@{}` has case-insensitive keys.
    - `[ordered]::new()` has case-sensitive keys, whereas a `[ordered] @{}` has
      case-insensitive keys. The `[ordered]` type _accelerator_ isn't available
      in PowerShell v5.1 and earlier.
  - Explicitly calling `Enum.Parse()` is case-sensitive by default, whereas
    PowerShell typically handles enums in a case-insensitive manner.

- `-Unique` cmdlets:
  - [`Select-Object -Unique`][21] and [`Get-Unique`][15] are case-sensitive by
    default. The [`-CaseInsensitive`][20] switch was added in PS v7.4.
  - [`Sort-Object -Unique`][25] is case-insensitive by default, but has always
    had [`-CaseSensitive`][24] switch.

- [`Compare-Object`][11] is case-insensitive by default, but has a
  [`-CaseSensitive`][12] switch. Comparison of `[char]` types is case-sensitive
  by default. String comparison is case-insensitive by default.

  ```powershell
  # Compare strings - Equal (no output)
  Compare-object -ReferenceObject a            -DifferenceObject A
  # Compare chars - Different (output)
  Compare-object -ReferenceObject ([char] 'a') -DifferenceObject ([char] 'A')
  ```

- [`ConvertFrom-Json -AsHashtable`][13]:
  - `-AsHashtable` was added in PS v6. In PS v7.3, a change was made to treat
    JSON keys as case-sensitive when this parameter is specified.
    - With the parameter, an object of type
      [`Management.Automation.OrderedHashtable`][27] is emitted, which has
      case-sensitive keys.
    - Without the parameter, JSON keys are treated as case-insensitive. Output
      is a custom object; last case-insensitive key wins.
  - https://github.com/PowerShell/PowerShell/issues/19928

- [`Group-Object`][16]:
  - Case-insensitive by default, but does have a [`-CaseSensitive`][18]
    switch.
  - In Windows PowerShell v5.1, `-CaseSensitive` and [`-AsHashtable`][17]
    produces a case-insensitive hashtable. Duplicate keys result in an error.

    ```powershell
    [pscustomobject] @{ Foo = 'Bar' }, [pscustomobject] @{ Foo = 'bar' } |
        Group-Object -Property Foo -CaseSensitive -AsHashtable
    ```

    ```Output
    Group-Object : The objects grouped by this property cannot be expanded
    because there is a key duplication. Provide a valid value for the
    property, and then try again.
    At line:2 char:11
    +           Group-Object -Property Foo -CaseSensitive -AsHashtable
    +           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : InvalidArgument: (:) [Group-Object], Exception
        + FullyQualifiedErrorId : The objects grouped by this property
    cannot be expanded because there is a key duplication. Provide a valid
    value for the property, and then try again.,Microsoft.PowerShell.Comman
    ds.GroupObjectCommand
    ```

  - In PowerShell v7 and higher, `-CaseSensitive` and `-AsHashtable` produces a
    case-sensitive hashtable. No error occurs with duplicate keys.

    ```powershell
    [pscustomobject] @{ Foo = 'Bar' }, [pscustomobject] @{ Foo = 'bar' } |
        Group-Object -Property Foo -CaseSensitive -AsHashtable
    ```

    ```Output
    Name                           Value
    ----                           -----
    Bar                            {@{Foo=Bar}}
    bar                            {@{Foo=bar}}
    ```

- [`Select-String`][22]:
  - Case-insensitive by default, but does have a [`-CaseSensitive`][23] switch.

- [`Get-Command`][14] and command discovery/invocation:
  - On case-sensitive file systems, discovery and invocation of
    `ExternalScript` and `Application` command are case-sensitive.
  - `Get-Command` wildcard matching with these types is also case-sensitive.
  - All other [`CommandTypes`][26] are case-insensitive.

- [Comparison operators][03]:
  - By default, operators are case-insensitive.
  - `-c*` operators are case-sensitive.
  - `-i*` operators are case-insensitive.
  - `-replace`/`-ireplace` is case-insensitive by default, _except_ with [named
    capture groups][01], which are case-sensitive.

    ```powershell
    'Bar' -replace '(?<a>a)', '${a}${a}'
    # Baar

    'Bar' -replace '(?<a>a)', '${A}${A}'
    # B${A}${A}r
    ```

- [`-split` operator](about_split):
  - `-split` and `-isplit` are case-insensitive.
  - `-csplit` is case-sensitive, _unless_ the `IgnoreCase` option is specified.

    ```powershell
    'Bar' -csplit 'A', 0
    # Bar

    'Bar' -csplit 'A', 0, 'IgnoreCase'
    # B
    # r
    ```

- [Tab completion][07]:
  - On case-sensitive file systems, tab completion and globbing are both
    case-insensitive. For example, `TabExpansion2 -inputScript ./foo` will
    complete to `./Foo.txt` on Linux.

- [`using`][08] statement:
  - On case-sensitive file systems, `using module` and `using assembly` are
    case-sensitive when a path is specified.
  - `using module` with just a module name is case-insensitive.
  - `using namespace` is always case-insensitive.

- [Special characters][06]:
  - Escape sequences like `` `n `` are case-sensitive.

## See also

- [about_Environment_Variables][04]
- [Import-Module][19]

<!-- link references -->
[01]: /dotnet/standard/base-types/substitutions-in-regular-expressions#substituting-a-named-group
[02]: /powershell/scripting/developer/provider/provider-cmdlets
[03]: about_comparison_operators.md
[04]: about_Environment_Variables.md
[05]: about_providers.md
[06]: about_special_characters.md
[07]: about_tab_expansion.md
[08]: about_using.md
[09]: about_wildcards.md
[11]: xref:Microsoft.PowerShell.Core.Compare-Object
[12]: xref:Microsoft.PowerShell.Core.Compare-Object#-casesensitive
[13]: xref:Microsoft.PowerShell.Core.ConvertFrom-Json#-ashashtable
[14]: xref:Microsoft.PowerShell.Core.Get-Command
[15]: xref:Microsoft.PowerShell.Core.Get-Unique
[16]: xref:Microsoft.PowerShell.Core.Group-Object
[17]: xref:Microsoft.PowerShell.Core.Group-Object#-ashashtable
[18]: xref:Microsoft.PowerShell.Core.Group-Object#-casesensitive
[19]: xref:Microsoft.PowerShell.Core.Import-Module
[20]: xref:Microsoft.PowerShell.Core.Select-Object#-caseinsensitive
[21]: xref:Microsoft.PowerShell.Core.Select-Object#-unique
[22]: xref:Microsoft.PowerShell.Core.Select-String
[23]: xref:Microsoft.PowerShell.Core.Select-String#-casesensitive
[24]: xref:Microsoft.PowerShell.Core.Sort-Object#-casesensitive
[25]: xref:Microsoft.PowerShell.Core.Sort-Object#-unique
[26]: xref:System.Management.Automation.CommandTypes
[27]: xref:System.Management.Automation.OrderedHashtable
