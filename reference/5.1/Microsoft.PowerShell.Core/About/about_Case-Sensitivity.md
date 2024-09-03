---
description: This article explains how PowerShell handles case-sensitivity.
Locale: en-US
ms.custom: wiki-migration
ms.date: 06/06/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_case-sensitivity?view=powershell-5.1&WT.mc_id=ps-gethelp
title: about_Case-Sensitivity
---
# about_Case-Sensitivity

## Short description
PowerShell is as case-insensitive as possible while preserving case.

## Long description

As a general principle, PowerShell is as case insensitive as possible while preserving case and not
breaking the underlying OS.

### On Unix-based systems

On Unix-based systems, PowerShell is case-sensitive because filesystem manipulation and environment
variables directly affect the underlying operating system and integration with other tools.

## On all systems

- PowerShell variables are case-insensitive

  Variable names have no interaction between them and the underlying operating system. PowerShell
  treats them case-insensitively.

- Module names are case-insensitive (with exceptions)

  The _name_ of the module is purely a PowerShell concept and treated case-insensitively. However, there
  is a strong mapping to a foldername, which can be case-sensitive in the underlying operating
  system. Importing two modules with the same case-insensitive name has the same behavior as
  importing two modules with the same name from different paths.

  The name of a module is stored in the session state using the case by which it was imported. The
  name, as stored in the session state, is used by `Update-Help` when looking for new help files.
  The web service that serves the help files for Microsoft uses a case-sensitive filesystem. When
  the case of the imported name of the module doesn't match, `Update-Help` can't find the help files
  and reports an error.

## Related links

- [about_Environment_Variables](about_environment_variables.md)
- [Import-Module](xref:Microsoft.PowerShell.Core.Import-Module)
