---
description: This article explains how to use the dynamic help feature of PSReadLine.
title: Using dynamic help
ms.date: 03/24/2023
---
# Using dynamic help

Dynamic Help provides just-in-time help that allows you to stay focused on your work without losing
your place typing on the command line.

## Getting cmdlet help

Dynamic Help provides a view of full cmdlet help shown in an alternative screen buffer.
**PSReadLine** maps the function `ShowCommandHelp` to the <kbd>F1</kbd>key.

- When the cursor is at the end of a fully expanded cmdlet name, pressing <kbd>F1</kbd>displays the
  help for that cmdlet.
- When the cursor is at the end of a fully expanded parameter name, pressing <kbd>F1</kbd>displays
  the help for the cmdlet beginning at the parameter.

![Full screen Dynamic help][01]

The pager in **PSReadLine** allows you to scroll the displayed help using the up and down arrow
keys. Pressing <kbd>Q</kbd> exits the alternative screen buffer and returns to the current cursor
position on the command line on the primary screen.

## Getting focused parameter help

Pressing <kbd>Alt</kbd>+<kbd>h</kbd> provides dynamic help for parameters. The help is shown below
the current command line similar to [MenuComplete][05]. The cursor must be at the end of
the fully expanded parameter name when you press the <kbd>Alt</kbd>+<kbd>h</kbd> key.

![Focused help for a parameter using Alt-h][02]

## Selecting arguments on the command line

To quickly select and edit the arguments of a cmdlet without disturbing your syntax using
<kbd>Alt</kbd>+<kbd>a</kbd>. Based on the cursor position, it searches from the current cursor
position and stops when it finds any arguments on the command line.

![Argument selection using Alt-A][03]

## Choosing keybindings

Not all keybindings work for all operating systems and terminal applications. For example,
keybindings for the <kbd>Alt</kbd> key don't work on macOS by default. On Linux,
<kbd>Ctrl</kbd>+<kbd>[</kbd> is the same as <kbd>Escape</kbd>. And
<kbd>Ctrl</kbd>+<kbd>Spacebar</kbd> generates a <kbd>Control</kbd>+<kbd>2</kbd> key sequence instead
of the <kbd>Control</kbd>+<kbd>Spacebar</kbd> sequence expected.

To work around these quirks, map the PSReadLine function to an available key combination. For
example:

```powershell
Set-PSReadLineKeyHandler -chord 'Ctrl+l' -Function ShowParameterHelp
Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -Function SelectCommandArgument
```

For more information about keybindings and workarounds, see [Using PSReadLine key handlers][04].

<!-- link references -->
[01]: ./media/dynamic-help/dynamic-help.gif
[02]: ./media/dynamic-help/dynamic-help-alt-h.png
[03]: ./media/dynamic-help/dynamic-help-alt-a.gif
[04]: using-keyhandlers.md
[05]: tab-completion.md#command-and-parameter-name-completion
