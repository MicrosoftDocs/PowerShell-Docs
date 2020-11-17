---
description: Describes easier, more natural-language ways of scripting filters for collections of objects.
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_simplified_syntax?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Simplified_Syntax
---
# about_Simplified_Syntax

## SHORT DESCRIPTION
Describes easier, more natural-language ways of scripting filters for
collections of objects.

## LONG DESCRIPTION

Simplified syntax, introduced in Windows PowerShell 3.0, lets you build some
filter commands without using script blocks. The simplified syntax more
closely resembles natural language, and is primarily useful with collections
of objects that get piped into commands `Where-Object` and `ForEach-Object` and
their corresponding aliases `where` and `foreach`.

You can use a method on the members of a collection (most commonly, an array)
without referring to the automatic variable `$_` inside a script block.

Consider the following two invocations:

### Standard Syntax

```powershell
dir Cert:\LocalMachine\Root | where { $_.FriendlyName -eq 'Verisign' }
dir Cert:\ -Recurse | foreach { $_.GetKeyAlgorithm() }
```

### Simplified syntax

Under the simplified syntax, comparison operators that work on members of objects in a
collection are treated as parameters. You can invoke a method on objects in a
collection without referring to the automatic variable `$_` inside a script block.
Compare the following two invocations to those of the previous example:

```powershell
dir Cert:\LocalMachine\Root | where FriendlyName -eq 'Verisign'
dir Cert:\ -Recurse | foreach GetKeyAlgorithm
```

While both syntaxes work, the simplified syntax returns results without
referring to the automatic variable `$_` inside a script block.
The method name `GetKeyAlgorithm` is treated as a parameter of `ForEach-Object`.
The second command returns the same results, but without errors,
because the simplified syntax does not attempt to return results for items
for which the specified argument did not apply.

In this example, the `Process` property `Description` is passed as the member name
parameter to the `ForEach-Object` command. The results are descriptions of active
processes.

```powershell
Get-Process | foreach Description
```

In this example, the `DirectoryInfo` method `GetFiles` is passed as the member name 
parameter of the `ForEach-Object` command.  
The method is called with the search pattern parameter `.*`.  
The results are `FileInfo` records for all Unix-style hidden files in user home directories. 

```powershell
Get-ChildItem /home -Directory | foreach GetFiles .*
```

## SEE ALSO

- [about_Comparison_Operators](about_Comparison_Operators.md)
- [about_Foreach](about_Foreach.md)
- [Where-Object](xref:Microsoft.PowerShell.Core.Where-Object)
- [Foreach-Object](xref:Microsoft.PowerShell.Core.ForEach-Object)

