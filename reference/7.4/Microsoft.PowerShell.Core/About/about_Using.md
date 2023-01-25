---
description: Allows you to indicate which namespaces are used in the session.
Locale: en-US
ms.date: 01/25/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_using?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Using
---
# about_Using

## Short description
Allows you to indicate which namespaces are used in the session.

## Long description

The `using` statement allows you to specify which namespaces are used in the
session. Adding namespaces simplifies usage of .NET classes and member and
allows you to import classes from script modules and assemblies.

The `using` statements must come before any other statements in a script or
module. No uncommented statement can precede it, including parameters.

The `using` statement must not contain any variables.

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

A module specification is a hashtable that has the following keys.

- `ModuleName` - **Required** Specifies the module name.
- `GUID` - **Optional** Specifies the GUID of the module.
- It's also **Required** to specify at least one of the three below keys.
  - `ModuleVersion` - Specifies a minimum acceptable version of the module.
  - `MaximumVersion` - Specifies the maximum acceptable version of the module.
  - `RequiredVersion` - Specifies an exact, required version of the module.
    This can't be used with the other Version keys.

The `using module` statement imports classes from the root module
(`ModuleToProcess`) of a script module or binary module. It does not
consistently import classes defined in nested modules or classes defined in
scripts that are dot-sourced into the module. Classes that you want to be
available to users outside of the module should be defined in the root module.

During development of a script module, it is common to make changes to the code
then load the new version of the module using `Import-Module` with the
**Force** parameter. This works for changes to functions in the root module
only. `Import-Module` does not reload any nested modules. Also, there is no way
to load any updated classes.

To ensure that you are running the latest version, you must unload the module
using the `Remove-Module` cmdlet. `Remove-Module` removes the root module, all
nested modules, and any classes defined in the modules. Then you can reload the
module and the classes using `Import-Module` and the `using module` statement.

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

- **Deck**
- **Card**

`Import-Module` and the `#requires` statement only import the module functions,
aliases, and variables, as defined by the module. Classes are not imported. The
`using module` command imports the module and also loads the class definitions.

```powershell
using module CardGames

[Deck]$deck = [Deck]::new()
$deck.Shuffle()
[Card[]]$hand1 = $deck.Deal(5)
[Card[]]$hand2 = $deck.Deal(5)
[Card[]]$hand3 = $deck.Deal(5)
```

### Example 3 - Load classes from an assembly

This example loads an assembly so that its classes can be used when processing
data. The following script converts data into a YAML format.

```powershell
using assembly './YamlDotNet.dll'
using namespace YamlDotNet

$yamlSerializer = [Serialization.Serializer]::new()

$info = [ordered]@{
  Inventory = @(
    @{ Name = 'Apples' ; Count = 1234 }
    @{ Name = 'Bagels' ; Count = 5678 }
  )
    CheckedAt = [datetime]'2023-01-01T01:01:01'
}

$yamlSerializer.Serialize($info)
```

```Output
Inventory:
- Name: Apples
  Count: 1234
- Name: Bagels
  Count: 5678
CheckedAt: 2023-01-01T01:01:01.0000000
```
