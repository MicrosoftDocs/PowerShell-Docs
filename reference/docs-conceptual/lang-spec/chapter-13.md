---
description: A cmdlet is a single-feature command that manipulates objects in PowerShell. Cmdlets can be recognized by their name format, a verb and noun separated by a dash.
ms.date: 05/19/2021
title: Cmdlets
---
# 13. Cmdlets

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

A cmdlet is a single-feature command that manipulates objects in PowerShell. Cmdlets can be
recognized by their name format, a verb and noun separated by a dash (`-`), such as `Get-Help`,
`Get-Process`, and `Start-Service`. A *verb pattern* is a verb expressed using wildcards, as
in `W*`. A *noun pattern* is a noun expressed using wildcards, as in *event*.

Cmdlets should be simple and be designed to be used in combination with other cmdlets. For example,
**Get** cmdlets should only retrieve data, **Set** cmdlets should only establish or change data,
**Format** cmdlets should only format data, and **Out** cmdlets should only direct the output to a
specified destination.

For each cmdlet, provide a help file that can be accessed by typing:

`get-help *cmdlet-name* -detailed`

The detailed view of the cmdlet help file should include a description of the cmdlet, the command
syntax, descriptions of the parameters, and an example that demonstrate the use of that cmdlet.

Cmdlets are used similarly to operating system commands and utilities. PowerShell commands are not
case-sensitive.

> [!NOTE]
> Editor's note: The original document contains a list of cmdlet with descriptions, syntax diagrams,
> parameter definitions, and examples. This information is incomplete and out dated. For current
> information about cmdlet, consult the **Reference** section of the
> [PowerShell documentation](/powershell/scripting/overview).

## 13.1 Common parameters

The *common parameters* are a set of cmdlet parameters that can be used with any cmdlet. They are
implemented by the PowerShell runtime environment itself, not by the cmdlet developer, and they are
automatically available to any cmdlet or function that uses the **Parameter** attribute
([§12.3.7][§12.3.7]) or **CmdletBinding** attribute ([§12.3.5][§12.3.5]).

Although the common parameters are accepted by any cmdlet, they might not have any semantics for
that cmdlet. For example, if a cmdlet does not generate any verbose output, using the **Verbose**
common parameter has no effect.

Several common parameters override system defaults or preferences that can be set via preference
variables ([§2.3.2.3][§2.3.2.3]). Unlike the preference variables, the common parameters affect only the
commands in which they are used.

> [!NOTE]
> Editor's note: The original document contains a list of the Common Parameters. This information is
> incomplete and out dated. For current information see
> [about_CommonParameters](/powershell/module/microsoft.powershell.core/about/about_commonparameters).

<!-- reference links -->
[§12.3.5]: chapter-12.md#1235-the-cmdletbinding-attribute
[§12.3.7]: chapter-12.md#1237-the-parameter-attribute
[§2.3.2.3]: chapter-02.md#2323-preference-variables
