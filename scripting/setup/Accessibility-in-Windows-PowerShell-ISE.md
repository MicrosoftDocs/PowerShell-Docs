---
title:  Accessibility in Windows PowerShell ISE
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  a078f9d1-dd6b-4323-b16d-0622cd993aa8
---

# Accessibility in Windows PowerShell ISE
This topic describes the accessibility features of Windows PowerShellÂ® Integrated Scripting Environment (ISE) that you might find helpful.

* [How to change the size and location of the Console and Script Panes](#bkmk_1)
* [Keyboard shortcuts for editing text](#bkmk_2)
* [Keyboard shortcuts for running scripts](#bkmk_3)
* [Keyboard shortcuts for customizing the view](#bkmk_4)
* [Keyboard shortcuts for debugging scripts](#bkmk_5)
* [Keyboard shortcuts for Windows PowerShell tabs](#bkmk_6)
* [Keyboard shortcuts for starting and exiting](#bkmk_7)

Microsoft is committed to making its products and services easier for everyone to use. The following topics provide information about the features, products, and services that make Windows PowerShell ISE more accessible for people with disabilities.

Windows PowerShell ISE supports high contrast mode. For the visually impaired, breakpoint information is available through the cmdlets for managing breakpoints, such as [Get-PSBreakpoint](https://technet.microsoft.com/en-us/library/0bf48936-00ab-411c-b5e0-9b10a812a3c6) and [Set-PSBreakpoint](https://technet.microsoft.com/en-us/library/6afd5d2c-a285-4796-8607-3cbf49471420). For more information please see “How to manage breakpoints” in [How to Debug Scripts in the Windows PowerShell ISE](../core-powershell/ise/How-to-Debug-Scripts-in-Windows-PowerShell-ISE.md#bkmk_1). In addition to accessibility features and utilities in Microsoft Windows, the following features make Windows PowerShell ISE more accessible for people with disabilities:

-   Keyboard Shortcuts

-   Syntax Coloring Table and the ability to modify several other color settings using the [$psISE.Options](https://technet.microsoft.com/en-us/library/75e2a76f-f3d1-490b-ad5d-e3829946aabb) scripting object.

-   Text Size Change

## <a name="bkmk_1"></a>How to change the size and location of the Console and Script Panes
You can use the following steps to change the size and location of the Console Pane and the Script Pane. When you open the Windows PowerShell ISE again, the size and location changes you made will be retained.

### To resize the Script Pane and Console Pane

1.  Pause the pointer on the split line between the Script Pane and Console Pane.

2.  When the mouse pointer changes to a two\-headed arrow, drag the border to change the size of the pane.

### To move the Script Pane and Console Pane
Do one of the following:

-   To move the Script Pane above the Command and Output Panes, press **CTRL\+1** or, on the toolbar, click the **Show Script Pane Top** icon, or in the **View** menu, click **Show Script Pane Top**.

-   To move the Script Pane to the right of the Console Pane, press **CTRL\+2** or, on the toolbar, click the **Show Script Pane Right** icon, or in the **View** menu, click **Show Script Pane Right**.

-   To maximize the Script Pane, press **CTRL\+3** or, on the toolbar, click the **Show Script Pane Maximized** icon, or in the **View** menu, click **Show Script Pane Maximized**.

-   To maximize the Console Pane and hide the Script Pane, on the far right edge of the row of tabs, click the **Hide Script Pane** icon, in the **View** menu, click to deselect the **Show Script Pane** menu option.

-   To display the Script Pane when the Console Pane is maximized, on the far right edge of the row of tabs, click the **Show Script Pane** icon, or in the **View** menu, click to select the **Show Script Pane** menu option.

## <a name="bkmk_2"></a>Keyboard shortcuts for editing text
You can use the following keyboard shortcuts when you edit text.

|Action|Keyboard Shortcuts|Use in|
|----------|----------------------|----------|
|**Copy**|CTRL\+C|Script Pane, Command Pane, Output Pane|
|**Cut**|CTRL\+X|Script Pane, Command Pane|
|**Find in Script**|CTRL\+F|Script Pane|
|**Find Next in Script**|F3|Script Pane|
|**Find Previous in Script**|SHIFT\+F3|Script Pane|
|**Paste**|CTRL\+V|Script Pane, Command Pane|
|**Redo**|CTRL\+Y|Script Pane, Command Pane|
|**Replace in Script**|CTRL\+H|Script Pane|
|**Save**|CTRL\+S|Script Pane|
|**Select All**|CTRL\+A|Script Pane, Command Pane, Output Pane|
|**Undo**|CTRL\+Z|Script Pane, Command Pane|

## <a name="bkmk_3"></a>Keyboard shortcuts for running scripts
You can use the following keyboard shortcuts when you run scripts in the Script Pane.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**New**|CTRL\+N|
|**Open**|CTRL\+O|
|**Run**|F5|
|**Run Selection**|F8|
|**Stop Execution**|CTRL\+BREAK. CTRL\+C can be used when the context is unambiguous (when there is no text selected).|
|**Tab** (to next script)|CTRL\+TAB **Note:** Tab to next script works only when you have a single PowerShell tab open, or when you have more than one PowerShell tab open, but the focus is in the Script Pane.|
|**Tab** (to previous script)|CTRL\+SHIFT\+TAB **Note:** Tab to previous script works when you have only one PowerShell tab open, or if you have more  than one PowerShell tab open, and the focus is in the Script Pane.|

## <a name="bkmk_4"></a>Keyboard shortcuts for customizing the view
You can use the following keyboard shortcuts to customize the view in Windows PowerShell ISE. They are accessible from all the panes in the application.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Go to Command Pane**|CTRL\+D|
|**Go to Output Pane**|CTRL\+SHIFT\+O|
|**Go to Script Pane**|CTRL\+I|
|**Show Script Pane**|CTRL\+R|
|**Hide Script Pane**|CTRL\+R|
||
|**Move Script Pane Up**|CTRL\+1|
|**Move Script Pane Right**|CTRL\+2|
|**Maximize Script Pane**|CTRL\+3|
|**Zoom In**|CTRL\+PLUS SIGN|
|**Zoom Out**|CTRL\+MINUS SIGN|

## <a name="bkmk_5"></a>Keyboard shortcuts for debugging scripts
You can use the following keyboard shortcuts when you debug scripts.

|Action|Keyboard Shortcut|Use in|
|----------|---------------------|----------|
|**Run\/Continue**|F5|Script Pane, when debugging a script|
|**Step Into**|F11|Script Pane, when debugging a script|
|**Step Over**|F10|Script Pane, when debugging a script|
|**Step Out**|SHIFT\+F11|Script Pane, when debugging a script|
|**Display Call Stack**|CTRL\+SHIFT\+D|Script Pane, when debugging a script|
|**List Breakpoints**|CTRL\+SHIFT\+L|Script Pane, when debugging a script|
|**Toggle Breakpoint**|F9|Script Pane, when debugging a script|
|**Remove All Breakpoints**|CTRL\+SHIFT\+F9|Script Pane, when debugging a script|
|**Stop Debugger**|SHIFT\+F5|Script Pane, when debugging a script|

> [!NOTE]
> You can also use the keyboard shortcuts designed for the Windows PowerShell console when you debug scripts in Windows PowerShell ISE. To use these shortcuts, you must type the shortcut in the Command Pane and press ENTER.

|Action|Keyboard Shortcut|Use in|
|----------|---------------------|----------|
|**Continue**|C|Command Pane, when debugging a script|
|**Step Into**|S|Command Pane, when debugging a script|
|**Step Over**|V|Command Pane, when debugging a script|
|**Step Out**|O|Command Pane, when debugging a script|
|**Repeat Last Command** (for Step Into or Step Over)|ENTER|Command Pane, when debugging a script|
|**Display Call Stack**|K|Command Pane, when debugging a script|
|**Stop Debugging**|Q|Command Pane, when debugging a script|
|**List the Script**|L|Command Pane, when debugging a script|
|**Display Console Debugging Commands**|H or ?|Command Pane, when debugging a script|

## <a name="bkmk_6"></a>Keyboard shortcuts for Windows PowerShell tabs
You can use the following keyboard shortcuts when you use Windows PowerShell tabs.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Close PowerShell Tab**|CTRL\+W|
|**New PowerShell Tab**|CTRL\+T|
|**Previous PowerShell tab**|CTRL\+SHIFT\+TAB. This shortcut works only when no files are open on any PowerShell tab.|
|**Next Windows PowerShell tab**|CTRL\+TAB. This shortcut works only when no files are open on any PowerShell tab.|

## <a name="bkmk_7"></a>Keyboard shortcuts for starting and exiting
You can use the following keyboard shortcuts to start the Windows PowerShell console (PowerShell.exe) or to exit Windows PowerShell ISE.

|Action|Keyboard Shortcut|
|----------|---------------------|
|**Exit**|ALT\+F4|
|**Start PowerShell.exe** (Windows PowerShell console)|CTRL\+SHIFT\+P|

## See Also
[Using the Windows PowerShell ISE](../core-powershell/ise/Using-the-Windows-PowerShell-ISE.md)

