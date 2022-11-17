---
description: PowerShell module authoring considerations
ms.date: 11/16/2022
title: PowerShell module authoring considerations
---

# PowerShell module authoring considerations

This document includes some guidelines related to how a module is authored for best performance.

## Module Manifest Authoring

A module manifest that doesn't use the following guidelines can have a noticeable impact on general
PowerShell performance even if the module isn't used in a session.

Command auto-discovery analyzes each module to determine which commands the module exports and this
analysis can be expensive. The results of module analysis are cached per user, but the cache isn't
available on first run, which is a typical scenario with containers. During module analysis, if the
exported commands can be fully determined from the manifest, more expensive analysis of the module
can be avoided.

### Guidelines

- In the module manifest, don't use wildcards in the `AliasesToExport`, `CmdletsToExport`, and
  `FunctionsToExport` entries.

- If the module doesn't export commands of a particular type, specify this explicitly in the
  manifest by specifying `@()`. A missing or `$null` entry is equivalent to specifying the wildcard
  `*`.

The following should be avoided where possible:

```powershell
@{
    FunctionsToExport = '*'

    # Also avoid omitting an entry, it's equivalent to using a wildcard
    # CmdletsToExport = '*'
    # AliasesToExport = '*'
}
```

Instead, use:

```powershell
@{
    FunctionsToExport = 'Format-Hex', 'Format-Octal'
    CmdletsToExport = @()  # Specify an empty array, not $null
    AliasesToExport = @()  # Also ensure all three entries are present
}
```

## Avoid CDXML

When deciding how to implement your module, there are three primary choices:

- Binary (usually C#)
- Script (PowerShell)
- CDXML (an XML file wrapping CIM)

If the speed of loading your module is important, CDXML is roughly an order of magnitude slower than
a binary module.

A binary module loads the fastest because it's compiled ahead of time and can use NGen to JIT
compile once per machine.

A script module typically loads a bit more slowly than a binary module because PowerShell must parse
the script before compiling and executing it.

A CDXML module is typically much slower than a script module because it must first parse an XML file
which then generates quite a bit of PowerShell script that's then parsed and compiled.
