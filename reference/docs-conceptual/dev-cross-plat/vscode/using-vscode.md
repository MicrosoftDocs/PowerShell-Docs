---
description: Using Visual Studio Code for PowerShell Development
ms.date: 09/09/2022
title: Using Visual Studio Code for PowerShell Development
---

# Using Visual Studio Code for PowerShell Development

[Visual Studio Code][01] (VS Code) is a cross-platform script editor by Microsoft. Together with
the [PowerShell extension][02], it provides a rich and interactive script editing experience,
making it easier to write reliable PowerShell scripts. Visual Studio Code with the PowerShell
extension is the recommended editor for writing PowerShell scripts.

It supports the following PowerShell versions:

- PowerShell 7.2 and higher (Windows, macOS, and Linux)
- Windows PowerShell 5.1 (Windows-only) with .NET Framework 4.8

> [!NOTE]
> Visual Studio Code isn't the same as [Visual Studio][03].

## Getting started

Before you begin, make sure PowerShell exists on your system. For modern workloads on Windows,
macOS, and Linux, see the following links:

- [Installing PowerShell on Linux][04]
- [Installing PowerShell on macOS][05]
- [Installing PowerShell on Windows][06]

For traditional Windows PowerShell workloads, see [Installing Windows PowerShell][07].

> [!IMPORTANT]
> The [Windows PowerShell ISE][08] is still available for Windows. However, it's no longer in
> active feature development. The ISE only works with PowerShell 5.1 and older. As a component of
> Windows, it continues to be officially supported for security and high-priority servicing fixes.
> we've no plans to remove the ISE from Windows.

## Install VS Code and the PowerShell Extension

1. Install Visual Studio Code. For more information, see the overview
   [Setting up Visual Studio Code][09].

   There are installation instructions for each platform:

   - [Running Visual Studio Code on Windows][10]
   - [Running Visual Studio Code on macOS][11]
   - [Running Visual Studio Code on Linux][12]

1. Install the PowerShell Extension.

   1. Launch the VS Code app by typing `code` in a console or `code-insiders` if you installed
      Visual Studio Code Insiders.
   1. Launch **Quick Open** on Windows or Linux by pressing <kbd>Ctrl</kbd>+<kbd>P</kbd>. On macOS,
      press <kbd>Cmd</kbd>+<kbd>P</kbd>.
   1. In Quick Open, type `ext install powershell` and press **Enter**.
   1. The **Extensions** view opens on the Side Bar. Select the PowerShell extension from Microsoft.
   1. Click the **Install** button on the PowerShell extension from Microsoft.
   1. After the install, if you see the **Install** button turn into **Reload**, Click on
      **Reload**.
   1. After VS Code has reloaded, you're ready for editing.

For example, to create a new file, click **File > New**. To save it, click **File > Save** and then
provide a filename, such as `HelloWorld.ps1`. To close the file, click the `X` next to the filename.
To exit VS Code, **File > Exit**.

### Installing the PowerShell Extension on Restricted Systems

Some systems are set up to require validation of all code signatures. You may receive the following
error:

```
Language server startup failed.
```

This problem can occur when PowerShell's execution policy is set by Windows Group Policy. To
manually approve PowerShell Editor Services and the PowerShell extension for VS Code, open a
PowerShell prompt and run the following command:

```powershell
Import-Module $HOME\.vscode\extensions\ms-vscode.powershell*\modules\PowerShellEditorServices\PowerShellEditorServices.psd1
```

You're prompted with **Do you want to run software from this untrusted publisher?** Type `A` to run
the file. Then, open VS Code and verify that the PowerShell extension is functioning properly. If
you still have problems getting started, let us know in a [GitHub issue][13].

### Choosing a version of PowerShell to use with the extension

With PowerShell installing side-by-side with Windows PowerShell, it's now possible to use a specific
version of PowerShell with the PowerShell extension. This feature looks at a few well-known paths on
different operating systems to discover installations of PowerShell.

Use the following steps to choose the version:

1. Open the **Command Palette** on Windows or Linux with
   <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>. On macOS, use
   <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>.
1. Search for **Session**.
1. Click on **PowerShell: Show Session Menu**.
1. Choose the version of PowerShell you want to use from the list.

If you installed PowerShell to a non-typical location, it might not show up initially in the Session
Menu. You can extend the session menu by [adding your own custom paths][14] as described below.

The PowerShell session menu can also be accessed from the `{}` icon in the bottom right corner of
status bar. Hovering on or selecting this icon displays a shortcut to the session menu and a small
pin icon. If you select the pin icon, the version number is added to the status bar. The version
number is a shortcut to the session menu requiring fewer clicks.

> [!NOTE]
> Pinning the version number replicates the behavior of the extension in versions of VS Code before
> 1.65. The 1.65 release of VS Code changed the APIs the PowerShell extension uses and standardized
> the status bar for language extensions.

## Configuration settings for Visual Studio Code

First, if you're not familiar with how to change settings in VS Code, we recommend reading
[Visual Studio Code's settings][15] documentation.

After reading the documentation, you can add configuration settings in `settings.json`.

```json
{
    "editor.renderWhitespace": "all",
    "editor.renderControlCharacters": true,
    "files.trimTrailingWhitespace": true,
    "files.encoding": "utf8bom",
    "files.autoGuessEncoding": true
}
```

If you don't want these settings to affect all files types, VS Code also allows per-language
configurations. Create a language-specific setting by putting settings in a `[<language-name>]`
field. For example:

```json
{
    "[powershell]": {
        "files.encoding": "utf8bom",
        "files.autoGuessEncoding": true
    }
}
```

> [!TIP]
> For more information about file encoding in VS Code, see
> [Understanding file encoding][16]. Also, check out
> [How to replicate the ISE experience in VS Code][17] for other tips on how to configure VS
> Code for PowerShell editing.

### Adding your own PowerShell paths to the session menu

You can add other PowerShell executable paths to the session menu through the
[Visual Studio Code setting][18]:
`powershell.powerShellAdditionalExePaths`.

You can do this using the GUI:

1. From the **Command Palette** search for and select **Open User Settings**. Or use the
   keyboard shortcut on Windows or Linux <kbd>Ctrl</kbd>+<kbd>,</kbd>. On macOS, use
   <kbd>Cmd</kbd>+<kbd>,</kbd>.
1. In the **Settings** editor, search for **PowerShell Additional Exe Paths**.
1. Click **Add Item**.
1. For the **Key** (under **Item**), provide your choice of name for this additional PowerShell
   installation.
1. For the **Value** (under **Value**), provide the absolute path to the executable itself.

You can add as many additional paths as you like. The added items show up in the session menu with
the given key as the name.

Alternatively you can add key-value pairs to the object
`powershell.powerShellAdditionalExePaths` in your `settings.json`:

```json
{
    "powershell.powerShellAdditionalExePaths": {
        "Downloaded PowerShell": "C:/Users/username/Downloads/PowerShell/pwsh.exe",
        "Built PowerShell": "C:/Users/username/src/PowerShell/src/powershell-win-core/bin/Debug/net6.0/win7-x64/publish/pwsh.exe"
    },
}
```

> [!NOTE]
> Prior to version 2022.5.0 of the extension, this setting was a list of objects with the required
> keys `exePath` and `versionName`. A breaking change was introduced to support configuration via
> GUI. If you had previously configured this setting, please convert it the new format. The value
> given for `versionName` is now the **Key**, and the value given for `exePath` is now the
> **Value**. You can do this more easily by resetting the value and using the Settings interface.

To set the default PowerShell version, set the value `powershell.powerShellDefaultVersion` to the
text displayed in the session menu (the text used for the key):

```json
{
    "powershell.powerShellAdditionalExePaths": {
        "Downloaded PowerShell": "C:/Users/username/Downloads/PowerShell/pwsh.exe",
    },
    "powershell.powerShellDefaultVersion": "Downloaded PowerShell",
}
```

After you've configured this setting, restart VS Code or to reload the current VS Code window from
the **Command Palette**, type `Developer: Reload Window`.

If you open the session menu, you now see your additional PowerShell installations.

> [!TIP]
> If you build PowerShell from source, this is a great way to test out your local build of
> PowerShell.

## Debugging with Visual Studio Code

### No-workspace debugging

In VS Code version 1.9 (or higher), you can debug PowerShell scripts without opening the folder that
contains the PowerShell script.

1. Open the PowerShell script file with **File > Open File...**
1. Set a breakpoint - select a line then press <kbd>F9</kbd>
1. Press <kbd>F5</kbd> to start debugging

You should see the Debug actions pane appear that allows you to break into the debugger, step,
resume, and stop debugging.

### Workspace debugging

Workspace debugging refers to debugging in the context of a folder that you've opened from the
**File** menu using **Open Folder...**. The folder you open is typically your PowerShell project
folder or the root of your Git repository. Workspace debugging allows you to define multiple debug
configurations other than just debugging the currently open file.

Follow these steps to create a debug configuration file:

1. Open the **Debug** view on Windows or Linux by pressing
   <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>D</kbd>. On macOS, press
   <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>D</kbd>.
1. Click the **create a launch.json file** link.
1. From the **Select Environment** prompt, choose **PowerShell**.
1. Choose the type of debugging you'd like to use:

   - **Launch Current File** - Launch and debug the file in the currently active editor window
   - **Launch Script** - Launch and debug the specified file or command
   - **Interactive Session** - Debug commands executed from the Integrated Console
   - **Attach** - Attach the debugger to a running PowerShell Host Process

VS Code creates a directory and a file `.vscode\launch.json` in the root of your workspace folder to
store the debug configuration. If your files are in a Git repository, you typically want to commit
the `launch.json` file. The contents of the `launch.json` file are:

```json
{
  "version": "0.2.0",
  "configurations": [
      {
          "type": "PowerShell",
          "request": "launch",
          "name": "PowerShell Launch (current file)",
          "script": "${file}",
          "args": [],
          "cwd": "${file}"
      },
      {
          "type": "PowerShell",
          "request": "attach",
          "name": "PowerShell Attach to Host Process",
          "processId": "${command.PickPSHostProcess}",
          "runspaceId": 1
      },
      {
          "type": "PowerShell",
          "request": "launch",
          "name": "PowerShell Interactive Session",
          "cwd": "${workspaceRoot}"
      }
  ]
}
```

This file represents the common debug scenarios. When you open this file in the editor, you see an
**Add Configuration...** button. You can click this button to add more PowerShell debug
configurations. One useful configuration to add is **PowerShell: Launch Script**. With this
configuration, you can specify a file containing optional arguments that are used whenever you press
<kbd>F5</kbd> no matter which file is active in the editor.

After the debug configuration is established, you can select the configuration you want to use
during a debug session. Select a configuration from the debug configuration drop-down in the
**Debug** view's toolbar.

## Troubleshooting the PowerShell extension

If you experience any issues using VS Code for PowerShell script development, see the
[troubleshooting guide][19] on GitHub.

## Useful resources

There are a few videos and blog posts that may be helpful to get you started using the PowerShell
extension for VS Code:

### Videos

- [Using Visual Studio Code as Your Default PowerShell Editor][20]
- [Visual Studio Code: deep dive into debugging your PowerShell scripts][21]

### Blog posts

- [PowerShell Extension][22]
- [Write and debug PowerShell scripts in Visual Studio Code][23]
- [Debugging Visual Studio Code Guidance][24]
- [Debugging PowerShell in Visual Studio Code][25]
- [Get started with PowerShell development in Visual Studio Code][26]
- [Visual Studio Code editing features for PowerShell development - Part 1][27]
- [Visual Studio Code editing features for PowerShell development - Part 2][28]
- [Debugging PowerShell script in Visual Studio Code - Part 1][29]
- [Debugging PowerShell script in Visual Studio Code - Part 2][30]

## PowerShell extension project source code

The PowerShell extension's source code can be found on [GitHub][31].

If you're interested in contributing, Pull Requests are greatly appreciated. Follow along with the
[developer documentation][32] on GitHub to get started.

<!-- Link references -->
[01]: https://code.visualstudio.com/
[02]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[03]: https://visualstudio.microsoft.com/
[04]: ../../install/Installing-PowerShell-on-Linux.md
[05]: ../../install/Installing-PowerShell-on-macOS.md
[06]: ../../install/Installing-PowerShell-on-Windows.md
[07]: ../../install/Installing-Windows-PowerShell.md
[08]: ../../windows-powershell/ise/Introducing-the-Windows-PowerShell-ISE.md
[09]: https://code.visualstudio.com/Docs/setup/setup-overview
[10]: https://code.visualstudio.com/docs/setup/windows
[11]: https://code.visualstudio.com/docs/setup/mac
[12]: https://code.visualstudio.com/docs/setup/linux
[13]: https://github.com/PowerShell/vscode-powershell/issues
[14]: #adding-your-own-powershell-paths-to-the-session-menu
[15]: https://code.visualstudio.com/docs/getstarted/settings
[16]: understanding-file-encoding.md
[17]: How-To-Replicate-the-ISE-Experience-In-VSCode.md
[18]: https://code.visualstudio.com/docs/getstarted/settings
[19]: https://github.com/PowerShell/vscode-powershell/blob/master/docs/troubleshooting.md
[20]: https://youtu.be/bGn45vIeAMM
[21]: https://youtu.be/cSbIXmlkr8o
[22]: /archive/blogs/cdndevs/visual-studio-code-powershell-extension
[23]: https://devblogs.microsoft.com/powershell/announcing-powershell-language-support-for-visual-studio-code-and-more/
[24]: https://johnpapa.net/debugging-with-visual-studio-code/
[25]: https://github.com/PowerShell/vscode-powershell/tree/master/examples
[26]: https://devblogs.microsoft.com/scripting/get-started-with-powershell-development-in-visual-studio-code/
[27]: https://devblogs.microsoft.com/scripting/visual-studio-code-editing-features-for-powershell-development-part-1/
[28]: https://devblogs.microsoft.com/scripting/visual-studio-code-editing-features-for-powershell-development-part-2/
[29]: https://devblogs.microsoft.com/scripting/debugging-powershell-script-in-visual-studio-code-part-1/
[30]: https://devblogs.microsoft.com/scripting/debugging-powershell-script-in-visual-studio-code-part-2/
[31]: https://github.com/PowerShell/vscode-powershell
[32]: https://github.com/PowerShell/vscode-powershell/blob/master/docs/development.md
