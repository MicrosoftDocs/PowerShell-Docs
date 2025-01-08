---
description: A module is a self-contained reusable unit of PowerShell code. A module can contain commands (such as cmdlets and functions) and items (such as variables and aliases).
ms.date: 05/19/2021
title: Modules
---
# 11. Modules

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

## 11.1 Introduction

As stated in [§3.14][§3.14], a module is a self-contained reusable unit that allows PowerShell code to be
partitioned, organized, and abstracted. A module can contain one or more *module members*, which are
commands (such as cmdlets and functions) and items (such as variables and aliases). The names of
these members can be kept private to the module or they may be *exported* to the session into which
the module is *imported*.

There are three different *module types*: manifest, script, and binary. A *manifest module* is a
file that contains information about a module, and controls certain aspects of that module's use. A
*script module* is a PowerShell script file with a file extension of `.psm1` instead of `.ps1`. A
*binary module* contains class types that define cmdlets and providers. Unlike script modules,
binary modules are written in compiled languages. Binary modules are not covered by this
specification.

A binary module is a .NET assembly (i.e.; a DLL) that was compiled against the PowerShell libraries.

Modules may *nest*; that is, one module may import another module. A module that has associated
nested modules is a *root module*.

When a PowerShell session is created, by default, no modules are imported.

When modules are imported, the search path used to locate them is defined by the environment
variable **PSModulePath**.

The following cmdlets deal with modules:

- [Get-Module](xref:Microsoft.PowerShell.Core.Get-Module): Identifies the modules that have been, or
can be imported
- [Import-Module](xref:Microsoft.PowerShell.Core.Import-Module): Adds one or more modules to the
  current session (see [§11.4][§11.4])
- [Export-ModuleMember](xref:Microsoft.PowerShell.Core.Export-ModuleMember): Identifies the module
  members that are to be exported
- [Remove-Module](xref:Microsoft.PowerShell.Core.Remove-Module): Removes one or more modules from
  the current session (see [§11.5][§11.5])
- [New-Module](xref:Microsoft.PowerShell.Core.New-Module): Creates a dynamic module (see [§11.7][§11.7])

## 11.2 Writing a script module

A script module is a script file. Consider the following script module:

```powershell
function Convert-CentigradeToFahrenheit ([double]$tempC) {
    return ($tempC * (9.0 / 5.0)) + 32.0
}
New-Alias c2f Convert-CentigradeToFahrenheit

function Convert-FahrenheitToCentigrade ([double]$tempF) {
    return ($tempF - 32.0) * (5.0 / 9.0)
}
New-Alias f2c Convert-FahrenheitToCentigrade

Export-ModuleMember -Function Convert-CentigradeToFahrenheit
Export-ModuleMember -Function Convert-FahrenheitToCentigrade
Export-ModuleMember -Alias c2f, f2c
```

This module contains two functions, each of which has an alias. By default, all function names, and
only function names are exported. However, once the cmdlet `Export-ModuleMember` has been used to
export anything, then only those things exported explicitly will be exported. A series of commands
and items can be exported in one call or a number of calls to this cmdlet; such calls are cumulative
for the current session.

## 11.3 Installing a script module

A script module is defined in a script file, and modules can be stored in any directory. The
environment variable PSModulePath points to a set of directories to be searched when module-related
cmdlets look for modules whose names do not include a fully qualified path. Additional lookup paths
can be provided; for example,

`$Env:PSModulepath = $Env:PSModulepath + ";<additional-path>"`

Any additional paths added affect the current session only.

Alternatively, a fully qualified path can be specified when a module is imported.

## 11.4 Importing a script module

Before the resources in a module can be used, that module must be imported into the current session,
using the cmdlet `Import-Module`. `Import-Module` can restrict the resources that it actually
imports.

When a module is imported, its script file is executed. That process can be configured by defining
one or more parameters in the script file, and passing in corresponding arguments via the
ArgumentList parameter of `Import-Module`.

Consider the following script that uses these functions and aliases defined in [§11.2][§11.2]:

`Import-Module` "E:\Scripts\Modules\PSTest\_Temperature" -Verbose

```powershell
"0 degrees C is " + (Convert-CentigradeToFahrenheit 0) + " degrees F"
"100 degrees C is " + (c2f 100) + " degrees F"
"32 degrees F is " + (Convert-FahrenheitToCentigrade 32) + " degrees C"
"212 degrees F is " + (f2c 212) + " degrees C"
```

Importing a module causes a name conflict when commands or items in the module have the same names
as commands or items in the session. A name conflict results in a name being hidden or replaced. The
Prefix parameter of `Import-Module` can be used to avoid naming conflicts. Also, the **Alias**,
**Cmdlet**, **Function**, and **Variable** parameters can limit the selection of commands to be
imported, thereby reducing the chances of name conflict.

Even if a command is hidden, it can be run by qualifying its name with the name of the module in
which it originated. For example, `& M\F 100` invokes the function *F* in module *M*, and passes it
the argument 100.

When the session includes commands of the same kind with the same name, such as two cmdlets with the
same name, by default it runs the most recently added command.

See [§3.5.6][§3.5.6] for a discussion of scope as it relates to modules.

## 11.5 Removing a script module

One or more modules can be removed from a session via the cmdlet `Remove-Module`.

Removing a module does not uninstall the module.

In a script module, it is possible to specify code that is to be executed prior to that module's
removal, as follows:

`$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = { *on-removal-code* }`

## 11.6 Module manifests

As stated in [§11.1][§11.1], a manifest module is a file that contains information about a module, and
controls certain aspects of that module's use.

A module need not have a corresponding manifest, but if it does, that manifest has the same name as
the module it describes, but with a `.psd1` file extension.

A manifest contains a limited subset of PowerShell script, which returns a Hashtable containing a
set of keys. These keys and their values specify the *manifest elements* for that module. That is,
they describe the contents and attributes of the module, define any prerequisites, and determine how
the components are processed.

Essentially, a manifest is a data file; however, it can contain references to data types, the if
statement, and the arithmetic and comparison operators. (Assignments, function definitions and loops
are not permitted.) A manifest also has read access to environment variables and it can contain
calls to the cmdlet `Join-Path`, so paths can be constructed.

> [!NOTE]
> Editor's Note: The original document contains a list of keys allowed in a module manifest file.
> That list is outdated and incomplete. For a complete list of keys in a module manifest, see
> [New-ModuleManifest](/powershell/module/microsoft.powershell.core/new-modulemanifest).

The only key that is required is **ModuleVersion**.

Here is an example of a simple manifest:

```powershell
@{
ModuleVersion = '1.0'
Author = 'John Doe'
RequiredModules = @()
FunctionsToExport = 'Set*','Get*','Process*'
}
```

The key **GUID** has a `string` value. This specifies a Globally Unique IDentifier (GUID) for the
module. The **GUID** can be used to distinguish among modules having the same name. To create a new
GUID, call the method `[guid]::NewGuid()`.

## 11.7 Dynamic modules

A *dynamic module* is a module that is created in memory at runtime by the cmdlet `New-Module`; it
is not loaded from disk. Consider the following example:

```powershell
$sb = {
    function Convert-CentigradeToFahrenheit ([double]$tempC) {
        return ($tempC * (9.0 / 5.0)) + 32.0
    }

    New-Alias c2f Convert-CentigradeToFahrenheit

    function Convert-FahrenheitToCentigrade ([double]$tempF) {
        return ($tempF - 32.0) * (5.0 / 9.0)
    }

    New-Alias f2c Convert-FahrenheitToCentigrade

    Export-ModuleMember -Function Convert-CentigradeToFahrenheit
    Export-ModuleMember -Function Convert-FahrenheitToCentigrade
    Export-ModuleMember -Alias c2f, f2c
}

New-Module -Name MyDynMod -ScriptBlock $sb
Convert-CentigradeToFahrenheit 100
c2f 100
```

The script block `$sb` defines the contents of the module, in this case, two functions and two
aliases to those functions. As with an on-disk module, only functions are exported by default, so
`Export-ModuleMember` cmdlets calls exist to export both the functions and the aliases.

Once `New-Module` runs, the four names exported are available for use in the session, as is shown by
the calls to the `Convert-CentigradeToFahrenheit` and c2f.

Like all modules, the members of dynamic modules run in a private module scope that is a child of
the global scope. `Get-Module` cannot get a dynamic module, but `Get-Command` can get the exported
members.

To make a dynamic module available to `Get-Module`, pipe a `New-Module` command to `Import-Module`,
or pipe the module object that `New-Module` returns, to `Import-Module`. This action adds the
dynamic module to the `Get-Module` list, but it does not save the module to disk or make it
persistent.

## 11.8 Closures

A dynamic module can be used to create a *closure*, a function with attached data. Consider the
following example:

```powershell
function Get-NextID ([int]$startValue = 1) {
    $nextID = $startValue
    {
        ($script:nextID++)
    }.GetNewClosure()
}

$v1 = Get-NextID      # get a scriptblock with $startValue of 0
& $v1                 # invoke Get-NextID getting back 1
& $v1                 # invoke Get-NextID getting back 2

$v2 = Get-NextID 100  # get a scriptblock with $startValue of 100
& $v2                 # invoke Get-NextID getting back 100
& $v2                 # invoke Get-NextID getting back 101
```

The intent here is that `Get-NextID` return the next ID in a sequence whose start value can be
specified. However, multiple sequences must be supported, each with its own `$startValue` and
`$nextID` context. This is achieved by the call to the method `[scriptblock]::GetNewClosure`
([§4.3.7][§4.3.7]).

Each time a new closure is created by `GetNewClosure`, a new dynamic module is created, and the
variables in the caller's scope (in this case, the script block containing the increment) are copied
into this new module. To ensure that the nextId defined inside the parent function (but outside the
script block) is incremented, the explicit script: scope prefix is needed.

Of course, the script block need not be a named function; for example:

```powershell
$v3 = & {      # get a scriptblock with $startValue of 200
    param ([int]$startValue = 1)
    $nextID = $startValue
    {
        ($script:nextID++)
    }.GetNewClosure()
} 200

& $v3          # invoke script getting back 200
& $v3          # invoke script getting back 201
```

<!-- reference links -->
[§11.1]: chapter-11.md#111-introduction
[§11.2]: chapter-11.md#112-writing-a-script-module
[§11.4]: chapter-11.md#114-importing-a-script-module
[§11.5]: chapter-11.md#115-removing-a-script-module
[§11.7]: chapter-11.md#117-dynamic-modules
[§3.14]: chapter-03.md#314-modules
[§3.5.6]: chapter-03.md#356-modules
[§4.3.7]: chapter-04.md#437-the-scriptblock-type
