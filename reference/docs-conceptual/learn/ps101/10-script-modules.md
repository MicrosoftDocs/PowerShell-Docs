---
description: Script modules are an easy way to package scripts and functions into a reusable tool.
ms.custom: Contributor-mikefrobbins
ms.date: 12/08/2022
ms.reviewer: mirobb
title: Script modules
---
# Chapter 10 - Script modules

Turning your one-liners and scripts in PowerShell into reusable tools becomes even more important if
it's something that you're going to use frequently. Packaging your functions in a script module
makes them look and feel more professional and makes them easier to share.

## Dot-Sourcing Functions

Something that we didn't talk about in the previous chapter is dot-sourcing functions. When a
function in a script isn't part of a module, the only way to load it into memory is to dot-source
the `.PS1` file that it's saved in.

The following function has been saved as `Get-MrPSVersion.ps1`.

```powershell
function Get-MrPSVersion {
    $PSVersionTable
}
```

When you run the script, nothing happens.

```powershell
.\Get-MrPSVersion.ps1
```

If you try to call the function, it generates an error message.

```powershell
Get-MrPSVersion
```

```Output
Get-MrPSVersion : The term 'Get-MrPSVersion' is not recognized as the name of a cmdlet,
function, script file, or operable program. Check the spelling of the name, or if a path
was included, verify that the path is correct and try again.
At line:1 char:1
+ Get-MrPSVersion
    + CategoryInfo          : ObjectNotFound: (Get-MrPSVersion:String) [], CommandNotFou
   ndException
    + FullyQualifiedErrorId : CommandNotFoundException

```

You can determine if functions are loaded into memory by checking to see if they exist on the
**Function** PSDrive.

```powershell
Get-ChildItem -Path Function:\Get-MrPSVersion
```

```Output
Get-ChildItem : Cannot find path 'Get-MrPSVersion' because it does not exist.
At line:1 char:1
+ Get-ChildItem -Path Function:\Get-MrPSVersion
    + CategoryInfo          : ObjectNotFound: (Get-MrPSVersion:String) [Get-ChildItem],
   ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
```

The problem with calling the script that contains the function is that the functions are loaded in
the _Script_ scope. When the script completes, that scope is removed and the function is removed
with it.

The function needs to be loaded into the _Global_ scope. That can be accomplished by dot-sourcing
the script that contains the function. The relative path can be used.

```powershell
. .\Get-MrPSVersion.ps1
```

The fully qualified path can also be used.

```powershell
. C:\Demo\Get-MrPSVersion.ps1
```

If a portion of the path is stored in a variable, it can be combined with the remainder of the path.
There's no reason to use string concatenation to combine the variable together with the remainder of
the path.

```powershell
$Path = 'C:\'
. $Path\Get-MrPSVersion.ps1
```

Now when I check the **Function** PSDrive, the `Get-MrPSVersion` function exists.

```powershell
Get-ChildItem -Path Function:\Get-MrPSVersion
```

```Output
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-MrPSVersion
```

## Script Modules

A script module in PowerShell is simply a file containing one or more functions that's saved as a
`.PSM1` file instead of a `.PS1` file.

How do you create a script module? You're probably guessing with a command named something like
`New-Module`. Your assumption would be wrong. While there is a command in PowerShell named
`New-Module`, that command creates a dynamic module, not a script module. Always be sure to read the
help for a command even when you think you've found the command you need.

```powershell
help New-Module
```

```Output
NAME
    New-Module

SYNOPSIS
    Creates a new dynamic module that exists only in memory.

SYNTAX
    New-Module [-Name] <String> [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>]
    [-AsCustomObject] [-Cmdlet <String[]>] [-Function <String[]>] [-ReturnResult]
    [<CommonParameters>]

DESCRIPTION
    The New-Module cmdlet creates a dynamic module from a script block. The members of
    the dynamic module, such as functions and variables, are immediately available in
    the session and remain available until you close the session.

    Like static modules, by default, the cmdlets and functions in a dynamic module are
    exported and the variables and aliases are not. However, you can use the
    Export-ModuleMember cmdlet and the parameters of New-Module to override the defaults.

    You can also use the AsCustomObject parameter of New-Module to return the dynamic
    module as a custom object. The members of the modules, such as functions, are
    implemented as script methods of the custom object instead of being imported into
    the session.

    Dynamic modules exist only in memory, not on disk. Like all modules, the members of
    dynamic modules run in a private module scope that is a child of the global scope.
    Get-Module cannot get a dynamic module, but Get-Command can get the exported members.

    To make a dynamic module available to Get-Module , pipe a New-Module command to
    Import-Module, or pipe the module object that New-Module returns to Import-Module .
    This action adds the dynamic module to the Get-Module list, but it does not save the
    module to disk or make it persistent.

RELATED LINKS
    Online Version: http://go.microsoft.com/fwlink/?LinkId=821495
    Export-ModuleMember
    Get-Module
    Import-Module
    Remove-Module

REMARKS
    To see the examples, type: "get-help New-Module -examples".
    For more information, type: "get-help New-Module -detailed".
    For technical information, type: "get-help New-Module -full".
    For online help, type: "get-help New-Module -online"
```

In the previous chapter, I mentioned that functions should use approved verbs otherwise they'll
generate a warning message when the module is imported. The following code uses the `New-Module`
cmdlet to create a dynamic module in memory. This module demonstrates the unapproved verb warning.

```powershell
New-Module -Name MyModule -ScriptBlock {

    function Return-MrOsVersion {
        Get-CimInstance -ClassName Win32_OperatingSystem |
        Select-Object -Property @{label='OperatingSystem';expression={$_.Caption}}
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

Just to reiterate, although the `New-Module` cmdlet was used in the previous example, that's not the
command for creating script modules in PowerShell.

Save the following two functions in a file named `MyScriptModule.psm1`.

```powershell
function Get-MrPSVersion {
    $PSVersionTable
}

function Get-MrComputerName {
    $env:COMPUTERNAME
}
```

Try to call one of the functions.

```powershell
Get-MrComputerName
```

```Output
Get-MrComputerName : The term 'Get-MrComputerName' is not recognized as the name of a
cmdlet, function, script file, or operable program. Check the spelling of the name, or
if a path was included, verify that the path is correct and try again.
At line:1 char:1
+ Get-MrComputerName
    + CategoryInfo          : ObjectNotFound: (Get-MrComputerName:String) [], CommandNot
   FoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

An error message is generated saying the function can't be found. You could also check the
**Function** PSDrive just like before and you'll find that it doesn't exist there either.

You could manually import the file with the `Import-Module` cmdlet.

```powershell
Import-Module C:\MyScriptModule.psm1
```

The module autoloading feature was introduced in PowerShell version 3. To take advantage of module
autoloading, a script module needs to be saved in a folder with the same base name as the `.PSM1` file
and in a location specified in `$env:PSModulePath`.

```powershell
$env:PSModulePath
```

```Output
C:\Users\mike-ladm\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\
Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsof
t SQL Server\130\Tools\PowerShell\Modules\
```

The results are difficult to read. Since the paths are separated by a semicolon, you can split the
results to return each path on a separate line. This makes them easier to read.

```powershell
$env:PSModulePath -split ';'
```

```Output
C:\Users\mike-ladm\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\Windows\system32\WindowsPowerShell\v1.0\Modules
C:\Program Files (x86)\Microsoft SQL Server\130\Tools\PowerShell\Modules\
```

The first three paths in the list are the default. When SQL Server Management Studio was installed,
it added the last path. For module autoloading to work, the `MyScriptModule.psm1` file needs to be
located in a folder named `MyScriptModule` directly inside one of those paths.

Not so fast. For me, my current user path isn't the first one in the list. I almost never use that
path since I log into Windows with a different user than the one I use to run PowerShell. That means
it's not located in my normal Documents folder.

The second path is the **AllUsers** path. This is the location where I store all of my modules.

The third path is underneath `C:\Windows\System32`. Only Microsoft should be storing modules in that
location since it resides within the operating systems folder.

Once the `.PSM1` file is located in the correct path, the module will load automatically when one of
its commands is called.

## Module Manifests

All modules should have a module manifest. A module manifest contains metadata about your module.
The file extension for a module manifest file is `.PSD1`. Not all files with a `.PSD1` extension are
module manifests. They can also be used for things such as storing the environmental portion of a
DSC configuration. `New-ModuleManifest` is used to create a module manifest. **Path** is the only
value that's required. However, the module won't work if **RootModule** isn't specified. It's a good
idea to specify **Author** and **Description** in case you decide to upload your module to a NuGet
repository with PowerShellGet since those values are required in that scenario.

The version of a module without a manifest is 0.0. This is a dead giveaway that the module doesn't
have a manifest.

```powershell
Get-Module -Name MyScriptModule
```

```Output
ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Script     0.0        myscriptmodule                      {Get-MrComputerName, Get-MrP...
```

The module manifest can be created with all of the recommended information.

```powershell
New-ModuleManifest -Path $env:ProgramFiles\WindowsPowerShell\Modules\MyScriptModule\MyScriptModule.psd1 -RootModule MyScriptModule -Author 'Mike F Robbins' -Description 'MyScriptModule' -CompanyName 'mikefrobbins.com'
```

If any of this information is missed during the initial creation of the module manifest, it can be
added or updated later using `Update-ModuleManifest`. Don't recreate the manifest using
`New-ModuleManifest` once it's already created because the GUID will change.

## Defining Public and Private Functions

You may have helper functions that you may want to be private and only accessible by other functions
within the module. They are not intended to be accessible to users of your module. There are a
couple of different ways to accomplish this.

If you're not following the best practices and only have a `.PSM1` file, then your only option is to
use the `Export-ModuleMember` cmdlet.

```powershell
function Get-MrPSVersion {
    $PSVersionTable
}

function Get-MrComputerName {
    $env:COMPUTERNAME
}

Export-ModuleMember -Function Get-MrPSVersion
```

In the previous example, only the `Get-MrPSVersion` function is available to the users of your
module, but the `Get-MrComputerName` function is available to other functions within the module
itself.

```powershell
Get-Command -Module MyScriptModule
```

```Output
CommandType     Name                                            Version    Source
-----------     ----                                            -------    ------
Function        Get-MrPSVersion                                 1.0        MyScriptModule
```

If you've added a module manifest to your module (and you should), then I recommend specifying the
individual functions you want to export in the **FunctionsToExport** section of the module manifest.

```powershell
FunctionsToExport = 'Get-MrPSVersion'
```

It's not necessary to use both `Export-ModuleMember` in the `.PSM1` file and the
**FunctionsToExport** section of the module manifest. One or the other is sufficient.

## Summary

In this chapter you've learned how to turn your functions into a script module in PowerShell. You've
also learned some of the best practices for creating script modules such as creating a module
manifest for your script module.

## Review

1. How do you create a script module in PowerShell?
1. Why is it important for your functions to use an approved verb?
1. How do you create a module manifest in PowerShell?
1. What are the two options for exporting only certain functions from your module?
1. What is required for your modules to load automatically when a command is called?

## Recommended Reading

- [How to Create PowerShell Script Modules and Module Manifests][How to Create PowerShell Script Modules and Module Manifests]
- [about_Modules][about_Modules]
- [New-ModuleManifest][New-ModuleManifest]
- [Export-ModuleMember][Export-ModuleMember]

<!-- link references -->
[How to Create PowerShell Script Modules and Module Manifests]: https://mikefrobbins.com/2013/07/04/how-to-create-powershell-script-modules-and-module-manifests/
[about_Modules]: /powershell/module/microsoft.powershell.core/about/about_modules
[New-ModuleManifest]: /powershell/module/microsoft.powershell.core/new-modulemanifest
[Export-ModuleMember]: /powershell/module/microsoft.powershell.core/export-modulemember
