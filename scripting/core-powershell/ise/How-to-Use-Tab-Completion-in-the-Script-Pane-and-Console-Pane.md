---
title:  How to Use Tab Completion in the Script Pane and Console Pane
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  3b752c3c-0bd0-4eca-a2d3-2d5a37fd9d84
---

# How to Use Tab Completion in the Script Pane and Console Pane
Tab completion provides automatic Help when you are typing in the Script Pane or in the Command Pane. Use the following steps to take advantage of this feature:

## To automatically complete a command entry
In the Command Pane or Script Pane, type a few characters of a command and then press TAB to select the desired completion text. If multiple items begin with the text that you initially typed, then continue pressing Tab until the item you want appears. Tab completion can help with typing a cmdlet name, parameter name, variable name, object property name, or a file path.

> [!NOTE]
> In the Script Pane, pressing TAB will automatically complete a command only when you are editing .ps1, .psd1, or .psm1 files. Tab completion works any time when you are typing in the Command Pane.

## To automatically complete a cmdlet parameter entry
In the Command Pane or Script pane, type a cmdlet followed by a dash, and then press TAB.

For example, type `get-process -` and then press TAB multiple times to display each of the parameters for the cmdlet in turn.

## See Also
[Using Windows PowerShell ISE](using-the-windows-powershell-ise.md)
[How to Create a PowerShell Tab](How-to-Create-a-PowerShell-Tab-in-Windows-PowerShell-ISE.md)

