---
title: Using Visual Studio Code for PowerShell Development
description: Using Visual Studio Code for PowerShell Development
ms.date: 11/07/2019
---

# Using Visual Studio Code for PowerShell Development

[Visual Studio Code][vscode] is a cross-platform script editor by Microsoft. Together with the
[PowerShell extension][psext], it provides a rich and interactive script editing experience, making
it easier to write reliable PowerShell scripts. Visual Studio Code with the PowerShell extension is
the recommended editor for writing PowerShell scripts.

It supports the following PowerShell versions:

- PowerShell 7 and up (Windows, macOS, and Linux)
- PowerShell Core 6 (Windows, macOS, and Linux)
- Windows PowerShell 5.1 (Windows-only)

> [!NOTE]
> Visual Studio Code is not the same as [Visual Studio][].

## Getting started

Before you begin, make sure PowerShell exists on your system. For modern workloads on Windows,
macOS, and Linux, see the following links:

- [Installing PowerShell on Linux][install-pscore-linux]
- [Installing PowerShell on macOS][install-pscore-macos]
- [Installing PowerShell on Windows][install-pscore-windows]

For traditional Windows PowerShell workloads, see [Installing Windows PowerShell][install-winps].

> [!IMPORTANT]
> The [Windows PowerShell ISE][ise] is still available for Windows. However, it is no longer in
> active feature development. The ISE does not work with PowerShell 6 and higher. As a component of
> Windows, it continues to be officially supported for security and high-priority servicing fixes.
> We have no plans to remove the ISE from Windows.

## Editing with Visual Studio Code

1. Install Visual Studio Code. For more information, see the overview
   [Setting up Visual Studio Code][vsc-setup].

   There are installation instructions for each platform:

   - **Windows**: follow the installation instructions on the
     [Running Visual Studio Code on Windows][vsc-setup-win] page.
   - **macOS**: follow the installation instructions on the
     [Running Visual Studio Code on macOS][vsc-setup-macOS] page.
   - **Linux**: follow the installation instructions on the
     [Running Visual Studio Code on Linux][vsc-setup-linux] page.

1. Install the PowerShell Extension.

   1. Launch the Visual Studio Code app by typing `code` in a console or `code-insiders`
      if you installed Visual Studio Code Insiders.
   1. Launch **Quick Open** on Windows or Linux by pressing <kbd>Ctrl</kbd>+<kbd>P</kbd>. On macOS,
      press <kbd>Cmd</kbd>+<kbd>P</kbd>.
   1. In Quick Open, type `ext install powershell` and press **Enter**.
   1. The **Extensions** view opens on the Side Bar. Select the PowerShell extension from Microsoft.
      You should see a Visual Studio Code screen similar to the following image:

      ![Visual Studio Code - view of the PowerShell extension](media/using-vscode/vscode.png)

   1. Click the **Install** button on the PowerShell extension from Microsoft.
   1. After the install, if you see the **Install** button turn into **Reload**, Click on **Reload**.
   1. After Visual Studio Code has reloaded, you're ready for editing.

For example, to create a new file, click **File > New**. To save it, click **File > Save** and then
provide a file name, such as `HelloWorld.ps1`. To close the file, click the `X` next to the file
name. To exit Visual Studio Code, **File > Exit**.

### Installing the PowerShell Extension on Restricted Systems

Some systems are set up to require validation of all code signatures. You may receive the following
error:

```
Language server startup failed.
```

This problem can occur when PowerShell's execution policy is set by Windows Group Policy. To
manually approve PowerShell Editor Services and the PowerShell extension for Visual Studio Code,
open a PowerShell prompt and run the following command:

```powershell
Import-Module $HOME\.vscode\extensions\ms-vscode.powershell*\modules\PowerShellEditorServices\PowerShellEditorServices.psd1
```

You're prompted with **Do you want to run software from this untrusted publisher?** Type `A` to run
the file. Then, open Visual Studio Code and check that the PowerShell extension is functioning
properly. If you still have problems getting started, let us know on [GitHub issues][].

> [!NOTE]
> The PowerShell extension for Visual Studio Code does not support running in constrained language
> mode. For more information, see [GitHub issue #606][i606].

### Choosing a version of PowerShell to use with the extension

With PowerShell Core installing side-by-side with Windows PowerShell, it's now possible to use a
specific version of PowerShell with the PowerShell extension. This feature looks at a few well-known
paths on different operating systems to discover installations of PowerShell.

Use the following steps to choose the version:

1. Open the **Command Palette** on Windows or Linux with
   <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>. On macOS, use
   <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>.
1. Search for **Session**.
1. Click on **PowerShell: Show Session Menu**.
1. Choose the version of PowerShell you want to use from the list, for example: **PowerShell Core**.

If you installed PowerShell to a non-typical location, it might not show up initially in the Session
Menu. You can extend the session menu by [adding your own custom paths](#adding-your-own-powershell-paths-to-the-session-menu)
as described below.

> [!NOTE]
> The PowerShell session menu can also be accessed from the green version number in the bottom right
> corner of status bar. Clicking this version number opens the session menu.

## Configuration settings for Visual Studio Code

First, if you're not familiar with how to change settings in Visual Studio Code, we recommend
reading [Visual Studio Code's settings][vsc-settings] documentation.

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

If you don't want these settings to affect all files types, Visual Studio Code also allows
per-language configurations. Create a language-specific setting by putting settings in a
`[<language-name>]` field. For example:

```json
{
    "[powershell]": {
        "files.encoding": "utf8bom",
        "files.autoGuessEncoding": true
    }
}
```

> [!TIP]
> For more information about file encoding in Visual Studio Code, see [Understanding file encoding][file-encoding].
>
> Also, check out [How to replicate the ISE experience in Visual Studio Code][vsc-ise] for other
> tips on how to configure Visual Studio Code for PowerShell editing.

### Adding your own PowerShell paths to the session menu

You can add other PowerShell executable paths to the session menu through the
[Visual Studio Code setting](https://code.visualstudio.com/docs/getstarted/settings):
`powershell.powerShellAdditionalExePaths`.

Add an item to the list `powershell.powerShellAdditionalExePaths` or create the list if it doesn't
exist in your `settings.json`:

```json
{
    // other settings...

    "powershell.powerShellAdditionalExePaths": [
        {
            "exePath": "C:\\Users\\tyler\\Downloads\\PowerShell\\pwsh.exe",
            "versionName": "Downloaded PowerShell"
        }
    ],

    // other settings...
}
```

Each item must have:

- `exePath`: The path to the `pwsh` or `powershell` executable.
- `versionName`: The text that will show up in the session menu.

To set the default PowerShell version, set the value `powershell.powerShellDefaultVersion` to the
text displayed in the session menu (also known as the `versionName`):

```json
{
    // other settings...

    "powershell.powerShellAdditionalExePaths": [
        {
            "exePath": "C:\\Users\\tyler\\Downloads\\PowerShell\\pwsh.exe",
            "versionName": "Downloaded PowerShell"
        }
    ],

    "powershell.powerShellDefaultVersion": "Downloaded PowerShell",

    // other settings...
}
```

After you've configured this setting, restart Visual Studio Code or to reload the current Visual
Studio Code window from the **Command Palette**, type **Developer: Reload Window**.

If you open the session menu, you now see your additional PowerShell versions!

> [!NOTE]
> If you build PowerShell from source, this is a great way to test out your local build of
> PowerShell.

### Using an older version of the PowerShell Extension for Windows PowerShell v3 and v4

The current PowerShell extension doesn't support [PowerShell v3 and v4][i1310]. However, you can
use the last version of the extension that supports PowerShell v3 and v4.

> [!CAUTION]
> There will be no additional fixes to this older version of the extension. It's provided "AS IS"
> but is available for you if you are still using Windows PowerShell v3 and Windows PowerShell v4.

First, open the Extension pane and search for `PowerShell`. Then click the gear and select
**Install another version...**.

![Menu item - Install another version...](media/using-vscode/install-another-version.png)

Then select the **2020.1.0** version. This version of the extension was the last version to
support v3 and v4. Be sure to add the following setting so that your extension version doesn't
update automatically:

```json
{
    "extensions.autoUpdate": false
}
```

Version **2020.1.0** will work for the foreseeable future. However, Visual Studio Code could
implement a change that breaks this version of the extension. Because of this, and lack of support,
we recommend:

- Upgrading to Windows PowerShell 5.1
- Install PowerShell 7, which is a side-by-side install to Windows PowerShell and works the
  best with the PowerShell extension

## Debugging with Visual Studio Code

### No-workspace debugging

In Visual Studio Code version 1.9 (or higher), you can debug PowerShell scripts without opening the
folder that contains the PowerShell script.

1. Open the PowerShell script file with **File > Open File...**
1. Set a breakpoint - select a line then press <kbd>F9</kbd>
1. Press <kbd>F5</kbd> to start debugging

You should see the Debug actions pane appear which allows you to break into the debugger,
step, resume, and stop debugging.

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

Visual Studio Code creates a directory and a file `.vscode\launch.json` in the root of your
workspace folder to store the debug configuration. If your files are in a Git repository, you
typically want to commit the `launch.json` file. The contents of the `launch.json` file are:

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
configuration, you can specify a file containing optional arguments that are used whenever you
press <kbd>F5</kbd> no matter which file is active in the editor.

After the debug configuration is established, you can select which configuration you want to use
during a debug session. Select a configuration from the debug configuration drop-down in the
**Debug** view's toolbar.

## Troubleshooting the PowerShell extension for Visual Studio Code

If you experience any issues using Visual Studio Code for PowerShell script development, see the
[troubleshooting guide][troubleshooting] on GitHub.

## Useful resources

There are a few videos and blog posts that may be helpful to get you started using the PowerShell
extension for Visual Studio Code:

### Videos

- [Using Visual Studio Code as Your Default PowerShell Editor](https://youtu.be/bGn45vIeAMM)
- [Visual Studio Code: deep dive into debugging your PowerShell scripts](https://youtu.be/cSbIXmlkr8o)

### Blog posts

- [PowerShell Extension][pscdn]
- [Write and debug PowerShell scripts in Visual Studio Code][debug]
- [Debugging Visual Studio Code Guidance][psdbgblog]
- [Debugging PowerShell in Visual Studio Code][psdbg-gh]
- [Get started with PowerShell development in Visual Studio Code][getting-started]
- [Visual Studio Code editing features for PowerShell development – Part 1][editing-part1]
- [Visual Studio Code editing features for PowerShell development – Part 2][editing-part2]
- [Debugging PowerShell script in Visual Studio Code – Part 1][debugging-part1]
- [Debugging PowerShell script in Visual Studio Code – Part 2][debugging-part2]

## PowerShell extension project source code

The PowerShell extension's source code can be found on [GitHub][psext-src].

If you're interested in contributing, Pull Requests are greatly appreciated. Follow along with the
[developer documentation][dev-docs] on GitHub to get started.

<!-- related articles -->
[ise]:                    ../../windows-powershell/ise/Introducing-the-Windows-PowerShell-ISE.md
[install-pscore-linux]:   ../../install/Installing-PowerShell-Core-on-Linux.md
[install-pscore-macos]:   ../../install/Installing-PowerShell-Core-on-macOS.md
[install-pscore-windows]: ../../install/Installing-PowerShell-Core-on-Windows.md
[install-winps]:          ../../install/Installing-Windows-PowerShell.md
[file-encoding]:          understanding-file-encoding.md
[vsc-ise]:                How-To-Replicate-the-ISE-Experience-In-VSCode.md

<!-- blogs -->
[debug]:                  https://devblogs.microsoft.com/powershell/announcing-powershell-language-support-for-visual-studio-code-and-more/
[debugging-part1]:        https://devblogs.microsoft.com/scripting/debugging-powershell-script-in-visual-studio-code-part-1/
[debugging-part2]:        https://devblogs.microsoft.com/scripting/debugging-powershell-script-in-visual-studio-code-part-2/
[editing-part1]:          https://devblogs.microsoft.com/scripting/visual-studio-code-editing-features-for-powershell-development-part-1/
[editing-part2]:          https://devblogs.microsoft.com/scripting/visual-studio-code-editing-features-for-powershell-development-part-2/
[getting-started]:        https://devblogs.microsoft.com/scripting/get-started-with-powershell-development-in-visual-studio-code/
[psdbgblog]:              https://johnpapa.net/debugging-with-visual-studio-code/
[psdbg-gh]:               https://github.com/PowerShell/vscode-powershell/tree/master/examples
[pscdn]:                  https://docs.microsoft.com/archive/blogs/cdndevs/visual-studio-code-powershell-extension

<!-- issues -->
[GitHub issues]:          https://github.com/PowerShell/vscode-powershell/issues
[i1310]:                  https://github.com/PowerShell/vscode-powershell/issues/1310
[i606]:                   https://github.com/PowerShell/vscode-powershell/issues/606

<!-- product links -->
[Visual Studio]:          https://visualstudio.microsoft.com/
[vscode]:                 https://code.visualstudio.com/
[psext]:                  https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[vsc-settings]:           https://code.visualstudio.com/docs/getstarted/settings
[vsc-setup]:              https://code.visualstudio.com/Docs/setup/setup-overview
[vsc-setup-win]:          https://code.visualstudio.com/docs/setup/windows
[vsc-setup-macos]:        https://code.visualstudio.com/docs/setup/mac
[vsc-setup-linux]:        https://code.visualstudio.com/docs/setup/linux
[psext-src]:              https://github.com/PowerShell/vscode-powershell
[troubleshooting]:        https://github.com/PowerShell/vscode-powershell/blob/master/docs/troubleshooting.md
[dev-docs]:               https://github.com/PowerShell/vscode-powershell/blob/master/docs/development.md
