---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Keyboard Shortcuts for the Windows PowerShell ISE
ms.assetid:  8328b946-0f02-4ef4-ac28-2743a1b4043b
---
# Keyboard Shortcuts for the Windows PowerShell ISE

Use the following keyboard shortcuts to perform actions in Windows PowerShell® Integrated Scripting Environment (ISE). Windows PowerShell ISE is available as part of the Windows Server and Windows client operating systems, but can also be installed on some older Windows operating systems as part of the [Windows Management Framework 4.0 download package](https://go.microsoft.com/fwlink/?LinkID=293881).

## Keyboard shortcuts for editing text

You can use the following keyboard shortcuts when you edit text.

|Action|Keyboard Shortcuts|Use in|
|----------|----------------------|----------|
|**Help**|F1|Script Pane **Important:** You can specify that F1 help comes from the TechNet Library on the web or downloaded Help (see Update-Help). To select, click **Tools**, **Options**, then on the **General Settings**tab, set or clear **Use local help content instead of online content.**|
|**Copy**|CTRL+C|Script Pane, Command Pane, Output Pane|
|**Cut**|CTRL+X|Script Pane, Command Pane|
|**Expand or Collapse Outlining**|CTRL+M|Script Pane|
|**Find in Script**|CTRL+F|Script Pane|
|**Find Next in Script**|F3|Script Pane|
|**Find Previous in Script**|SHIFT+F3|Script Pane|
|**Find Matching Brace**|CTRL+]|Script Pane|
|**Paste**|CTRL+V|Script Pane, Command Pane|
|**Redo**|CTRL+Y|Script Pane, Command Pane|
|**Replace in Script**|CTRL+H|Script Pane|
|**Save**|CTRL+S|Script Pane|
|**Select All**|CTRL+A|Script Pane, Command Pane, Output Pane|
|**Show Snippets**|CTRL+J|Script Pane, Command Pane|
|**Undo**|CTRL+Z|Script Pane, Command Pane|

## Keyboard shortcuts for running scripts

You can use the following keyboard shortcuts when you run scripts in the Script Pane.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**New**|CTRL+N|
|**Open**|CTRL+O|
|**Run**|F5|
|**Run Selection**|F8|
|**Stop Execution**|CTRL+BREAK. CTRL+C can be used when the context is unambiguous (when there is no text selected).|
|**Tab** (to next script)|CTRL+TAB **Note:** Tab to next script works only when you have a single Windows PowerShell tab open, or when you have more than one Windows PowerShell tab open, but the focus is in the Script Pane.|
|**Tab** (to previous script)|CTRL+SHIFT+TAB **Note:** Tab to previous script works when you have only one Windows PowerShell tab open, or if you have more than one Windows PowerShell tab open, and the focus is in the Script Pane.|

## Keyboard shortcuts for customizing the view

You can use the following keyboard shortcuts to customize the view in Windows PowerShell ISE. They are accessible from all the panes in the application.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Go to Command (v2) or Console (v3 and later) Pane**|CTRL+D|
|**Go to Output Pane (v2 only)**|CTRL+SHIFT+O|
|**Go to Script Pane**|CTRL+I|
|**Show Script Pane**|CTRL+R|
|**Hide Script Pane**|CTRL+R|
|**Move Script Pane Up**|CTRL+1|
|**Move Script Pane Right**|CTRL+2|
|**Maximize Script Pane**|CTRL+3|
|**Zoom In**|CTRL+PLUS SIGN|
|**Zoom Out**|CTRL+MINUS SIGN|

## Keyboard shortcuts for debugging scripts

You can use the following keyboard shortcuts when you debug scripts.

|Action|Keyboard Shortcut|Use in|
|----------|---------------------|----------|
|**Run/Continue**|F5|Script Pane, when debugging a script|
|**Step Into**|F11|Script Pane, when debugging a script|
|**Step Over**|F10|Script Pane, when debugging a script|
|**Step Out**|SHIFT+F11|Script Pane, when debugging a script|
|**Display Call Stack**|CTRL+SHIFT+D|Script Pane, when debugging a script|
|**List Breakpoints**|CTRL+SHIFT+L|Script Pane, when debugging a script|
|**Toggle Breakpoint**|F9|Script Pane, when debugging a script|
|**Remove All Breakpoints**|CTRL+SHIFT+F9|Script Pane, when debugging a script|
|**Stop Debugger**|SHIFT+F5|Script Pane, when debugging a script|

> [!NOTE]
> You can also use the keyboard shortcuts designed for the Windows PowerShell console when you debug scripts in Windows PowerShell ISE. To use these shortcuts, you must type the shortcut in the Command Pane and press ENTER.

|Action|Keyboard Shortcut|Use in|
|----------|---------------------|----------|
|**Continue**|C|Console Pane, when debugging a script|
|**Step Into**|S|Console Pane, when debugging a script|
|**Step Over**|V|Console Pane, when debugging a script|
|**Step Out**|O|Console Pane, when debugging a script|
|**Repeat Last Command** (for Step Into or Step Over)|ENTER|Console Pane, when debugging a script|
|**Display Call Stack**|K|Console Pane, when debugging a script|
|**Stop Debugging**|Q|Console Pane, when debugging a script|
|**List the Script**|L|Console Pane, when debugging a script|
|**Display Console Debugging Commands**|H or ?|Console Pane, when debugging a script|

## Keyboard shortcuts for Windows PowerShell tabs

You can use the following keyboard shortcuts when you use Windows PowerShell tabs.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Close PowerShell Tab**|CTRL+W|
|**New PowerShell Tab**|CTRL+T|
|**Previous PowerShell tab**|CTRL+SHIFT+TAB. This shortcut works only when no files are open on any Windows PowerShell tab.|
|**Next Windows PowerShell tab**|CTRL+TAB. This shortcut works only when no files are open on any Windows PowerShell tab.|

## Keyboard shortcuts for starting and exiting

You can use the following keyboard shortcuts to start the Windows PowerShell console (PowerShell.exe) or to exit Windows PowerShell ISE.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Exit**|ALT+F4|
|**Start PowerShell.exe** (Windows PowerShell console)|CTRL+SHIFT+P|

## See Also

- [PowerShell Magazine: The Complete List of Windows PowerShell ISE Keyboard Shortcuts](https://www.powershellmagazine.com/2013/01/29/the-complete-list-of-powershell-ise-3-0-keyboard-shortcuts/)