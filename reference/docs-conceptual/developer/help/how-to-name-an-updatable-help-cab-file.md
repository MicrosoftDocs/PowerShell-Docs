---
ms.date: 09/12/2016
ms.topic: reference
title: How to Name an Updatable Help CAB File
description: How to Name an Updatable Help CAB File
---
# How to Name an Updatable Help CAB File

This topic explains the required name format for the Updatable Help cabinet (`.CAB`) files.

## How to Name an Updatable Help CAB File

A Updatable cabinet (`.CAB`) file must have a name with the following format.

`<ModuleName>_<ModuleGUID>_<UICulture>_HelpContent.cab`

The elements of the name are as follows.

- `<ModuleName>` -The value of the **Name** property of the **ModuleInfo** object that the
  [Get-Module](/powershell/module/Microsoft.PowerShell.Core/Get-Module) cmdlet returns.
- `<ModuleGUID>` - The value of the **GUID** key in the module manifest.
- `<UICulture>` - The UI culture of the help files in the CAB file. This value must match the value
  of one of the **UICulture** elements in the HelpInfo XML file for the module.

For example, if the module name is "TestModule," the module GUID is
9cabb9ad-f2ac-4914-a46b-bfc1bebf07f9, and the UI culture is "en-US", the name of the CAB file would
be:

`TestModule_9cabb9ad-f2ac-4914-a46b-bfc1bebf07f9_en-US_HelpContent.cab`
