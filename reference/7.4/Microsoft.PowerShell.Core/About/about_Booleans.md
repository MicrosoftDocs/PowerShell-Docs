---
description: Describes how boolean expressions are evaluated.
Locale: en-US
ms.date: 01/19/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_booleans?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Booleans
---
# about_Booleans

## Short description
Describes how boolean expressions are evaluated.

## Long description

PowerShell can implicitly treat any type as a **Boolean**. It is important to
understand the rules that PowerShell uses to convert other types to **Boolean**
values.

## Converting from scalar types

A [scalar][02] type is an atomic quantity that can hold only one value at a
time. The following types evaluate to `$false`:

- Empty strings like `''` or `""`
- Null values like `$null`
- Any numeric type with the value of `0`

Examples:

```powershell
PS> $false -eq ''
True
PS> if ("") { $true } else { $false }
False
PS> if ($null) { $true } else { $false }
False
PS> if ([int]0) { $true } else { $false }
False
PS> if ([double]0.0) { $true } else { $false }
False
```

The following types evaluate to `$true`:

- Non-empty strings
- Instances of any other non-collection type

Examples:

```powershell
# a non-collection type
PS> [bool]@{value = 0}
True
# non-empty strings
PS> if ('hello') { $true } else { $false }
True
PS> [bool]'False'
True
```

Note that this differs from _explicit string parsing_:

```powershell
PS> [bool]::Parse('false')
False
PS> [bool]::Parse('True')
True
PS> [bool]::Parse('Not True')
MethodInvocationException: Exception calling "Parse" with "1" argument(s):
"String 'Not True' was not recognized as a valid Boolean."
```

## Converting from collection types

Arrays are the most common collection type in PowerShell. These rules apply to
any collection-like types that implement the [IList][01] interface.

- Empty collections are always `$false`
- The special null value indicating the absence of output from a command,
  `[System.Management.Automation.Internal.AutomationNull]::Value` is always
  `$false`.
- Single-element collections evaluate to the **Boolean** value of their one and
  only element.
- Collections with more than 1 element are always `$true`.

Examples:

```powershell
# Empty collections
PS> [bool]@()
False
PS> [bool](Get-ChildItem | Where-Object Name -eq 'Non-existent-File.txt')
False
# Single-element collections
PS> $a = @(0)
PS> [bool]$a
False
PS> $b = @(1)
PS> [bool]$b
True
# Multi-element collections
PS> $c = @(0,0)
PS> [bool]$c
True
```

## See also

- [about_Arrays][03]

<!-- link references -->
[01]: /dotnet/api/system.collections.ilist
[02]: /powershell/scripting/learn/glossary#scalar-value
[03]: about_Arrays.md#where
