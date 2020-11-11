---
description:  Describes how to edit commands at the PowerShell command prompt. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 07/10/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_line_editing?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Line_Editing
---

# About Line Editing

## Short description

Describes how to edit commands at the PowerShell command prompt.

## Long description

The PowerShell console has some useful keyboard shortcuts to help you edit
commands at the PowerShell command prompt.

### Add a line

To add a line, press <kbd>Shift</kbd>+<kbd>Enter</kbd>.

You can add multiple lines. Each additional line begins with `>>`, the
continuation prompt. Press <kbd>Enter</kbd> to execute the command.

### Move left and right

To move the cursor one character to the left, press the <kbd>Left arrow</kbd>.

To move the cursor one word to the left, press <kbd>Ctrl</kbd>+<kbd>Left
arrow</kbd>.

To move the cursor one character to the right, press the <kbd>Right
arrow</kbd>.

To move the cursor one word to the right, press <kbd>Ctrl</kbd>+<kbd>Right
arrow</kbd>.

### Move to a line's beginning or end

To move to the beginning of a line, press <kbd>Home</kbd>.

To move to the end of a line, press <kbd>End</kbd>.

If lines were added, press <kbd>Home</kbd> or <kbd>End</kbd> twice to move to
the beginning or end of the lines.

### Delete characters

To delete the character behind the cursor's position, press
<kbd>Backspace</kbd>.

To delete the character at the cursor's position, press <kbd>Delete</kbd>.

### Delete characters from a line

To delete all the characters from the cursor's position to the end of a line,
press <kbd>Ctrl</kbd>+<kbd>End</kbd>.

To delete all the characters from the cursor's position to the beginning of a
line, press <kbd>Ctrl</kbd>+<kbd>Home</kbd>.

If lines were added, characters are deleted from the current line and the lines
that were added.

### Insert and overstrike mode

To change to overwrite mode, press <kbd>Insert</kbd>. To return to insert mode,
press <kbd>Insert</kbd> again.

### Tab completion

To complete a cmdlet name, a parameter, or a path, press the <kbd>Tab</kbd>
key. To scroll through a list of values, press the <kbd>Tab</kbd> key again.

## See also

[about_Command_Syntax](about_Command_Syntax.md)

[about_Path_Syntax](about_Path_Syntax.md)

[about_PSReadline](../../PSReadline/About/about_PSReadline.md)
