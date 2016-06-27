---
title: about_Windows_PowerShell_ISE
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dfa54d47-60c6-4fff-8197-c747e8d411bb
---
# about_Windows_PowerShell_ISE
## TOPIC  
 about\_Windows\_PowerShell\_ISE  
  
## SHORT DESCRIPTION  
 Describes the features and system requirements of [!INCLUDE[wps_1]()] Integrated Scripting Environment \(ISE\).  
  
## LONG DESCRIPTION  
 [!INCLUDE[wps_2]()] ISE is a graphical host application for [!INCLUDE[wps_2]()]. In [!INCLUDE[wps_2]()] ISE, you can run commands and write, test, and debug scripts in a single Windows\-based graphical user interface. Its features include Intellisense, multiline editing, tab completion, auto\-save, syntax coloring, selective execution, context\-sensitive help, Show Command \(compose commands in a window\) and support for double\-byte character sets and right\-to\-left languages.  
  
 [!INCLUDE[wps_2]()] ISE is an excellent tool for beginners. The Show Command window and New Remote PowerShell Tab guide you through tasks so that you can be successful on the first try. Snippets and error indicators help you learn the [!INCLUDE[wps_2]()] language as you work.  
  
 Advanced users can take advantage of the sophisticated debugging features, add\-ons, and the [!INCLUDE[wps_2]()] ISE object model.  
  
### WHAT’S NEW IN WINDOWS POWERSHELL ISE IN WINDOWS POWERSHELL 4.0  
 [!INCLUDE[wps_2]()] ISE introduces two new features in [!INCLUDE[wps_2]()] 4.0.  
  
 [!INCLUDE[wps_2]()] ISE now supports both [!INCLUDE[wps_2]()] Workflow debugging and remote script debugging. For more Information, see about\_Debuggers.  
  
 IntelliSense support has been added for [!INCLUDE[wps_2]()] Desired State Configuration providers and configurations.  
  
## STARTING WINDOWS POWERSHELL ISE  
 [!INCLUDE[wps_2]()] ISE is installed, enabled, and ready to use in all supported versions of Windows.  
  
 In Windows 8.1, Windows 8, Windows Server 2012 R2, and Windows Server2012, on the Start screen, type PowerShell\_ISE, and then click PowerShell\_ISE or [!INCLUDE[wps_2]()] ISE.  
  
 In Windows Server 2012 R2 and Windows Server 2012, in Server Manager, on the Tools  menu, click [!INCLUDE[wps_2]()] ISE.  
  
 In earlier versions of Windows, click Start, All Programs, Accessories, [!INCLUDE[wps_2]()], and then click [!INCLUDE[wps_2]()] ISE.  
  
 In a [!INCLUDE[wps_2]()] console, Cmd.exe, or the Run or Search box in Windows, type "PowerShell\_ise.exe". You can also use the command\-line parameters, including the NoProfile switch. For more information, see PowerShell\_ISE.exe Console Help \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=243055\).  
  
### RUNNING INTERACTIVE COMMANDS  
 You can run any [!INCLUDE[wps_2]()] expression or command in [!INCLUDE[wps_2]()] ISE. You can use cmdlets, providers, snap\-ins, and modules as you would use them in the [!INCLUDE[wps_2]()] console.  
  
 You can type or paste interactive commands in the Console pane. To run the commands, you can use buttons, menu items, and keyboard shortcuts.  
  
 You can use the multiline editing feature to type or paste several lines of code into the Console pane at once. When you press the UP ARROW key to recall the previous command, all the lines in the command are recalled. When you type commands, press SHIFT\+ENTER to make a new blank line appear under the current line.  
  
### VIEWING OUTPUT  
 The results of commands and scripts are displayed in the Console pane. You can move or copy the results from the Console pane by using keyboard shortcuts or the Copy button on the toolbar, and you can paste the results in the Script pane or Console panes or other programs. To clear the Console pane, click the "Clear Output Pane" button or type one  of the following commands:  
  
```  
Clear-Host  
cls  
```  
  
### WRITING SCRIPTS AND FUNCTIONS  
 In the Script pane, you can open, compose, edit, and run scripts. The Script pane lets you edit scripts by using buttons and keyboard shortcuts. You can also copy, cut, and paste text between the Script pane and the Console pane.  
  
 You can use the selective run feature to run all or part of a script. To run part of a script, select the text you want to run, and then click the Run Selection button or press F8. By default, F8 runs the current line.  
  
 Advanced editing features include brace\-matching, expand\-collapse, line numbers, error indicators, block editing and indenting, rich copy, and case conversion.  
  
### GETTING HELP  
 [!INCLUDE[wps_2]()] ISE includes help topics that describe its use. In addition, all installed help files are accessible from the Script and Command panes.  
  
 [!INCLUDE[wps_2]()] ISE also supports context\-sensitive help. To get help about a particular cmdlet, provider, or keyword, place the cursor in the name of the item and press F1. To search the help topics, press F1 and type the search term.  
  
 To update the help topics on the computer, use the Update [!INCLUDE[wps_2]()] Help item in the Help menu. This item updates help for the modules in the current session in the current UI culture. It is equivalent to running the Update\-Help cmdlet without parameters. To update help for the cmdlets that come with [!INCLUDE[wps_2]()], start [!INCLUDE[wps_2]()] ISE with the "Run as administrator" option.  
  
 You can also use the Get\-Help, Save\-Help, and Update\-Help cmdlets in [!INCLUDE[wps_2]()] ISE, just as you use it in the [!INCLUDE[wps_2]()] console. However, in [!INCLUDE[wps_2]()] ISE, the Help function displays the entire help topic, not one page at a time.  
  
### DEBUGGING SCRIPTS  
 You can use the [!INCLUDE[wps_2]()] ISE debugger to debug a [!INCLUDE[wps_2]()] script or function. When you debug a script, you can use menu items and shortcut keys to perform many of the same tasks that you would perform in the [!INCLUDE[wps_2]()] console. For example, to set a line breakpoint in a script, right\-click the line of code, and then click Toggle Breakpoint.  
  
 As you step through a script while debugging, the debugging highlighter shows precisely which part of the command is running and automatically opens files that include called functions and scripts.  
  
 By default, the Toggle Breakpoint menu item sets a breakpoint on an entire line in a script, but you can set a breakpoint on a variable or command name. You can also set a breakpoint on a command by line and column number, making it easier to debug long pipeline commands.  
  
 Often, you can debug syntax errors in a script just by opening the script file in [!INCLUDE[wps_2]()] ISE. The error indicators identify syntax errors and the outlining features let you collapse parts of the script to focus on trouble spots.  
  
 You can also use the [!INCLUDE[wps_2]()] debugger cmdlets in the Command pane just as you would use them in the console.  
  
### RUNNING REMOTE COMMANDS  
 The New Remote PowerShell Tab feature makes it easy to establish a persistent user\-managed [!INCLUDE[wps_2]()] session \("PSSession"\) to the local computer or a remote computer. The command opens a pop\-up window that prompts you for a computer name and for the user account that has permission to run commands on the remote computer.  
  
### CUSTOMIZING THE VIEW  
 You can use [!INCLUDE[wps_2]()] ISE features to move and to resize the Console pane and the Script pane. You can show and hide either pane, and you can change the text size in all the panes.  
  
 You can also use the Options window to customize the appearance and operation of [!INCLUDE[wps_2]()] ISE. In addition, [!INCLUDE[wps_2]()] ISE has a custom host variable, $psISE, that you can use to customize [!INCLUDE[wps_2]()] ISE, including adding menus and menu items.  
  
### WINDOWS POWERSHELL ISE PROFILE  
 [!INCLUDE[wps_2]()] ISE has its own [!INCLUDE[wps_2]()] profile, Microsoft.PowerShellISE\_profile.ps1. In this profile, you can store functions, aliases, variables, and commands that you use in [!INCLUDE[wps_2]()] ISE.  
  
 Items in the [!INCLUDE[wps_2]()] AllHosts profiles \(CurrentUser\\AllHosts and AllUsers\\AllHosts\) are also available in [!INCLUDE[wps_2]()] ISE, just as they are in any [!INCLUDE[wps_2]()] host program. However, the items in your [!INCLUDE[wps_2]()] console profiles are not available in [!INCLUDE[wps_2]()] ISE.  
  
 Instructions for moving and reconfiguring your profiles are available in [!INCLUDE[wps_2]()] ISE Help and in about\_Profiles.  
  
## NOTES  
 [!INCLUDE[wps_2]()] ISE is an optional Windows Feature that is turned on by default on client and server versions of Windows. To enable and disable [!INCLUDE[wps_2]()] ISE in client versions of Windows, use Turn Windows Features On or Off in Control Panel. To enable and disable [!INCLUDE[wps_2]()] ISE in server versions of Windows, use the Add Roles and Features Wizard in Server Manager.  
  
 Because [!INCLUDE[wps_2]()] ISE requires a user interface, it does not work on Server Core installations of Windows Server. However, if you add the [!INCLUDE[wps_2]()] ISE feature, the installation automatically converts to Server with a GUI.  
  
 [!INCLUDE[wps_2]()] ISE is built on the Windows Presentation Foundation \(WPF\). If the graphical elements of [!INCLUDE[wps_2]()] ISE do not render correctly on your system, you might resolve the problem by adding or adjusting the "Disable WPF Hardware acceleration" graphics rendering settings on  your system. For more information, see "Graphics Rendering Registry Settings" in the MSDN library at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=144711.  
  
## SEE ALSO  
 about\_Debuggers  
  
 about\_Profiles  
  
 about\_Updatable\_Help  
  
 Get\-Help  
  
 Get\-IseSnippet  
  
 Import\-IseSnippet  
  
 New\-IseSnippet  
  
 Save\-Help  
  
 Show\-Command  
  
 Update\-Help