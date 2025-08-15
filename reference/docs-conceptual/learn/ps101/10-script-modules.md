---
description: Script modules are an easy way to package scripts and functions into a reusable tool.
ms.custom: Contributor-mikefrobbins
ms.date: 03/27/2025
ms.reviewer: mirobb
title: Script modules
---

# Chapter 10 - Script modules

If you find yourself using the same PowerShell one-liners or scripts often, turning them into
reusable tools is even more important. Packaging your functions in a script module gives them a more
professional feel and makes them easier to support and share with others.

## Dot-sourcing functions

One thing we didn't cover in the previous chapter is dot-sourcing functions. When you define a
function in a script but not part of a module, the only way to load it into memory is by
dot-sourcing its `.ps1` file.

For example, save the following function in a file named `Get-MrPSVersion.ps1`.

```powershell
function Get-MrPSVersion {
    $PSVersionTable
}
```

When you run the script, it appears that nothing happens.

```powershell
.\Get-MrPSVersion.ps1
```

Attempting to call the function results in an error because it isn't loaded into memory.

```powershell
Get-MrPSVersion
```

```Output
Get-MrPSVersion : The term 'Get-MrPSVersion' is not recognized as the name
of a cmdlet, function, script file, or operable program. Check the spelling
of the name, or if a path was included, verify that the path is correct and
try again.
At line:1 char:1
+ Get-MrPSVersion
+ ~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Get-MrPSVersion:String) [],
   CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

You can confirm whether functions are loaded into memory by verifying their existence on the
**Function:** PSDrive.

```powershell
Get-ChildItem -Path Function:\Get-MrPSVersion
```

```Output
Get-ChildItem : Cannot find path 'Get-MrPSVersion' because it does not
exist.
At line:1 char:1
+ Get-ChildItem -Path Function:\Get-MrPSVersion
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Get-MrPSVersion:String) [Get
   -ChildItem], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.Ge
   tChildItemCommand
```

The issue with running the script that defines the function is that it loads it into the **Script**
scope. Once the script finishes executing, PowerShell discards that scope along with the function.

To keep the function available after the script runs, it needs to be loaded into the **Global**
scope. You can accomplish this by dot-sourcing the script file. You can use a relative path for this
purpose.

```powershell
. .\Get-MrPSVersion.ps1
```

You can also use the full path to the script when dot-sourcing it.

```powershell
. C:\Demo\Get-MrPSVersion.ps1
```

If part of the path is stored in a variable, you can combine it with the rest of the path. There's
no need to use string concatenation to do this.

```powershell
$Path = 'C:\'
. $Path\Get-MrPSVersion.ps1
```

Now, if you check the **Function** PSDrive, you see the `Get-MrPSVersion` function is available.

```powershell
Get-ChildItem -Path Function:\Get-MrPSVersion
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Function        Get-MrPSVersion
```

## Script modules

In PowerShell, a script module is simply a `.psm1` file that contains one or more functions, just
like a regular script, but with a different file extension.

How do you create a script module? You might assume with a command named something like
`New-Module`. That assumption is a reasonable guess, but that command actually creates a dynamic
module, not a script module.

This scenario is a good reminder to always read the help documentation, even when a command name
looks exactly like what you need.

```powershell
help New-Module
```

```Output
NAME
    New-Module

SYNOPSIS
    Creates a new dynamic module that exists only in memory.


SYNTAX
    New-Module [-Name] <System.String> [-ScriptBlock]
    <System.Management.Automation.ScriptBlock> [-ArgumentList
    <System.Object[]>] [-AsCustomObject] [-Cmdlet <System.String[]>]
    [-Function <System.String[]>] [-ReturnResult] [<CommonParameters>]


DESCRIPTION
    The `New-Module` cmdlet creates a dynamic module from a script block.
    The members of the dynamic module, such as functions and variables, are
    immediately available in the session and remain available until you
    close the session.

    Like static modules, by default, the cmdlets and functions in a dynamic
    module are exported and the variables and aliases are not. However, you
    can use the Export-ModuleMember cmdlet and the parameters of
    `New-Module` to override the defaults.

    You can also use the **AsCustomObject** parameter of `New-Module` to return
    the dynamic module as a custom object. The members of the modules, such
    as functions, are implemented as script methods of the custom object
    instead of being imported into the session.

    Dynamic modules exist only in memory, not on disk. Like all modules,
    the members of dynamic modules run in a private module scope that is a
    child of the global scope. Get-Module cannot get a dynamic module, but
    Get-Command can get the exported members.

    To make a dynamic module available to `Get-Module`, pipe a `New-Module`
    command to Import-Module, or pipe the module object that `New-Module`
    returns to `Import-Module`. This action adds the dynamic module to the
    `Get-Module` list, but it does not save the module to disk or make it
    persistent.


RELATED LINKS
    Online Version: https://learn.microsoft.com/powershell/module/microsoft.
    powershell.core/new-module?view=powershell-5.1&WT.mc_id=ps-gethelp
    Export-ModuleMember
    Get-Module
    Import-Module
    Remove-Module
    about_Modules

REMARKS
    To see the examples, type: "Get-Help New-Module -Examples".
    For more information, type: "Get-Help New-Module -Detailed".
    For technical information, type: "Get-Help New-Module -Full".
    For online help, type: "Get-Help New-Module -Online"
```

The previous chapter mentioned that functions should use approved verbs. Otherwise, PowerShell
generates a warning when the module is imported.

The following example uses the `New-Module` cmdlet to create a dynamic module in memory,
specifically to demonstrate what happens when you don't use an approved verb.

```powershell
New-Module -Name MyModule -ScriptBlock {

    function Return-MrOsVersion {
        Get-CimInstance -ClassName Win32_OperatingSystem |
        Select-Object -Property @{Label='OperatingSystem';Expression={$_.Caption}}
    }

    Export-ModuleMember -Function Return-MrOsVersion

} | Import-Module
```

```Output
WARNING: The names of some imported commands from the module 'MyModule' include
unapproved verbs that might make them less discoverable. To find the commands with
unapproved verbs, run the Import-Module command again with the Verbose parameter. For a
list of approved verbs, type Get-Verb.
```

Although you used the `New-Module` cmdlet in the previous example, as mentioned before, it's not the
command for creating script modules in PowerShell.

To create a script module, save your functions in a `.psm1` file. For example, save the following
two functions in a file named `MyScriptModule.psm1`.

```powershell
function Get-MrPSVersion {
    $PSVersionTable
}

function Get-MrComputerName {
    $env:COMPUTERNAME
}
```

Try to run one of the functions.

```powershell
Get-MrComputerName
```

When you call the function, you receive an error saying PowerShell can't find it. Like before,
checking the **Function:** PSDrive confirms that it isn't loaded into memory.

```Output
Get-MrComputerName : The term 'Get-MrComputerName' is not recognized as the
name of a cmdlet, function, script file, or operable program. Check the
spelling of the name, or if a path was included, verify that the path is
correct and try again.
At line:1 char:1
+ Get-MrComputerName
+ ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Get-MrComputerName:String) [
   ], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

To make the function available, you can manually import the `MyScriptModule.psm1` file using the
`Import-Module` cmdlet.

```powershell
Import-Module C:\MyScriptModule.psm1
```

PowerShell introduced module autoloading in version 3. To take advantage of this feature, the script
module must be saved in a folder with the same base name as the `.psm1` file. That folder must be
located in one of the directories specified in the `$env:PSModulePath` environment variable.

```powershell
$env:PSModulePath
```

The output of `$env:PSModulePath` is difficult to read.

```Output
C:\Users\mike-ladm\Documents\WindowsPowerShell\Modules;C:\Program Files\Wind
owsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules;C:\
Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules\
```

To make the results more readable, split the paths on the semicolon path separator so each one
appears on its own line.

```powershell
$env:PSModulePath -split ';'
```

The first three paths in the list are the default module locations. SQL Server Management Studio
added the last path when you installed it.

```Output
C:\Users\mike-ladm\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\Windows\system32\WindowsPowerShell\v1.0\Modules
C:\Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules\
```

For module autoloading to work, you must place the `MyScriptModule.psm1` file must in a folder named
`MyScriptModule`, and that folder must reside directly inside one of the paths listed in  
`$env:PSModulePath`.

Not all those paths are equally useful. For example, the current user path on my system isn't the
first one in the list. That's because I sign in to Windows with a different account than the one I
use to run PowerShell. So, it doesn't point to my user's documents folder.

The second path is the **AllUsers** path, which is where I store all of my modules.

The third path points to `C:\Windows\System32`, a protected system location. Only Microsoft should
be placing modules there, as it falls under the operating system's directory structure.

Once you place the `.psm1` file in an appropriate folder within one of these paths, PowerShell
automatically loads the module the first time you call one of its commands.

## Module manifests

Every module should include a module manifest, which is a `.psd1` file containing metadata about the
module. While the `.psd1` extension is used for manifests, not all `.psd1` files are module
manifests. You can also use them for other purposes, such as defining environment data in a DSC  
configuration.

You can create a module manifest using the `New-ModuleManifest` cmdlet. The only required parameter
is **Path**, but for the module to work correctly, you must also specify the **RootModule**
parameter.

It's a best practice to include values like **Author** and **Description**, especially if you plan
to publish your module to a NuGet repository using **PowerShellGet**. These fields are required in
that scenario.

One quick way to tell if a module lacks a manifest is to check its version.

```powershell
Get-Module -Name MyScriptModule
```

A version number of `0.0` is a clear sign that the module lacks a manifest.

```Output
ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Script     0.0        MyScriptModule                      {Get-MrComputer...
```

You should include all recommended details when creating a module manifest to ensure your module is
well-documented and ready for sharing or publishing.

```powershell
$moduleManifestParams = @{
    Path = "$env:ProgramFiles\WindowsPowerShell\Modules\MyScriptModule\MyScriptModule.psd1"
    RootModule = 'MyScriptModule'
    Author = 'Mike F. Robbins'
    Description = 'MyScriptModule'
    CompanyName = 'mikefrobbins.com'
}

New-ModuleManifest @moduleManifestParams
```

If you omit any values when initially creating the module manifest, you can add or update it later
using the `Update-ModuleManifest` cmdlet. Avoid recreating the manifest with `New-ModuleManifest`
once you create it, as doing so generates a new GUID.

## Defining public and private functions

Sometimes, your module might include helper functions you don't want to expose to users. These
private functions are used internally by other functions in the module but aren't exposed to users.
There are a few ways to handle this scenario.

If you're not following best practices and only have a `.psm1` file without a proper module
structure, your only option is to control visibility using the `Export-ModuleMember` cmdlet. This
option lets you explicitly define which functions should be exposed directly from within the `.psm1`
script module file, keeping everything else private by default.

In the following example, only the `Get-MrPSVersion` function is exposed to users of your module,
while the `Get-MrComputerName` function remains accessible internally to other functions within the
module.

```powershell
function Get-MrPSVersion {
    $PSVersionTable
}

function Get-MrComputerName {
    $env:COMPUTERNAME
}

Export-ModuleMember -Function Get-MrPSVersion
```

Determine what commands are available publicly in the **MyScriptModule** module.

```powershell
Get-Command -Module MyScriptModule
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Function        Get-MrPSVersion                                    1.0
```

If you add a module manifest to your module, it's a best practice to explicitly list the functions
you want to export in the **FunctionsToExport** section. This option gives you control over what you
expose to users from the `.psd1` module manifest file.

```powershell
FunctionsToExport = 'Get-MrPSVersion'
```

You don't need to use both `Export-ModuleMember` in the `.psm1` file and the `FunctionsToExport`
section in the module manifest. Either approach is enough on its own.

## Summary

In this chapter, you learned how to turn your functions into a script module in PowerShell. You also
explored best practices for creating script modules, including the importance of adding a module
manifest to define metadata and manage exported commands.

## Review

1. How do you create a script module in PowerShell?
1. Why is it important to use approved verbs for your function names?
1. How do you create a module manifest in PowerShell?
1. What are the two ways to export only specific functions from a module?
1. What conditions must be met for a module to autoload when you run one of its commands?

## References

- [How to Create PowerShell Script Modules and Module Manifests][create-modules-and-manifests]
- [about_Modules][about-modules]
- [New-ModuleManifest][new-modulemanifest]
- [Export-ModuleMember][export-modulemember]

<!-- link references -->

[create-modules-and-manifests]: https://mikefrobbins.com/2013/07/04/how-to-create-powershell-script-modules-and-module-manifests/
[about-modules]: /powershell/module/microsoft.powershell.core/about/about_modules
[new-modulemanifest]: /powershell/module/microsoft.powershell.core/new-modulemanifest
[export-modulemember]: /powershell/module/microsoft.powershell.core/export-modulemember
