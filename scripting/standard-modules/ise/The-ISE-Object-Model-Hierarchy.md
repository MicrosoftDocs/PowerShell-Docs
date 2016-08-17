---
title:  The ISE Object Model Hierarchy
ms.date:  2016-05-11
keywords:  powershell,cmdlet
description:  
ms.topic:  article
author:  jpjofre
manager:  dongill
ms.prod:  powershell
ms.assetid:  bc3300e4-9c17-4f00-a621-c8867126e3b3
---

# The ISE Object Model Hierarchy
  This topic shows the hierarchy of objects that are part of Windows PowerShell Integrated Scripting Environment (ISE). Windows PowerShell ISE is included in Windows PowerShell 3.0 and in Windows PowerShell 4.0. Click an object to take you to the reference documentation for the class that defines the object.

##  <a name="psISE"></a> **$psISE Object**
 The **$psISE** object is the [root object](The-ObjectModelRoot-Object.md) of the Windows PowerShell ISE object hierarchy. Located at the top level, it makes the following objects available for scripting:

-   **[$psISE.CurrentFile](#currentfile)**

-   **[$psISE.CurrentPowerShellTab](#currentpowershelltab)**

-   **[$psISE.CurrentVisibleHorizontalTool](#CurrentVisibleHorizontalTool)**

-   **[$psISE.CurrentVisibleVerticalTool](#CurrentVisibleVerticalTool)**

-   **[$psISE.Options](#options)**

-   **[$psISE.PowerShellTabs](#powershelltabs)**

##  <a name="CurrentFile"></a> **[$psISE.CurrentFile](The-ISEFile-Object.md)**
 The **$psISE.CurrentFile** object is an instance of the [ISEFile](The-ISEFile-Object.md) class and makes the following objects available for scripting:

-   **[$psISE.CurrentFile.DisplayName](The-ISEFile-Object.md#Displayname)**

-   **[$psISE.CurrentFile.Editor](The-ISEEditor-Object.md)**  This object is an instance of the [ISEEditor](The-ISEEditor-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentFile.Editor.CanGoToMatch](The-ISEEditor-Object.md#cangotomatch)**

    -   **[CaretColumn](The-ISEEditor-Object.md#CaretColumn)**

    -   **[CaretLine](The-ISEEditor-Object.md#CaretLine)**

    -   **[$psISE.CurrentFile.Editor.CaretLineText](The-ISEEditor-Object.md#CaretLineText)**

    -   **[LineCount](The-ISEEditor-Object.md#LineCount)**

    -   **[SelectedText](The-ISEEditor-Object.md#SelectedText)**

    -   **[Text](The-ISEEditor-Object.md#Text)**

-   **[Encoding](The-ISEFile-Object.md#Encoding)**

-   **[FullPath](The-ISEFile-Object.md#FullPath)**

-   **[IsSaved](The-ISEFile-Object.md#IsSaved)**

-   **[IsUntitled](The-ISEFile-Object.md#IsUntitled)**

##  <a name="CurrentPowerShellTab"></a> **[$psISE.CurrentPowerShellTab](The-PowerShellTab-Object.md)**
 The **$psISE.CurrentPowerShellTab** object is an instance of the [PowerShellTab](The-PowerShellTab-Object.md) class and makes the following objects available for scripting:

-   **[$psISE.CurrentPowerShellTab.AddOnsMenu](The-ISEMenuItem-Object.md)**  This object is an instance of the [ISEMenuItem](The-ISEMenuItem-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Action](The-ISEMenuItem-Object.md#Action)**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.DisplayName](The-ISEMenuItem-Object.md#DisplayName)**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Shortcut](The-ISEMenuItem-Object.md#Shortcut)**

    -   **[$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus](The-ISEMenuItemCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.CanInvoke](The-PowerShellTab-Object.md#CanExecute)**

-   **[$psISE.CurrentPowerShellTab.ConsolePane](The-ISEEditor-Object.md)**  This object is an instance of the [ISEEditor](The-ISEEditor-Object.md) class and makes the following objects available for scripting:

    -   **[$psISE.CurrentPowerShellTab.ConsolePane.CanGoToMatch](The-ISEEditor-Object.md#cangotomatch)**

    -   **[CaretColumn](The-ISEEditor-Object.md#CaretColumn)**

    -   **[CaretLine](The-ISEEditor-Object.md#CaretLine)**

    -   **[$psISE.CurrentPowerShellTab.ConsolePane.CaretLineText](The-ISEEditor-Object.md#CaretLineText)**

    -   **[LineCount](The-ISEEditor-Object.md#LineCount)**

    -   **[SelectedText](The-ISEEditor-Object.md#SelectedText)**

    -   **[Text](The-ISEEditor-Object.md#Text)**

-   **[$psISE.CurrentPowerShellTab.DisplayName](The-PowerShellTab-Object.md#Displayname)**

-   **[$psISE.CurrentPowerShellTab.ExpandedScript](The-PowerShellTab-Object.md#ExpandedScript)**

-   **[$psISE.CurrentPowerShellTab.Files](The-ISEFileCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.HorizontalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.HorizontalAddOnToolsPaneOpened](The-PowerShellTab-Object.md#HorizontalAddOnToolsPaneOpened)**

-   **[$psISE.CurrentPowerShellTab.Prompt](The-PowerShellTab-Object.md#Prompt)**

-   **[$psISE.CurrentPowerShellTab.ShowCommands](The-PowerShellTab-Object.md#ShowCommands)**

-   **[$psISE.CurrentPowerShellTab.Snippets](The-ISESnippetCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.StatusText](The-PowerShellTab-Object.md#StatusText)**

-   **[$psISE.CurrentPowerShellTab.VerticalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.VerticalAddOnToolsPaneOpened](The-PowerShellTab-Object.md#VerticalAddOnToolsPaneOpened)**

-   **[$psISE.CurrentPowerShellTab.VisibleHorizontalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

-   **[$psISE.CurrentPowerShellTab.VisibleVerticalAddOnTools](The-ISEAddOnToolCollection-Object.md)**

##  <a name="CurrentVisibleHorizontalTool"></a> **$psISE.CurrentVisibleHorizontalTool**
 The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the [ISEAddOnTool](The-ISEAddOnTool-Object.md) class. It represents the installed add\-on tool that is currently docked to the top edge of the Windows PowerShell ISE window. This object makes the following objects available for scripting:

-   **[$psISE.CurrentVisibleHorizontalTool.Control](The-ISEAddOnTool-Object.md#control)**

-   **[$psISE.CurrentVisibleHorizontalTool.IsVisible](The-ISEAddOnTool-Object.md#isvisible)**

-   **[$psISE.CurrentVisibleHorizontalTool.Name](The-ISEAddOnTool-Object.md#name)**

##  <a name="CurrentVisibleVerticalTool"></a> **$psISE.CurrentVisibleVerticalTool**
 The **$psISE.CurrentVisibleHorizontalTool** object is an instance of the [ISEAddOnTool](The-ISEAddOnTool-Object.md) class. It represents the installed add\-on tool that is currently docked to the right\-hand edge of the Windows PowerShell ISE window. This object makes the following objects available for scripting:

-   **[$psISE.CurrentVisibleHorizontalTool.Control](The-ISEAddOnTool-Object.md#control)**

-   **[$psISE.CurrentVisibleHorizontalTool.IsVisible](The-ISEAddOnTool-Object.md#isvisible)**

-   **[$psISE.CurrentVisibleHorizontalTool.Name](The-ISEAddOnTool-Object.md#name)**

##  <a name="Options"></a> **$psISE.Options**
 The **$psISE.Options** object makes the following objects available for scripting:

-   **[$psISE.Options.AutoSaveMinuteInterval](The-ISEOptions-Object.md#asmi)**

-   **[$psISE.Options.ConsolePaneBackgroundColor](The-ISEOptions-Object.md#cpbc)**

-   **[$psISE.Options.ConsolePaneTextForegroundColor](The-ISEOptions-Object.md#conpfc)**

-   **[$psISE.Options.ConsolePaneTextBackgroundColor](The-ISEOptions-Object.md#conptbc)**

-   **[$psISE.Options.ConsoleTokenColors](The-ISEOptions-Object.md#contc)**

-   **[$psISE.Options.DebugBackgroundColor](The-ISEOptions-Object.md#dbc)**

-   **[$psISE.Options.DebugForegroundColor](The-ISEOptions-Object.md#dfc)**

-   **[$psISE.Options.DefaultOptions](The-ISEOptions-Object.md)**

-   **[$psISE.Options.ErrorBackgroundColor](The-ISEOptions-Object.md#ebc)**

-   **[$psISE.Options.ErrorForegroundColor](The-ISEOptions-Object.md#efc)**

-   **[$psISE.Options.FontName](The-ISEOptions-Object.md#fn)**

-   **[$psISE.Options.Fontsize](The-ISEOptions-Object.md#fs)**

-   **[$psISE.Options.IntellisenseTimeoutInSeconds](The-ISEOptions-Object.md#itis)**

-   **[$psISE.Options.MRUCount](The-ISEOptions-Object.md#mc)**

-   **[$psISE.Options.ScriptPaneBackgroundColor](The-ISEOptions-Object.md#spbc)**

-   **[$psISE.Options.ScriptPaneForegroundColor](The-ISEOptions-Object.md#spfc)**

-   **[$psISE.Options.SelectedScriptPaneState](The-ISEOptions-Object.md#ssps)**

-   **[$psISE.Options.ShowDefaultSnippets](The-ISEOptions-Object.md#sds)**

-   **[$psISE.Options.ShowIntellisenseInConsolePane](The-ISEOptions-Object.md#siicp)**

-   **[$psISE.Options.ShowIntellisenseInScriptPane](The-ISEOptions-Object.md#siisp)**

-   **[$psISE.Options.ShowLineNumbers](The-ISEOptions-Object.md#sln)**

-   **[$psISE.Options.ShowOutlining](The-ISEOptions-Object.md#so)**

-   **[$psISE.Options.ShowToolBar](The-ISEOptions-Object.md#stb)**

-   **[$psISE.Options.ShowWarningBeforeSavingOnRun](The-ISEOptions-Object.md#swbsor)**

-   **[$psISE.Options.ShowWarningForDuplicateFiles](The-ISEOptions-Object.md#swfdf)**

-   **[$psISE.Options.TokenColors](The-ISEOptions-Object.md#tc)**

-   **[$psISE.Options.UseEnterToSelectConsolePaneIntellisense](The-ISEOptions-Object.md#uetsicpi)**

-   **[$psISE.Options. UseEnterToSelectScriptPaneIntellisense](The-ISEOptions-Object.md#uetsispi)**

-   **[$psISE.Options.UseLocalHelp](The-ISEOptions-Object.md#ulh)**

-   **[$psISE.Options.VerboseBackgroundColor](The-ISEOptions-Object.md#vbc)**

-   **[$psISE.Options.VerboseForegroundColor](The-ISEOptions-Object.md#vfc)**

-   **[$psISE.Options.WarningBackgroundColor](The-ISEOptions-Object.md#wbc)**

-   **[$psISE.Options.WarningForegroundColor](The-ISEOptions-Object.md#wfc)**

-   **[$psISE.Options.XmlTokenColors](The-ISEOptions-Object.md#xtc)**

-   **[$psISE.Options.Zoom](The-ISEOptions-Object.md#z)**

##  <a name="PowerShellTabs"></a> **[$psISE.PowerShellTabs](The-PowerShellTabCollection-Object.md)**
 The **$psISE.PowerShellTabs** object is an instance of the [PowerShellTabCollection](The-PowerShellTabCollection-Object.md) class. It is a collection of all the currently open PowerShell tabs that represent the available Windows PowerShell run environments on the local computer or on connected remote computers. Each member in the collection is an instance of the [PowerShellTab](The-PowerShellTab-Object.md) class.

## See Also
 [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md)
 [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md)

