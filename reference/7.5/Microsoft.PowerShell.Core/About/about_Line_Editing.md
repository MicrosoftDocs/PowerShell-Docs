---
description: Describes how to edit commands at the PowerShell command prompt.
Locale: en-US
ms.date: 02/24/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_line_editing?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Line_Editing
---

# about_Line_Editing

## Short description

Describes how to edit commands at the PowerShell command prompt.

## Long description

The PSReadLine module provides useful keyboard shortcuts to help you edit
commands at the PowerShell command prompt. The key bindings discussed in this
article are the default key bindings on Windows platforms. You can create
custom key bindings by using the `Set-PSReadLineKeyHandler` command.

On non-Windows platforms, PSReadLine defaults to the `Emacs` edit mode. You can
change the edit mode using the `Set-PSReadLineOption` command. PSReadLine has
three edit modes: `Emacs`, `Vi`, and `Windows`.

To see the current edit mode, use the `Get-PSReadLineOption` command. To see a
list of the current key bindings, use the `Get-PSReadLineKeyHandler` command.

### Add a line

To add a line, press <kbd>Shift</kbd>+<kbd>Enter</kbd>.

You can add multiple lines. Each additional line begins with `>>`, the
continuation prompt. Press <kbd>Enter</kbd> to execute the command.

### Move left and right

To move the cursor one character to the left, press the <kbd>LeftArrow</kbd>.

To move the cursor one word to the left, press
<kbd>Ctrl</kbd>+<kbd>LeftArrow</kbd>.

To move the cursor one character to the right, press the <kbd>RightArrow</kbd>.

To move the cursor one word to the right, press
<kbd>Ctrl</kbd>+<kbd>RightArrow</kbd>.

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

- [about_PSReadLine](../../PSReadLine/About/about_PSReadline.md)
- [about_Tab_Expansion](about_Tab_Expansion.md)
- [Get-PSReadLineOption](xref:PSReadline.Get-PSReadLineOption)
- [Get-PSReadLineKeyHandler](xref:PSReadline.Get-PSReadLineKeyHandler)
- [Set-PSReadLineOption](xref:PSReadline.Set-PSReadLineOption)
- [Set-PSReadLineKeyHandler](xref:PSReadline.Set-PSReadLineKeyHandler)
- [Using PSReadLine key handlers](/powershell/scripting/learn/shell/using-keyhandlers)
