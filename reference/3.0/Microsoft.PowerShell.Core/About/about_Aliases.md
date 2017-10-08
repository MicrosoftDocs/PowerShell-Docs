---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Aliases
---

# About Aliases

## Short Description

Describes how to use alternate names for cmdlets and commands in  Windows PowerShell.

## Long Description

An alias is an alternate name or nickname for a cmdlet or for a command element, such as a function, script, file, or executable file. You can use the alias instead of the command name in any  Windows PowerShell commands.

To create an alias, use the `New-Alias` cmdlet.
For example, the following command creates the "gas" alias for the `Get-AuthenticodeSignature` cmdlet:

```powershell
New-Alias -Name gas -Value Get-AuthenticodeSignature
```

After you create the alias for the cmdlet name, you can use the alias instead of the cmdlet name.
For example, to get the Authenticode signature for the SqlScript.ps1 file, type:

```powershell
Get-AuthenticodeSignature SqlScript.ps1
```

Or, type:

```powershell
gas SqlScript.ps1
```

If you create "word" as the alias for Microsoft Office Word, you can type "word" instead of the following:

```
"C:\Program Files\Microsoft Office\Office11\Winword.exe"
```

## Built-in Aliases

Windows PowerShell includes a set of built-in aliases, including "cd" and "chdir" for the `Set-Location` cmdlet, and "ls" and "dir" for the `Get-ChildItem` cmdlet.
To get all the aliases on the computer, including the built-in aliases, type: `Get-Alias`

## Alias Cmdlets

Windows PowerShell includes the following cmdlets, which are designed for working with aliases:

* `Get-Alias` gets all the aliases in the current session
* `New-Alias` creates a new alias
* `Set-Alias` creates or changes an alias
* `Export-Alias` exports one or more aliases to a file
* `Import-Alias` imports an alias file into Windows PowerShell

For detailed information about the cmdlets, type `Get-Help <cmdlet-Name> -Detailed`.
For example, type:

```powershell
Get-Help Export-Alias -Detailed
```

## Creating an Alias

To create a new alias, use the `New-Alias` cmdlet.
For example, to create the "gh" alias for `Get-Help`, type:

```powershell
New-Alias -Name gh -Value Get-Help
```

You can use the alias in commands, just as you would use the full cmdlet name, and you can use the alias with parameters.
For example, to get detailed Help for the `Get-WmiObject` cmdlet, type:

```
Get-Help Get-WmiObject -Detailed
```

Or, type:

```
gh Get-WmiObject -Detailed
```

## Saving Aliases

The aliases that you create are saved only in the current session. To use the aliases in a different session, add the alias to your  Windows PowerShell profile. Or, use the `Export-Alias` cmdlet to save the aliases to a file.
For more information, see [about_Profiles](about_Profiles.md)

## Getting Aliases

To get all the aliases in the current session, including the built-in aliases, the aliases in your Windows PowerShell profiles, and the aliases that you have created in the current session, type:

```powershell
Get-Alias
```

To get particular aliases, use the Name parameter of the `Get-Alias` cmdlet.
For example, to get aliases that begin with "p", type:

```powershell
Get-Alias -Name p*
```

To get the aliases for a particular item, use the **Definition** parameter.
For example, to get the aliases for the `Get-ChildItem` cmdlet type:

```powershell
Get-Alias -Definition Get-ChildItem
```

## Get-Alias Output

`Get-Alias` returns only one type of object, an AliasInfo object (System.Management.Automation.AliasInfo). However, beginning in  Windows PowerShell 3.0, the name of aliases that don't include a hyphen, such as "cd" are displayed in the following format:

```
<alias> -> <definition>
```

For example,

```
ac -> Add-Content
```

This makes it very quick and easy to get the information that you need.

The arrow-based alias name format is not used for aliases that include a hyphen. These are likely to be preferred substitute names for cmdlets and functions, instead of typical abbreviations or nicknames, and the author might not want them to be as evident.

## Alternate Names for Commands With Parameters

You can assign an alias to a cmdlet, script, function, or executable file. However, you cannot assign an alias to a command and its parameters. For example, you can assign an alias to the `Get-Eventlog` cmdlet, but you cannot assign an alias to the `Get-Eventlog -LogName System` command.

However, you can create a function that includes the command. To create a function, type the word "function" followed by a name for the function. Type the command, and enclose it in braces (`{}`).

For example, the following command creates the syslog function. This function represents the `Get-Eventlog -LogName System` command:

```powershell
function syslog { Get-Eventlog -LogName System }
```

You can now type "syslog" instead of the command. And, you can create aliases for the syslog function.
For more information about functions, see [about_Functions](about_Functions.md)

## Alias Objects

Windows PowerShell aliases are represented by objects that are instances of the System.Management.Automation.AliasInfo class.
For more information about this type of object, see [AliasInfo Class](https://go.microsoft.com/fwlink/?LinkId=143644).

To view the properties and methods of the alias objects, get the aliases. Then, pipe them to the `Get-Member` cmdlet.
For example:

```powershell
Get-Alias | Get-Member
```

To view the values of the properties of a specific alias, such as the "dir" alias, get the alias. Then, pipe it to the `Format-List` cmdlet.
For example, the following command gets the "dir" alias. Next, the command pipes the alias to the `Format-List` cmdlet. Then, the command uses the **Property** parameter of `Format-List` with a wildcard character (`*`) to display all the properties of the "dir" alias. The following command performs these tasks:

```powershell
Get-Alias -Name dir | Format-List -Property *
```

## Windows Powershell Alias Provider

Windows PowerShell includes the Alias provider. The Alias provider lets you view the aliases in Windows PowerShell as though they were on a file system drive.

The Alias provider exposes the Alias: drive. To go into the Alias: drive, type:

```powershell
Set-Location Alias:
```

To view the contents of the drive, type:

```powershell
Get-ChildItem
```

To view the contents of the drive from another Windows PowerShell drive, begin the path with the drive name. Include the colon (:). 
For example:

```powershell
Get-ChildItem -Path Alias:
```

To get information about a particular alias, type the drive name and the alias name. Or, type a name pattern.
For example, to get all the aliases that begin with "p", type:

```powershell
Get-ChildItem -Path Alias:p*
```

For more information about the Windows PowerShell Alias provider, type: `Get-Help Alias`

## See Also

[New-Alias](../../Microsoft.PowerShell.Utility/New-Alias.md)

[Get-Alias](../../Microsoft.PowerShell.Utility/Get-Alias.md)

[Set-Alias](../../Microsoft.PowerShell.Utility/Set-Alias.md)

[Export-Alias](../../Microsoft.PowerShell.Utility/Export-Alias.md)

[Import-Alias](../../Microsoft.PowerShell.Utility/Import-Alias.md)

[Get-PSProvider](../../Microsoft.PowerShell.Management/Get-PSProvider.md)

[Get-PSDrive](../../Microsoft.PowerShell.Management/Get-PSDrive.md)

[about_Functions](about_Functions.md)

[about_Profiles](about_Profiles.md)

[about_Providers](about_Providers.md)
