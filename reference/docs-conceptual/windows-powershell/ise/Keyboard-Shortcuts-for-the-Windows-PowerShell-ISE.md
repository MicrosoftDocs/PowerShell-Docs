---
ms.date:  01/02/2020
title:  Keyboard Shortcuts for the Windows PowerShell ISE
description: This article is a list of the keyboard shortcuts used in the PowerShell ISE.
---

# Keyboard Shortcuts for the Windows PowerShell ISE

Use the following keyboard shortcuts to perform actions in Windows PowerShell&reg; Integrated Scripting
Environment (ISE). Windows PowerShell ISE is available as part of the Windows Server and Windows
client operating systems, but can also be installed on some older Windows operating systems as part
of the
[Windows Management Framework 4.0 download package](https://go.microsoft.com/fwlink/?LinkID=293881).

## Keyboard shortcuts for editing text

You can use the following keyboard shortcuts when you edit text.

|              Action              |       Keyboard Shortcuts       |                                                                                                                                                 Use in                                                                                                                                                 |
| -------------------------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Help**                         | <kbd>F1</kbd>                  | Script Pane **Important:** You can specify that <kbd>F1</kbd> help comes from docs.microsoft.com or downloaded Help (see `Update-Help`). To select, click **Tools**, **Options**, then on the **General Settings** tab, set or clear **Use local help content instead of online content.** |
| **Copy**                         | <kbd>CTRL</kbd>+<kbd>C</kbd>   | Script Pane, Command Pane, Output Pane                                                                                                                                                                                                                                                                 |
| **Cut**                          | <kbd>CTRL</kbd>+<kbd>X</kbd>   | Script Pane, Command Pane                                                                                                                                                                                                                                                                              |
| **Expand or Collapse Outlining** | <kbd>CTRL</kbd>+<kbd>M</kbd>   | Script Pane                                                                                                                                                                                                                                                                                            |
| **Find in Script**               | <kbd>CTRL</kbd>+<kbd>F</kbd>   | Script Pane                                                                                                                                                                                                                                                                                            |
| **Find Next in Script**          | <kbd>F3</kbd>                  | Script Pane                                                                                                                                                                                                                                                                                            |
| **Find Previous in Script**      | <kbd>SHIFT</kbd>+<kbd>F3</kbd> | Script Pane                                                                                                                                                                                                                                                                                            |
| **Find Matching Brace**          | <kbd>CTRL</kbd>+<kbd>]</kbd>   | Script Pane                                                                                                                                                                                                                                                                                            |
| **Paste**                        | <kbd>CTRL</kbd>+<kbd>V</kbd>   | Script Pane, Command Pane                                                                                                                                                                                                                                                                              |
| **Redo**                         | <kbd>CTRL</kbd>+<kbd>Y</kbd>   | Script Pane, Command Pane                                                                                                                                                                                                                                                                              |
| **Replace in Script**            | <kbd>CTRL</kbd>+<kbd>H</kbd>   | Script Pane                                                                                                                                                                                                                                                                                            |
| **Save**                         | <kbd>CTRL</kbd>+<kbd>S</kbd>   | Script Pane                                                                                                                                                                                                                                                                                            |
| **Select All**                   | <kbd>CTRL</kbd>+<kbd>A</kbd>   | Script Pane, Command Pane, Output Pane                                                                                                                                                                                                                                                                 |
| **Show Snippets**                | <kbd>CTRL</kbd>+<kbd>J</kbd>   | Script Pane, Command Pane                                                                                                                                                                                                                                                                              |
| **Undo**                         | <kbd>CTRL</kbd>+<kbd>Z</kbd>   | Script Pane, Command Pane                                                                                                                                                                                                                                                                              |

## Keyboard shortcuts for running scripts

You can use the following keyboard shortcuts when you run scripts in the Script Pane.

|            Action            |                                                                                                             Keyboard Shortcut                                                                                                             |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **New**                      | <kbd>CTRL</kbd>+<kbd>N</kbd>                                                                                                                                                                                                              |
| **Open**                     | <kbd>CTRL</kbd>+<kbd>O</kbd>                                                                                                                                                                                                              |
| **Run**                      | <kbd>F5</kbd>                                                                                                                                                                                                                             |
| **Run Selection**            | <kbd>F8</kbd>                                                                                                                                                                                                                             |
| **Stop Execution**           | <kbd>CTRL</kbd>+<kbd>BREAK</kbd>. <kbd>CTRL</kbd>+<kbd>C</kbd> can be used when the context is unambiguous (when there is no text selected).                                                                                              |
| **Tab** (to next script)     | <kbd>CTRL</kbd>+<kbd>TAB</kbd> **Note:** Tab to next script works only when you have a single Windows PowerShell tab open, or when you have more than one Windows PowerShell tab open, but the focus is in the Script Pane.               |
| **Tab** (to previous script) | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>TAB</kbd> **Note:** Tab to previous script works when you have only one Windows PowerShell tab open, or if you have more than one Windows PowerShell tab open, and the focus is in the Script Pane. |

## Keyboard shortcuts for customizing the view

You can use the following keyboard shortcuts to customize the view in Windows PowerShell ISE. They
are accessible from all the panes in the application.

|                        Action                         |               Keyboard Shortcut               |
| ----------------------------------------------------- | --------------------------------------------- |
| **Go to Command (v2) or Console (v3 and later) Pane** | <kbd>CTRL</kbd>+<kbd>D</kbd>                  |
| **Go to Output Pane (v2 only)**                       | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>O</kbd> |
| **Go to Script Pane**                                 | <kbd>CTRL</kbd>+<kbd>I</kbd>                  |
| **Show Script Pane**                                  | <kbd>CTRL</kbd>+<kbd>R</kbd>                  |
| **Hide Script Pane**                                  | <kbd>CTRL</kbd>+<kbd>R</kbd>                  |
| **Move Script Pane Up**                               | <kbd>CTRL</kbd>+<kbd>1</kbd>                  |
| **Move Script Pane Right**                            | <kbd>CTRL</kbd>+<kbd>2</kbd>                  |
| **Maximize Script Pane**                              | <kbd>CTRL</kbd>+<kbd>3</kbd>                  |
| **Zoom In**                                           | <kbd>CTRL</kbd>+<kbd>+</kbd>                  |
| **Zoom Out**                                          | <kbd>CTRL</kbd>+<kbd>-</kbd>                  |

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
> Command Pane and press <kbd>ENTER</kbd>.

|                        Action                        | Keyboard Shortcut |                Use in                 |
| ---------------------------------------------------- | ----------------- | ------------------------------------- |
| **Continue**                                         | `C`               | Console Pane, when debugging a script |
| **Step Into**                                        | `S`               | Console Pane, when debugging a script |
| **Step Over**                                        | `V`               | Console Pane, when debugging a script |
| **Step Out**                                         | `O`               | Console Pane, when debugging a script |
| **Repeat Last Command** (for Step Into or Step Over) | <kbd>ENTER</kbd>  | Console Pane, when debugging a script |
| **Display Call Stack**                               | `K`               | Console Pane, when debugging a script |
| **Stop Debugging**                                   | `Q`               | Console Pane, when debugging a script |
| **List the Script**                                  | `L`               | Console Pane, when debugging a script |
| **Display Console Debugging Commands**               | `H` or `?`        | Console Pane, when debugging a script |

## Keyboard shortcuts for Windows PowerShell tabs

You can use the following keyboard shortcuts when you use Windows PowerShell tabs.

|             Action              |                                                        Keyboard Shortcut                                                        |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **Close PowerShell Tab**        | <kbd>CTRL</kbd>+<kbd>W</kbd>                                                                                                    |
| **New PowerShell Tab**          | <kbd>CTRL</kbd>+<kbd>T</kbd>                                                                                                    |
| **Previous PowerShell tab**     | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>TAB</kbd>. This shortcut works only when no files are open on any Windows PowerShell tab. |
| **Next Windows PowerShell tab** | <kbd>CTRL</kbd>+<kbd>TAB</kbd>. This shortcut works only when no files are open on any Windows PowerShell tab.                  |

## Keyboard shortcuts for starting and exiting

You can use the following keyboard shortcuts to start the Windows PowerShell console
(PowerShell.exe) or to exit Windows PowerShell ISE.

|                        Action                        |               Keyboard Shortcut               |
| ---------------------------------------------------- | --------------------------------------------- |
| **Exit**                                             | <kbd>ALT</kbd>+<kbd>F4</kbd>                  |
| **Start PowerShell.exe**(Windows PowerShell console) | <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>P</kbd> |

## See Also

- [PowerShell Magazine: The Complete List of Windows PowerShell ISE Keyboard Shortcuts](https://www.powershellmagazine.com/2013/01/29/the-complete-list-of-powershell-ise-3-0-keyboard-shortcuts/)
