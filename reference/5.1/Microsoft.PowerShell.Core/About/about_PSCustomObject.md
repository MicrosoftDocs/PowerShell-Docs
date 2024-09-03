---
description: Explains the differences between the [psobject] and [pscustomobject] type accelerators.
Locale: en-US
ms.date: 07/02/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pscustomobject?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSCustomObject
---
value

PS> $object.Count
PS> $object.Length
```

Starting in PowerShell 6, objects created by casting a **Hashtable** to
`[pscustomobject]` always have a value of `1` for the **Length** and **Count**
properties.

## See also

- [about_Object_Creation][01]
- [about_Objects][02]
- [System.Management.Automation.PSObject][05]
- [System.Management.Automation.PSCustomObject][04]

<!-- link references -->
[01]: about_Object_Creation.md
[02]: about_Objects.md
[03]: about_type_accelerators.md
[04]: xref:System.Management.Automation.PSCustomObject
[05]: xref:System.Management.Automation.PSObject
