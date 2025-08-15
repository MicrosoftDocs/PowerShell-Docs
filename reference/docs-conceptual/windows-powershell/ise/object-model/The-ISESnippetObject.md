---
description: An ISESnippet object is an instance of the Microsoft.PowerShell.Host.ISE.ISESnippet class.
ms.date: 03/27/2025
title: The ISESnippetObject
---

# The ISESnippetObject

An **ISESnippet** object is an instance of the Microsoft.PowerShell.Host.ISE.ISESnippet class. The
members of the `$psISE.CurrentPowerShellTab.Snippets` collection are all examples of **ISESnippet**
objects. The easiest way to create a snippet is to use the [New-IseSnippet][01] cmdlet.

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

- [The ISESnippetCollection Object][04]
- [Purpose of the Windows PowerShell ISE Scripting Object Model][02]
- [The ISE Object Model Hierarchy][03]

<!-- link references -->
[01]: /powershell/module/ISE/New-IseSnippet
[02]: purpose-of-the-windows-powershell-ise-scripting-object-model.md
[03]: The-ISE-Object-Model-Hierarchy.md
[04]: The-ISESnippetCollection-Object.md
