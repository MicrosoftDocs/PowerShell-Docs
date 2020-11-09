---
description:  Describes the features and system requirements of Windows PowerShell Integrated Scripting Environment (ISE).
keywords: powershell,cmdlet
Locale: en-US
ms.date: 01/03/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_windows_powershell_ise?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Windows_PowerShell_ISE
---

# About Windows PowerShell ISE

## SHORT DESCRIPTION

Describes the features and system requirements of Windows PowerShell
Integrated Scripting Environment (ISE).

## LONG DESCRIPTION

Windows PowerShell ISE is a graphical host application for Windows PowerShell.
In Windows PowerShell ISE, you can run commands and write, test, and debug
scripts in a single Windows-based graphical user interface. Its features
include Intellisense, multiline editing, tab completion, auto-save, syntax
coloring, selective execution, context-sensitive help, Show Command (compose
commands in a window) and support for double-byte character sets and
right-to-left languages.

Windows PowerShell ISE is an excellent tool for beginners. The Show Command
window and New Remote PowerShell Tab guide you through tasks so that you can
be successful on the first try. Snippets and error indicators help you learn
the Windows PowerShell language as you work.

Advanced users can take advantage of the sophisticated debugging features,
add-ons, and the Windows PowerShell ISE object model.

What's New in Windows PowerShell ISE in Windows PowerShell 4.0

Windows PowerShell ISE introduces two new features in Windows PowerShell 4.0.

- Windows PowerShell ISE now supports both Windows PowerShell Workflow
  debugging and remote script debugging. For more Information, see
  about_Debuggers.

- IntelliSense support has been added for Windows PowerShell Desired State
  Configuration providers and configurations.

## Starting Windows PowerShell ISE

Windows PowerShell ISE is installed, enabled, and ready to use in all
supported versions of Windows.

- In Windows 8.1, Windows 8, Windows Server 2012 R2, and Windows Server 2012,
  on the Start screen, type PowerShell_ISE, and then click PowerShell_ISE or
  Windows PowerShell ISE.

- In Windows Server 2012 R2 and Windows Server 2012, in Server Manager, on the
  Tools menu, click Windows PowerShell ISE.

- In earlier versions of Windows, click Start, All Programs, Accessories,
  Windows PowerShell, and then click Windows PowerShell ISE.

- In a Windows PowerShell console, Cmd.exe, or the Run or Search box in
  Windows, type "PowerShell_ise.exe". You can also use the command-line
  parameters, including the NoProfile switch. For more information, see
  [PowerShell_ISE.exe Console Help](about_powershell_ise_exe.md).

## Running Interactive Commands

You can run any Windows PowerShell expression or command in Windows PowerShell
ISE. You can use cmdlets, providers, snap-ins, and modules as you would use
them in the Windows PowerShell console.

You can type or paste interactive commands in the Console pane. To run the
commands, you can use buttons, menu items, and keyboard shortcuts.

You can use the multiline editing feature to type or paste several lines of
code into the Console pane at once. When you press the UP ARROW key to recall
the previous command, all the lines in the command are recalled. When you type
commands, press SHIFT+ENTER to make a new blank line appear under the current
line.

## Viewing Output

The results of commands and scripts are displayed in the Console pane. You can
move or copy the results from the Console pane by using keyboard shortcuts or
the Copy button on the toolbar, and you can paste the results in the Script
pane or Console panes or other programs. To clear the Console pane, click the
"Clear Output Pane" button or type one of the following commands:

```
Clear-Host
cls
```

## Writing Scripts and Functions

In the Script pane, you can open, compose, edit, and run scripts. The Script
pane lets you edit scripts by using buttons and keyboard shortcuts. You can
also copy, cut, and paste text between the Script pane and the Console pane.

You can use the selective run feature to run all or part of a script. To run
part of a script, select the text you want to run, and then click the Run
Selection button or press F8. By default, F8 runs the current line.

Advanced editing features include brace-matching, expand-collapse, line
numbers, error indicators, block editing and indenting, rich copy, and case
conversion.

## Getting Help

Windows PowerShell ISE includes help topics that describe its use. In
addition, all installed help files are accessible from the Script and Command
panes.

Windows PowerShell ISE also supports context-sensitive help. To get help about
a particular cmdlet, provider, or keyword, place the cursor in the name of the
item and press F1. To search the help topics, press F1 and type the search
term.

To update the help topics on the computer, use the Update Windows PowerShell
Help item in the Help menu. This item updates help for the modules in the
current session in the current UI culture. It is equivalent to running the
Update-Help cmdlet without parameters. To update help for the cmdlets that
come with Windows PowerShell, start Windows PowerShell ISE with the "Run as
administrator" option.

You can also use the Get-Help, Save-Help, and Update-Help cmdlets in Windows
PowerShell ISE, just as you use it in the Windows PowerShell console. However,
in Windows PowerShell ISE, the Help function displays the entire help topic,
not one page at a time.

## Debugging Scripts

You can use the Windows PowerShell ISE debugger to debug a Windows PowerShell
script or function. When you debug a script, you can use menu items and
shortcut keys to perform many of the same tasks that you would perform in the
Windows PowerShell console. For example, to set a line breakpoint in a script,
right-click the line of code, and then click Toggle Breakpoint.

As you step through a script while debugging, the debugging highlighter shows
precisely which part of the command is running and automatically opens files
that include called functions and scripts.

By default, the Toggle Breakpoint menu item sets a breakpoint on an entire
line in a script, but you can set a breakpoint on a variable or command name.
You can also set a breakpoint on a command by line and column number, making
it easier to debug long pipeline commands.

Often, you can debug syntax errors in a script just by opening the script file
in Windows PowerShell ISE. The error indicators identify syntax errors and the
outlining features let you collapse parts of the script to focus on trouble
spots.

You can also use the Windows PowerShell debugger cmdlets in the Command pane
just as you would use them in the console.

## Running Remote Commands

The New Remote PowerShell Tab feature makes it easy to establish a persistent
user-managed Windows PowerShell session ("PSSession") to the local computer or
a remote computer. The command opens a pop-up window that prompts you for a
computer name and for the user account that has permission to run commands on
the remote computer.

## Customizing the View

You can use Windows PowerShell ISE features to move and to resize the Console
pane and the Script pane. You can show and hide either pane, and you can
change the text size in all the panes.

You can also use the Options window to customize the appearance and operation
of Windows PowerShell ISE. In addition, Windows PowerShell ISE has a custom
host variable, $psISE, that you can use to customize Windows PowerShell ISE,
including adding menus and menu items.

## Windows PowerShell ISE Profile

Windows PowerShell ISE has its own Windows PowerShell profile,
Microsoft.PowerShellISE_profile.ps1. In this profile, you can store functions,
aliases, variables, and commands that you use in Windows PowerShell ISE.

Items in the Windows PowerShell AllHosts profiles (CurrentUser\\AllHosts and
AllUsers\\AllHosts) are also available in Windows PowerShell ISE, just as they
are in any Windows PowerShell host program. However, the items in your Windows
PowerShell console profiles are not available in Windows PowerShell ISE.

Instructions for moving and reconfiguring your profiles are available in
Windows PowerShell ISE Help and in about_Profiles.

## NOTES

Windows PowerShell ISE is an optional Windows Feature that is turned on by
default on client and server versions of Windows. To enable and disable
Windows PowerShell ISE in client versions of Windows, use Turn Windows
Features On or Off in Control Panel. To enable and disable Windows PowerShell
ISE in server versions of Windows, use the Add Roles and Features Wizard in
Server Manager.

Because Windows PowerShell ISE requires a user interface, it does not work on
Server Core installations of Windows Server. However, if you add the Windows
PowerShell ISE feature, the installation automatically converts to Server with
a GUI.

Windows PowerShell ISE is built on the Windows Presentation Foundation (WPF).
If the graphical elements of Windows PowerShell ISE do not render correctly on
your system, you might resolve the problem by adding or adjusting the "Disable
WPF Hardware acceleration" graphics rendering settings on your system. For more
information, see
[Graphics Rendering Registry Settings](/dotnet/framework/wpf/graphics-multimedia/graphics-rendering-registry-settings).

## SEE ALSO

[about_Debuggers](about_Debuggers.md)

[about_Profiles](about_Profiles.md)

[about_Updatable_Help](about_Updatable_Help.md)

[Get-Help](xref:Microsoft.PowerShell.Core.Get-Help)

[Get-IseSnippet](xref:ISE.Get-IseSnippet)

[Import-IseSnippet](xref:ISE.Import-IseSnippet)

[New-IseSnippet](xref:ISE.New-IseSnippet)

[Save-Help](xref:Microsoft.PowerShell.Core.Save-Help)

[Show-Command](xref:Microsoft.PowerShell.Utility.Show-Command)

[Update-Help](xref:Microsoft.PowerShell.Core.Update-Help)
