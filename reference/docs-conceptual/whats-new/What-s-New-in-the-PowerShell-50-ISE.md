---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  What s New in the PowerShell 50 ISE
ms.assetid:  38648d47-7c27-4b37-a40e-ad29948519c2
---

# What&#39;s New in the Windows PowerShell ISE
This topic explains the new and updated features that have been introduced in versions of Windows PowerShell  Integrated Scripting Environment (ISE).

## Feature description
The Windows PowerShell ISE is a host application that enables you to write, run, and test scripts and modules in a graphical and intuitive environment. Key features such as syntax-coloring, tab completion, visual debugging, Unicode compliance, and context-sensitive Help provide a rich scripting experience.

For an overview of Windows PowerShell ISE, see [Windows PowerShell Integrated Scripting Environment overview](https://technet.microsoft.com/en-us/library/3c1892c2-bf84-4cb6-af26-1f453be9e671).

## New and changed functionality in Windows PowerShell ISE
The following table lists the new and changed features for this release of Windows PowerShell ISE in Windows PowerShell.

|Feature/functionality|Windows PowerShell ISE 4.0|Windows PowerShell ISE 3.0|Windows PowerShell ISE 2.0|
|--------------------------|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|
|**[IntelliSense](#intellisense)**|X|X||
|**[Snippets](#snippets)**|X|X||
|**[Add-on Tools](#add-on-tools)**|X|X||
|**[Restart Manager and Auto-save](#restart-manager-and-auto-save)**|X|X||
|**[Most-recently used list](#most-recently-used-list)**|X|X||
|**[Console Pane](#console-pane)**|X|X||
|**[Command-line switches](#command-line-switches)**|X|X||
|**[New editor features](#new-editor-features)**|X|X||
|**[New Help viewer window](#new-help-viewer-window)**|X|X||
|**[Show-Command cmdlet](#show-command-cmdlet)**|X|X||

### IntelliSense
**Added in ISE 3.0**

IntelliSense is an automatic-completion assistance feature that is part of Windows PowerShell ISE. IntelliSense displays clickable menus of potentially matching cmdlets, parameters, parameter values, files, or folders as you type.

**What value does this change add?**

With the addition of IntelliSense, it is easier to discover cmdlets and syntax when you use Windows PowerShell ISE to create scripts. You can also use Windows PowerShell ISE to learn Windows PowerShell while you create new scripts.

**What works differently?**

When you type cmdlets in the Windows PowerShell ISE 3.0 or later, a scrollable and clickable menu displays, allowing you to browse and select the appropriate commands.

### Snippets
**Added in ISE 3.0**

*Snippets* are short sections of Windows PowerShell code that you can insert into the scripts you create in Windows PowerShell ISE. Windows PowerShell ISE comes with a default set of snippets. You can add snippets by using the **New-Snippet** cmdlet while working in Windows PowerShell ISE.

**What value does this change add?**

By using snippets, you can quickly assemble and create scripts to automate your environment.

**What works differently?**

To use snippets in Windows PowerShell 3.0 or later, on the **Edit** menu, click **Start Snippets**, or press **Ctrl-J**.

### Add-on tools
**Added in PowerShell 3.0**

Windows PowerShell ISE now supports add-on tools, which are Windows Presentation Foundation (WPF) controls that are added by using the object model. Add-on tools can be displayed as a vertical or horizontal pane in the console. Multiple add-on tools in a pane are displayed as a tabbed control. You can also add or remove add-on tools that are produced by non-Microsoft parties. For more information about how to import or remove add-on tools, see [Windows PowerShell ISE Operations](http://technet.microsoft.com/library/cc732148.aspx).

**What value does this change add?**

Add-ons allow you to extend and customize Windows PowerShell ISE with tools that can enhance your scripting experience or add functionality to Windows PowerShell ISE.

**What works differently?**

Windows PowerShell ISE 3.0 and later come with the **Commands** add-on. The **Commands** add-on allows you to browse cmdlets, and access help about the cmdlets side-by-side with the **Script** and **Console** Panes.

Additional add-ons can be found by using the **Open Add-on Tools Website** command on the **Add-ons** menu.

### Restart manager and auto-save
**Added in PowerShell 3.0**

Windows PowerShell ISE now automatically saves your open scripts every two minutes, in a separate location.  If Windows PowerShell ISE stops working, or if the operating system is restarted, after Windows PowerShell ISE restarts, it recovers scripts that were open in the last session, even if the scripts were not saved.

To change the automatic saving interval, run the following command in the Console pane: **$psise.Options.AutoSaveMinuteInterval**.

**What value does this change add?**

You can now work within Windows PowerShell ISE knowing that your open scripts are automatically saved in the event of an unexpected restart.

**What works differently?**

Windows PowerShell ISE 2.0 does not save the scripts automatically in the event of a restart.

### Most-recently used list
**Added in PowerShell 3.0**

Windows PowerShell ISE now has a most-recently used list for files. When you open a file in Windows PowerShell ISE, the file is added to the most-recently used list on the **File** menu.

To change the default number of files in the most-recently used list, run the following command in the Console Pane: **$psise.Options.MruCount**.

**What value does this change add?**

You can now use the most-recently used list to easily access your frequently-used files.

**What works differently?**

Windows PowerShell ISE 2.0 does not have a most-recently used list.

### Console Pane
**Added in PowerShell 3.0**

The separate Command and Output Panes that were available in the first release of Windows PowerShell ISE have been combined into a single Console Pane. The Console Pane is similar in function and appearance to a typical Windows PowerShell console, but it includes the following enhancements (most are described in this topic).

- Syntax coloring for input text (not output text), including XML syntax

- IntelliSense

- Brace matching

- Error indication

- Full Unicode support

- **F1** context-sensitive help

- **Ctrl+F1** context-sensitive Show-Command

- Complex script and right-to-left support

- Font support

- Zoom

- Line-select and block-select modes

- Preservation of typed content at the command line when you press the **Up** arrow to view history in the console

**What value does this change add?**

The addition of these Console Pane changes provides a scripting experience that is more consistent with the console interface.

**What works differently?**

Windows PowerShell ISE 2.0 has separate Command and Output Panes.

### Command-line switches
**Added in PowerShell 3.0**

If you start Windows PowerShell ISE from the command line (by typing **powershell_ise.exe**), you can add the following new command-line switches.

- *-NoProfile*: Starts Windows PowerShell ISE without running **$profile**

- *-Help*: Displays a Help window

- *-mta*: Starts Windows PowerShell ISE in multithreaded apartment mode. The default operation mode for Windows PowerShell ISE is single-threaded apartment mode, or *-sta*.

**What value does this change add?**

The addition of these command-line switches allows you to control the environment in which the Windows PowerShell ISE runs.

**What works differently?**

Windows PowerShell ISE 2.0 does not recognize these command-line switches.

### New editor features
**Added in PowerShell 3.0**

Other Windows PowerShell ISE editing features include:

- **XML syntax coloring**Windows PowerShell ISE now colors XML syntax in the same way as it colors Windows PowerShell syntax.

- **Brace matching** Windows PowerShell ISE includes brace matching and highlighting, and can be used in the following ways: (for example, using the **Go to Match** command or **Ctrl + ]** locates the closing brace, if you have an opening brace selected).

- **Outline view** The Script Pane supports outlining, which allows collapsing or expanding sections of code by clicking plus or minus signs in the left margin. You can use braces or the **#region** and **#endregion** tags to mark the beginning or end of a collapsible section. To expand or collapse all regions, press **Ctrl + M**.

- **Drag and drop text editing**Windows PowerShell ISE now supports drag and drop text editing. You can select any block of text and drag that text to another location in the editor or the console to move the text. If you hold down the Ctrl key while you drag the selected text, when you release the mouse button the text is copied to the new location. In this version of Windows PowerShell ISE, as well as the previous version of Windows PowerShell ISE, when you drag and drop files onto Windows PowerShell ISE, Windows PowerShell ISE opens the file.

- **Parse error display** Parse errors are indicated with red underlines. When you hover over an indicated error, tooltip text displays the problem that was found in the code.

- **Zoom** The zoom percentage of the console'™s content can be set by using the zoom slider (in the lower right corner of Windows PowerShell ISE window), or by entering the command **$psise.options.Zoom** in the Console Pane.

- **Rich text copy and paste** Copying to the clipboard in Windows PowerShell ISE preserves the font, size, and color information of the original selection.

- **Block selection** You can select a block of text by holding down the ALT key while selecting text in the Script Pane with your mouse, or by pressing **Alt+Shift+Arrow**.

**What value does this change add?**

The additional editing features provide a more consistent and powerful editing environment.

**What works differently?**

These editing enhancements were not present in Windows PowerShell ISE 2.0.

### New Help viewer window
**Added in PowerShell 3.0**

If you press **F1** when your cursor is in a cmdlet, or you have part of a cmdlet highlighted, the new Help viewer opens context-sensitive Help about the highlighted cmdlet. To display Windows PowerShell About help, type  **operators** in the console pane, and then press **F1**.

Before you use this feature, download the most current version of Windows PowerShell Help topics from the Microsoft website. The simplest method for downloading the Help topics is to run the **Update-Help** cmdlet in the Console Pane when running Windows PowerShell ISE as administrator.

You can alter where the **F1** key looks for Help. In the **Tools**/**Options** menu, on the **General Settings** tab, under **Other Settings**, you can set or clear the checkbox **Use local help content instead of online content**. If checked, then the client looks for the cmdlet Help in the downloaded Help found in the modules folder.  If the checkbox is cleared, then the client looks on the TechNet library for the cmdlet help.

**What value does this change add?**

Context-sensitive Help without leaving your current cmdlet or script provides a seamless learning experience.

**What works differently?**

Pressing F1 in previous versions of Windows PowerShell ISE opened the help file on the local computer. In Windows PowerShell ISE 3.0 and later, a window opens that contains the help for the cmdlet that is searchable and configurable. This Help experience is new for Windows PowerShell ISE 3.0, and Updatable Help is new for Windows PowerShell 3.0.

### Show-Command cmdlet
**Added in PowerShell 3.0**

The **Show-Command** cmdlet enables you to compose or run a cmdlet or function by filling in a graphical form. The form lets users work with Windows PowerShell in a graphical environment. **Show-Command** also enables advanced scripters to create a quick Windows PowerShell-based GUI.

**What value does this change add?**

By using **Show-Command** in your Windows PowerShell scripts, you can provide your users with the graphical environment with which they are familiar. **Show-Command** can also help introductory users learn Windows PowerShell.

**What works differently?**

Show-Command is new Windows PowerShell ISE 3.0.

## See also
For more information about using Windows PowerShell ISE in Windows PowerShell, see the following links.

- [Using the Windows PowerShell Integrated Scripting Environment](../core-powershell/ise/Using-the-Windows-PowerShell-ISE.md)
- [ISE on the TechNet Wiki](http://social.technet.microsoft.com/wiki/search/searchresults.aspx?q=ISE)
- [Script Center](http://technet.microsoft.com/scriptcenter/default)

