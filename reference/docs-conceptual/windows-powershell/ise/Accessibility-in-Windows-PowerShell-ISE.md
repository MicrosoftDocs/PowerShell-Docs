---
ms.date: 12/19/2019
title: Accessibility in Windows PowerShell ISE
description: This topic describes the accessibility features of Windows PowerShell Integrated Scripting Environment (ISE) that you might find helpful.
---

# Accessibility in Windows PowerShell ISE

This topic describes the accessibility features of Windows PowerShell Integrated Scripting
Environment (ISE) that you might find helpful.

- [How to change the size and location of the Console and Script Panes](#how-to-change-the-size-and-location-of-the-console-and-script-panes)
- [Keyboard shortcuts for editing text](#keyboard-shortcuts-for-editing-text)
- [Keyboard shortcuts for running scripts](#keyboard-shortcuts-for-running-scripts)
- [Keyboard shortcuts for customizing the view](#keyboard-shortcuts-for-customizing-the-view)
- [Keyboard shortcuts for debugging scripts](#keyboard-shortcuts-for-debugging-scripts)
- [Keyboard shortcuts for Windows PowerShell tabs](#keyboard-shortcuts-for-windows-powershell-tabs)
- [Keyboard shortcuts for starting and exiting](#keyboard-shortcuts-for-starting-and-exiting)
- [Breakpoint management with cmdlets](#breakpoint-management)

Microsoft is committed to making its products and services easier for everyone to use. The following
topics provide information about the features, products, and services that make Windows PowerShell
ISE more accessible for people with disabilities.

In addition to accessibility features and utilities in Microsoft Windows, the following features
make Windows PowerShell ISE more accessible for people with disabilities:

- Keyboard Shortcuts

- Syntax Coloring Table and the ability to modify several other color settings using the
  [$psISE.Options](object-model/The-ISEOptions-Object.md) scripting object.

- Text Size Change

## How to change the size and location of the Console and Script Panes

You can use the following steps to change the size and location of the Console Pane and the Script
Pane. When you open the Windows PowerShell ISE again, the size and location changes you made will be
retained.

### To resize the Script Pane and Console Pane

1. Pause the pointer on the split line between the Script Pane and Console Pane.

2. When the mouse pointer changes to a two-headed arrow, drag the border to change the size of the pane.

### To move the Script Pane and Console Pane

Do one of the following:

- To move the Script Pane above the Console Pane, press <kbd>CTRL</kbd>+<kbd>1</kbd> or, on the
  toolbar, click the **Show Script Pane Top** icon, or in the **View** menu, click **Show Script
  Pane Top**.

- To move the Script Pane to the right of the Console Pane, press <kbd>CTRL</kbd>+<kbd>2</kbd> or,
  on the toolbar, click the **Show Script Pane Right** icon, or in the **View** menu, click **Show
  Script Pane Right**.

- To maximize the Script Pane, press <kbd>CTRL</kbd>+<kbd>3</kbd> or, on the toolbar, click the
  **Show Script Pane Maximized** icon, or in the **View** menu, click **Show Script Pane
  Maximized**.

- To maximize the Console Pane and hide the Script Pane, on the far right edge of the row of tabs,
  click the **Hide Script Pane** icon, in the **View** menu, click to deselect the **Show Script
  Pane** menu option.

- To display the Script Pane when the Console Pane is maximized, on the far right edge of the row of
  tabs, click the **Show Script Pane** icon, or in the **View** menu, click to select the **Show
  Script Pane** menu option.

## Keyboard shortcuts for editing text

You can use the following keyboard shortcuts when you edit text.

|           Action            |       Keyboard Shortcuts       |          Use in           |
| --------------------------- | ------------------------------ | ------------------------- |
| **Copy**                    | <kbd>CTRL</kbd>+<kbd>C</kbd>   | Script Pane, Console Pane |
| **Cut**                     | <kbd>CTRL</kbd>+<kbd>X</kbd>   | Script Pane, Console Pane |
| **Find in Script**          | <kbd>CTRL</kbd>+<kbd>F</kbd>   | Script Pane               |
| **Find Next in Script**     | <kbd>F3</kbd>                  | Script Pane               |
| **Find Previous in Script** | <kbd>SHIFT</kbd>+<kbd>F3</kbd> | Script Pane               |
| **Paste**                   | <kbd>CTRL</kbd>+<kbd>V</kbd>   | Script Pane, Console Pane |
| **Redo**                    | <kbd>CTRL</kbd>+<kbd>Y</kbd>   | Script Pane, Console Pane |
| **Replace in Script**       | <kbd>CTRL</kbd>+<kbd>H</kbd>   | Script Pane               |
| **Save**                    | <kbd>CTRL</kbd>+<kbd>S</kbd>   | Script Pane               |
| **Select All**              | <kbd>CTRL</kbd>+<kbd>A</kbd>   | Script Pane, Console Pane |
| **Undo**                    | <kbd>CTRL</kbd>+<kbd>Z</kbd>   | Script Pane, Console Pane |

## Keyboard shortcuts for running scripts

You can use the following keyboard shortcuts when you run scripts in the Script Pane.

|            Action            |                                                                                                     Keyboard Shortcut                                                                                                      |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **New**                      | <kbd>CTRL</kbd>+<kbd>N</kbd>                                                                                                                                                                                               |
| **Open**                     | <kbd>CTRL</kbd>+<kbd>O</kbd>                                                                                                                                                                                               |
| **Run**                      | <kbd>F5</kbd>                                                                                                                                                                                                              |
| **Run Selection**            | <kbd>F8</kbd>                                                                                                                                                                                                              |
| **Stop Execution**           | <kbd>CTRL</kbd>+<kbd>BREAK</kbd>. <kbd>CTRL</kbd>+<kbd>C</kbd> can be used when the context is unambiguous (when there is no text selected).                                                                               |
| **Tab** (to next script)     | <kbd>CTRL</kbd>+<kbd>TAB</kbd> **Note:** Tab to next script works only when you have a single PowerShell tab open, or when you have more than one PowerShell tab open, but the focus is in the Script Pane.                |
| **Tab** (to previous script) | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>TAB</kbd> **Note:** Tab to previous script works when you have only one PowerShell tab open, or if you have more  than one PowerShell tab open, and the focus is in the Script Pane. |

## Keyboard shortcuts for customizing the view

You can use the following keyboard shortcuts to customize the view in Windows PowerShell ISE. They
are accessible from all the panes in the application.

|           Action           |         Keyboard Shortcut        |
| -------------------------- | -------------------------------- |
| **Go to Console Pane**     | <kbd>CTRL</kbd>+<kbd>D</kbd>     |
| **Go to Script Pane**      | <kbd>CTRL</kbd>+<kbd>I</kbd>     |
| **Show Script Pane**       | <kbd>CTRL</kbd>+<kbd>R</kbd>     |
| **Hide Script Pane**       | <kbd>CTRL</kbd>+<kbd>R</kbd>     |
| **Move Script Pane Up**    | <kbd>CTRL</kbd>+<kbd>1</kbd>     |
| **Move Script Pane Right** | <kbd>CTRL</kbd>+<kbd>2</kbd>     |
| **Maximize Script Pane**   | <kbd>CTRL</kbd>+<kbd>3</kbd>     |
| **Zoom In**                | <kbd>CTRL</kbd>+<kbd>PLUS</kbd>  |
| **Zoom Out**               | <kbd>CTRL</kbd>+<kbd>MINUS</kbd> |

## Keyboard shortcuts for debugging scripts

You can use the following keyboard shortcuts when you debug scripts.

|           Action           |               Keyboard Shortcut                |                Use in                |
| -------------------------- | ---------------------------------------------- | ------------------------------------ |
| **Run/Continue**           | <kbd>F5</kbd>                                  | Script Pane, when debugging a script |
| **Step Into**              | <kbd>F11</kbd>                                 | Script Pane, when debugging a script |
| **Step Over**              | <kbd>F10</kbd>                                 | Script Pane, when debugging a script |
| **Step Out**               | <kbd>SHIFT</kbd>+<kbd>F11</kbd>                | Script Pane, when debugging a script |
| **Display Call Stack**     | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>D</kbd>  | Script Pane, when debugging a script |
| **List Breakpoints**       | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>L</kbd>  | Script Pane, when debugging a script |
| **Toggle Breakpoint**      | <kbd>F9</kbd>                                  | Script Pane, when debugging a script |
| **Remove All Breakpoints** | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>F9</kbd> | Script Pane, when debugging a script |
| **Stop Debugger**          | <kbd>SHIFT</kbd>+<kbd>F5</kbd>                 | Script Pane, when debugging a script |

> [!NOTE]
> You can also use the keyboard shortcuts designed for the Windows PowerShell console when you debug
> scripts in Windows PowerShell ISE. To use these shortcuts, you must type the shortcut in the
> Console Pane and press <kbd>ENTER</kbd>.

|                 Action                  |      Keyboard Shortcut       |                Use in                 |
| --------------------------------------- | ---------------------------- | ------------------------------------- |
| **Continue**                            | <kbd>C</kbd>                 | Console Pane, when debugging a script |
| **Step Into**                           | <kbd>S</kbd>                 | Console Pane, when debugging a script |
| **Step Over**                           | <kbd>V</kbd>                 | Console Pane, when debugging a script |
| **Step Out**                            | <kbd>O</kbd>                 | Console Pane, when debugging a script |
| **Repeat Last Command**(Step Into/Over) | <kbd>ENTER</kbd>             | Console Pane, when debugging a script |
| **Display Call Stack**                  | <kbd>K</kbd>                 | Console Pane, when debugging a script |
| **Stop Debugging**                      | <kbd>Q</kbd>                 | Console Pane, when debugging a script |
| **List the Script**                     | <kbd>L</kbd>                 | Console Pane, when debugging a script |
| **Display Console Debugging Commands**  | <kbd>H</kbd> or <kbd>?</kbd> | Console Pane, when debugging a script |

## Keyboard shortcuts for Windows PowerShell tabs

You can use the following keyboard shortcuts when you use Windows PowerShell tabs.

|             Action              |                                 Keyboard Shortcut                                  |
| ------------------------------- | ---------------------------------------------------------------------------------- |
| **Close PowerShell Tab**        | <kbd>CTRL</kbd>+<kbd>W</kbd>                                                       |
| **New PowerShell Tab**          | <kbd>CTRL</kbd>+<kbd>T</kbd>                                                       |
| **Previous PowerShell tab**     | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>TAB</kbd> (Only when no files are open on any PowerShell tab) |
| **Next Windows PowerShell tab** | <kbd>CTRL</kbd>+<kbd>TAB</kbd> (Only when no files are open on any PowerShell tab) |

## Keyboard shortcuts for starting and exiting

You can use the following keyboard shortcuts to start the Windows PowerShell console
(**PowerShell.exe**) or to exit Windows PowerShell ISE.

|                        Action                         |               Keyboard Shortcut               |
| ----------------------------------------------------- | --------------------------------------------- |
| **Exit**                                              | <kbd>ALT</kbd>+<kbd>F4</kbd>                  |
| **Start PowerShell.exe** (Windows PowerShell console) | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>P</kbd> |

## Breakpoint Management

For the visually impaired, breakpoint information is available through the cmdlets for managing
breakpoints, such as
[Get-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Get-PSBreakpoint) and
[Set-PSBreakpoint](/powershell/module/Microsoft.PowerShell.Utility/Set-PSBreakpoint). For more
information please see 'How to manage breakpoints' in
[How to Debug Scripts in the Windows PowerShell ISE](How-to-Debug-Scripts-in-Windows-PowerShell-ISE.md).

## See Also

[Introducing the Windows PowerShell ISE](Introducing-the-Windows-PowerShell-ISE.md)
