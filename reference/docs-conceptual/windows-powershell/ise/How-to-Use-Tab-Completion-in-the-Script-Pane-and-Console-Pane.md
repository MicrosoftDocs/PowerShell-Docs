---
ms.date:  01/02/2020
title:  How to Use Tab Completion in the Script Pane and Console Pane
description:  How to Use Tab Completion in the Script Pane and Console Pane
---

# How to Use Tab Completion in the Script Pane and Console Pane

Tab completion provides automatic help when you are typing in the Script Pane or in the Command
Pane. Use the following steps to take advantage of this feature:

## To automatically complete a command entry

In the Command Pane or Script Pane, type a few characters of a command and then press <kbd>TAB</kbd> to select
the desired completion text. If multiple items begin with the text that you initially typed, then
continue pressing <kbd>TAB</kbd> until the item you want appears. Tab completion can help with typing a cmdlet
name, parameter name, variable name, object property name, or a file path.

> [!NOTE]
> In the Script Pane, pressing <kbd>TAB</kbd> will automatically complete a command only when you are editing
> `.ps1`, `.psd1`, or `.psm1` files. Tab completion works any time when you are typing in the Command Pane.

## To automatically complete a cmdlet parameter entry

In the Command Pane or Script pane, type a cmdlet followed by a dash and then press <kbd>TAB</kbd>.

For example, type `Get-Process -` and then press <kbd>TAB</kbd> multiple times to display each of
the parameters for the cmdlet in turn.

## See Also

- [Introducing the Windows PowerShell ISE](Introducing-the-Windows-PowerShell-ISE.md)
- [How to Create a PowerShell Tab](How-to-Create-a-PowerShell-Tab-in-Windows-PowerShell-ISE.md)
