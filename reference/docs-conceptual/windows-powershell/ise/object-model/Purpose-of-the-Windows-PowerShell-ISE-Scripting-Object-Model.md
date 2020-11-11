---
ms.date:  12/31/2019
title:  Purpose of the Windows PowerShell ISE Scripting Object Model
description: Purpose of the Windows PowerShell ISE Scripting Object Model
---

# Purpose of the Windows PowerShell ISE Scripting Object Model

Objects are associated with the form and function of Windows PowerShell Integrated Scripting
Environment (ISE). The object model reference provides details about the member properties and
methods that these objects expose. Examples are provided to show how you can use scripts to
directly access these methods and properties. The scripting object model makes the following range
of tasks easier.

## Customizing the appearance of Windows PowerShell ISE

You can use the object model to modify the application settings and options. For example, you can
modify them as follows:

- Change the color of errors, warnings, verbose outputs, and debug outputs.
- Get or set the background colors for the Command pane, the Output pane, and the Script pane.
- Set the foreground color for the Output pane.
- Set the font name and font size for Windows PowerShell ISE.
- Configure warnings. This setting includes warnings that are issued when a file is opened
  in multiple PowerShell tabs or when a script in the file is run before the file has been saved.
- Switch between a view where the Script pane and the Output pane are side-by-side and a
  view where the Script pane is on top of the Output pane.
- Dock the Command pane to the bottom or the top of the Output pane.

## Enhancing the functionality of Windows PowerShell ISE

You can use the object model to enhance the functionality of Windows PowerShell ISE. For example,
you can:

- Add and modify the instance of Windows PowerShell ISE itself. For example, to change the menus,
  you can add new menu items and map the new menu items to scripts.
- Create scripts that perform some of the tasks that you can perform by using the menu commands and
  buttons in Windows PowerShell ISE. For example, you can add, remove, or select a PowerShell tab.
- Complement tasks that can be performed by using menu commands and buttons. For example, you can
  rename a PowerShell tab.
- Manipulate text buffers for the Command pane, the Output pane, and the Script pane that are
  associated with a file. For example, you can:
  - Get or set all text.
  - Get or set a text selection.
  - Run a script or run a selected portion of a script.
  - Scroll a line into view.
  - Insert text at a caret position.
  - Select a block of text.
  - Get the last line number.
- Perform file operations. For example, you can:
  - Open a file, save a file, or save a file by using a different name.
  - Determine whether a file has been changed after it was last saved.
  - Get the file name.
  - Select a file.

## Automating tasks

You can use the scripting object model to create keyboard shortcuts for frequent operations.

## See also

- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
