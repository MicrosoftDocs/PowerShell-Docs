---
description:  
manager:  carmonm
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Exploring the Windows PowerShell ISE
ms.technology:  powershell
ms.assetid:    e0d2c6e8-5126-40e7-a1e1-d1cff29fe94a
---


# Exploring the Windows PowerShell ISE
You can use the Windows PowerShell® Integrated Scripting Environment (ISE) to create, run, and debug commands and scripts. The Windows PowerShell ISE consists of the menu bar, Windows PowerShell tabs, the toolbar, script tabs, a Script Pane, a Console Pane, a status bar, a text-size slider and context-sensitive Help.

> [!NOTE]
> Beginning with Windows PowerShell ISE 3.0 the Command and Output Panes were combined into a single Console Pane.

## Menu Bar
The menu bar contains the **File**, **Edit**, **View**, **Tools**, **Debug**, **Add-ons**, and **Help** menus. The buttons on the menus allow you to perform tasks related to writing and running scripts and running commands in the Windows PowerShell ISE. Additionally, an [add-on tool](../../core-powershell/ise/The-ISEAddOnTool-Object.md) may be placed on the menu bar by running scripts that use the [Windows PowerShell ISE Scripting Object Model](../../core-powershell/ise/The-Windows-PowerShell-ISE-Scripting-Object-Model.md).

> [!NOTE]
> In Windows PowerShell ISE 2.0, The **Tools** and **Add-ons** menus were not present.

## Windows PowerShell Tabs
A Windows PowerShell tab is the environment in which a Windows PowerShell script runs. You can open new Windows PowerShell tabs in the Windows PowerShell ISE to create separate environments on your local computer or on remote computers. You may have a maximum of eight PowerShell tabs simultaneously open.

## Toolbar
The following buttons are located on the toolbar.

|Button|Function|
|----------|------------|
|**New**|Opens a new script.|
|**Open**|Opens an existing script or file.|
|**Save**|Saves a script or file.|
|**Cut**|Cuts the selected text and copies it to the clipboard.|
|**Copy**|Copies the selected text to the clipboard.|
|**Paste**|Pastes the contents of the clipboard at the cursor location.|
|**Clear Output Pane**|Clears all content in the Output Pane.|
|**Undo**|Reverses the action that was just performed.|
|**Redo**|Performs the action that was just undone.|
|**Run Script**|Runs a script.|
|**Run Selction**|Runs a selected portion of a script.|
|**Stop Execution**|Stops a script that is running.|
|**New Remote PowerShell Tab**|Creates a new PowerShell Tab that establishes a session on a remote computer. A dialog box appears and prompts you to enter details required to establish the remote connection.|
|**Start PowerShell.exe**|Opens a PowerShell Console.|
|**Show Script Pane Top**|Moves the Script Pane to the top in the display.|
|**Show Script Pane Right**|Moves the Script Pane to the right in the display.|
|**Show Script Pane Maximized**|Maximizes the Script Pane.|

## Script Tab
Displays the name of the script you are editing. You can click a script tab to select the script you want to edit.

When you point to the script tab, the fully qualified path to the script file appears in a tooltip.

## Script Pane
Allows you to create and run scripts. You can open, edit and run existing scripts in the Script Pane.

## Output Pane
Displays the results of the commands and scripts you have run. You can also copy and clear the contents in the Output Pane.

## Command Pane
Allows you to write commands. You can run a one line command or a multiline command in the Command Pane. Press SHIFT+ENTER to enter each line of a multiline command, and press ENTER after the last line to execute the multiline command. The prompt displayed on top of the Command Pane shows the path to the current working directory.

## Status Bar
Allows you to see whether the commands and scripts that you run are complete. The status bar is at the very bottom of the display. Selected portions of error messages are displayed on the status bar.

## Text-Size Slider
Increases or decreases the size of the text on the screen.

## Help
Help for Windows PowerShell ISE is available on the Web in the TechNet Library. You can open the Help by clicking **Windows PowerShell ISE Help** on the **Help** menu or by pressing the F1 key anywhere except when the cursor is on a cmdlet name in either the Script Pane or the Console Pane. From the **Help** menu you can also run the Update-Help cmdlet, and display the Command Window which assists you in constructing commands by showing you all of the parameters for a cmdlet and enabling you to fill in the parameters in an easy-to-use form.

## See Also
- [Using the Windows PowerShell ISE](../../core-powershell/ise/Using-the-Windows-PowerShell-ISE.md)

