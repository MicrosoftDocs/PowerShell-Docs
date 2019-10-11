---
title: "How to Test Updatable Help | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 3e064048-2b94-4365-bdb7-f1ee7c0a7fd7
caps.latest.revision: 6
---
# How to Test Updatable Help

This topic describes approaches to testing Updatable Help for a module.

## Using Verbose to Detect Errors

After uploading the HelpInfo XML file and CAB files for your module, test the files by running an [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) command with the **Verbose** parameter. The **Verbose** parameter directs `Update-Help` to report the critical steps in its actions, from reading the **HelpInfoUri** key in the module manifest to validating the file types in the unpacked CAB file and placing the files in the language-specific module directory.

When all verbose messages are resolved, run an `Update-Help` command with the **Debug** parameter. This parameter should detect any remaining problems with the Updatable Help files.