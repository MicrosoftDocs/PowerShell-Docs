---
title: The ISE Object Model Hierarchy
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bc3300e4-9c17-4f00-a621-c8867126e3b3
---
# The ISE Object Model Hierarchy
  This topic shows the hierarchy of objects that are part of Windows PowerShell Integrated Scripting Environment (ISE). Windows PowerShell ISE is included in Windows PowerShell 3.0 and in Windows PowerShell 4.0. Click an object to take you to the reference documentation for the class that defines the object.

##  <a name="psISE"></a> **$psISE Object**
 The **$psISE** object is the [root object](../Topic/The-ObjectModelRoot-Object.md) of the Windows PowerShell ISE object hierarchy. Located at the top level, it makes the following objects available for scripting:

-   **[$psISE.CurrentFile](#currentfile)**

-   **[$psISE.CurrentPowerShellTab](#currentpowershelltab)**

-   **[$psISE.CurrentVisibleHorizontalTool](#CurrentVisibleHorizontalTool)**

-   **[$psISE.CurrentVisibleVerticalTool](#CurrentVisibleVerticalTool)**

-   **[$psISE.Options](#options)**

-   **[$psISE.PowerShellTabs](#powershelltabs)**

##  <a name="CurrentFile"></a> **[$psISE.CurrentFile](../Topic/The-ISEFile-Object.md)**
 The **$psISE.CurrentFile** object is an instance of the [ISEFile](../Topic/The-ISEFile-Object.md) class and makes the following objects available for scripting:

-   **[$psISE.CurrentFile.DisplayName](../Topic/The-ISEFile-Object.md#Displayname)**

-   **[$psISE.CurrentFile.Editor](../Topic/The-ISEEditor-Object.md)**  This object is an instance of the [ISEEditor](../Topic/The-ISEEditor-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentFile.Editor.CanGoToMatch](../Topic/The-ISEEditor-Object.md#cangotomatch)**

    -   **[CaretColumn](../Topic/The-ISEEditor-Object.md#CaretColumn)**

    -   **[CaretLine](../Topic/The-ISEEditor-Object.md#CaretLine)**

    -   **[$psISE.CurrentFile.Editor.CaretLineText](../Topic/The-ISEEditor-Object.md#CaretLineText)**

    -   **[LineCount](../Topic/The-ISEEditor-Object.md#LineCount)**

    -   **[SelectedText](../Topic/The-ISEEditor-Object.md#SelectedText)**

    -   **[Text](../Topic/The-ISEEditor-Object.md#Text)**

-   **[Encoding](../Topic/The-ISEFile-Object.md#Encoding)**

-   **[FullPath](../Topic/The-ISEFile-Object.md#FullPath)**

-   **[$psISE.CurrentFile.IsRecovered](../Topic/The-ISEFile-Object.md#IsRecovered)**

-   **[IsSaved](../Topic/The-ISEFile-Object.md#IsSaved)**

-   **[IsUntitled](../Topic/The-ISEFile-Object.md#IsUntitled)**

##  <a name="CurrentPowerShellTab"></a> **[$psISE.CurrentPowerShellTab](../Topic/The-PowerShellTab-Object.md)**
 The **$psISE.CurrentPowerShellTab** object is an instance of the [PowerShellTab](../Topic/The-PowerShellTab-Object.md) class and makes the following objects available for scripting:

-   **[$psISE.CurrentPowerShellTab.AddOnsMenu](../Topic/The-ISEMenuItem-Object.md)**  This object is an instance of the [ISEMenuItem](../Topic/The-ISEMenuItem-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Action](../Topic/The-ISEMenuItem-Object.md#Action)**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.DisplayName](../Topic/The-ISEMenuItem-Object.md#DisplayName)**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Shortcut](../Topic/The-ISEMenuItem-Object.md#Shortcut)**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus](../Topic/The-ISEMenuItemCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.CanInvoke](../Topic/The-PowerShellTab-Object.md#CanExecute)**

-   **[$psISE.CurrentPowerShellTab.ConsolePane](../Topic/The-ISEEditor-Object.md)**  This object is an instance of the [ISEEditor](../Topic/The-ISEEditor-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentPowerShellTab.ConsolePane.CanGoToMatch](../Topic/The-ISEEditor-Object.md#cangotomatch)**

    -   **[CaretColumn](../Topic/The-ISEEditor-Object.md#CaretColumn)**

    -   **[CaretLine](../Topic/The-ISEEditor-Object.md#CaretLine)**

    -   **[$psISE.CurrentPowerShellTab.ConsolePane.CaretLineText](../Topic/The-ISEEditor-Object.md#CaretLineText)**

    -   **[LineCount](../Topic/The-ISEEditor-Object.md#LineCount)**

    -   **[SelectedText](../Topic/The-ISEEditor-Object.md#SelectedText)**

    -   **[Text](../Topic/The-ISEEditor-Object.md#Text)**

-   **[$psISE.CurrentPowerShellTab.DisplayName](../Topic/The-PowerShellTab-Object.md#Displayname)**

-   **[$psISE.CurrentPowerShellTab.ExpandedScript](../Topic/The-PowerShellTab-Object.md#ExpandedScript)**

-   **[$psISE.CurrentPowerShellTab.Files](../Topic/The-ISEFileCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.HorizontalAddOnTools](../Topic/The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.HorizontalAddOnToolsPaneOpened](../Topic/The-PowerShellTab-Object.md#HorizontalAddOnToolsPaneOpened)**

-   **[$psISE.CurrentPowerShellTab.Prompt](../Topic/The-PowerShellTab-Object.md#Prompt)**

-   **[$psISE.CurrentPowerShellTab.ShowCommands](../Topic/The-PowerShellTab-Object.md#ShowCommands)**

-   **[$psISE.CurrentPowerShellTab.Snippets](../Topic/The-ISESnippetCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.StatusText](../Topic/The-PowerShellTab-Object.md#StatusText)**

-   **[$psISE.CurrentPowerShellTab.VerticalAddOnTools](../Topic/The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.VerticalAddOnToolsPaneOpened](../Topic/The-PowerShellTab-Object.md#VerticalAddOnToolsPaneOpened)**

-   **[$psISE.CurrentPowerShellTab.VisibleHorizontalAddOnTools](../Topic/The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.VisibleVerticalAddOnTools](../Topic/The-ISEAddOnToolCollection-Object.md)**

##  <a name="CurrentVisibleHorizontalTool"></a> **$psISE.CurrentVisibleHorizontalTool**
 The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the [ISEAddOnTool](../Topic/The-ISEAddOnTool-Object.md) class. It represents the installed add\-on tool that is currently docked to the top edge of the Windows PowerShell ISE window. This object makes the following objects available for scripting:

-   **[$psISE.CurrentVisibleHorizontalTool.Control](../Topic/The-ISEAddOnTool-Object.md#control)**

-   **[$psISE.CurrentVisibleHorizontalTool.IsVisible](../Topic/The-ISEAddOnTool-Object.md#isvisible)**

-   **[$psISE.CurrentVisibleHorizontalTool.Name](../Topic/The-ISEAddOnTool-Object.md#name)**

##  <a name="CurrentVisibleVerticalTool"></a> **$psISE.CurrentVisibleVerticalTool**
 The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the [ISEAddOnTool](../Topic/The-ISEAddOnTool-Object.md) class. It represents the installed add\-on tool that is currently docked to the right\-hand edge of the Windows PowerShell ISE window. This object makes the following objects available for scripting:

-   **[$psISE.CurrentVisibleHorizontalTool.Control](../Topic/The-ISEAddOnTool-Object.md#control)**

-   **[$psISE.CurrentVisibleHorizontalTool.IsVisible](../Topic/The-ISEAddOnTool-Object.md#isvisible)**

-   **[$psISE.CurrentVisibleHorizontalTool.Name](../Topic/The-ISEAddOnTool-Object.md#name)**

##  <a name="Options"></a> **$psISE.Options**
 The **$psISE.Options** object makes the following objects available for scripting:

-   **[$psISE.Options.AutoSaveMinuteInterval](../Topic/The-ISEOptions-Object.md#asmi)**

-   **[$psISE.Options.ConsolePaneBackgroundColor](../Topic/The-ISEOptions-Object.md#cpbc)**

-   **[$psISE.Options.ConsolePaneTextForegroundColor](../Topic/The-ISEOptions-Object.md#cptfc)**

-   **[$psISE.Options.ConsolePaneTextBackgroundColor](../Topic/The-ISEOptions-Object.md#cptbc)**

-   **[$psISE.Options.ConsoleTokenColors](../Topic/The-ISEOptions-Object.md#ctc)**

-   **[$psISE.Options.DebugBackgroundColor](../Topic/The-ISEOptions-Object.md#dbc)**

-   **[$psISE.Options.DebugForegroundColor](../Topic/The-ISEOptions-Object.md#dfc)**

-   **[$psISE.Options.DefaultOptions](../Topic/The-ISEOptions-Object.md)**

-   **[$psISE.Options.ErrorBackgroundColor](../Topic/The-ISEOptions-Object.md#ebc)**

-   **[$psISE.Options.ErrorForegroundColor](../Topic/The-ISEOptions-Object.md#efc)**

-   **[$psISE.Options.FontName](../Topic/The-ISEOptions-Object.md#fn)**

-   **[$psISE.Options.Fontsize](../Topic/The-ISEOptions-Object.md#fs)**

-   **[$psISE.Options.IntellisenseTimeoutInSeconds](../Topic/The-ISEOptions-Object.md#itis)**

-   **[$psISE.Options.MRUCount](../Topic/The-ISEOptions-Object.md#mc)**

-   **[$psISE.Options.ScriptPaneBackgroundColor](../Topic/The-ISEOptions-Object.md#spbc)**

-   **[$psISE.Options.ScriptPaneForegroundColor](../Topic/The-ISEOptions-Object.md#spfc)**

-   **[$psISE.Options.SelectedScriptPaneState](../Topic/The-ISEOptions-Object.md#ssps)**

-   **[$psISE.Options.ShowDefaultSnippets](../Topic/The-ISEOptions-Object.md#sds)**

-   **[$psISE.Options.ShowIntellisenseInConsolePane](../Topic/The-ISEOptions-Object.md#siicp)**

-   **[$psISE.Options.ShowIntellisenseInScriptPane](../Topic/The-ISEOptions-Object.md#siisp)**

-   **[$psISE.Options.ShowLineNumbers](../Topic/The-ISEOptions-Object.md#sln)**

-   **[$psISE.Options.ShowOutlining](../Topic/The-ISEOptions-Object.md#so)**

-   **[$psISE.Options.ShowToolBar](../Topic/The-ISEOptions-Object.md#stb)**

-   **[$psISE.Options.ShowWarningBeforeSavingOnRun](../Topic/The-ISEOptions-Object.md#swbsor)**

-   **[$psISE.Options.ShowWarningForDuplicateFiles](../Topic/The-ISEOptions-Object.md#swfdf)**

-   **[$psISE.Options.TokenColors](../Topic/The-ISEOptions-Object.md#tc)**

-   **[$psISE.Options.UseEnterToSelectConsolePaneIntellisense](../Topic/The-ISEOptions-Object.md#uetscpi)**

-   **[$psISE.Options. UseEnterToSelectScriptPaneIntellisense](../Topic/The-ISEOptions-Object.md#uetsspi)**

-   **[$psISE.Options.UseLocalHelp](../Topic/The-ISEOptions-Object.md#ulh)**

-   **[$psISE.Options.VerboseBackgroundColor](../Topic/The-ISEOptions-Object.md#vbc)**

-   **[$psISE.Options.VerboseForegroundColor](../Topic/The-ISEOptions-Object.md#vfc)**

-   **[$psISE.Options.WarningBackgroundColor](../Topic/The-ISEOptions-Object.md#wbc)**

-   **[$psISE.Options.WarningForegroundColor](../Topic/The-ISEOptions-Object.md#wfc)**

-   **[$psISE.Options.XmlTokenColors](../Topic/The-ISEOptions-Object.md#xtc)**

-   **[$psISE.Options.Zoom](../Topic/The-ISEOptions-Object.md#z)**

##  <a name="PowerShellTabs"></a> **[$psISE.PowerShellTabs](../Topic/The-PowerShellTabCollection-Object.md)**
 The **$psISE.PowerShellTabs** object is an instance of the [PowerShellTabCollection](../Topic/The-PowerShellTabCollection-Object.md) class. It is a collection of all the currently open PowerShell tabs that represent the available Windows PowerShell run environments on the local computer or on connected remote computers. Each member in the collection is an instance of the [PowerShellTab](../Topic/The-PowerShellTab-Object.md) class.

## See Also
 [The Windows PowerShell ISE Scripting Object Model](../Topic/The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
 [Windows PowerShell ISE Object Model Reference](../Topic/Windows-PowerShell-ISE-Object-Model-Reference.md)

  
