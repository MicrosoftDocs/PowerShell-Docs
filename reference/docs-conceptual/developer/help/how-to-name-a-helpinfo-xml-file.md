---
ms.date: 09/12/2016
ms.topic: reference
title: How to Name a HelpInfo XML File
description: How to Name a HelpInfo XML File
---
# How to Name a HelpInfo XML File

This topic explains the required name format for the Updatable Help Information files, commonly
known as HelpInfo XML files.

## How to Name a HelpInfo XML File

A HelpInfo XML file must have a name with the following format.

`<ModuleName>_<ModuleGUID>_HelpInfo.xml`

The elements of the name are as follows.

- `<ModuleName>` - The value of the **Name** property of the **ModuleInfo** object that the
  [Get-Module](/powershell/module/Microsoft.PowerShell.Core/Get-Module) cmdlet returns.

- `<ModuleGUID>` - The value of the **GUID** key in the module manifest.

For example, if the module name is "TestModule" and the module GUID is
9cabb9ad-f2ac-4914-a46b-bfc1bebf07f9, the name of the HelpInfo XML file for the module would be:

`TestModule_9cabb9ad-f2ac-4914-a46b-bfc1bebf07f9_HelpInfo.xml`
