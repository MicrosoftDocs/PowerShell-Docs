---
description: The ISESnippetCollection object is a collection of ISESnippet objects. The files collection that's associated with a PowerShellTab object is a member of this class.
ms.date: 03/27/2025
title: The ISESnippetCollection Object
---

# The ISESnippetCollection Object

The **ISESnippetCollection** object is a collection of **ISESnippet** objects. The files collection
that's associated with a **PowerShellTab** object is a member of this class. An example is the
`$psISE.CurrentPowerShellTab.Files` collection.

## Methods

### `Load( FilePathName )`

Supported in Windows PowerShell ISE 3.0 and later, and not present in earlier versions.

Loads a `snippets.ps1xml` file that contains user-defined snippets. The easiest way to create
snippets is to use the `New-IseSnippet` cmdlet, which automatically stores them in your profile
folder so that they're loaded every time that you start Windows PowerShell ISE.

- **FilePathName** - String - The path and file name to a `snippets.ps1xml` file that contains
  snippet definitions.

```powershell
# Loads a custom snippet file into the current PowerShell tab.
$joinPathSplat = @{
    Path = ( Split-Path $PROFILE)
    ChildPath = 'Snippets\MySnips.snippets.ps1xml'
    AdditionalChildPath = $psISE.CurrentPowerShellTab.Snippets.Add($SnipPath)
}
$SnipFile = Join-Path @joinPathSplat
```

## See Also

- [The ISESnippetObject][03]
- [Purpose of the Windows PowerShell ISE Scripting Object Model][01]
- [The ISE Object Model Hierarchy][02]

<!-- link references -->
[01]: Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md
[02]: The-ISE-Object-Model-Hierarchy.md
[03]: The-ISESnippetObject.md
