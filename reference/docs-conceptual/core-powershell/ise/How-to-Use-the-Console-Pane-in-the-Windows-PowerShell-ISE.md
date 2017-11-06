---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  How to Use the Console Pane in the Windows PowerShell ISE
ms.assetid:  44d67705-87c7-4a69-a53e-6471fdebb757
---

# How to Use the Console Pane in the Windows PowerShell ISE
The Console pane in the Windows PowerShell Integrated Scripting Environment (ISE) operates exactly like the stand-alone Windows PowerShell ISE console window.

To run a command in the Console Pane, type a command, and then press ENTER. To enter multiple commands that you want to execute in sequence, type SHIFT+ENTER between commands. See [How to Use Tab Completion in the Script Pane and Console Pane](How-to-Use-Tab-Completion-in-the-Script-Pane-and-Console-Pane.md) for help in typing commands.

To stop a command, on the toolbar, click **Stop Operation**, or press CTRL+BREAK. You can also use CTRL+C to stop a command if the context is unambiguous. For example, if some text has been selected in the current Pane, then CTRL+C maps to the copy operation.

Beginning in Windows PowerShell v3, the Output pane was combined with the Console pane. This has the benefit of behaving like the stand-alone Windows PowerShell console and eliminates the differences in procedures that were needed when they were separate. You can:

- Select and copy text from the Console pane to the Clipboard for pasting in any other window. To select text, click and hold the mouse in the output pane while dragging the mouse over the text you want to capture. You can also use the cursor arrow keys while holding **SHIFT** to select text. Then press CTRL+C or click the **Copy** icon in the toolbar.

- Paste the selected text at a current cursor position. Click the **Paste** icon on the toolbar.

- Clear all the text in the Console pane. To clear the Console pane, you can click the **Clear Console Pane** icon on the toolbar, or run the command **Clear-Host** or its alias, **cls**.

## See Also
- [Using the Windows PowerShell ISE](Using-the-Windows-PowerShell-ISE.md)

