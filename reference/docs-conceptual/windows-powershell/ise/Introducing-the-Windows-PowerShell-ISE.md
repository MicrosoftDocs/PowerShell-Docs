---
ms.date:  08/14/2018
title:  Introducing the Windows PowerShell ISE
description: The PowerShell ISE is a host application for Windows PowerShell that allows you to run commands and write, test, and debug scripts in a single Windows-based graphic user interface.
---

# The Windows PowerShell ISE

The Windows PowerShell Integrated Scripting Environment (ISE) is a host application for Windows
PowerShell. In the ISE, you can run commands and write, test, and debug scripts in a single
Windows-based graphic user interface. The ISE provides multiline editing, tab completion, syntax
coloring, selective execution, context-sensitive help, and support for right-to-left languages. Menu
items and keyboard shortcuts are mapped to many of the same tasks that you would do in the Windows
PowerShell console. For example, when you debug a script in the ISE, you can right-click on a line
of code in the edit pane to set a breakpoint.

## Support

The ISE was first introduced with Windows PowerShell V2 and was re-designed with PowerShell V3. The
ISE is supported in all supported versions of Windows PowerShell up to and including Windows
PowerShell V5.1.

> [!NOTE]
> The PowerShell ISE is no longer in active feature development. As a shipping component of
> Windows, it continues to be officially supported for security and high-priority servicing fixes.
> We currently have no plans to remove the ISE from Windows.
>
> There is no support for the ISE in PowerShell v6 and beyond. Users looking for replacement for the
> ISE should use [Visual Studio Code](https://code.visualstudio.com/) with the
> [PowerShell Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell).

## Key Features

Key features in Windows PowerShell ISE include:

- Multiline editing: To insert a blank line under the current line in the Command pane, press
  <kbd>SHIFT</kbd>+<kbd>ENTER</kbd>.
- Selective execution: To run part of a script, select the text you want to run, and then click the
  **Run Script** button. Or, press <kbd>F5</kbd>.
- Context-sensitive help: Type `Invoke-Item`, and then press <kbd>F1</kbd>. The Help file opens to
  the article for the `Invoke-Item` cmdlet.

The Windows PowerShell ISE lets you customize some aspects of its appearance. It also has its own
Windows PowerShell profile script.

## To start the Windows PowerShell ISE

Click **Start**, select **Windows PowerShell**, and then click **Windows PowerShell ISE**.
Alternately, you can type `powershell_ise.exe` in any command shell or in the Run box.

## To get Help in the Windows PowerShell ISE

On the **Help** menu, click **Windows PowerShell Help**. Or, press <kbd>F1</kbd>. The file that
opens describes Windows PowerShell ISE and Windows PowerShell, including all the help available from
the `Get-Help` cmdlet.
