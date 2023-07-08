---
description: How to replicate the ISE experience in Visual Studio Code
ms.date: 11/16/2022
title: How to replicate the ISE experience in Visual Studio Code
---

# How to replicate the ISE experience in Visual Studio Code

While the PowerShell extension for VS Code doesn't seek complete feature parity with the PowerShell
ISE, there are features in place to make the VS Code experience more natural for users of the ISE.

This document tries to list settings you can configure in VS Code to make the user experience a bit
more familiar compared to the ISE.

## ISE Mode

> [!NOTE]
> This feature is available in the PowerShell Preview extension since version 2019.12.0 and in the
> PowerShell extension since version 2020.3.0.

The easiest way to replicate the ISE experience in Visual Studio Code is by turning on "ISE Mode".
To do this, open the command palette (<kbd>F1</kbd> OR <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>
OR <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on macOS) and type in "ISE Mode". Select
"PowerShell: Enable ISE Mode" from the list.

This command automatically applies the settings described below The result looks like this:

![Visual Studio Code in ISE Mode][09]

## ISE Mode configuration settings

ISE Mode makes the following changes to VS Code settings.

- Key bindings

  |               Function                |         ISE Binding          |              VS Code Binding                |
  | ------------------------------------- | ---------------------------- | ------------------------------------------- |
  | Interrupt and break debugger          | <kbd>Ctrl</kbd>+<kbd>B</kbd> | <kbd>F6</kbd>                               |
  | Execute current line/highlighted text | <kbd>F8</kbd>                | <kbd>F8</kbd>                               |
  | List available snippets               | <kbd>Ctrl</kbd>+<kbd>J</kbd> | <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>J</kbd> |

  > [!NOTE]
  > You can [configure your own key bindings][09] in VS Code as well.

- Simplified ISE-like UI

  If you're looking to simplify the Visual Studio Code UI to look more closely to the UI of the ISE,
  apply these two settings:

  ```json
  "workbench.activityBar.visible": false,
  "debug.openDebug": "neverOpen",
  ```

  These settings hide the "Activity Bar" and the "Debug Side Bar" sections shown inside the red box
  below:

  ![Highlighted section includes Activity Bar and Debug Side Bar][07]

  The end result looks like this:

  ![Simplified view of VS Code][08]

- Tab completion

  To enable more ISE-like tab completion, add this setting:

  ```json
  "editor.tabCompletion": "on",
  ```

- No focus on console when executing

  To keep the focus in the editor when you execute with <kbd>F8</kbd>:

  ```json
  "powershell.integratedConsole.focusConsoleOnExecute": false
  ```

  The default is `true` for accessibility purposes.

- Don't start integrated console on startup

  To stop the integrated console on startup, set:

  ```json
  "powershell.integratedConsole.showOnStartup": false
  ```

  > [!NOTE]
  > The background PowerShell process still starts to provide IntelliSense, script analysis, symbol
  > navigation, etc., but the console won't be shown.

- Assume files are PowerShell by default

  To make new/untitled files, register as PowerShell by default:

  ```json
  "files.defaultLanguage": "powershell",
  ```

- Color scheme

  There are a number of ISE themes available for VS Code to make the editor look much more like the
  ISE.

  In the [Command Palette][01] type `theme` to get `Preferences: Color Theme` and press
  <kbd>Enter</kbd>. In the drop-down list, select `PowerShell ISE`.

  You can set this theme in the settings with:

  ```json
  "workbench.colorTheme": "PowerShell ISE",
  ```

- PowerShell Command Explorer

  Thanks to the work of [@corbob][04], the PowerShell extension has the beginnings of its own
  command explorer.

  In the [Command Palette][01], enter `PowerShell Command Explorer` and press <kbd>Enter</kbd>.

- Open in the ISE

  If you want to open a file in the Windows PowerShell ISE anyway, open the [Command Palette][01],
  search for "open in ise", then select **PowerShell: Open Current File in PowerShell ISE**.

## Other resources

- 4sysops has [a great article][02] on configuring VS Code to be more like the ISE.
- Mike F Robbins has [a great post][06] on setting up VS Code.

## VS Code Tips

- Command Palette

  The Command Palette is handy way of executing commands in VS Code. Open the command palette using
  <kbd>F1</kbd> OR <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> OR
  <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on macOS.

  For more information, see [the VS Code documentation][03].

- Hide the Debug Console panel

  The PowerShell extension uses the built-in debugging interface of VS Code to allow for debugging
  of PowerShell scripts and modules. However, the extension does not use the Debug Console panel. To
  hide the Debug Console, right-click on **Debug Console** and select **Hide 'Debug Console'**.

  ![Screenshot show how to hide the Debug Console panel.][10]

  For more information about debugging PowerShell with Visual Studio Code, see [Using VS Code][11].

## More settings

If you know of more ways to make VS Code feel more familiar for ISE users, contribute to this doc.
If there's a compatibility configuration you're looking for, but you can't find any way to enable
it, [open an issue][05] and ask away!

We're always happy to accept PRs and contributions as well!

<!-- link references -->
[01]: #vs-code-tips
[02]: https://4sysops.com/archives/make-visual-studio-code-look-and-behave-like-powershell-ise/
[03]: https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette
[04]: https://github.com/corbob
[05]: https://github.com/PowerShell/VSCode-powershell/issues/new/choose
[06]: https://mikefrobbins.com/2017/08/24/how-to-install-visual-studio-code-and-configure-it-as-a-replacement-for-the-powershell-ise/
[07]: media/How-To-Replicate-the-ISE-Experience-In-VSCode/1-highlighted-sidebar.png
[08]: media/How-To-Replicate-the-ISE-Experience-In-VSCode/2-simplified-ui.png
[09]: media/How-To-Replicate-the-ISE-Experience-In-VSCode/3-ise-mode.png
[10]: media/How-To-Replicate-the-ISE-Experience-In-VSCode/4-debug-console.png
[11]: using-vscode.md#debugging-with-visual-studio-code
