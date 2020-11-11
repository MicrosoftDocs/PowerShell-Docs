---
ms.date: 09/12/2016
ms.topic: reference
title: How to Test Updatable Help
description: How to Test Updatable Help
---
# How to Test Updatable Help

This topic describes approaches to testing Updatable Help for a module.

## Using Verbose to Detect Errors

After uploading the HelpInfo XML file and CAB files for your module, test the files by running an
[Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) command with the **Verbose**
parameter. The **Verbose** parameter directs `Update-Help` to report the critical steps in its
actions, from reading the **HelpInfoUri** key in the module manifest to validating the file types in
the unpacked CAB file and placing the files in the language-specific module directory.

When all verbose messages are resolved, run an `Update-Help` command with the **Debug** parameter.
This parameter should detect any remaining problems with the Updatable Help files.
