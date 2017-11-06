---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Accessibility in Windows PowerShell ISE
ms.assetid:  a078f9d1-dd6b-4323-b16d-0622cd993aa8
---

# Accessibility in Windows PowerShell ISE
This topic describes the accessibility features of Windows PowerShell Integrated Scripting Environment (ISE) that you might find helpful.

* [How to change the size and location of the Console and Script Panes](#how-to-change-the-size-and-location-of-the-console-and-script-panes)
* [Keyboard shortcuts for editing text](#keyboard-shortcuts-for-editing-text)
* [Keyboard shortcuts for running scripts](#keyboard-shortcuts-for-running-scripts)
* [Keyboard shortcuts for customizing the view](#keyboard-shortcuts-for-customizing-the-view)
* [Keyboard shortcuts for debugging scripts](#keyboard-shortcuts-for-debugging-scripts)
* [Keyboard shortcuts for Windows PowerShell tabs](#keyboard-shortcuts-for-windows-powershell-tabs)
* [Keyboard shortcuts for starting and exiting](#keyboard-shortcuts-for-starting-and-exiting)

Microsoft is committed to making its products and services easier for everyone to use. The following topics provide information about the features, products, and services that make Windows PowerShell ISE more accessible for people with disabilities.

Windows PowerShell ISE supports high contrast mode. For the visually impaired, breakpoint information is available through the cmdlets for managing breakpoints, such as [Get-PSBreakpoint](https://technet.microsoft.com/en-us/library/0bf48936-00ab-411c-b5e0-9b10a812a3c6) and [Set-PSBreakpoint](https://technet.microsoft.com/en-us/library/6afd5d2c-a285-4796-8607-3cbf49471420). For more information please see 'How to manage breakpoints' in [How to Debug Scripts in the Windows PowerShell ISE](../core-powershell/ise/How-to-Debug-Scripts-in-Windows-PowerShell-ISE.md). In addition to accessibility features and utilities in Microsoft Windows, the following features make Windows PowerShell ISE more accessible for people with disabilities:

- Keyboard Shortcuts

- Syntax Coloring Table and the ability to modify several other color settings using the [$psISE.Options](https://technet.microsoft.com/en-us/library/75e2a76f-f3d1-490b-ad5d-e3829946aabb) scripting object.

- Text Size Change

## How to change the size and location of the Console and Script Panes
You can use the following steps to change the size and location of the Console Pane and the Script Pane. When you open the Windows PowerShell ISE again, the size and location changes you made will be retained.

### To resize the Script Pane and Console Pane

1. Pause the pointer on the split line between the Script Pane and Console Pane.

2. When the mouse pointer changes to a two-headed arrow, drag the border to change the size of the pane.

### To move the Script Pane and Console Pane
Do one of the following:

- To move the Script Pane above the Console Pane, press **CTRL+1** or, on the toolbar, click the **Show Script Pane Top** icon, or in the **View** menu, click **Show Script Pane Top**.

- To move the Script Pane to the right of the Console Pane, press **CTRL+2** or, on the toolbar, click the **Show Script Pane Right** icon, or in the **View** menu, click **Show Script Pane Right**.

- To maximize the Script Pane, press **CTRL+3** or, on the toolbar, click the **Show Script Pane Maximized** icon, or in the **View** menu, click **Show Script Pane Maximized**.

- To maximize the Console Pane and hide the Script Pane, on the far right edge of the row of tabs, click the **Hide Script Pane** icon, in the **View** menu, click to deselect the **Show Script Pane** menu option.

- To display the Script Pane when the Console Pane is maximized, on the far right edge of the row of tabs, click the **Show Script Pane** icon, or in the **View** menu, click to select the **Show Script Pane** menu option.

## Keyboard shortcuts for editing text
You can use the following keyboard shortcuts when you edit text.

|Action|Keyboard Shortcuts|Use in|
|----------|----------------------|----------|
|**Copy**|CTRL+C|Script Pane, Console Pane|
|**Cut**|CTRL+X|Script Pane, Console Pane|
|**Find in Script**|CTRL+F|Script Pane|
|**Find Next in Script**|F3|Script Pane|
|**Find Previous in Script**|SHIFT+F3|Script Pane|
|**Paste**|CTRL+V|Script Pane, Console Pane|
|**Redo**|CTRL+Y|Script Pane, Console Pane|
|**Replace in Script**|CTRL+H|Script Pane|
|**Save**|CTRL+S|Script Pane|
|**Select All**|CTRL+A|Script Pane, Console Pane|
|**Undo**|CTRL+Z|Script Pane, Console Pane|

## Keyboard shortcuts for running scripts
You can use the following keyboard shortcuts when you run scripts in the Script Pane.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**New**|CTRL+N|
|**Open**|CTRL+O|
|**Run**|F5|
|**Run Selection**|F8|
|**Stop Execution**|CTRL+BREAK. CTRL+C can be used when the context is unambiguous (when there is no text selected).|
|**Tab** (to next script)|CTRL+TAB **Note:** Tab to next script works only when you have a single PowerShell tab open, or when you have more than one PowerShell tab open, but the focus is in the Script Pane.|
|**Tab** (to previous script)|CTRL+SHIFT+TAB **Note:** Tab to previous script works when you have only one PowerShell tab open, or if you have more  than one PowerShell tab open, and the focus is in the Script Pane.|

## Keyboard shortcuts for customizing the view
You can use the following keyboard shortcuts to customize the view in Windows PowerShell ISE. They are accessible from all the panes in the application.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Go to Console Pane**|CTRL+D|
|**Go to Script Pane**|CTRL+I|
|**Show Script Pane**|CTRL+R|
|**Hide Script Pane**|CTRL+R|
||
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

> ![NOTE](../core-powershell/web-access/images/Note.jpeg)**Note**
>
> You can also use the keyboard shortcuts designed for the Windows PowerShell console when you debug scripts in Windows PowerShell ISE. To use these shortcuts, you must type the shortcut in the Console Pane and press ENTER.

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
|**Previous PowerShell tab**|CTRL+SHIFT+TAB. This shortcut works only when no files are open on any PowerShell tab.|
|**Next Windows PowerShell tab**|CTRL+TAB. This shortcut works only when no files are open on any PowerShell tab.|

## Keyboard shortcuts for starting and exiting
You can use the following keyboard shortcuts to start the Windows PowerShell console (PowerShell.exe) or to exit Windows PowerShell ISE.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Exit**|ALT+F4|
|**Start PowerShell.exe** (Windows PowerShell console)|CTRL+SHIFT+P|

## See Also
- [Using the Windows PowerShell ISE](../core-powershell/ise/Using-the-Windows-PowerShell-ISE.md)

