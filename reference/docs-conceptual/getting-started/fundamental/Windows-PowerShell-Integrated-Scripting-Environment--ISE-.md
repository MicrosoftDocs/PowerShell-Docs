---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Windows PowerShell Integrated Scripting Environment ISE
ms.assetid:  f156b92d-0203-46d2-89c7-b4989d32e3d2
---

# Windows PowerShell Integrated Scripting Environment (ISE)
The Windows PowerShell Integrated Scripting Environment (ISE) is one of two hosts for the Windows PowerShell engine and language. With it you can write, run, and test scripts in ways that are not available in the Windows PowerShell Console. The ISE adds syntax-coloring, tab completion, IntelliSense, visual debugging, and context sensitive Help.

The ISE lets you run commands in a console pane, but it also supports panes that you can use to simultaneously view the source code of your script and other tools that can plug into the ISE. You can even open up multiple script windows at the same time, which is especially helpful when you are debugging a script that uses functions defined in other scripts or modules.

## What’s New
Here are some of the features that have been added to the ISE in the most recent releases of PowerShell.

### Added in PowerShell 3.0 (Windows Server 2012, Windows 8)
**IntelliSense** automatically completes your commands by displaying menus of matching cmdlets, parameters, parameter values, files, or folders as you type.

**Snippets** are short sections of code that you can easily insert into the scripts your write. A collection of useful snippets is included in the box and you can more by using the **New-Snippet** cmdlet.

**Add-on tools** that add features to the ISE can be created by writing code that interacts with the [The Windows PowerShell ISE Scripting Object Model](../../core-powershell/ise/The-Windows-PowerShell-ISE-Scripting-Object-Model.md). These tools can display controls in a tabbed pane or work invisibly in the background. The **Commands** add-on is a good example and is included with version 3.0 and later that displays a list of the available commands and their Help.

**Restart Manager and Auto-save** automatically save your scripts every two minutes to help you avoid the loss of your work in the event of a crash or unexpected restart.

**Most Recently Used list** is now part of the File Open menu to make it easier to get to the files you use most often.

**Merged Console pane**. In previous versions of the ISE there were separate Command and Output panes. They are now combined into a single pane that more directly mimics what you see in the Windows Powershell Console.

**Command-line switches**. Several new command-line switches give you more control over the way the ISE works. -NoProfile starts the ISE without running a profile script. -Help opens up a help window with the ISE. -mta starts the ISE in “multi-threaded apartment mode”. The default is single-threaded.

**New editor features** make it easier to create and read your code:

- **XML syntax coloring**. The ISE editor now colors XML syntax in the same way as it colors Windows PowerShell code syntax.

- **Brace matching**. The ISEWindows PowerShell ISE highlights matching braces to help you ensure you have the right number of closing braces to match your opening ones. Use CTRL-\[ to locate the closing brace that matches the opening brace that the cursor is on.

- **Outline view**. You can collapse or expand sections of your code by clicking the plus and minus signs in the left margin. This makes it easier to find the code you’re looking for in a long script.

- **Drag and drop text editing**. You can select a block of text and drag it to another location to move it. If you hold down the Ctrl key while you drag the selected text you copy instead of move.

- **Parse error display**. Windows PowerShell examines your script as you type. If it detects an error, it shows a red squiggle under the offending code. When you hover over the indicated error, a tooltip shows you the problem that was found.

- **Zoom**. You can zoom in on your text to make it easier to read or zoom out to see the bigger picture by using the slider in the bottom-right corner of the ISE window.

- **Rich text copy and paste**. When you copy from the ISE to the clipboard, the font, size, and color information of the selected text is included.

- **Block selection**. You can select a block-shaped chunk of text by holding down the ALT key while selecting text in the script pane with your mouse, or by pressing **Alt+Shift+Arrow**.

### Added in PowerShell 2.0 (Windows Server 2008 R2, Windows 7)
The ISE was introduced with PowerShell v2.0.

## Requirements for running the Windows PowerShell ISE
The ISE is available on any Windows computer that can run Windows PowerShell
v2.0 or later.
Each version of Windows and Windows Server includes a version of Windows
PowerShell and the ISE, but you can upgrade to the latest available by
installing the Windows Management Framework.
Run this search to find the latest version available:
[Downloads](http://www.microsoft.com/en-us/search/DownloadResults.aspx?q=%22windows%20management%20framework%22%20PowerShell&sortby=Relevancy~Descending).
Note that any entries labelled "Preview" are pre-release code and are not feature complete.

> [!NOTE]
> Because Windows PowerShell ISE requires a graphical user interface, you can’t run it on the Server Core option of Windows Server.

## See also
- [Using the Windows PowerShell Integrated Scripting Environment](Using-the-Windows-PowerShell-ISE.md)

