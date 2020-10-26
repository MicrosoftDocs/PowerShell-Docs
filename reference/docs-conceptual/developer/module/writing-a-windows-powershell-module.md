---
ms.date: 09/13/2016
ms.topic: reference
title: Writing a Windows PowerShell Module
description: Writing a Windows PowerShell Module
---
# Writing a Windows PowerShell Module

This document is written for administrators, script developers, and cmdlet developers who need to package and distribute their Windows PowerShell cmdlets. By using Windows PowerShell modules, you can package and distribute your Windows PowerShell solutions without using a compiled language.

Windows PowerShell modules enable you to partition, organize, and abstract your Windows PowerShell code into self-contained, reusable units. With these reusable units, you can easily share your modules directly with others. If you are a script developer, you can also repackage third-party modules to create custom script-based applications. Modules, similar to modules in other scripting languages such as Perl and Python, enable production-ready scripting solutions that use reusable, redistributable components, with the added benefit of enabling you to repackage and abstract multiple components to create custom solutions.

At their most basic, Windows PowerShell will treat any valid Windows PowerShell script code saved in a .psm1 file as a module. PowerShell will also automatically treat any binary cmdlet assembly as a module. However, you can also use a module (or more specifically, a module manifest) to bundle an entire solution together. The following scenarios describe typical uses for Windows PowerShell modules.

### Libraries

Modules can be used to package and distribute cohesive libraries of functions that perform common tasks. Typically, the names of these functions share one or more nouns that reflect the common task that they are used for. These functions can also be similar to .NET Framework classes in that they can have public and private members. For example, a library can contain a set of functions for file transfers. In this case, the noun reflecting the common task might be "file."

### Configuration

Modules can be used to customize your environment by adding specific cmdlets, providers, functions, and variables.

### Compiled Code Development and Distribution

Cmdlet and provider developers can use modules to test and distribute their compiled code without needing to create snap-ins. They can import the assembly that contains the compiled code as a module (a binary module) without needing to create and register snap-ins.

## See Also

[Understanding a Windows PowerShell Module](./understanding-a-windows-powershell-module.md)

[How to Write a PowerShell Script Module](./how-to-write-a-powershell-script-module.md)

[How to Write a PowerShell Binary Module](./how-to-write-a-powershell-binary-module.md)

[How to Write a PowerShell Module Manifest](how-to-write-a-powershell-module-manifest.md)

[Modifying the PSModulePath Installation Path](./modifying-the-psmodulepath-installation-path.md)

[Importing a PowerShell Module](./importing-a-powershell-module.md)

[Installing a PowerShell Module](./installing-a-powershell-module.md)
