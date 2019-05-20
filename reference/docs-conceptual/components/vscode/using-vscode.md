---
title: Using Visual Studio Code for PowerShell Development
description: Using Visual Studio Code for PowerShell Development
ms.date: 08/06/2018
---

# Using Visual Studio Code for PowerShell Development

In addition to the [PowerShell ISE][ise],
PowerShell is also well-supported in Visual Studio Code.
Furthermore, the ISE is not supported with PowerShell Core,
while Visual Studio Code is supported for PowerShell Core on all platforms (Windows, macOS, and Linux)

You can use Visual Studio Code on Windows with PowerShell version 5 by using Windows 10 or by installing [Windows Management Framework 5.0 RTM](https://www.microsoft.com/en-us/download/details.aspx?id=50395) for down-level Windows OSs (e.g. Windows 8.1, etc.).

Before starting it, please make sure PowerShell exists on your system.
For modern workloads on Windows, macOS, and Linux, see:

- [Installing PowerShell Core on Linux][install-pscore-linux]
- [Installing PowerShell Core on macOS][install-pscore-macos]
- [Installing PowerShell Core on Windows][install-pscore-windows]

For traditional Windows PowerShell workloads, see [Installing Windows PowerShell][install-winps].

## Editing with Visual Studio Code

### [1. Installing Visual Studio Code](https://code.visualstudio.com/Docs/setup/setup-overview)

- **Linux**: follow the installation instructions on the [Running VS Code on Linux](https://code.visualstudio.com/docs/setup/linux) page

- **macOS**: follow the installation instructions on the [Running VS Code on macOS](https://code.visualstudio.com/docs/setup/mac) page

  > [!IMPORTANT]
  > On macOS, you must install OpenSSL for the PowerShell extension to work correctly.
  > The easiest way to accomplish this is to install [Homebrew](https://brew.sh/) and then run `brew install openssl`.
  > VS Code can now load the PowerShell extension successfully.

- **Windows**: follow the installation instructions on the [Running VS Code on Windows](https://code.visualstudio.com/docs/setup/windows) page

### 2. Installing PowerShell Extension

- Launch the Visual Studio Code app by:
  - **Windows**: typing `code` in your PowerShell session
  - **Linux**: typing `code` in your terminal
  - **macOS**: typing `code` in your terminal

- Launch **Quick Open** by pressing **Ctrl+P** (**Cmd+P** on Mac).
- In Quick Open, type `ext install powershell` and hit **Enter**.
- The **Extensions** view opens on the Side Bar. Select the PowerShell extension from Microsoft.
  You should see something like below:

  ![VSCode](../../images/vscode.png)

- Click the **Install** button on the PowerShell extension from Microsoft.
- After the install, you see the **Install** button turns to **Reload**.
  Click on **Reload**.
- After Visual Studio Code has reload, you are ready for editing.

For example, to create a new file, click **File->New**.
To save it, click **File->Save** and then provide a file name, let's say `HelloWorld.ps1`.
To close the file, click on "x" next to the file name.
To exit Visual Studio Code, **File->Exit**.

### Installing the PowerShell Extension on Restricted Systems

Some systems are set up in a way that requires all code signatures to be checked and thus requires
PowerShell Editor Services to be manually approved to run on the system.
A Group Policy update that changes execution policy is a likely cause if you have installed the
PowerShell extension but are reaching an error like:

```
Language server startup failed.
```

To manually approve PowerShell Editor Services and thus the PowerShell extension for VSCode
open a PowerShell prompt and run:

```powershell
Import-Module $HOME\.vscode\extensions\ms-vscode.powershell*\modules\PowerShellEditorServices\PowerShellEditorServices.psd1
```

You are prompted with "Do you want to run software from this untrusted publisher?"
Type `R` to run the file. Then, open Visual Studio Code and check that the PowerShell extension is
functioning properly. If you still have issues getting started, let us know on [GitHub](https://github.com/PowerShell/vscode-powershell/issues).

#### Choosing a version of PowerShell to use with the extension

With PowerShell Core installing side-by-side with Windows PowerShell, is it now possible to use a
particular version of PowerShell with the PowerShell extension. Use the following these steps to
choose the version:

1. Open the command pallet (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on Windows & Linux,
   <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on macOS).
1. Search for "Session".
1. Click on "PowerShell: Show Session Menu".
1. Choose the version of PowerShell you want to use from the list - for example, "PowerShell Core".

>[!IMPORTANT]
> This feature looks at a few well-known paths on different operating systems to discover install
> locations of PowerShell. If you installed PowerShell to a non-typical location, it might not show
> up initially in the Session Menu. You can extend the session menu by [adding your own custom paths](#adding-your-own-powershell-paths-to-the-session-menu)
> as described below.

>[!NOTE]
> There is another way to get to the session menu. When a PowerShell file is open in your editor, you
> see a green version number in the bottom right. Clicking this version number will bring you to the
> session menu.

##### Adding your own PowerShell paths to the session menu

You can add other PowerShell executable paths to the session menu through a VS Code setting.

Add an item to the list  `powershell.powerShellAdditionalExePaths` or create the list if it doesn't 
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

You can set the default PowerShell version to use using the `powershell.powerShellDefaultVersion` setting 
by setting this to the text displayed in the session menu (aka the `versionName` in the last setting):

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

Once you've set this setting, restart Visual Studio Code or use the the "Developer: Reload Window" command 
pallet action to reload the current vscode window.

If you open the session menu, you will now see your additional PowerShell versions!

> [!NOTE]
> If you build PowerShell from source, this is a great way to test out your local build of PowerShell.

#### Configuration settings for Visual Studio Code

By using the steps in the previous paragraph you can add configuration settings in `settings.json`.

We recommend the following configuration settings for Visual Studio Code:

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
configurations. Create a language specific setting by putting settings in a `[<language-name>]`
field. For example:

```json
"[powershell]": {
    "files.encoding": "utf8bom",
    "files.autoGuessEncoding": true
}
```

For more information about file encoding in VS Code, see [Understanding file encoding](understanding-file-encoding.md).

## Debugging with Visual Studio Code

### No-workspace debugging

As of Visual Studio Code version 1.9 you can debug PowerShell scripts without having to open the
folder containing the PowerShell script. Open the PowerShell script file with **File->Open
File...**, set a breakpoint on a line (press F9) and then press F5 to start debugging. You should
see the Debug actions pane appear which allows you to break into the debugger, step, resume and stop
debugging.

### Workspace debugging

Workspace debugging refers to debugging in the context of a folder that you have opened in Visual Studio Code using **Open Folder...** from the **File** menu.
The folder you open is typically your PowerShell project folder and/or the root of your Git repository.

Even in this mode, you can start debugging the currently selected PowerShell script by simply pressing F5.
However, workspace debugging allows you to define multiple debug configurations other than just debugging the currently open file.
For instance, you can add a configurations to:

- Launch Pester tests in the debugger
- Launch a specific file with arguments in the debugger
- Launch an interactive session in the debugger
- Attach the debugger to a PowerShell host process

Follow these steps to create your debug configuration file:

  1. Open the **Debug** view by pressing **Ctrl+Shift+D** (**Cmd+Shift+D** on Mac).
  2. Press the **Configure** gear icon in the toolbar.
  3. Visual Studio Code prompts you to **Select Environment**. Choose **PowerShell**.

  When you do this, Visual Studio Code creates a directory and a file ".vscode\launch.json" in the root of your workspace folder.
  This is where your debug configuration is stored. If your files are in a Git repository, you typically want to commit the launch.json file.
  The contents of the launch.json file are:

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

  This represents the common debug scenarios.
  However, when you open this file in the editor, you see an **Add Configuration...** button.
  You can press this button to add more PowerShell debug configurations. One handy configuration to add is **PowerShell: Launch Script**.
  With this configuration, you can specify a specific file with optional arguments that should be launched whenever you press F5 no matter which file is currently active in the editor.

  Once the debug configuration is established, you can select which configuration you want to use during a debug session by selecting one from the debug configuration drop-down in the **Debug** view's toolbar.

There are a few blogs that may be helpful to get you started using PowerShell extension for Visual Studio Code:

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

## PowerShell Extension for Visual Studio Code

The PowerShell extension's source code can be found on [GitHub](https://github.com/PowerShell/vscode-powershell).
