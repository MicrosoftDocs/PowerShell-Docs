---
description: This article describe how to use aliases in PowerShell.
ms.date: 07/23/2024
title: Using aliases
---
# Using aliases

An alias is an alternate name or shorthand name for a cmdlet or for a command element, such as a
function, script, file, or executable file. You can run the command using the alias instead of the
executable name.

## Managing command aliases

PowerShell provides cmdlets for managing command aliases. The following command shows the cmdlets
that manage aliases.

```powershell
Get-Command -Noun Alias
```

```Output
CommandType Name         Version Source
----------- ----         ------- ------
Cmdlet      Export-Alias 7.0.0.0 Microsoft.PowerShell.Utility
Cmdlet      Get-Alias    7.0.0.0 Microsoft.PowerShell.Utility
Cmdlet      Import-Alias 7.0.0.0 Microsoft.PowerShell.Utility
Cmdlet      New-Alias    7.0.0.0 Microsoft.PowerShell.Utility
Cmdlet      Remove-Alias 7.0.0.0 Microsoft.PowerShell.Utility
Cmdlet      Set-Alias    7.0.0.0 Microsoft.PowerShell.Utility
```

For more information, see [about_Aliases][01].

Use the [Get-Alias][04] cmdlet to list the aliases available in your environment. To list the
aliases for a single cmdlet, use the **Definition** parameter and specify the executable name.

```powershell
Get-Alias -Definition Get-ChildItem
```

```Output
CommandType     Name
-----------     ----
Alias           dir -> Get-ChildItem
Alias           gci -> Get-ChildItem
Alias           ls -> Get-ChildItem
```

To get the definition of a single alias, use the **Name** parameter.

```powershell
Get-Alias -Name gci
```

```Output
CommandType     Name
-----------     ----
Alias           gci -> Get-ChildItem
```

To create an alias, use the `Set-Alias` command. You can create aliases for cmdlets, functions,
scripts, and native executables files.

```powershell
Set-Alias -Name np -Value Notepad.exe
Set-Alias -Name cmpo  -Value Compare-Object
```

## Compatibility aliases in Windows

PowerShell has several aliases that allow **UNIX** and `cmd.exe` users to use familiar commands in
Windows. The following table show common commands, the related PowerShell cmdlet, and the PowerShell
alias:

|     Windows Command Shell     | UNIX command | PowerShell cmdlet |             PowerShell alias              |
| ----------------------------- | ------------ | ----------------- | ----------------------------------------- |
| `cd`, `chdir`                 | `cd`         | `Set-Location`    | `sl`, `cd`, `chdir`                       |
| `cls`                         | `clear`      | `Clear-Host`      | `cls` `clear`                             |
| `copy`                        | `cp`         | `Copy-Item`       | `cpi`, `cp`, `copy`                       |
| `del`, `erase`, `rd`, `rmdir` | `rm`         | `Remove-Item`     | `ri`, `del`, `erase`, `rd`, `rm`, `rmdir` |
| `dir`                         | `ls`         | `Get-ChildItem`   | `gci`, `dir`, `ls`                        |
| `echo`                        | `echo`       | `Write-Output`    | `write` `echo`                            |
| `md`                          | `mkdir`      | `New-Item`        | `ni`                                      |
| `move`                        | `mv`         | `Move-Item`       | `mi`, `move`, `mi`                        |
| `popd`                        | `popd`       | `Pop-Location`    | `popd`                                    |
|                               | `pwd`        | `Get-Location`    | `gl`, `pwd`                               |
| `pushd`                       | `pushd`      | `Push-Location`   | `pushd`                                   |
| `ren`                         | `mv`         | `Rename-Item`     | `rni`, `ren`                              |
| `type`                        | `cat`        | `Get-Content`     | `gc`, `cat`, `type`                       |

> [!NOTE]
> The aliases in this table are Windows-specific. Some aliases aren't available on other platforms.
> This is to allow the native command to work in a PowerShell session. For example, `ls` isn't
> defined as a PowerShell alias on macOS or Linux so that the native command is run instead of
> `Get-ChildItem`.

## Creating alternate names for commands with parameters

You can assign an alias to a cmdlet, script, function, or executable file. Unlike some Unix shells,
you cannot assign an alias to a command with parameters. For example, you can assign an alias to the
`Get-Eventlog` cmdlet, but you cannot assign an alias to the `Get-Eventlog -LogName System` command.
You must create a function that contains the command with parameters.

For more information, see [about_Aliases][02].

## Parameter aliases and shorthand names

PowerShell also provides ways to create shorthand names for parameters. Parameter aliases are
defined using the `Alias` attribute when you declare the parameter. These can't be defined using the
`*-Alias` cmdlets.

For more information, see the [Alias attribute][03] documentation.

In addition to parameter aliases, PowerShell lets you specify the parameter name using the fewest
characters needed to uniquely identify the parameter. For example, the `Get-ChildItem` cmdlet has
the **Recurse** and **ReadOnly** parameters. To uniquely identify the **Recurse** parameter you only
need to provide `-rec`. If you combine that with the command alias, `Get-ChildItem -Recurse` can be
shortened to `dir -rec`.

## Don't use aliases in scripts

Aliases are a convenience feature to be used interactively in the shell. You should always use the
full command and parameter names in your scripts.

- Aliases can be deleted or redefined in a profile script
- Any aliases you define may not be available to the user of your scripts
- Aliases make your code harder to read and maintain

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_aliases
[02]: /powershell/module/microsoft.powershell.core/about/about_aliases#alternate-names-for-commands-with-parameters
[03]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters#alias-attribute
[04]: xref:Microsoft.PowerShell.Utility.Get-Alias
