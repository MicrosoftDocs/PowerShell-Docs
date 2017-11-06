---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  How to Write and Run Scripts in the Windows PowerShell ISE
ms.assetid:  62f916d9-b3a1-484a-bdfb-41f57112c22b
---

# How to Write and Run Scripts in the Windows PowerShell ISE
This topic describes how to create, edit, run, and save scripts in the Script Pane.

## How to create and run scripts
You can open and edit Windows PowerShell files in the Script Pane. Specific file types of interest in Windows PowerShell are script files (.ps1), script data files (.psd1), and script module files (.psm1). These file types are syntax colored in the Script Pane editor. Other common file types you may open in the Script Pane are configuration files (.ps1xml), XML files, and text files.

> [!NOTE]
> The Windows PowerShell execution policy determines whether you can run scripts and load Windows PowerShell profiles and configuration files. The default execution policy, Restricted, prevents all scripts from running, and prevents loading profiles. To change the execution policy to allow profiles to load and be used, see [Set-ExecutionPolicy[PSITPro5_Security]](https://technet.microsoft.com/en-us/library/5690a0e1-495b-4e63-8280-65ead7bf01ab) and [about_Signing [v4]](https://technet.microsoft.com/en-us/library/fcbdd3b9-0b9f-4734-b5c7-e0dcc304fa1d).

### To create a new script file
On the toolbar, click **New** , or on the **File** menu, click **New**. The created file appears in a new file tab under the current PowerShell tab. Remember that the PowerShell tabs are only visible when there are more than one. By default a file of type script (.ps1) is created, but it can be saved with a new name and extension. Multiple script files can be created in the same PowerShell tab.

### To open an existing script
On the toolbar, click **Open**, or on the **File** menu, click **Open**. In the **Open** dialog box, select the file you want to open. The opened file appears in a new tab.

### To close a script tab
Click the script tab of the script you want to close, then do one of the following:

1. Click the **Close** icon (X) on the script tab.

2. On the **File** menu, click **Close**.

If the file has been altered since it was last saved, you are prompted to save or discard it.

### To display the file path
On the file tab, point to the file name. The fully qualified path to the script file appears in a tooltip.

### To run a script
On the toolbar, click **Run Script**, or on the **File** menu, click **Run**.

### To run a portion of a script

1. In the Script Pane, select a portion of a script.

2. On the **File** menu, click **Run Selection**, or on the toolbar, click **Run Selection**.

### To stop a running script
On the toolbar, click **Stop Operation**, press CTRL+BREAK, or on the **File** menu, click **Stop Operation**. Pressing **CTRL+C** also works unless some text is currently selected, in which case **CTRL+C** maps to the copy function for the selected text.

## How to write and edit text in the Script Pane
Use the following steps to edit text in the Script Pane. You can copy, cut, paste, find, and replace text. You can also undo and redo the last action you just performed. The keyboard shortcuts for performing these actions are the same as those used for all Windows applications.

### To enter text in the Script Pane

1. Move the cursor to the Script Pane by clicking anywhere in the Script Pane, or by clicking **Go to Script Pane** in the **View** menu.

2. Create a script. Syntax coloring and tab completion make this a richer experience in Windows PowerShell ISE.

3. See [How to Use Tab Completion in the Script Pane and Console Pane](How-to-Use-Tab-Completion-in-the-Script-Pane-and-Console-Pane.md) for details about using the tab completion feature to help in typing.

### To find text in the Script Pane

1. To find text anywhere, press **CTRL+F** or, on the **Edit** menu, click **Find in Script**.

2. To find text after the cursor, press **F3** or, on the **Edit** menu, click **Find Next in Script**.

3. To find text before the cursor, press **SHIFT+F3** or, on the **Edit** menu, click **Find Previous in Script**.

### To find and replace text in the Script Pane
Press **CRTL+H** or, on the **Edit** menu, click **Replace in Script**. Enter both the text you want to find and the text with which you want to replace it, and then press **ENTER**.

### To go to a particular line of text in the Script Pane

1. In the Script Pane, press **CTRL+G** or, on the **Edit** menu, click **Go to Line**.

2. Enter a line number.

### To copy text in the Script Pane

1. In the Script Pane, select the text that you want to copy.

2. Press **CTRL+C** or, on the toolbar, click the **Copy** icon, or on the **Edit** menu, click **Copy**.

### To cut text in the Script Pane

1. In the Script Pane, select the text that you want to cut.

2. Press **CTRL+X** or, on the toolbar, click the **Cut** icon, or on the **Edit** menu, click **Cut**.

### To paste text into the Script Pane
Press **CTRL+V** or, on the toolbar, click the **Paste** icon, or on the **Edit** menu, click **Paste**.

### To undo an action in the Script Pane
Press **CTRL+Z** or, on the toolbar, click the **Undo** icon, or on the **Edit** menu, click **Undo**.

### To redo an action in the Script Pane
Press **CTRL+Y** or, on the toolbar, click the **Redo** icon, or on the **Edit** menu, click **Redo**.

## How to save a script
Use the following steps to save and name a script. An asterisk appears next to the script name to mark a file that has not been saved since it was altered. The asterisk disappears when the file is saved.

### To save a script
Press **CTRL+S** or, on the toolbar, click the **Save** icon, or on the **File** menu, click **Save**.

### To save and name a script

1. On the **File** menu, click **Save As**. The **Save As** dialog box will appear.

2. In the **File name** box, enter a name for the file.

3. In the **Save as type** box, select a file type. For example, in the **Save as type** box, select 'œPowerShell Scripts (\* .ps1)'.

4. Click **Save**.

### To save a script in ASCII encoding
By default, Windows PowerShell ISE saves new script files (.ps1), script data files (.psd1), and script module files (.psm1) as Unicode (BigEndianUnicode) by default.Â To save a script in another encoding, such as ASCII (ANSI), use the **Save** or **SaveAs** methods on the [$psISE.CurrentFile](https://technet.microsoft.com/en-us/library/bc3300e4-9c17-4f00-a621-c8867126e3b3#CurrentFile) object.

The following command saves a new script as MyScript.ps1 with ASCII encoding.

```
$psise.CurrentFile.SaveAs("MyScript.ps1", [System.Text.Encoding]::ASCII)
```

The following command replaces the current script file with a file with the same name, but with ASCII encoding.

```
$psise.CurrentFile.Save([System.Text.Encoding]::ASCII)
```

The following command gets the encoding of the current file.

```
$psise.CurrentFile.encoding
```

Windows PowerShell ISE supports the following encoding options: ASCII, BigEndianUnicode, Unicode, UTF32, UTF7, UTF8 and Default. The value of the Default option varies with the system.

Windows PowerShell ISE does not change the encoding of scripts that were created by in other editors, even when you use the Save or Save As commands in Windows PowerShell ISE.

## See Also
- [Using the Windows PowerShell ISE](Using-the-Windows-PowerShell-ISE.md)

