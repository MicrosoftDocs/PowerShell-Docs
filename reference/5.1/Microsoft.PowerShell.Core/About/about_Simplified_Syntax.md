---
description: Describes easier, more natural-language ways of scripting filters for collections of objects.
Locale: en-US
ms.date: 04/26/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_simplified_syntax?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Simplified_Syntax
---
# about_Simplified_Syntax

## Short description
Describes easier, more natural-language ways of scripting filters for
collections of objects.

## Long description

Simplified syntax, introduced in Windows PowerShell 3.0, lets you build some
filter commands without using script blocks. The simplified syntax more closely
resembles natural language, and is primarily useful with collections of objects
that get piped into commands `Where-Object` and `ForEach-Object` or their
corresponding aliases `where` and `foreach`.

You can use a method on the members of a collection (most commonly, an array)
without referring to the automatic variable `$_` inside a script block.

Consider the following two invocations:

### Standard Syntax

```powershell
Get-ChildItem Cert:\LocalMachine\Root |
    Where-Object -FilterScript { $_.FriendlyName -eq 'Verisign' }
Get-ChildItem Cert:\ -Recurse |
    ForEach-Object -FilterScript { $_.GetKeyAlgorithm() }
```

> [!NOTE]
> In the second command, the `GetKeyAlgorithm` method is called on each object
> in the collection. If the object received from the pipeline doesn't have a
> `GetKeyAlgorithm` method, the command produces an error.

### Simplified syntax

Under the simplified syntax, comparison operators that work on members of
objects in a collection are implemented as parameters. Also, you can invoke a
method on objects in a collection without referring to the automatic variable
`$_` inside a script block. Compare the following two invocations to the
standard syntax examples:

```powershell
Get-ChildItem Cert:\LocalMachine\Root |
    Where-Object -Property FriendlyName -EQ 'Verisign'
Get-ChildItem Cert:\ -Recurse |
    ForEach-Object -MemberName GetKeyAlgorithm
```

Since the **Property** and **MemberName** parameters are positional, you can
omit them from the command. Using aliases, you can further simplify the
commands:

```powershell
dir Cert:\LocalMachine\Root | Where FriendlyName -EQ 'Verisign'
dir Cert:\ -Recurse | ForEach GetKeyAlgorithm
```

While both syntaxes work, the simplified syntax returns results without
referring to the automatic variable `$_` inside a script block. The simplified
syntax reads more like a natural language statement and can be easier to
understand.

The method name `GetKeyAlgorithm` is passed as an argument for the
**MemberName** parameter of `ForEach-Object`. When you invoke the method using
the simplified syntax, the method is called for each object in pipeline only if
that object has that method. Therefore, you get the same results, but without
errors.

In the next example, `Description` is passed to the **MemberName** parameter of
`ForEach-Object`. The command displays the description of each
**System.Diagnostics.Process** object returned by `Get-Process`.

```powershell
Get-Process | foreach Description
```

In this example, the method name `GetFiles` is passed to the **MemberName**
parameter of the `ForEach-Object` command. The `.*` value is passed to the
**ArgumentList** parameter. The `GetFiles()` method is called with the search
pattern parameter `.*` for each **System.IO.DirectoryInfo** object returned by
`Get-ChildItem`.

```powershell
Get-ChildItem /home -Directory | foreach GetFiles .*
```

## See also

- [about_Comparison_Operators](about_Comparison_Operators.md)
- [about_Foreach](about_Foreach.md)
- [Foreach-Object](xref:Microsoft.PowerShell.Core.ForEach-Object)
- [Where-Object](xref:Microsoft.PowerShell.Core.Where-Object)
