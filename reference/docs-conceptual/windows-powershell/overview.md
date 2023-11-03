---
description: This article explains the difference between Windows PowerShell and PowerShell.
ms.date: 11/03/2023
ms.topic: conceptual
title: What is Windows PowerShell?
---
# What is Windows PowerShell?

Windows PowerShell and PowerShell are two separate products.

_Windows PowerShell_ is the version of PowerShell that ships in Windows. This version of PowerShell
uses the full .NET Framework, which only runs on Windows. The latest version is Windows PowerShell
5.1. Microsoft is no longer updating Windows PowerShell with new features. Support for Windows
PowerShell is tied to the version of Windows you are using.

_PowerShell_ is built on the new versions of .NET instead of the .NET Framework and runs on Windows,
Linux, and macOS. Support for PowerShell is based on the version of .NET that it was built on. For
more information about the support lifecycle for PowerShell, see the
[PowerShell support lifecycle][01] documentation.

## Further reading

- For a more detailed explanation of the differences between Windows PowerShell and PowerShell, see
  [Differences between Windows PowerShell 5.1 and PowerShell 7.x][02].
- For information about migrating from Windows PowerShell to PowerShell, see
  [Migrating from Windows PowerShell 5.1 to PowerShell 7][03].
- For more information about previous versions of Windows PowerShell, see
  [Previous versions of PowerShell][04].

<!-- link references -->
[01]: ../install/PowerShell-Support-Lifecycle.md
[02]: ../whats-new/differences-from-windows-powershell.md
[03]: ../whats-new/Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[04]: /previous-versions/powershell/scripting/overview
