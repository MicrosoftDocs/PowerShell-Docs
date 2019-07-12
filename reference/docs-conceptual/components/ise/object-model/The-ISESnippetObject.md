---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  The ISESnippetObject
---
# The ISESnippetObject

An **ISESnippet** object is an instance of the Microsoft.PowerShell.Host.ISE.ISESnippet class. The members of the **$psISE.CurrentPowerShellTab.Snippets** collection are all examples of **ISESnippet** objects. The easiest way to create a snippet is to use the [New-IseSnippet&#91;PSITPro5_ISE&#93;](https://technet.microsoft.com/library/0a6339a3-2683-4a8e-8929-90ad9a95c3e0) cmdlet.

## Properties

### Author

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

The read-only property that gets the name of the author of the snippet.

```powershell
# Get the author of the first snippet item
$psISE.CurrentPowerShellTab.Snippets.Item(0).Author
```

### CodeFragment

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

The read-only property that gets the code fragment to be inserted into the editor.

```powershell
# Get the code fragment associated with the first snippet item.
$psISE.CurrentPowerShellTab.Snippets.Item(0).CodeFragment
```

### Shortcut

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

The read-only property that gets the Windows keyboard shortcut for the menu item.

```powershell
# Get the shortcut for the first submenu item.
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Clear()
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('_Process', {Get-Process}, 'Alt+P')
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus[0].Shortcut
```

## See Also

- [The ISESnippetCollection Object](The-ISESnippetCollection-Object.md)
- [Purpose of the Windows PowerShell ISE Scripting Object Model](purpose-of-the-windows-powershell-ise-scripting-object-model.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
