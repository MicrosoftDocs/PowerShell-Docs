---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  The ISE Object Model Hierarchy
ms.assetid:  bc3300e4-9c17-4f00-a621-c8867126e3b3
---

# The ISE Object Model Hierarchy
This topic shows the hierarchy of objects that are part of 
Windows PowerShell Integrated Scripting Environment (ISE). 
Windows PowerShell ISE is included in Windows PowerShell 3.0 
and in Windows PowerShell 4.0. 
Click an object to take you to the reference documentation 
for the class that defines the object.

##  **$psISE Object**
 The **$psISE** object is the [root object](The-ObjectModelRoot-Object.md) of the Windows PowerShell ISE object hierarchy. Located at the top level, it makes the following objects available for scripting:

-   **[$psISE.CurrentFile]()**

-   **[$psISE.CurrentPowerShellTab]()**

-   **[$psISE.CurrentVisibleHorizontalTool]()**

-   **[$psISE.CurrentVisibleVerticalTool]()**

-   **[$psISE.Options]()**

-   **[$psISE.PowerShellTabs]()**

##  **[$psISE.CurrentFile](The-ISEFile-Object.md)**
 The **$psISE.CurrentFile** object is an instance of the [ISEFile](The-ISEFile-Object.md) class and makes the following objects available for scripting:

-   **[$psISE.CurrentFile.DisplayName](The-ISEFile-Object.md)**

-   **[$psISE.CurrentFile.Editor](The-ISEEditor-Object.md)**  This object is an instance of the [ISEEditor](The-ISEEditor-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentFile.Editor.CanGoToMatch](The-ISEEditor-Object.md)**

    -   **[CaretColumn](The-ISEEditor-Object.md)**

    -   **[CaretLine](The-ISEEditor-Object.md)**

    -   **[$psISE.CurrentFile.Editor.CaretLineText](The-ISEEditor-Object.md)**

    -   **[LineCount](The-ISEEditor-Object.md)**

    -   **[SelectedText](The-ISEEditor-Object.md)**

    -   **[Text](The-ISEEditor-Object.md)**

-   **[EncodingThe-ISEFile-Object.md]()**

-   **[FullPathThe-ISEFile-Object.md]()**

-   **[IsSavedThe-ISEFile-Object.md]()**

-   **[IsUntitledThe-ISEFile-Object.md]()**

##  **[$psISE.CurrentPowerShellTab](The-PowerShellTab-Object.md)**
 The **$psISE.CurrentPowerShellTab** object is an instance of the [PowerShellTab](The-PowerShellTab-Object.md) class and makes the following objects available for scripting:

-   **[$psISE.CurrentPowerShellTab.AddOnsMenu](The-ISEMenuItem-Object.md)**  This object is an instance of the [ISEMenuItem](The-ISEMenuItem-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.ActionThe-ISEMenuItem-Object.md]()**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.DisplayNameThe-ISEMenuItem-Object.md]()**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.ShortcutThe-ISEMenuItem-Object.md]()**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus](The-ISEMenuItemCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.CanInvokeThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.ConsolePane](The-ISEEditor-Object.md)**  This object is an instance of the [ISEEditor](The-ISEEditor-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentPowerShellTab.ConsolePane.CanGoToMatchThe-ISEEditor-Object.md]()**

    -   **[CaretColumnThe-ISEEditor-Object.md]()**

    -   **[CaretLineThe-ISEEditor-Object.md]()**

    -   **[$psISE.CurrentPowerShellTab.ConsolePane.CaretLineTextThe-ISEEditor-Object.md]()**

    -   **[LineCountThe-ISEEditor-Object.md]()**

    -   **[SelectedTextThe-ISEEditor-Object.md]()**

    -   **[TextThe-ISEEditor-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.DisplayNameThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.ExpandedScriptThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.Files](The-ISEFileCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.HorizontalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.HorizontalAddOnToolsPaneOpenedThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.PromptThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.ShowCommandsThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.Snippets](The-ISESnippetCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.StatusTextThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.VerticalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.VerticalAddOnToolsPaneOpenedThe-PowerShellTab-Object.md]()**

-   **[$psISE.CurrentPowerShellTab.VisibleHorizontalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.VisibleVerticalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

##  **$psISE.CurrentVisibleHorizontalTool**
 The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the [ISEAddOnTool](The-ISEAddOnTool-Object.md) class. It represents the installed add-on tool that is currently docked to the top edge of the Windows PowerShell ISE window. This object makes the following objects available for scripting:

-   **[$psISE.CurrentVisibleHorizontalTool.ControlThe-ISEAddOnTool-Object.md]()**

-   **[$psISE.CurrentVisibleHorizontalTool.IsVisibleThe-ISEAddOnTool-Object.md]()**

-   **[$psISE.CurrentVisibleHorizontalTool.NameThe-ISEAddOnTool-Object.md]()**

##  **$psISE.CurrentVisibleVerticalTool**
 The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the [ISEAddOnTool](The-ISEAddOnTool-Object.md) class. It represents the installed add-on tool that is currently docked to the right-hand edge of the Windows PowerShell ISE window. This object makes the following objects available for scripting:

-   **[$psISE.CurrentVisibleHorizontalTool.ControlThe-ISEAddOnTool-Object.md]()**

-   **[$psISE.CurrentVisibleHorizontalTool.IsVisibleThe-ISEAddOnTool-Object.md]()**

-   **[$psISE.CurrentVisibleHorizontalTool.NameThe-ISEAddOnTool-Object.md]()**

##  **$psISE.Options**
 The **$psISE.Options** object makes the following objects available for scripting:

-   **[$psISE.Options.AutoSaveMinuteIntervalThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ConsolePaneBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ConsolePaneTextForegroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ConsolePaneTextBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ConsoleTokenColorsThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.DebugBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.DebugForegroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.DefaultOptions](The-ISEOptions-Object.md)**

-   **[$psISE.Options.ErrorBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ErrorForegroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.FontNameThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.FontsizeThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.IntellisenseTimeoutInSecondsThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.MRUCountThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ScriptPaneBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ScriptPaneForegroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.SelectedScriptPaneStateThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowDefaultSnippetsThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowIntellisenseInConsolePaneThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowIntellisenseInScriptPaneThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowLineNumbersThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowOutliningThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowToolBarThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowWarningBeforeSavingOnRunThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ShowWarningForDuplicateFilesThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.TokenColorsThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.UseEnterToSelectConsolePaneIntellisenseThe-ISEOptions-Object.md]()**

-   **[$psISE.Options. UseEnterToSelectScriptPaneIntellisenseThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.UseLocalHelpThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.VerboseBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.VerboseForegroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.WarningBackgroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.WarningForegroundColorThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.XmlTokenColorsThe-ISEOptions-Object.md]()**

-   **[$psISE.Options.ZoomThe-ISEOptions-Object.md]()**

##  **[$psISE.PowerShellTabs](The-PowerShellTabCollection-Object.md)**
 The **$psISE.PowerShellTabs** object is an instance of the [PowerShellTabCollection](The-PowerShellTabCollection-Object.md) class. It is a collection of all the currently open PowerShell tabs that represent the available Windows PowerShell run environments on the local computer or on connected remote computers. Each member in the collection is an instance of the [PowerShellTab](The-PowerShellTab-Object.md) class.

## See Also
- [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md)

