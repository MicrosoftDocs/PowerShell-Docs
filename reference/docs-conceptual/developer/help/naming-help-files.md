---
ms.date: 09/12/2016
ms.topic: reference
title: Naming Help Files
description: Naming Help Files
---
# Naming Help Files

This topic explains how to name an XML-based help file so that the
[Get-Help](/powershell/module/Microsoft.PowerShell.Core/Get-Help) cmdlet can find it. The name
requirements differ for each command type.

## Cmdlet Help Files

The help file for a C# cmdlet must be named for the assembly in which the cmdlet is defined. Use the
following filename format:

```
<AssemblyName>.dll-help.xml
```

The assembly name format is required even when the assembly is a nested module.

For example, the [Get-WinEvent](/powershell/module/Microsoft.PowerShell.Diagnostics/Get-WinEvent)
cmdlet is defined in the Microsoft.PowerShell.Diagnostics.dll assembly. The `Get-Help` cmdlet looks
for a help topic for the `Get-WinEvent` cmdlet only in the
`Microsoft.PowerShell.Diagnostics.dll-help.xml` file in the module directory.

## Provider Help files

The help file for a PowerShell provider must be named for the assembly in which the provider is
defined. Use the following filename format:

`<AssemblyName>.dll-help.xml`

The assembly name format is required even when the assembly is a nested module.

For example, the Certificate provider is defined in the `Microsoft.PowerShell.Security.dll`
assembly. The `Get-Help` cmdlet looks for a help topic for the Certificate provider only in the
`Microsoft.PowerShell.Security.dll-help.xml` file in the module directory.

## Function Help Files

Functions can be documented by using
[comment-based help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help) or
documented in an XML help file. When the function is documented in an XML file, the function must
have an `.ExternalHelp` comment keyword that associates the function with the XML file. Otherwise,
the `Get-Help` cmdlet cannot find the help file.

There are no technical requirements for the name of a function help file. However, a best practice
is to name the help file for the script module in which the function is defined. For example, the
following function is defined in the `MyModule.psm1` file.

```csharp
#.ExternalHelp MyModule.psm1-help.xml
function Test-Function { ... }
```

## CIM Command Help Files

The help file for a CIM command must be named for the CDXML file in which the CIM command is
defined. Use the following filename format:

`<FileName>.cdxml-help.xml`

CIM commands are defined in CDXML files that can be included in modules as nested modules. When the
CIM command is imported into the session as a function, PowerShell adds an `.ExternalHelp`
comment keyword to the function definition that associates the function with an XML help file that
is named for the CDXML file in which the CIM command is defined.

## Script Workflow Help Files

Script workflows that are included in modules can be documented in XML-based help files. There are
no technical requirements for the name of the help file. However, a best practice is to name the
help file for the script module in which the script workflow is defined. For example:

`<ScriptModule>.psm1-help.xml`

Unlike other scripted commands, script workflows do not require an `.ExternalHelp` comment keyword
to associate them with a help file. Instead, PowerShell searches the UI-Culture-specific
subdirectories of the module directory for XML-based help files and looks for help for the script
workflow in all the files. `.ExternalHelp` comment keyword are ignored.

Because the `.ExternalHelp` comment keyword is ignored, the `Get-Help` cmdlet can find help for
script workflows only when they are included in modules.
