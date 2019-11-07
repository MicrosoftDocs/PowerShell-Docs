---
title: Using Visual Studio Code for PowerShell Development
description: Using Visual Studio Code for PowerShell Development
ms.date: 08/06/2018
---

# Using Visual Studio Code for PowerShell Development

In addition to the [PowerShell ISE][ise], PowerShell is also well-supported in Visual Studio Code
(VSCode). The ISE isn't supported with PowerShell Core, but VSCode is supported for PowerShell Core
on all platforms: Windows, macOS, and Linux.

You can use VSCode on Windows with PowerShell version 5 by using Windows 10 or by installing
[Windows Management Framework 5.0 RTM](https://devblogs.microsoft.com/powershell/windows-management-framework-wmf-5-0-rtm-is-now-available-via-the-microsoft-update-catalog/)
for down-level Windows OSs such as Windows 8.1.

Before you begin, make sure PowerShell exists on your system. For modern workloads on Windows,
macOS, and Linux, see the following links:

- [Installing PowerShell Core on Linux][install-pscore-linux]
- [Installing PowerShell Core on macOS][install-pscore-macos]
- [Installing PowerShell Core on Windows][install-pscore-windows]

For traditional Windows PowerShell workloads, see [Installing Windows PowerShell][install-winps].

## Editing with VSCode

1. Install VSCode. For more information, see the overview
   [Setting up Visual Studio Code](https://code.visualstudio.com/Docs/setup/setup-overview).

   There are installation instructions for each platform:

   - **Linux**: follow the installation instructions on the
     [Running VSCode on Linux](https://code.visualstudio.com/docs/setup/linux) page.
   - **macOS**: follow the installation instructions on the
     [Running VSCode on macOS](https://code.visualstudio.com/docs/setup/mac) page.

     > [!IMPORTANT]
     > On macOS, you must install OpenSSL for the PowerShell extension to work correctly. The
     > easiest way to accomplish this is to install [Homebrew](https://brew.sh/) and then run
     > `brew install openssl`. VSCode can now load the PowerShell extension successfully.

   - **Windows**: follow the installation instructions on the
     [Running VSCode on Windows](https://code.visualstudio.com/docs/setup/windows) page.

1. Install the PowerShell Extension.

   1. Launch the VSCode app by:
      - **Windows**: typing `code` in your PowerShell session
      - **Linux**: typing `code` in your terminal
      - **macOS**: typing `code` in your terminal
   1. Launch **Quick Open** on Windows or Linux by pressing <kbd>Ctrl</kbd>+<kbd>P</kbd>. On macOS,
      press <kbd>Cmd</kbd>+<kbd>P</kbd>.
   1. In Quick Open, type `ext install powershell` and press **Enter**.
   1. The **Extensions** view opens on the Side Bar. Select the PowerShell extension from Microsoft.
      You should see a VSCode screen similar to the following image:

      ![VSCode](../../images/using-vscode/vscode.png)

   1. Click the **Install** button on the PowerShell extension from Microsoft.
   1. After the install, you see the **Install** button turns to **Reload**. Click on **Reload**.
   1. After VSCode has reloaded, you're ready for editing.

For example, to create a new file, click **File > New**. To save it, click **File > Save** and then
provide a file name, such as `HelloWorld.ps1`. To close the file, click the `X` next to the file
name. To exit VSCode, **File > Exit**.

### Installing the PowerShell Extension on Restricted Systems

Some systems are set up in a way that requires all code signatures to be checked and requires
PowerShell Editor Services to be manually approved to run on the system. A Group Policy update that
changes execution policy is a likely cause if you've installed the PowerShell extension but are
receiving an error such as:

```
Language server startup failed.
```

To manually approve PowerShell Editor Services and the PowerShell extension for VSCode, open a
PowerShell prompt and run the following command:

```powershell
Import-Module $HOME\.vscode\extensions\ms-vscode.powershell*\modules\PowerShellEditorServices\PowerShellEditorServices.psd1
```

You're prompted with **Do you want to run software from this untrusted publisher?** Type `A` to run
the file. Then, open VSCode and check that the PowerShell extension is functioning properly. If you
still have issues getting started, let us know on
[GitHub](https://github.com/PowerShell/vscode-powershell/issues).

### Choosing a version of PowerShell to use with the extension

With PowerShell Core installing side-by-side with Windows PowerShell, it's now possible to use a
particular version of PowerShell with the PowerShell extension. Use the following steps to choose
the version:

1. Open the **Command Palette** on Windows or Linux with
   <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>. On macOS, use
   <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>.
1. Search for **Session**.
1. Click on **PowerShell: Show Session Menu**.
1. Choose the version of PowerShell you want to use from the list, for example: **PowerShell Core**.

> [!IMPORTANT]
> This feature looks at a few well-known paths on different operating systems to discover install
> locations of PowerShell. If you installed PowerShell to a non-typical location, it might not show
> up initially in the Session Menu. You can extend the session menu by
> [adding your own custom paths](#adding-your-own-powershell-paths-to-the-session-menu) as described
> below.

>[!NOTE]
> There's another way to get to the session menu. When a PowerShell file is open in your editor, you
> see a green version number in the bottom right. Clicking this version number will bring you to the
> session menu.

### Adding your own PowerShell paths to the session menu

You can add other PowerShell executable paths to the session menu through a VSCode setting.

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

* `exePath`: The path to the `pwsh` or `powershell` executable.
* `versionName`: The text that will show up in the session menu.

You can set the default PowerShell version to use the `powershell.powerShellDefaultVersion` setting
by setting this to the text displayed in the session menu (also known as the `versionName` in the
last setting):

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

After you've configured this setting, restart VSCode or to reload the current VSCode window from the
**Command Palette**, type **Developer: Reload Window**.

If you open the session menu, you now see your additional PowerShell versions!

> [!NOTE]
> If you build PowerShell from source, this is a great way to test out your local build of
> PowerShell.

### Configuration settings for VSCode

By using the steps in the previous paragraph, you can add configuration settings in `settings.json`.

We recommend the following configuration settings for VSCode:

```json
{
    "csharp.suppressDotnetRestoreNotification": true,
    "editor.renderWhitespace": "all",
    "editor.renderControlCharacters": true,
    "omnisharp.projectLoadTimeout": 120,
    "files.trimTrailingWhitespace": true,
    "files.encoding": "utf8bom",
    "files.autoGuessEncoding": true
}
```

If you don't want these settings to affect all files types, VSCode also allows per-language
configurations. Create a language-specific setting by putting settings in a `[<language-name>]`
field. For example:

```json
"[powershell]": {
    "files.encoding": "utf8bom",
    "files.autoGuessEncoding": true
}
```

For more information about file encoding in VSCode, see [Understanding file encoding](understanding-file-encoding.md).

## Debugging with VSCode

### No-workspace debugging

As of VSCode version 1.9 you can debug PowerShell scripts without opening the folder that contains
the PowerShell script. Open the PowerShell script file with **File > Open File...**, set a
breakpoint on a line, press <kbd>F9</kbd>, and then press <kbd>F5</kbd> to start debugging. You
should see the Debug actions pane appear which allows you to break into the debugger, step, resume,
and stop debugging.

### Workspace debugging

Workspace debugging refers to debugging in the context of a folder that you've opened in Visual
Studio Code from the **File** menu using **Open Folder...**. The folder you open is typically your
PowerShell project folder and/or the root of your Git repository.

Even in this mode, you can start debugging the currently selected PowerShell script by pressing
<kbd>F5</kbd>. However, workspace debugging allows you to define multiple debug configurations other
than just debugging the currently open file. For instance, you can add a configuration to:

- Launch Pester tests in the debugger.
- Launch a specific file with arguments in the debugger.
- Launch an interactive session in the debugger.
- Attach the debugger to a PowerShell host process.

Follow these steps to create your debug configuration file:

  1. Open the **Debug** view on Windows or Linux by pressing
     <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>D</kbd>. On macOS, press
     <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>D</kbd>.
  1. Click the **Configure** gear icon in the toolbar.
  1. VSCode prompts you to **Select Environment**. Choose **PowerShell**.

The result is that VSCode creates a directory and a file `.vscode\launch.json` in the root of your
workspace folder. This location is where your debug configuration is stored. If your files are in a
Git repository, you typically want to commit the `launch.json` file. The contents of the
`launch.json` file are:

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
configuration, you can specify a file with optional arguments that should be launched whenever you
press <kbd>F5</kbd> no matter which file is currently active in the editor.

After the debug configuration is established, you can select which configuration you want to use
during a debug session. Select a configuration from the debug configuration drop-down in the
**Debug** view's toolbar.

There are a few blogs that may be helpful to get you started using PowerShell extension for Visual
Studio Code:

- [PowerShell Extension][ps-extension]
- [Write and debug PowerShell scripts in Visual Studio Code][debug]
- [Debugging Visual Studio Code Guidance][vscode-guide]
- [Debugging PowerShell in Visual Studio Code][ps-vscode]
- [Get started with PowerShell development in Visual Studio Code][getting-started]
- [Visual Studio Code editing features for PowerShell development – Part 1][editing-part1]
- [Visual Studio Code editing features for PowerShell development – Part 2][editing-part2]
- [Debugging PowerShell script in Visual Studio Code – Part 1][debugging-part1]
- [Debugging PowerShell script in Visual Studio Code – Part 2][debugging-part2]

[ise]: ../ise/Introducing-the-Windows-PowerShell-ISE.md
[install-pscore-linux]:  ../../setup/Installing-PowerShell-Core-on-Linux.md
[install-pscore-macos]:  ../../setup/Installing-PowerShell-Core-on-macOS.md
[install-pscore-windows]: ../../setup/Installing-PowerShell-Core-on-Windows.md
[install-winps]: ../../setup/Installing-Windows-PowerShell.md
[ps-extension]: https://blogs.msdn.microsoft.com/cdndevs/2015/12/11/visual-studio-code-powershell-extension/
[debug]: https://blogs.msdn.microsoft.com/powershell/2015/11/16/announcing-powershell-language-support-for-visual-studio-code-and-more/
[vscode-guide]: https://johnpapa.net/debugging-with-visual-studio-code/
[ps-vscode]: https://github.com/PowerShell/vscode-powershell/tree/master/examples
[getting-started]: https://blogs.technet.microsoft.com/heyscriptingguy/2016/12/05/get-started-with-powershell-development-in-visual-studio-code/
[editing-part1]: https://blogs.technet.microsoft.com/heyscriptingguy/2017/01/11/visual-studio-code-editing-features-for-powershell-development-part-1/
[editing-part2]: https://blogs.technet.microsoft.com/heyscriptingguy/2017/01/12/visual-studio-code-editing-features-for-powershell-development-part-2/
[debugging-part1]: https://blogs.technet.microsoft.com/heyscriptingguy/2017/02/06/debugging-powershell-script-in-visual-studio-code-part-1/
[debugging-part2]: https://blogs.technet.microsoft.com/heyscriptingguy/2017/02/13/debugging-powershell-script-in-visual-studio-code-part-2/

## PowerShell Extension for VSCode

The PowerShell extension's source code can be found on [GitHub](https://github.com/PowerShell/vscode-powershell).
