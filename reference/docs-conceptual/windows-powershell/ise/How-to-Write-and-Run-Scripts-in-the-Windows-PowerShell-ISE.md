---
ms.date:  01/02/2020
title:  How to Write and Run Scripts in the Windows PowerShell ISE
description: This article describes how to create, edit, run, and save scripts in the Script Pane.
---

# How to Write and Run Scripts in the Windows PowerShell ISE

This article describes how to create, edit, run, and save scripts in the Script Pane.

## How to create and run scripts

You can open and edit Windows PowerShell files in the Script Pane. Specific file types of interest
in Windows PowerShell are script files (`.ps1`), script data files (`.psd1`), and script module
files (`.psm1`). These file types are syntax colored in the Script Pane editor. Other common file
types you may open in the Script Pane are configuration files (`.ps1xml`), XML files, and text
files.

> [!NOTE]
> The Windows PowerShell execution policy determines whether you can run scripts and load Windows
> PowerShell profiles and configuration files. The default execution policy, Restricted, prevents
> all scripts from running, and prevents loading profiles. To change the execution policy to allow
> profiles to load and be used, see
> [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy) and
> [about_Signing](/powershell/module/microsoft.powershell.core/about/about_signing).

### To create a new script file

On the toolbar, click **New**, or on the **File** menu, click **New**. The created file appears in
a new file tab under the current PowerShell tab. Remember that the PowerShell tabs are only visible
when there are more than one. By default a file of type script (`.ps1`) is created, but it can be
saved with a new name and extension. Multiple script files can be created in the same PowerShell
tab.

### To open an existing script

On the toolbar, click **Open**, or on the **File** menu, click **Open**. In the **Open** dialog
box, select the file you want to open. The opened file appears in a new tab.

### To close a script tab

Click the **Close** icon (**X**) of the file tab you want to close or select the **File** menu and
click **Close**.

If the file has been altered since it was last saved, you're prompted to save or discard it.

### To display the file path

On the file tab, point to the file name. The fully qualified path to the script file appears in a
tooltip.

### To run a script

On the toolbar, click **Run Script**, or on the **File** menu, click **Run**.

### To run a portion of a script

1. In the Script Pane, select a portion of a script.
2. On the **File** menu, click **Run Selection**, or on the toolbar, click **Run Selection**.

### To stop a running script

There are several ways to stop a running script.

- Click **Stop Operation** on the toolbar
- Press <kbd>CTRL</kbd>+<kbd>BREAK</kbd>
- Select the **File** menu and click **Stop Operation**.

Pressing <kbd>CTRL</kbd>+<kbd>C</kbd> also works unless some text is currently selected, in which
case <kbd>CTRL</kbd>+<kbd>C</kbd> maps to the copy function for the selected text.

## How to write and edit text in the Script Pane

You can copy, cut, paste, find, and replace text in the Script Pane. You can also undo and redo the
last action you just performed. The keyboard shortcuts for these actions are the same shortcuts
used for all Windows applications.

### To enter text in the Script Pane

1. Move the cursor to the Script Pane by clicking anywhere in the Script Pane, or by clicking **Go
   to Script Pane** in the **View** menu.
2. Create a script. Syntax coloring and tab completion provide a richer editing experience in
   Windows PowerShell ISE.
3. See [How to Use Tab Completion in the Script Pane and Console Pane](How-to-Use-Tab-Completion-in-the-Script-Pane-and-Console-Pane.md)
   for details about using the tab completion feature to help in typing.

### To find text in the Script Pane

1. To find text anywhere, press <kbd>CTRL</kbd>+<kbd>F</kbd> or, on the **Edit** menu, click **Find
   in Script**.
2. To find text after the cursor, press <kbd>F3</kbd> or, on the **Edit** menu, click **Find Next in
   Script**.
3. To find text before the cursor, press <kbd>SHIFT</kbd>+<kbd>F3</kbd> or, on the **Edit** menu,
   click **Find Previous in Script**.

### To find and replace text in the Script Pane

Press <kbd>CTRL</kbd>+<kbd>H</kbd> or, on the **Edit** menu, click **Replace in Script**. Enter the
text you want to find and the replacement text, then press <kbd>ENTER</kbd>.

### To go to a particular line of text in the Script Pane

1. In the Script Pane, press <kbd>CTRL</kbd>+<kbd>G</kbd> or, on the **Edit** menu, click **Go to
   Line**.

2. Enter a line number.

### To copy text in the Script Pane

1. In the Script Pane, select the text that you want to copy.

2. Press <kbd>CTRL</kbd>+<kbd>C</kbd> or, on the toolbar, click the **Copy** icon, or on the
   **Edit** menu, click **Copy**.

### To cut text in the Script Pane

1. In the Script Pane, select the text that you want to cut.
2. Press <kbd>CTRL</kbd>+<kbd>X</kbd> or, on the toolbar, click the **Cut** icon, or on the **Edit**
   menu, click **Cut**.

### To paste text into the Script Pane

Press <kbd>CTRL</kbd>+<kbd>V</kbd> or, on the toolbar, click the **Paste** icon, or on the **Edit**
menu, click **Paste**.

### To undo an action in the Script Pane

Press <kbd>CTRL</kbd>+<kbd>Z</kbd> or, on the toolbar, click the **Undo** icon, or on the **Edit**
menu, click **Undo**.

### To redo an action in the Script Pane

Press <kbd>CTRL</kbd>+<kbd>Y</kbd> or, on the toolbar, click the **Redo** icon, or on the **Edit**
menu, click **Redo**.

## How to save a script

An asterisk appears next to the script name to mark a file that hasn't been saved since it was
changed. The asterisk disappears when the file is saved.

### To save a script

Press <kbd>CTRL</kbd>+<kbd>S</kbd> or, on the toolbar, click the **Save** icon, or on the **File**
menu, click **Save**.

### To save and name a script

1. On the **File** menu, click **Save As**. The **Save As** dialog box will appear.
2. In the **File name** box, enter a name for the file.
3. In the **Save as type** box, select a file type. For example, in the **Save as type** box,
   select 'PowerShell Scripts (`*.ps1`)'.
4. Click **Save**.

### To save a script in ASCII encoding

By default, Windows PowerShell ISE saves new script files (`.ps1`), script data files (`.psd1`), and
script module files (`.psm1`) as Unicode (BigEndianUnicode) by default. To save a script in another
encoding, such as ASCII (ANSI), use the **Save** or **SaveAs** methods on the
[$psISE.CurrentFile](object-model/the-ise-object-model-hierarchy.md) object.

The following command saves a new script as MyScript.ps1 with ASCII encoding.

```powershell
$psISE.CurrentFile.SaveAs("MyScript.ps1", [System.Text.Encoding]::ASCII)
```

The following command replaces the current script file with a file with the same name, but with
ASCII encoding.

```powershell
$psISE.CurrentFile.Save([System.Text.Encoding]::ASCII)
```

The following command gets the encoding of the current file.

```powershell
$psISE.CurrentFile.encoding
```

Windows PowerShell ISE supports the following encoding options: ASCII, BigEndianUnicode, Unicode,
UTF32, UTF7, UTF8, and Default. The value of the Default option varies with the system.

Windows PowerShell ISE doesn't change the encoding of script files when you use the Save or
Save As commands.

## See Also

- [Exploring the Windows PowerShell ISE](exploring-the-windows-powershell-ise.md)
