---
ms.date: 09/13/2016
ms.topic: reference
title: Modules and Snap-ins
description: Modules and Snap-ins
---
# Modules and Snap-ins

Cmdlets can be added to a session using modules (introduced by Windows PowerShell 2.0) or snap-ins. Once the cmdlet is added to the session it can be run programmatically by a host application or interactively at the command line.

We recommend that you use modules as the delivery method for adding cmdlets to a session for the following reasons:

- Modules allow you to add cmdlets by loading the assembly where the cmdlet is defined. There is no need to implement a snap-in class.

- Modules allow you to add other resources, such as variables, functions, scripts, types and formatting files, and more.

- Snap-ins can be used only to add cmdlets and providers to the session.

## See Also

[Writing a Windows PowerShell Module](writing-a-windows-powershell-module.md)

[Writing a Windows PowerShell Cmdlet](../cmdlet/cmdlet-overview.md)
