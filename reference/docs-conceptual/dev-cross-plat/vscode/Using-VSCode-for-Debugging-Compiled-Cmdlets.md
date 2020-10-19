---
ms.date:  10/19/2020
keywords:  powershell,cmdlet,debug
title:  Using Visual Studio Code for debugging compiled cmdlets
description: How to set a build task and launch configuration for a PSModule project in .NET Core
---
# Using Visual Studio Code for debugging compiled cmdlets

This guide will show you how to interactively debug C# source code for a compiled PowerShell module,
using Visual Studio Code and the C# extension.

> These steps will show you how to debug your module in PowerShell Core. They will not work for
Windows PowerShell.

Some familiarity with the Visual Studio Code debugger is assumed.

- For a general introduction to the Visual Studio Code debugger, see [Debugging in Visual Studio Code][].

- For examples of debugging PowerShell script files and modules, see [Using Visual Studio Code for remote editing and debugging][].

This guide follows on from the [Writing Portable Modules][] guide.

## Creating a build task

It is a good idea to build your project automatically before launching a debugging session. This
ensures that you are debugging the latest version of your code.

This can be achieved with a build task:

1. In the Command Palette, run the `Configure Default Build Task` command

   ![Run Configure Default Build Task](media/Using-VSCode-for-Debugging-Compiled-Cmdlets/configure-default-build-task.png)

2. In the `Select a task to configure` dialog, choose `Create tasks.json file from template`

3. In the `Select a Task Template` dialog, choose `.NET Core`

This will create a new `tasks.json` file, if one does not exist yet.

To test your build task:

1. In the Command Palette, run the `Run Build Task` command

2. In the `Select the build task to run` dialog, choose `build`

A successful build will not, by default, show output in the terminal pane. If you see output, review
it. If the output contains the text `Project file does not exist`, then you should edit the
`tasks.json` file to include the explicit path to the C# project, which can be expressed as
`"${workspaceFolder}/myModule"` (where `myModule` is the name of the project folder, if applicable).

This needs to go after the `build` entry in the `args` list, as follows:

```json
    {
        "label": "build",
        "command": "dotnet",
        "type": "shell",
        "args": [
            "build",
            "${workspaceFolder}/myModule",
            // Ask dotnet build to generate full paths for file names.
            "/property:GenerateFullPaths=true",
            // Do not generate summary otherwise it leads to duplicate errors in Problems panel
            "/consoleloggerparameters:NoSummary",
        ],
        "group": "build",
        "presentation": {
            "reveal": "silent"
        },
        "problemMatcher": "$msCompile"
    }
```

## Setting up the debugger

To debug the PowerShell cmdlet, you will need to set up a custom launch configuration. This
configuration will:

- Build your source code

- Start PowerShell with your module loaded

- Leave PowerShell open in the terminal pane, so that you can invoke your cmdlet

- When you invoke your cmdlet, the debugger will stop at any breakpoints in your source code

The steps are:

1. Install the [C# for Visual Studio Code][] extension

2. In the Debug pane, add a debug configuration

3. In the `Select environment` dialog, choose `.NET Core`

4. This will open `launch.json`. With your cursor inside the `configurations` array, you will see the
`configuration` picker. If you do not see this, click on `Add Configuration`.

5. Choose `Launch .NET Core Console App`:

   ![Launch .NET Core Console App](media/Using-VSCode-for-Debugging-Compiled-Cmdlets/add-configuration-dialog.png)

   This will create a default debug configuration.

6. Edit the `name`, `program`, `args` and `console` fields as follows:

   ```json
    {
        "name": "PowerShell cmdlets",
        "type": "coreclr",
        "request": "launch",
        "preLaunchTask": "build",
        "program": "pwsh",
        "args": [
            "-NoExit",
            "-NoProfile",
            "-Command",
            "Import-Module ${workspaceFolder}/myModule/bin/Debug/netstandard2.0/myModule.dll",
        ],
        "cwd": "${workspaceFolder}",
        "stopAtEntry": false,
        "console": "integratedTerminal"
    }
   ```

### Explanation of the edits

- It is necessary to launch `pwsh` so that the cmdlet being debugged can be run

- `powershell.exe` will not work with these steps

- The `-NoExit` argument prevents the PowerShell session from exiting as soon as the module is
imported

- The path in the `Import-Module` argument is the default build output path if you have followed the
[Writing Portable Modules][] guide

  > The `/` path separator works on Windows, Linux and macOS.

- It is necessary to use the integrated terminal because the debug terminal will not allow you to
run PowerShell commands

## Launching a debugging session

Now everything is ready to begin debugging.

- Place a breakpoint in the source code for the cmdlet you want to debug:

  ![A breakpoint shows as a red dot in the gutter](media/Using-VSCode-for-Debugging-Compiled-Cmdlets/set-breakpoint.png)

- Ensure that the `PowerShell cmdlets` configuration is selected in the configuration drop-down menu
in the Debug view:

  ![Select the PowerShell cmdlets configuration](media/Using-VSCode-for-Debugging-Compiled-Cmdlets/select-launch-configuration.png)

- press `F5` or click on the `Start Debugging` button

- Switch to the terminal pane and invoke your cmdlet:

  ![Invoke the cmdlet](media/Using-VSCode-for-Debugging-Compiled-Cmdlets/invoke-the-cmdlet.png)

- Execution stops at the breakpoint:

  ![Invoke the cmdlet](media/Using-VSCode-for-Debugging-Compiled-Cmdlets/stopped-at-breakpoint.png)

You can step through the source code, inspect variables and inspect the call stack.

To end debugging, click `Stop` in the debug toolbar or press `Shift-F5`.

<!-- reference links -->
[Debugging in Visual Studio Code]: https://code.visualstudio.com/docs/editor/debugging
[Using Visual Studio Code for remote editing and debugging]: Using-VSCode-for-Remote-Editing-and-Debugging
[Writing Portable Modules]: /powershell/scripting/dev-cross-plat/writing-portable-modules
[C# for Visual Studio Code]: https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp
