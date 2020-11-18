---
description: Allows you to indicate which namespaces are used in the session.
Locale: en-US
ms.date: 11/18/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_using?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Using
---
# About Using

## SHORT DESCRIPTION
Allows you to indicate which namespaces are used in the session.

## LONG DESCRIPTION

The `using` statement allows you to specify which namespaces are used in the
session. Adding namespaces simplifies usage of .NET classes and member and
allows you to import classes from script modules and assemblies.

The `using` statements must come before any other statements in a script.

The `using` statement should not be confused with the `using:` scope modifier
for variables. For more information, see
[about_Remote_Variables](about_Remote_Variables.md).

## Namespace syntax

To specify .NET namespaces from which to resolve types:

```
using namespace <.NET-namespace>
```

Specifying a namespace makes it easier to reference types by their short names.

## Module syntax

To load classes from a PowerShell module:

```
using module <module-name>
```

The value of `<module-name>` can be a module name, a full module specification,
or a path to a module file.

When `<module-name>` is a path, the path can be fully qualified or relative. A
relative path is resolved relative to the script that contains the using
statement.

When `<module-name>` is a name or module specification, PowerShell searches the
**PSModulePath** for the specified module.

A module specification is a hash table that has the following keys.

- `ModuleName` - **Required** Specifies the module name.
- `GUID` - **Optional** Specifies the GUID of the module.
- It's also **Required** to specify one of the three below keys. These keys
  can't be used together.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.

## Assembly syntax

To preload types from a .NET assembly:

```
using assembly <.NET-assembly-path>
```

Loading an assembly preloads .NET types from that assembly into a script at
parse time. This allows you to create new PowerShell classes that use types
from the preloaded assembly.

If you are not creating new PowerShell classes, use the `Add-Type` cmdlet
instead. For more information, see
[Add-Type](xref:Microsoft.PowerShell.Utility.Add-Type).

## Examples

### Example 1 - Add namespaces for typename resolution

The following script gets the cryptographic hash for the "Hello World" string.

Note how the `using namespace System.Text` and `using namespace System.IO`
simplify the references to `[UnicodeEncoding]` in `System.Text` and `[Stream]`
and to `[MemoryStream]` in `System.IO`.

```powershell
using namespace System.Text
using namespace System.IO

[string]$string = "Hello World"
## Valid values are "SHA1", "SHA256", "SHA384", "SHA512", "MD5"
[string]$algorithm = "SHA256"

[byte[]]$stringbytes = [UnicodeEncoding]::Unicode.GetBytes($string)

[Stream]$memorystream = [MemoryStream]::new($stringbytes)
$hashfromstream = Get-FileHash -InputStream $memorystream `
  -Algorithm $algorithm
$hashfromstream.Hash.ToString()
```

### Example 2 - Load classes from a script module

In this example, we have a PowerShell script module named **CardGames** that
defines the following classes:

- **CardGames.Deck**
- **CardGames.Card**

`Import-Module` and the `#requires` statement only import the module functions,
aliases, and variables, as defined by the module. Classes are not imported. The
`using module` command imports the module and also loads the class definitions.

```powershell
using module CardGames
using namespace CardGames

[Deck]$deck = [Deck]::new()
$deck.Shuffle()
[Card[]]$hand1 = $deck.Deal(5)
[Card[]]$hand2 = $deck.Deal(5)
[Card[]]$hand3 = $deck.Deal(5)
```

### Example 3 - Load classes from an assembly

This example loads an assembly so that its classes can be used to create new
PowerShell classes. The following script creates a new PowerShell class that is
derived from **DirectoryContext** class.

```powershell
using assembly 'C:\Program Files\PowerShell\7\System.DirectoryServices.dll'
using namespace System.DirectoryServices.ActiveDirectory

class myDirectoryClass : System.DirectoryServices.ActiveDirectory.DirectoryContext
{

  [DirectoryContext]$domain

  myDirectoryClass([DirectoryContextType]$ctx) : base($ctx)
  {
    $this.domain = [DirectoryContext]::new([DirectoryContextType]$ctx)
  }

}

$myDomain = [myDirectoryClass]::new([DirectoryContextType]::Domain)
$myDomain
```

```Output
domain                                                    Name UserName ContextType
------                                                    ---- -------- -----------
System.DirectoryServices.ActiveDirectory.DirectoryContext                    Domain
```
