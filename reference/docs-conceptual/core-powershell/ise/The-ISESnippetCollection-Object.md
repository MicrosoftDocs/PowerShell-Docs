---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  The ISESnippetCollection Object
ms.assetid:  ae974955-4282-4cbc-8c42-0fff1904ef32
---
# The ISESnippetCollection Object

The **ISESnippetCollection** object is a collection of **ISESnippet** objects. The files collection that is associated with a **PowerShellTab** object is a member of this class. An example is the **$psISE.CurrentPowerShellTab.Files** collection.

## Methods

### Load\( FilePathName \)

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

Loads a .snippets.ps1xml file that contains user-defined snippets. The easiest way to create snippets is to use the New-IseSnippet cmdlet, which automatically stores them in your profile folder so that they are loaded every time that you start Windows PowerShell ISE.

**FilePathName** - String
The path and file name to a .snippets.ps1xml file that contains snippet definitions.

```powershell
# Loads a custom snippet file into the current PowerShell tab.
$SnipFile = Join-Path ( Split-Path $profile) 'Snippets\MySnips.snippets.ps1xml' $psISE.CurrentPowerShellTab.Snippets.Add($SnipPath)
```

## See Also

- [The ISESnippetObject](The-ISESnippetObject.md)
- [Purpose of the Windows PowerShell ISE Scripting Object Model](Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)