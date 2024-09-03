---
description: Describes how to use PowerShell data (.psd1) files.
Locale: en-US
ms.date: 01/19/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_data_files?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Data_Files
---
# about_Data_Files

## Short description
PowerShell data files are used to store arbitrary data using PowerShell syntax.

## Long description

PowerShell data (`.psd1`) files can store arbitrary data in PowerShell syntax.
That data can be imported into variables in a PowerShell session. PowerShell
has three types of data files and provides a cmdlet to import each type.

## Basic data files

The `Import-PowerShellDataFile` cmdlet imports basic data files. The data in
the file must be contained in a hashtable. This format only supports constant
values. You can't use code or PowerShell expressions.

## Module manifests

Module manifests are PowerShell data files. The data in the file must be
contained in a hashtable. The structure of that hashtable only supports
specific key names related to PowerShell modules.

The values assigned to the settings in the manifest file can be expressions
that are evaluated by PowerShell. This allows you to construct paths and
conditionally assign values based on variables.

When you import a module using `Import-Module`, the manifest is evaluated in
`Restricted` language mode. `Restricted` mode limits the commands and variables
that can be used.

For more information, see [about_Module_Manifests][03].

## Localized data

The `Import-LocalizedData` cmdlet imports localized data files. During import,
the file is processed in `Constrained` language mode. `Constrained` mode limits
the commands and variables that can be used.

For more information, see [about_Language_Modes][02].

Originally, localized data files were meant to be used to store string data that
could be translated into other languages. This allowed your scripts to import
the data to provide localized string output in other languages. However, you
aren't limited to storing string data and don't have to use the data for
localized output.

The data in the file isn't limited to hashtables. It can be in any format
supported by the PowerShell syntax, such as `DATA` sections.

For more information, see [about_Data_Sections][01].

## See also

- [Import-LocalizedData][05]
- [Import-Module][04]
- [Import-PowerShellDataFile][06]
- [about_Data_Sections][01]
- [about_Language_Modes][02]
- [about_Module_Manifests][03]

<!-- link references -->
[01]: about_Data_Sections.md
[02]: about_Language_Modes.md
[03]: about_Module_Manifests.md
[04]: xref:Microsoft.PowerShell.Core.Import-Module
[05]: xref:Microsoft.PowerShell.Utility.Import-LocalizedData
[06]: xref:Microsoft.PowerShell.Utility.Import-PowerShellDataFile
