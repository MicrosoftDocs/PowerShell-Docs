---
ms.date:  10/20/2019
keywords:  powershell,cmdlet
title:  How to use the PowerShell documentation
---
# How to use the PowerShell documentation

Welcome to the PowerShell online documentation. This site contains cmdlet reference for the
following versions of PowerShell:

- PowerShell 7 (preview)
- PowerShell 6
- PowerShell 5.1

## Finding articles and selecting a version

There are two ways to search for content in Docs. The simplest way is to use the filter box under
the version selector. Just enter a word that appears in the title of an article. The page displays
a list of matching articles. You can also select the option to search the entire site from that
list.

By default, this site displays documentation for the latest released version of PowerShell. Some
cmdlets work differently in various versions of PowerShell. Be sure you are viewing the
documentation for the version of PowerShell you are using.

Use the version picker at the top of the page to select the version of PowerShell you want.

![version picker](media/how-to-use-docs/version-search.gif)

You can verify the version of PowerShell you are using by inspecting the `$PSversionTable.PSVersion`
value. The following example shows the output for Windows PowerShell v5.1.

```powershell
$PSVersionTable.PSVersion
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      18362  145
```
